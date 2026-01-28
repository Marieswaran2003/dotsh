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

cat > /home/student/podman-compose.yml 

# Start the containers using Podman Compose

echo "Pull a image from docker.io"
sudo -u student docker pull docker.io/library/mariadb

echo "Logging into Docker registry as student..."
sudo -u student bash -c 'echo "redhat321" | podman login docker.io -u admin034 --password-stdin'

# Step 6: Install httpd, enable and start the service
echo "Installing httpd server..."
sudo dnf install httpd -y

echo "Enabling and starting httpd service..."
sudo systemctl enable httpd
sudo systemctl start httpd


echo "All tasks completed successfully. Good luck!"
echo "Your Eligible for practice now..!!"






