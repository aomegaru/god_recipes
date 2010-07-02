#
# The launched file
# Includes all the dependent files
# There's no management here. Only inclusions
#

ROOT = File.join(File.dirname(__FILE__)) unless defined? ROOT
$: << File.dirname(__FILE__)

#
# Email notification settings
#
God::Contacts::Email.defaults do |d|
  d.from_email = 'noreply@dmathieu.com'
  d.from_name = 'God'
  d.delivery_method = :sendmail
end
God.contact(:email) do |c|
  c.name = 'damien'
  c.to_email = '42@dmathieu.com'
end

#
# The global recipes
#
Dir[ROOT + '/lib/*.rb'].each do |file|
  load file
end

#
# And in every project, we look for a potential god.rb file in the "god" directory and load it
# But we ignore the current directory
#
Dir[ROOT + '/../../../*/'].each do |plugin|
  load(File.join(plugin, 'current', 'god', 'god.rb')) if File.basename(plugin) != 'god' and File.directory?(plugin) and File.exists?(File.join(plugin, 'current', 'god', 'god.rb'))
end