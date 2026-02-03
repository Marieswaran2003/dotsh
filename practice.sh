# Ensure the 'student' user exists

loginctl enable-linger student

rm -rf /home/student/*

# Ensure the necessary directories exist and permissions are correct

echo "Creating directory structure..."

mkdir -p /home/student/projects/nginx/html/
mkdir -p /home/student/projects/mariadb/
mkdir -p /home/student/projects/mariadb/exports
mkdir -p /home/student/projects/mariadb/scripts

sudo chown -R student:student /home/student/projects/nginx/html/
sudo chown -R student:student /home/student/projects/mariadb/
sudo chown -R student:student /home/student/projects/mariadb/exports
sudo chown -R student:student /home/student/projects/mariadb/scripts


cat > /home/student/projects/mariadb/scripts/export.sh <<EOF
mysql -u root -pacme mysql > /home/app.sql
EOF


sudo chown student:student /home/student/projects/mariadb/scripts/export.sh
sudo chmod +x  /home/student/projects/mariadb/scripts/export.sh
sudo chmod 755  /home/student/projects/mariadb/scripts/export.sh
sudo chmod 755  /home/student/projects/mariadb/scripts/



cat > /home/student/projects/mariadb/acme_containerfile <<EOF

#add the base images mariadb:latest

#add the arguments

#add the environement variable 

EOF

sudo chown student:student /home/student/projects/mariadb/acme_containerfile

cat > /home/student/projects/mariadb/acme_export_containerfile <<EOF

#add containerfile

EOF

sudo chown student:student /home/student/projects/mariadb/acme_export_containerfile
echo "Directory created and ownership set: /home/student/projects/nginx/index.html"

echo "Creating index.html file..."
echo "<html><body><h1>Yes u done 1st question correctly</h1></body></html>" > /home/student/projects/nginx/html/index.html
sudo chown student:student /home/student/projects/nginx/html/index.html
echo "File created: /home/student/projects/nginx/html/index.html"


# Step 2: Deploy the Nginx container

sudo dnf install container-tools -y
sudo dnf install nginx -y


# Define variables


mkdir -p /home/student/projects/nginx_web/html
mkdir -p /home/student/projects/nginx_web/conf

# Change ownership to root
echo "Changing ownership of directories to root..."
sudo chown -R student:student /home/student/projects/nginx_web/html/
sudo chown -R student:student /home/student/projects/nginx_web/conf/
rm -rf /home/student/projects/nginx_web/index.html
echo "<html><body><h1>Im running successfully man all the best for your exams" > /home/student/projects/nginx_web/html/index.html
# Step 1: Create the default.conf for Nginx
echo "Creating default.conf for Nginx"
cat > /home/student/projects/nginx_web/conf/default.conf <<EOF
# For more information on configuration, see:
#   * Official English Documentation: http://nginx.org/en/docs/
#   * Official Russian Documentation: http://nginx.org/ru/docs/


worker_processes auto;
error_log /var/log/nginx/error.log;
pid /run/nginx.pid;

# Load dynamic modules. See /usr/share/doc/nginx/README.dynamic.
include /usr/share/nginx/modules/*.conf;

events {
    worker_connections 1024;
}

http {
    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    

    sendfile            on;
    tcp_nopush          on;
    tcp_nodelay         on;
    keepalive_timeout   65;
    types_hash_max_size 2048;

    include             /etc/nginx/mime.types;
    default_type        application/octet-stream;

    # Load modular configuration files from the /etc/nginx/conf.d directory.
    # See http://nginx.org/en/docs/ngx_core_module.html#include
    # for more information.
    include /etc/nginx/conf.d/*.conf;

    server {
        listen       8080 default_server;
        server_name  _;
        root         /usr/share/nginx/html/;

        # Load configuration files for the default server block.
        include /etc/nginx/default.d/*.conf;

        location / {
        }

        error_page 404 /404.html;
            location = /40x.html {
        }

        error_page 500 502 503 504 /50x.html;
            location = /50x.html {
        }
    }
}
EOF


echo "Logging into Docker registry as student..."
sudo -u student bash -c 'echo "redhat321" | podman login docker.io -u admin034 --password-stdin'

sudo -u student bash -c 'echo "developer" | podman login registry.ocp4.example.com:8443 -u developer --password-stdin'


sudo podman pull docker.io/library/mariadb

echo "Logging into Docker registry as student..."

# Step 6: Install httpd, enable and start the service
echo "Installing httpd server..."
sudo dnf install httpd -y

echo "Enabling and starting httpd service..."
sudo systemctl enable httpd
sudo systemctl start httpd


echo "All tasks completed successfully. Good luck!"
echo "Your Eligible for practice now..!!"






