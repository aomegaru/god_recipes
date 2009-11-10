#
# The launched file
# Includes all the dependent files
# There's no management here. Only inclusions
#

ROOT = File.join(File.dirname(__FILE__), '..')
$: << File.dirname(__FILE__)

require 'lib/apache'