class VagrantPlugins::ProviderVirtualBox::Action::SetName
  alias_method :original_call, :call
  def call(env)
    machine = env[:machine]
    driver = machine.provider.driver
    uuid = driver.instance_eval { @uuid }
    ui = env[:ui]
    vm_folder = ''
    vm_info = driver.execute('showvminfo', uuid, '--machinereadable')
    lines = vm_info.split("\n")
    lines.each do |line|
      if line.start_with?("CfgFile")
        vm_folder = line.split('=')[1].gsub('"','')
        vm_folder = File.expand_path('..', vm_folder)
        ui.info "VM Folder is: #{vm_folder}"
      end
    end
    size = 512
    disk_file = vm_folder + '/datadisk.vdi'
    ui.info 'Adding disk to VM'
    if File.exist?(disk_file)
      ui.info 'Disk already exists'
    else
      ui.info 'Creating new disk'
      driver.execute('createmedium', 'disk', '--filename', disk_file, '--size', "#{size}", '--format', 'VDI')
      ui.info 'Attaching disk to VM'
      driver.execute('storageattach', uuid, '--storagectl', 'SATA Controller', '--port', '1', '--type', 'hdd', '--medium', disk_file)
    end
    original_call(env)
  end
end
