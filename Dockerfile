# Usamos la version estable y estandar de Payara 5
FROM payara/server-full:5.2022.5

# Forzamos a Java a usar un maximo de 300MB de RAM para evitar el OOM Killer
ENV JAVA_TOOL_OPTIONS="-Xmx300m"

# Instalamos el driver de MySQL en la carpeta global de librerias de Payara
COPY web/WEB-INF/lib/mysql-connector-j-9.7.0.jar /opt/payara/appserver/glassfish/domains/domain1/lib/

# Script de pre-configuracion: registra el pool JDBC y el recurso ANTES de desplegar el WAR
COPY pre-boot-commands.txt $PAYARA_PATH/pre-boot-commands.txt

# Copiamos el archivo .war generado por NetBeans
COPY dist/TecnologiasWeb.war $DEPLOY_DIR