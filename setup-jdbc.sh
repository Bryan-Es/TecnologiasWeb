#!/bin/bash
set -e

# Usa la variable PREBOOT_COMMANDS si existe, sino el path por defecto de Payara
PREBOOT_FILE="${PREBOOT_COMMANDS:-/opt/payara/preboot-commands.txt}"

echo "================================================"
echo "[Setup] Configurando pool JDBC para MySQL..."
echo "[Setup] Host:     ${MYSQLHOST}"
echo "[Setup] Puerto:   ${MYSQLPORT:-3306}"
echo "[Setup] Database: ${MYSQLDATABASE}"
echo "[Setup] Usuario:  ${MYSQLUSER}"
echo "================================================"

# Agrega los comandos JDBC al archivo de pre-boot de Payara (sin sobrescribir)
cat >> "$PREBOOT_FILE" << EOF
create-jdbc-connection-pool --datasourceclassname=com.mysql.cj.jdbc.MysqlDataSource --restype=javax.sql.DataSource --property serverName=${MYSQLHOST}:portNumber=${MYSQLPORT:-3306}:databaseName=${MYSQLDATABASE}:user=${MYSQLUSER}:password=${MYSQLPASSWORD}:useSSL=false:allowPublicKeyRetrieval=true empresa_db_pool
create-jdbc-resource --connectionpoolid=empresa_db_pool jdbc/empresa_db
EOF

echo "[Setup] Comandos JDBC escritos en: $PREBOOT_FILE"
echo "[Setup] Contenido del archivo pre-boot:"
cat "$PREBOOT_FILE"
echo "================================================"
echo "[Setup] Iniciando Payara..."

# Llama al entrypoint original de Payara pasando todos los argumentos
exec /opt/payara/entrypoint.sh "$@"
