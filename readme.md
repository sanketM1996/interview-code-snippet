# for docker file


# 🚀 Nginx Docker Setup using Ubuntu 20.04

This project demonstrates how to create a Docker image using Ubuntu 20.04 
and run an Nginx web server inside a container.

---

# 📦 Prerequisites

- Docker installed
- Basic knowledge of Docker commands

Check Docker installation:
docker --version

---

# 📁 Project Structure

.
├── Dockerfile
└── index.html   # (optional custom file)

---

# 🐳 Dockerfile Explanation
```bash
FROM ubuntu:20.04
# Use Ubuntu 20.04 as base image

RUN apt-get update && apt-get install -y nginx
# Install Nginx web server

RUN rm -f /var/www/html/index.nginx-debian.html
# Remove default Nginx page

# COPY ./index.html /var/www/html/
# Copy your custom HTML file (optional)

EXPOSE 80
# Expose port 80

CMD ["nginx", "-g", "daemon off;"]
# Run Nginx in foreground
```


---

# 🔨 Build Docker Image
```bash
docker build -t nginx-ubuntu .
```
---

# ▶️ Run Container
```bash
docker run -d -p 8080:80 --name nginx-container nginx-ubuntu
```

---

# 🌐 Access Application
```bash
Open browser:
http://localhost:8080
```
---

# 🛑 Stop Container
```bash
docker stop nginx-container
```
---

# ❌ Remove Container
```bash
docker rm nginx-container
```
---

# 🧹 Remove Image
```bash
docker rmi nginx-ubuntu
```
---

# 📌 Notes

- If using custom HTML, uncomment COPY line in Dockerfile
- Ensure index.html is in same directory as Dockerfile
- Port mapping: 8080 (host) → 80 (container)

---

# ✅ Output

You will see your Nginx web page running inside Docker 🚀

---
# 🚀 Jenkins Pipeline: Install & Deploy Nginx Website

This pipeline installs Nginx, deploys a custom index.html file,
and manages the Nginx service.

---

# ⚙️ Prerequisites

# Add Jenkins user to sudoers file
sudo visudo

# Add below line:
jenkins ALL=(ALL) NOPASSWD: ALL

# Add Jenkins user to root group (optional)
sudo usermod -aG root jenkins

---
```bash
# 📄 Jenkinsfile (Pipeline Script)

pipeline {
    agent any

    stages {

        stage('Install Nginx') {
            steps {
                sh 'sudo apt update -y'
                sh 'sudo apt install nginx -y'
            }
        }

        stage('Deploy Index File') {
            steps {
                sh '''
                echo "Welcome to Young Minds. Keep Learning!! Keep Growing!!" > index.html
                sudo mv index.html /var/www/html/index.html
                '''
            }
        }

        stage('Stop Nginx') {
            steps {
                sh 'sudo systemctl stop nginx'
            }
        }

        stage('Start Nginx') {
            steps {
                sh 'sudo systemctl start nginx'
            }
        }

    }
}
```
---

# ❗ Fixes Applied
```bash
# 1. Removed incorrect sudo with echo redirection
#    ❌ sudo echo "text" > file
#    ✅ echo "text" > file && sudo mv file ...

# 2. Used multi-line shell (''' ''') for better readability

# 3. Fixed stage naming conventions (clean & readable)
```
---

# ▶️ How to Run
```bash
1. Create a Jenkins Pipeline job
2. Add this Jenkinsfile
3. Run Build
```
---

# 🌐 Verify Output
```bash
Open browser:
http://<your-server-ip>
```
You should see:
"Welcome to Young Minds. Keep Learning!! Keep Growing!!"

---

# 🛑 Optional Improvements
```bash
# Restart instead of stop/start
sudo systemctl restart nginx

# Enable Nginx on boot
sudo systemctl enable nginx
```
---

# ✅ Output
```bash
- Nginx installed automatically
- Custom HTML deployed
- Service managed via pipeline 🚀
```