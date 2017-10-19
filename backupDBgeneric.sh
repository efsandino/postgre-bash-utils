# Historia de los parametros:
# $1 nombre de usuario
# $2 clave
# $3 nombre de base de datos
export PGPASSWORD=$2
#DATE=`date '+%Y-%m-%d %H:%M:%S'`
read YYYY MM DD HH M200 SS<<<$(date +'%Y %m %d %H %M %S')
fecha=$YYYY$MM$DD'_'$HH$M200$SS
export backupFNAME=$5"_"$3_$fecha
export backupFileName=$backupFNAME.gz
#/opt/PostgreSQL/9.6/bin/pg_dump --host localhost --port 5432 --username "$1" --no-password  --format plain --no-owner --section pre-data --section data --inserts --column-inserts --verbose --file "BACKUP_TELEFERICO_205_20170923.sql" "$3"
$4 --host localhost --port 5432 --username $1 --no-password  --format plain --no-owner --section pre-data --section data --inserts --column-inserts --verbose $3 | gzip > $backupFileName
clear
export comandillo="./bdBackupRestore.sh "`echo $1 $2 $3 $backupFNAME`
echo 
echo " Backup Automatico by Eduardo F. Sandino eduardos@sintesis.com.bo"
echo " Se ha generado un backup de su bd "$3 $backupFileName" para restaurar la misma utilize"
echo " el script restaurarBD.sh pasando el parametro como sigue a continuacion:"
echo 
echo "  "$comandillo
echo
echo " o ejecute el comando recientemente creado:"
echo
export restoreFileName=`echo $5"_restore"$3_$fecha".rx"`
echo "  ./"$restoreFileName
echo 
touch $restoreFileName
echo "gunzip -q "$backupFNAME".gz" >> $restoreFileName
echo $comandillo >> $restoreFileName
echo "gzip $backupFNAME" >> $restoreFileName
chmod +x $restoreFileName
