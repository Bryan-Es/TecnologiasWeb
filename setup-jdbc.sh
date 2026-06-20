#!/bin/bash
# Este script es ejecutado AUTOMATICAMENTE por el entrypoint de Payara
# antes de init_1_generate_deploy_commands.sh (orden alfabetico: init_0 < init_1)
# NO necesita llamar ningun entrypoint - Payara lo hace despues de este script

PREBOOT_FILE="${PREBOOT_COMMANDS:-/opt/payara/preboot-commands.txt}"

echo "================================================"
echo "[Setup] Configurando pool JDBC para MySQL..."
echo "[Setup] Host:     ${MYSQLHOST}"
echo "[Setup] Puerto:   ${MYSQLPORT:-3306}"
echo "[Setup] Database: ${MYSQLDATABASE}"
echo "[Setup] Usuario:  ${MYSQLUSER}"
echo "================================================"

# Escribe los comandos (sobrescribe para evitar duplicados en reinicios)
cat > "$PREBOOT_FILE" << EOF
create-jdbc-connection-pool --datasourceclassname=com.mysql.cj.jdbc.MysqlDataSource --restype=javax.sql.DataSource --property serverName=${MYSQLHOST}:portNumber=${MYSQLPORT:-3306}:databaseName=${MYSQLDATABASE}:user=${MYSQLUSER}:password=${MYSQLPASSWORD}:useSSL=false:allowPublicKeyRetrieval=true empresa_db_pool
create-jdbc-resource --connectionpoolid=empresa_db_pool jdbc/empresa_db
EOF

echo "[Setup] Pool JDBC escrito en: $PREBOOT_FILE"
echo "[Setup] Listo. Payara continuara con init_1..."
