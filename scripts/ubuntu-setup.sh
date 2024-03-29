# # https://github.com/zachriggle/config/blob/4f92346002f5d7faf69faad8ed06a48e70c8d162/bin/initialize-linux-vm.sh

# Ubuntu Setup
# Sudo no password
sudo bash
umask 377
echo "user ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers.d/user
exit

# Update and install
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y install binutils binwalk build-essential gdb git ipython nasm netcat-traditional nmap qemu-system openssl p7zip pwgen scapy socat ssh tmux vim stow

# checksec
wget http://www.trapkit.de/tools/checksec.sh

# binjitsu
sudo apt-get update
sudo apt-get install python2.7 python-pip python-dev git
sudo pip install --upgrade git+https://github.com/binjitsu/binjitsu.git

# pwndbg
git clone https://github.com/zachriggle/pwndbg
echo "source $PWD/pwndbg/gdbinit.py" >> ~/.gdbinit
sudo apt-get python3-pip

sudo pip install pycparser
sudo pip3 install pycparser

git clone https://github.com/aquynh/capstone
cd capstone
git checkout -t origin/next
sudo ./make.sh install
cd bindings/python
sudo python2 setup.py install # Ubuntu 12.04, GDB uses Python2
sudo python3 setup.py install # Ubuntu 14.04+, GDB uses Python3
pip install -Ur requirements.txt

#unicorn
git clone https://github.com/unicorn-engine/unicorn.git
sudo apt-get install libglib2.0-dev
cd unicorn
./make.sh
./make.sh install

# qira

git clone https://github.com/BinaryAnalysisPlatform/qira.git
cd qira/
./install.sh

# pwntools
sudo pip install pwntools
sudo add-apt-repository ppa:pwntools/binutils -y
sudo apt-get update -qy
sudo apt-get install -qy binutils-{aarch64,alpha,arm,avr,cris,hppa,i386,ia64,m68k,msp430,powerpc{,64},sparc{,64},vax,xscale}-linux-gnu

# peda
git clone https://github.com/longld/peda.git ~/peda
echo "source ~/peda/peda.py" >> ~/.gdbinit

# Qemu Setup
# http://www.routards.org/2013/08/defcon-21-ctf-binaries-and-environment.html
# apt-get install qemu-system
# wget http://odroid.us/odroid/users/osterluk/qemu-example/qemu-example.tgz
# wget http://releases.linaro.org/12.04/ubuntu/precise-images/developer/linaro-precise-developer-20120426-86.tar.gz

tar zxf qemu-example.tgz ./zImage
rm -f qemu-example.tgz
sudo tar zxf linaro-precise-developer-20120426-86.tar.gz
rm -f linaro-precise-developer-20120426-86.tar.gz
qemu-img create -f raw rootfs.img 3G
mkfs.ext3 rootfs.img
mkdir mnt
sudo mount -o loop rootfs.img mnt
sudo rsync -a binary/boot/filesystem.dir/ mnt/
sudo umount mnt
sudo rm -rf binary

qemu-system-arm -M vexpress-a9 -m 512 -kernel zImage -sd rootfs.img \
  -append "root=/dev/mmcblk0 rw physmap.enabled=0 console=ttyAMA0" \
  -net nic -net user,hostfwd=tcp:0.0.0.0:2222-10.0.2.15:22 -nographic

# Configue Qemu Guest
sudo echo "auto eth0\niface eth0 inet dhcp" >> /etc/network/interfaces
ifconfig eth0 up
dhclient eth0
apt-get install openssh-server
passwd

# Connect to Guest
ssh -p2222 root@localhost

# METASPLOIT
cd ~
wget -nc https://github.com/rapid7/metasploit-framework/archive/release.zip
unzip release.zip
cd metasploit-framework-*
rm -f .ruby-version
gem install bundler
bundle install

# SSH

sudo service ssh restart
sudo mv -n /etc/ssh/sshd_config{,.original}
sudo sh -c "cat > /etc/ssh/sshd_config <<EOF
Protocol                        2
Port                            22
PubkeyAuthentication            yes
Ciphers                         aes256-ctr
UsePAM                          no
PermitRootLogin                 no
PasswordAuthentication          no
PermitEmptyPasswords            no
KerberosAuthentication          no
GSSAPIAuthentication            no
ChallengeResponseAuthentication no
HostbasedAuthentication         no
KbdInteractiveAuthentication    no
X11Forwarding                   yes
PermitTunnel                    no
AllowTcpForwarding              yes
UsePrivilegeSeparation          sandbox
UseDNS                          no
StrictModes                     yes
Compression                     delayed
Subsystem      sftp             /usr/lib/openssh/sftp-server
AcceptEnv LANG LC_*
AcceptEnv TZ
AcceptEnv COLORFGBG
AcceptEnv WINDOW
AcceptEnv TMUX
EOF"
sudo service ssh restart

# Set PW

password=$(pwgen -s 64 1)
sudo passwd -u -d "$USER"
(echo "$password"; echo "$passwd") | passwd
echo Password is "$password"
