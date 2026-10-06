#!/bin/bash
set -e

# Actualizar sistema
apt-get update
apt-get upgrade -y

# Instalar Node.js y npm
curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
apt-get install -y nodejs

# Instalar herramientas utiles
apt-get install -y curl wget git htop

# Crear directorio para aplicacion
mkdir -p /opt/fintech-app
cd /opt/fintech-app

# Crear aplicacion basica (placeholder)
# En produccion, descargar desde repo Git
cat > server.js <<'EOF'
const http = require('http');

const server = http.createServer((req, res) => {
  if (req.url === '/health') {
    res.writeHead(200, {'Content-Type': 'application/json'});
    res.end(JSON.stringify({status: 'ok', timestamp: new Date().toISOString()}));
  } else {
    res.writeHead(200, {'Content-Type': 'text/plain'});
    res.end('Fintech API - Running\n');
  }
});

const PORT = process.env.PORT || 8080;
server.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
EOF

# Iniciar aplicacion
nohup node server.js > /var/log/fintech-app.log 2>&1 &

# Crear systemd service para persistencia
cat > /etc/systemd/system/fintech-app.service <<'EOF'
[Unit]
Description=Fintech Application
After=network.target

[Service]
Type=simple
User=root
WorkingDirectory=/opt/fintech-app
ExecStart=/usr/bin/node server.js
Restart=always
RestartSec=10
StandardOutput=append:/var/log/fintech-app.log
StandardError=append:/var/log/fintech-app-error.log

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable fintech-app.service
systemctl start fintech-app.service

echo "Setup completado en $(date)" >> /var/log/fintech-setup.log
