# Get the deployed git revision to display in the footer
module Git
  REVISION ||= (ENV['POWERUP_APP_REVISION'] || `git rev-parse --short HEAD`.strip || '????????')[0..6]
end

Rails.logger.info "Revision: #{Git::REVISION}"
