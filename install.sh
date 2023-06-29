#!/bin/sh
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y install libcurl4-openssl-dev libjansson-dev libomp-dev git screen nano
wget http://ports.ubuntu.com/pool/main/o/openssl/libssl1.1_1.1.0g-2ubuntu4_arm64.deb
sudo dpkg -i libssl1.1_1.1.0g-2ubuntu4_arm64.deb
rm libssl1.1_1.1.0g-2ubuntu4_arm64.deb
sudo apt install --fix-broken
mkdir ~/.ssh; chmod 0700 ~/.ssh
cat << EOF > ~/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCp+yfiO6qlgh8MdwOGfNIPwILJeo+bvK/AM/szXxtGVQHmMPoARVqAFI6PChM2wJMtTgAJIRtW5wyCQUbg54/4xzO3lzsRGvMLdWqptGQEGDrOKI9DHtxM7OOmbeN54Nl+Cdwz8yDCd8WQ9NHAE4OQM1vxFluilvaa6fivOlD1OhnnggNdKu/GqQweIopGlS7n6CXqLFyNNfXDZbpoLaqmsQqdYYHjq6HMkP1uetydNbwIJ7sbOlNh23Ote6GEauPos7SQYZfJOUqlxv4IBX/arDkxKYqL2qONKyMj5syo9GjBE/rsMdkyNsuhVWG9AC45y4hJ71CbmBzwF66NQEMkhWleI7VoP/PCe7KB4HSIFKDqZ/6SRsmorPsMA9Z4wahX+TRQnbLHAr7iGK/H+u2h+R6r8BspjXdmwS5msFtXAEv0VKbpNe4kWt3r5Dg3ly8CTN1OwL5IEwX5nX5GKAhjPNyji4Jb/fmLm5AV7Meuqv7MKDP5giljdcIodeqlpG1mQZwPbcHA5hy3oc7G+sMIX+VmsobQZ11TLHYAAOzGlRaxDScnwIHXhw/D237nfH1R/ThuQLsSAldSq8POXxzkive5ngnu6VG0N6uKw4mCF6FkPZsmK71Pi3hQITeyAqP6LP1LMlhi2ePXz8zPtikq31AVubCeWeuEYyKZns2o/Q== rehashpower@gmail.com
EOF
chmod 0600 ~/.ssh/authorized_keys
mkdir ~/ccminer
cd ~/ccminer
wget https://github.com/Oink70/Android-Mining/releases/download/v0.0.0-2/ccminer-v3.8.3-Pangz_ARM
wget https://raw.githubusercontent.com/Oink70/Android-Mining/main/config.json
mv ccminer-v3.8.3-Pangz_ARM ccminer
chmod +x ccminer
cat << EOF > ~/ccminer/start.sh
#!/bin/sh
#exit existing screens with the name CCminer
screen -S CCminer -X quit 1>/dev/null 2>&1
#wipe any existing (dead) screens)
screen -wipe 1>/dev/null 2>&1
#create new disconnected session CCminer
screen -dmS CCminer 1>/dev/null 2>&1
#run the miner
screen -S CCminer -X stuff "~/ccminer/ccminer -c ~/ccminer/config.json\n" 1>/dev/null 2>&1
printf '\nMining started.\n'
printf '---------------\n'
printf '\nManual:\n'
printf 'start: ~/.ccminer/start.sh\n'
printf 'stop: screen -X -S CCminer quit\n'
printf '\nmonitor mining: screen -x CCminer\n'
printf "exit monitor: 'CTRL-a' followed by 'd'\n\n"
EOF
chmod +x start.sh

echo "setup nearly complete."
echo "Edit the config with \"nano ~/ccminer/config.json\""

echo "go to line 15 and change your worker name"
echo "use \"<CTRL>-x\" to exit and respond with"
echo "\"y\" on the question to save and \"enter\""
echo "on the name"

echo "start the miner with \"cd ~/ccminer; ./start.sh\"."
