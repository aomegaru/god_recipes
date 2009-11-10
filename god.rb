#
# The launched file
# Includes all the dependent files
# There's no management here. Only inclusions
#

ROOT = File.join(File.dirname(__FILE__))
$: << File.dirname(__FILE__)

#
# Email notification settings
#
God::Contacts::Email.message_settings = { :from => 'god@predicteo.com' }
God::Contacts::Email.server_settings = { :address => 'localhost', :port => 25 }
God.contact(:email) do |c|
  c.name = 'damien'
  c.email = '42@dmathieu.com'
end

#
# The global recipes
#
require 'lib/apache'

#
# And in every project, we look for a potential god.rb file in the "god" directory and load it
# But we ignore the current directory
#
Dir[ROOT + '/../*/'].each do |plugin|
  load(File.join(plugin, 'god', 'god.rb')) if File.basename(plugin) != 'god' and File.directory?(plugin) and File.exists?(File.join(plugin, 'god', 'god.rb'))
end