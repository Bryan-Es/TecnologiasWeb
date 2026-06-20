# Usamos la version estable y estandar de Payara 5
FROM payara/server-full:5.2022.5

# Forzamos a Java a usar un maximo de 300MB de RAM para evitar el OOM Killer
ENV JAVA_TOOL_OPTIONS="-Xmx300m"

# IMPORTANTE: Copiar el driver MySQL al lib GLOBAL del servidor
# El lib global garantiza que el driver este disponible en el classpath del servidor
COPY web/WEB-INF/lib/mysql-connector-j-9.7.0.jar /opt/payara/appserver/glassfish/lib/

# Script que genera los comandos JDBC con los valores reales de las variables de entorno
# No necesita chmod porque el ENTRYPOINT llama a /bin/bash directamente
COPY setup-jdbc.sh /opt/payara/setup-jdbc.sh

# Copiamos el archivo .war generado por NetBeans
COPY dist/TecnologiasWeb.war $DEPLOY_DIR

# Bash ejecuta el script (no necesita permisos de ejecucion en el archivo)
ENTRYPOINT ["/bin/bash", "/opt/payara/setup-jdbc.sh"]