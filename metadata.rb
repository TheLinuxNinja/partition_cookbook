name 'partition'
maintainer 'Bryan L. Gay'
maintainer_email 'github@bryangay.com'
license 'Apache-2.0'
description 'Installs/Configures partition_cookbook'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.1.0'
chef_version '>= 12.14' if respond_to?(:chef_version)

%w[ubuntu].each do |os|
  supports os
end

issues_url 'https://github.com/TheLinuxNinja/partition_cookbook/issues'
source_url 'https://github.com/TheLinuxNinja/partition_cookbook'
