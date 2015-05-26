require File.expand_path('../boot', __FILE__)

require 'rails/all'


Bundler.require(*Rails.groups)

module PhotoContest
  class Application < Rails::Application
    config.active_record.raise_in_transactional_callbacks = true

    config.generators do |g|
      g.assets    =   false
      g.helper    =   false
      g.jbuilder  =   false
    end

  end
end
