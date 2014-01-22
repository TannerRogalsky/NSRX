require 'spec_helper'

describe User do
  let(:foo_user)  { User.create!(:username => 'foo', :notification_token => 'ABC123') }

  let(:message)   { "Ohai!" }
  let(:data)      { { :useful => ['john', 'paul', 'george'], :filler => 'ringo' } }
  let(:kik_url)   { "https://api.kik.com/push/v1/send" }
  let(:post_params_with_data)       { '{"token":"ABC123","ticker":"Ohai!","data":{"useful":["john","paul","george"],"filler":"ringo"}}' }
  let(:post_params_with_empty_data) { '{"token":"ABC123","ticker":"Ohai!","data":{}}' }

  describe '#update_kik_user_info!' do
    it 'should not attempt to modify a non-whitelisted attribute (username)' do
      params = { :username => 'haxorz' }
      foo_user.update_kik_user_info! params

      foo_user.reload.username.should_not == 'haxorz'
    end

    it 'should ignore other parameters' do
      params = { :someOtherParam => 'blah', :thumbnail => 'the_thumb' }
      foo_user.update_kik_user_info! params

      foo_user.reload.thumbnail.should == 'the_thumb'
    end

    %w'notification_token thumbnail'.each do |param|
      before { foo_user.update_attribute param.underscore, 'old_value' }

      it "should update the user's #{param.underscore} if #{param} was sent" do
        params = { param.to_sym => 'new_value' }
        foo_user.update_kik_user_info! params

        foo_user.reload[param.underscore].should == 'new_value'
      end

      it "should not change the user's #{param.underscore} if an empty #{param} was sent" do
        params = { param.to_sym => '' }
        foo_user.update_kik_user_info! params

        foo_user.reload[param.underscore].should == 'old_value'
      end

      it "should not change the user's #{param.underscore} if no #{param} was sent" do
        params = { }
        foo_user.update_kik_user_info! params

        foo_user.reload[param.underscore].should == 'old_value'
      end
    end
  end

  describe '#send_notification' do
    context 'user with token (normal request)' do
      let(:http_status) { 200 + rand(400) }

      before do
        stub_request(:post, "https://api.kik.com/push/v1/send").to_return(:status => http_status)
      end

      it 'should send the message, data and token to Kik servers' do
        foo_user.send_notification(message, data)

        WebMock.should have_requested(:post, kik_url).with(
          :body => post_params_with_data, :headers => { 'Content-Type' => 'application/json' }
        ).once
      end

      it 'should return the http status sent by Kik' do
        foo_user.send_notification(message, data).should == http_status
      end

      it "should set an explicit timeout" do
        req = double('req', :headers => {}, :options => {})
        Faraday.stub('post').and_yield(req).and_return(double('status' => 200))

        foo_user.send_notification(message, data)
        req.options[:timeout].should be_present
      end

      context 'no data' do
        it 'should send the message, token and empty data to Kik servers' do
          foo_user.send_notification(message)

          WebMock.should have_requested(:post, kik_url).with(
            :body => post_params_with_empty_data, :headers => { 'Content-Type' => 'application/json' }
          ).once
        end
      end
    end

    context 'user with no token' do
      before { foo_user.update_attribute(:notification_token, nil) }

      it 'should return nil (and not do any request) if user has no token' do
        foo_user.send_notification(message, data).should == nil
      end
    end

    context 'user with bad token (server responds 403, as per http://cards.kik.com/docs/push/#service)' do
      before { stub_request(:post, "https://api.kik.com/push/v1/send").to_return(:status => 403) }

      it 'should remove the token from the db (so it can be re-requested)' do
        expect {
          foo_user.send_notification message
        }.to change{ foo_user.notification_token }.to be_nil
      end
    end
  end
end
