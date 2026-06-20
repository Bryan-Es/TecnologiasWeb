#!/bin/bash
# Genera el archivo de pre-boot con los valores REALES de las variables de entorno
# (Payara no expande variables de entorno en pre-boot commands, el shell sí)
cat > /opt/payara/preboot-commands.txt << EOF
create-jdbc-connection-pool --datasourceclassname=com.mysql.cj.jdbc.MysqlDataSource --restype=javax.sql.DataSource --property serverName=${MYSQLHOST}:portNumber=${MYSQLPORT}:databaseName=${MYSQLDATABASE}:user=${MYSQLUSER}:password=${MYSQLPASSWORD}:useSSL=false:allowPublicKeyRetrieval=true empresa_db_pool
create-jdbc-resource --connectionpoolid=empresa_db_pool jdbc/empresa_db
EOF

echo "[Setup] Pool JDBC generado con host: ${MYSQLHOST}, db: ${MYSQLDATABASE}"

# Llama al entrypoint original de Payara
exec /opt/payara/entrypoint.sh
