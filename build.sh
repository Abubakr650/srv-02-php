#!/bin/bash
# build.sh - PHP Version
# سكريبت تثبيت وتشغيل نسخة PHP على EC2 (Ubuntu)
# ملاحظة: تم استبدال AWS CodeCommit بـ GitHub / GitLab
# (AWS CodeCommit تم إيقافه رسمياً في يوليو 2024)

# =============================================
# الإعدادات - عدّل هذه القيم قبل التشغيل
# =============================================

# --- GitHub ---
# REPO_URL="https://github.com/YOUR_USERNAME/YOUR_REPO.git"

# --- GitLab ---
# REPO_URL="https://gitlab.com/YOUR_USERNAME/YOUR_REPO.git"

# إذا كان الريبو Private، استخدم Personal Access Token:
# REPO_URL="https://YOUR_TOKEN@github.com/YOUR_USERNAME/YOUR_REPO.git"
# REPO_URL="https://oauth2:YOUR_TOKEN@gitlab.com/YOUR_USERNAME/YOUR_REPO.git"

REPO_URL="https://github.com/YOUR_USERNAME/srv-02-php.git"
REPO_DIR="srv-02-php"
DEPLOY_DIR="/var/www/html"

# =============================================
# 1. تحديث النظام
# =============================================
echo "=== Updating system ==="
apt update
apt upgrade -y

# =============================================
# 2. تثبيت PHP و Apache
# =============================================
echo "=== Installing PHP & Apache ==="
apt install -y php php-cli apache2 libapache2-mod-php

# =============================================
# 3. تثبيت Git
# (لا حاجة لـ AWS CLI بعد الآن)
# =============================================
echo "=== Installing Git ==="
apt install -y git

# =============================================
# 4. استنساخ المشروع من GitHub / GitLab
# =============================================
echo "=== Cloning repo from GitHub/GitLab ==="
cd /home/ubuntu
sudo -u ubuntu git clone "$REPO_URL" "$REPO_DIR"

if [ ! -d "$REPO_DIR" ]; then
    echo "ERROR: Clone failed! Check REPO_URL and access token."
    exit 1
fi

cd "$REPO_DIR"

# =============================================
# 5. نسخ ملفات PHP إلى Apache
# =============================================
echo "=== Deploying PHP files ==="
mkdir -p "$DEPLOY_DIR"
cp -r . "$DEPLOY_DIR/"

# ضبط الصلاحيات
chown -R www-data:www-data "$DEPLOY_DIR/"
chmod -R 755 "$DEPLOY_DIR/"

# =============================================
# 6. تفعيل Apache وتشغيله
# =============================================
echo "=== Starting Apache ==="
systemctl enable apache2
systemctl start apache2

echo ""
echo "=== Done! ==="
echo "Access your app: http://$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)"
