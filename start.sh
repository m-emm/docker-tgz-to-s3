#! /bin/sh
ACCESS_KEY=${ACCESS_KEY:?"ACCESS_KEY env variable is required"}
SECRET_KEY=${SECRET_KEY:?"SECRET_KEY env variable is required"}
S3_PATH=${S3_PATH:?"S3_PATH env variable is required"}
DATA_PATH=${DATA_PATH:-/data/}
FILEPREFIX=${FILEPREFIX:-backup_}
FILESUFFIX=${FILESUFFIX:-.tgz}
TIMESTAMP_GENERATED=`( echo "import datetime" ; echo "print(datetime.datetime.now().strftime('%Y%m%d%H%M%S'))" ) | python `
TIMESTAMP=${TIMESTAMP:-$TIMESTAMP_GENERATED}
echo "access_key=$ACCESS_KEY" >> /root/.s3cfg
echo "secret_key=$SECRET_KEY" >> /root/.s3cfg
TMP_FILENAME=/tmp/${FILEPREFIX}${TIMESTAMP}${FILESUFFIX}
tar cvfz ${TMP_FILENAME} ${DATA_PATH}
exec s3cmd put --mime-type application/gzip --verbose "$FILENAME" "$S3_PATH"
