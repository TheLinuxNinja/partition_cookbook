name 'build_cookbook'
maintainer 'Bryan L. Gay'
maintainer_email 'github@bryangay.com'
license 'all_rights'
version '0.1.0'
chef_version '>= 12.14' if respond_to?(:chef_version)

depends 'delivery-truck'
