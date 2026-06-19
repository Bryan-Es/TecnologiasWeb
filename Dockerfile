
# Usamos la versión estable y estándar de Payara 5
FROM payara/server-full:5.2022.5

# Copiamos el archivo .war generado por NetBeans
COPY dist/TecnologiasWeb.war $DEPLOY_DIR