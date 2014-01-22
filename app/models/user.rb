class User < ActiveRecord::Base
  def send_notification(message, data = {})
    return unless notification_token.present?

    params = {
      :token => notification_token,
      :ticker => message,
      :data => data
    }.to_json

    response = Faraday.post "https://api.kik.com/push/v1/send", params do |req|
      req.headers['Content-Type'] = 'application/json'
      req.options[:timeout] = 3
    end

    update_attribute :notification_token, nil if response.status == 403

    response.status
  end

  def update_kik_user_info!(params)
    user_params = Hash[params.
                         reject { |k, v| v.blank? }.
                         slice(:notification_token, :thumbnail).
                         map { |k, v| [k.to_s.underscore, v] }]
    update_attributes!(user_params)
  end
end
