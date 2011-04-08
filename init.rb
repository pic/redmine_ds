require 'redmine'

ActiveRecord::Base.observers << DsObserver
config.to_prepare do
  require_dependency 'redmine_ds_patches'
  unless config.cache_classes
    DsObserver.instance.reload_observer
  end
end

Redmine::Plugin.register :redmine_ds do
  name 'Redmine Ds'
  description 'This plugin is useless'
  version '0.0.1'
  url 'http://github.com/pic/redmine_ds'
  author 'Nicola Piccinini'
  author_url 'mailto:piccinini@gmail.com'
end
