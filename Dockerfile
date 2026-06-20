# Usamos la version estable y estandar de Payara 5
FROM payara/server-full:5.2022.5

# Forzamos a Java a usar un maximo de 300MB de RAM para evitar el OOM Killer
ENV JAVA_TOOL_OPTIONS="-Xmx300m"

# Driver MySQL en el lib GLOBAL del servidor
COPY web/WEB-INF/lib/mysql-connector-j-9.7.0.jar /opt/payara/appserver/glassfish/lib/

# Colocamos nuestro script como init_0 para que Payara lo ejecute automaticamente
# ANTES de init_1_generate_deploy_commands.sh (orden alfabetico garantiza esto)
# No se necesita chmod ni override de ENTRYPOINT
COPY setup-jdbc.sh /opt/payara/scripts/init_0_setup_jdbc.sh

# Copiamos el archivo .war generado por NetBeans
COPY dist/TecnologiasWeb.war $DEPLOY_DIR