#
# The launched file
# Includes all the dependent files
# There's no management here. Only inclusions
#

ROOT = File.join(File.dirname(__FILE__), '..')
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

require 'lib/apache'