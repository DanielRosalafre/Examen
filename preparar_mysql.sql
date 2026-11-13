CREATE DATABASE IF NOT EXISTS api_animales_php CHARACTER SET utf8mb4;
CREATE USER IF NOT EXISTS 'animales_php'@'127.0.0.1' IDENTIFIED BY 'animales_local_2026';
GRANT ALL PRIVILEGES ON api_animales_php.* TO 'animales_php'@'127.0.0.1';
