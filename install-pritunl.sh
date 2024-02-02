#!/bin/bash

# Add Pritunl repository
echo "deb http://repo.pritunl.com/stable/apt $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/pritunl.list

# Add MongoDB repository
sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list << EOF
deb https://repo.mongodb.org/apt/ubuntu $(lsb_release -cs)/mongodb-org/6.0 multiverse
EOF

# Import GPG keys
curl -fsSL https://www.mongodb.org/static/pgp/server-6.0.asc | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/mongodb-6.gpg
curl -fsSL https://raw.githubusercontent.com/pritunl/pgp/master/pritunl_repo_pub.asc | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/pritunl.gpg

# Update and install packages
sudo apt update
sudo apt --assume-yes install pritunl mongodb-org

# Start and enable services
sudo systemctl start pritunl mongod
sudo systemctl enable pritunl mongod

# Display status
sudo systemctl status pritunl mongod

