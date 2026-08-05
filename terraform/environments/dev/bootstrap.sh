#!/bin/bash

set -e

apt update

apt install -y nginx

cat <<EOF >/var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
    <title>Acme Enterprise Platform</title>
</head>
<body>
    <h1>Welcome to Acme Enterprise Platform</h1>
    <p>Provisioned automatically using Terraform</p>
</body>
</html>
EOF

systemctl enable nginx
systemctl start nginx
