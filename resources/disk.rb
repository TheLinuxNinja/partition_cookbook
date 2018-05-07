# Custom disk partitioning resource

property :device, String, required: true
property :label_type, String, default: 'gpt'
property :file_system, String, default: 'ext4'
property :part_type, String, default: 'primary'
property :part_start, String, default: '1'
property :part_end, String, default: '-1'
property :flag_name, String, default: 'boot'

resource_name :partition_disk
default_action :nothing

action :mklabel do
  execute "parted #{new_resource.device} --script -- mklabel #{new_resource.label_type}" do
    not_if "parted #{new_resource.device} --script -- print |grep 'Partition Table: #{new_resource.label_type}'"
  end
end

action :mkpart do
  execute "parted #{new_resource.device} --script -- mkpart #{new_resource.part_type} #{new_resource.file_system} \
#{new_resource.part_start} #{new_resource.part_end}" do
    # Number  Start   End    Size   File system  Name  Flags
    #  1      17.4kB  537GB  537GB               xfs
    not_if "parted #{new_resource.device} --script -- print |sed '1,/^Number/d' |grep #{new_resource.part_type}"
  end
end

action :mkfs do
  execute "mkfs.#{new_resource.file_system} #{new_resource.device}" do
    # /dev/sdb1: SGI XFS filesystem data (blksz 4096, inosz 256, v2 dirs)
    # or
    # /dev/sdb1: Linux rev 1.0 ext4 filesystem data, UUID=435fd604-cf17-4f5c-b39a-c9829a209ed5 (extents) (large files) (huge files)
    not_if "file -sL #{new_resource.device} |grep -i #{new_resource.file_system}"
  end
end

action :setflag do
  execute "parted #{new_resource.device} --script -- set 1 #{new_resource.flag_name} on" do
    # Number  Start   End    Size   Type     File system  Flags
    #  1      1049kB  107GB  107GB  primary               boot
    not_if "parted #{new_resource.device} --script -- print |grep '#{new_resource.flag_name}'"
  end
end

action :nothing do
end
