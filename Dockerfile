# Usamos la version estable y estandar de Payara 5
FROM payara/server-full:5.2022.5

# Forzamos a Java a usar un maximo de 300MB de RAM para evitar el OOM Killer
ENV JAVA_TOOL_OPTIONS="-Xmx300m"

# Copiamos el archivo .war generado por NetBeans
COPY dist/TecnologiasWeb.war $DEPLOY_DIR