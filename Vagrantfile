
# configuration of Server Machine
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"

#   script update apt and installs apache2
  config.vm.provision "shell", path: "scripts/bootstrap.sh"

  config.vm.define "bamghougS" do |server|
	#   script that installs and runs K3s Server
	server.vm.provision "shell", path: "scripts/Server_script.sh"

	server.vm.provider :virtualbox do |vb|
		vb.name = "bamghougS"
	end
	server.vm.network "private_network", ip: "192.168.56.110"
  end	

  config.vm.define "bamghougSW" do |serverWorker|
	#   script that installs and runs K3s Agent
	serverWorker.vm.provision "shell", path: "scripts/ServerWorker_script.sh"
	
	serverWorker.vm.provider :virtualbox do |vb|
		vb.name = "bamghougSW"
	end
	serverWorker.vm.network "private_network", ip: "192.168.56.111"
  end

end
