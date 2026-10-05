@echo off
echo [1] Dang tat Tomcat...
call "D:\Eclipse\apache-tomcat-10.1.59\bin\shutdown.bat"

echo [2] Xoa ban cu trong Tomcat...
del /Q /F "D:\Eclipse\apache-tomcat-10.1.59\webapps-javaee\BookStore_20133096*.war"
rmdir /S /Q "D:\Eclipse\apache-tomcat-10.1.59\webapps\BookStore_20133096"
rmdir /S /Q "D:\Eclipse\apache-tomcat-10.1.59\webapps\BookStore_20133096-1.0-SNAPSHOT"

echo [3] Copy ban moi tu Target sang webapps-javaee...
copy "D:\Download\BookStore_20133096/target\BookStore_20133096-1.0-SNAPSHOT.war" "D:\Eclipse\apache-tomcat-10.1.59\webapps-javaee\BookStore_20133096.war"

echo [4] Khoi dong lai Tomcat...
call "D:\Eclipse\apache-tomcat-10.1.59\bin\startup.bat"

echo XONG! Moi ban F5 trinh duyet!