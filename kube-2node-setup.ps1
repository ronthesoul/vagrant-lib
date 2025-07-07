# Run as Administrator

# Install Chocolatey if not already installed
if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = "Tls12"
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

# Install Git, Vagrant, VirtualBox
choco install git vagrant virtualbox -y

# Clone project and start it
git clone https://github.com/ronthesoul/vagrant-lib.git
cd vagrant-lib\kube-2node