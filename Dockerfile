# Usamos la version estable y estandar de Payara 5
FROM payara/server-full:5.2022.5

# Forzamos a Java a usar un maximo de 300MB de RAM para evitar el OOM Killer
ENV JAVA_TOOL_OPTIONS="-Xmx300m"

# Instalamos el driver de MySQL en la carpeta global de librerias de Payara
COPY web/WEB-INF/lib/mysql-connector-j-9.7.0.jar /opt/payara/appserver/glassfish/domains/domain1/lib/

# Script que genera los pre-boot commands con los valores reales de las env vars
COPY setup-jdbc.sh /opt/payara/setup-jdbc.sh
RUN chmod +x /opt/payara/setup-jdbc.sh

# Copiamos el archivo .war generado por NetBeans
COPY dist/TecnologiasWeb.war $DEPLOY_DIR

# Usamos nuestro script como entrypoint para inyectar el pool JDBC antes de que Payara arranque
ENTRYPOINT ["/bin/bash", "/opt/payara/setup-jdbc.sh"]