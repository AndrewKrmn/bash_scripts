sudo apt update

sudo apt install -y openjdk-11-jdk

sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 5BA31D57EF5975CA

wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -

sudo apt update

sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'

sudo apt update

sudo apt install -y jenkins

sudo systemctl start jenkins

sudo systemctl enable jenkins

sudo cat /var/lib/jenkins/secrets/initialAdminPassword
