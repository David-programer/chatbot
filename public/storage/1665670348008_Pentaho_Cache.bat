@echo off
echo Borrando Archivo Pentaho Cache
attrib archivo.bat +r
cd C:\Users\juan.herrera\.kettle
del /f /q db.cache-9.1.0.0-324
echo El archivo fue borrado con exito
attrib archivo.bat -r
exit