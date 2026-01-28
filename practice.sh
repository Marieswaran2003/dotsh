# Ensure the 'student' user exists

if ! id "student" &>/dev/null; then

	    echo "Creating user 'student'..."

	        useradd -m student

		    echo "User 'student' created successfully."

	    else

		        echo "User 'student' already exists."

fi

loginctl enable-linger student

rm -rf /home/student/*

# Ensure the necessary directories exist and permissions are correct

echo "Creating directory structure..."

mkdir -p /home/student/projects/nginx/html/
mkdir -p /home/student/projects/mariadb/
mkdir -p /home/student/projects/mariadb/exports
mkdir -p /home/student/projects/mariadb/scripts

chown -R student:student /home/student/projects/nginx/html/
chown -R student:student /home/student/projects/mariadb/
chown -R student:student /home/student/projects/mariadb/exports
chown -R student:student /home/student/projects/mariadb/scripts


cat > /home/student/projects/mariadb/scripts/export.sh <<EOF
mysql -u root -pacme mysql > /home/app.sql
EOF


chown student:student /home/student/projects/mariadb/scripts/export.sh
chmod +x  /home/student/projects/mariadb/scripts/export.sh
chmod 755  /home/student/projects/mariadb/scripts/export.sh
chmod 755  /home/student/projects/mariadb/scripts/



cat > /home/student/projects/mariadb/acme_containerfile <<EOF

#add the base images

#add the arguments

#add the environement variable 

EOF

chown student:student /home/student/projects/mariadb/acme_containerfile

cat > /home/student/projects/mariadb/acme_export_containerfile <<EOF

#add containerfile

EOF

chown student:student /home/student/projects/mariadb/acme_export_containerfile
echo "Directory created and ownership set: /home/student/projects/nginx/index.html"

echo "Creating index.html file..."
echo "<html><body><h1>Yes u done 1st question correctly</h1></body></html>" > /home/student/projects/nginx/html/index.html
chown student:student /home/student/projects/nginx/html/index.html
echo "File created: /home/student/projects/nginx/html/index.html"


# Step 2: Deploy the Nginx container

dnf install container-tools -y
dnf install nginx -y


# Define variables


mkdir -p /home/student/projects/nginx_web/html
mkdir -p /home/student/projects/nginx_web/conf

# Change ownership to root
echo "Changing ownership of directories to root..."
chown -R student:student /home/student/projects/nginx_web/html/
chown -R student:student /home/student/projects/nginx_web/conf/
rm -rf /home/student/projects/nginx_web/index.html
echo "<html><body><h1>Im running successfully man all the best for your exams" > /home/student/projects/nginx_web/html/index.html
# Step 1: Create the default.conf for Nginx
echo "Creating default.conf for Nginx"
cat > /home/student/projects/nginx_web/conf/default.conf <<EOF
server {
    listen       80;
    server_name  localhost;

    # Define the root directory where the HTML files are mounted
    root   /usr/share/nginx/html;

    # Default page for the server
    index  index.html;

    # Main location block to serve files
    location / {
        try_files \$uri \$uri/ =404;
    }
}
EOF

cat > /home/student/podman-compose.yml <<EOF
version: '3.9'
services:
  acme-wp-db:
    image: quay.io/myacme/mariadb:1.0
    container_name: mariadb
    networks:
      - acme-wp-net
    volumes:
      - acme-wp-backend:/bitnami/mariadb
    restart: always

  acme-nginx:
    image: quay.io/myacme/nginx
    container_name: acme-wp-app
    networks:
      - acme-wp-net
    volumes:
      - acme-wp-app:/etc/nginx
    restart: always

  acme-wp-nginx:
    image: quay.io/myacme/wordpress:1.0
    container_name: acme-wordpress
    networks:
      - acme-wp-net
    volumes:
      - acme-wordpress-data:/bitnami/wordpress
    ports:
      - "8004:8080"
      - "8443:8443"
    restart: always

networks:
  acme-wp-net:
    external: true

volumes:
  acme-wp-backend:
    external: true
  acme-wp-app:
    external: true
  acme-wordpress-data:
    external: true
EOF

# Start the containers using Podman Compose
ssh student@workstation podman-compose up -d

echo "Pull a image from docker.io"
sudo -u student docker pull docker.io/library/mariadb

echo "Logging into Docker registry as student..."
sudo -u student bash -c 'echo "redhat321" | podman login docker.io -u admin034 --password-stdin'

# Step 6: Install httpd, enable and start the service
echo "Installing httpd server..."
dnf install httpd -y

echo "Enabling and starting httpd service..."
systemctl enable httpd
systemctl start httpd


echo "All tasks completed successfully. Good luck!"
echo "Your Eligible for practice now..!!"






