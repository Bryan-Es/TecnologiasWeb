# Usamos la version estable y estandar de Payara 5
FROM payara/server-full:5.2022.5

# Forzamos a Java a usar un maximo de 300MB de RAM para evitar el OOM Killer
ENV JAVA_TOOL_OPTIONS="-Xmx300m"

# IMPORTANTE: Copiar el driver MySQL al lib GLOBAL del servidor (no al domain1/lib)
# El lib global garantiza que el driver este disponible en el classpath del servidor
COPY web/WEB-INF/lib/mysql-connector-j-9.7.0.jar /opt/payara/appserver/glassfish/lib/

# Script que genera los comandos JDBC con los valores reales de las variables de entorno
COPY setup-jdbc.sh /opt/payara/setup-jdbc.sh
RUN chmod +x /opt/payara/setup-jdbc.sh

# Copiamos el archivo .war generado por NetBeans
COPY dist/TecnologiasWeb.war $DEPLOY_DIR

# Usamos nuestro script como entrypoint
ENTRYPOINT ["/bin/bash", "/opt/payara/setup-jdbc.sh"]