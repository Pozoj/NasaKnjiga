RAILS_GEM_VERSION = '2.3.12' unless defined? RAILS_GEM_VERSION

require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.action_controller.session = {
    :key => '_mojaknjiga_session',
    :secret      => 'a406a09e903c61fa55fadsadas223154dsfsdfdsce763e5df7cae1320592290a64e0665412cd9aff9b18116daeab3309fe69bfb3ffc6da224671f5ea5ab96ad7245b276a06a448f2c0a'
  }
  config.time_zone = 'Ljubljana'
  config.i18n.default_locale = :sl
  config.gem 'RedCloth', :lib => 'redcloth'
  config.gem 'haml',  :version => "2.2.24"
  config.gem 'thoughtbot-pacecar',
    :lib     => "pacecar",
    :source  => 'http://gems.github.com'
  config.gem "inherited_resources", :version => "1.0.6"
  config.gem "will_paginate", :version => "2.3.16"
  config.gem "paperclip"
  config.gem "subdomain-fu"
  config.gem "whenever"
  config.gem 'spreadsheet'
  config.gem 'hoptoad_notifier'
end

SubdomainFu.override_only_path = true
