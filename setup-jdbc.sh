#!/bin/bash

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

# Diagnostico: encontrar el entrypoint real de Payara
echo "[Setup] Buscando entrypoint de Payara..."
ls -la /opt/payara/ 2>/dev/null || true
find /opt/payara -maxdepth 2 -name "*.sh" 2>/dev/null | sort || true

# Intentar los paths mas comunes del entrypoint de Payara
if [ -f "/opt/payara/entrypoint.sh" ]; then
    echo "[Setup] Usando: /opt/payara/entrypoint.sh"
    exec /opt/payara/entrypoint.sh "$@"
elif [ -f "/entrypoint.sh" ]; then
    echo "[Setup] Usando: /entrypoint.sh"
    exec /entrypoint.sh "$@"
elif [ -f "/opt/payara/scripts/entrypoint.sh" ]; then
    echo "[Setup] Usando: /opt/payara/scripts/entrypoint.sh"
    exec /opt/payara/scripts/entrypoint.sh "$@"
elif [ -f "/opt/payara/bin/entrypoint.sh" ]; then
    echo "[Setup] Usando: /opt/payara/bin/entrypoint.sh"
    exec /opt/payara/bin/entrypoint.sh "$@"
else
    echo "[Setup] ERROR: No se encontro el entrypoint. Contenido de /opt/payara/:"
    ls -la /opt/payara/
    exit 1
fi
