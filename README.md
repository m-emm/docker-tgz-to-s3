Docker tar-gzip to Amazon S3
===================

Docker container which tar-gzips a directory, adds a timestamp to the filename, and uploads the result to S3 using [s3cmd put](http://s3tools.org/s3cmd).
Based on alpine, yielding a rather small image.

### Usage

	docker run -d [OPTIONS] m-emm/docker-tgz-to-s3

### Parameters:

* `-e ACCESS_KEY=<AWS_KEY>`: Your AWS key.
* `-e SECRET_KEY=<AWS_SECRET>`: Your AWS secret.
* `-e S3_PATH=s3://<BUCKET_NAME>/<PATH>/`: S3 Bucket name and path. Should end with trailing slash. 
* `-v /path/to/backup:/data:ro`: mount target local folder to container's data folder.

### Optional parameters:

* `-e DATA_PATH=/data/`: container's data folder. Default is `/data/`. Should end with trailing slash.
* `-e FILEPREFIX=backup_`: the prefix for the file to be generated. Default is `backup_`. 
* `-e FILESUFFIX=.tgz`: the suffix for the tar-gzip file to be generated. Default is `.tgz`.
* `-e TIMESTAMP=54681848`: the timestamp in the name of the tar-gzip file. By default, a timestamp is generated in the format `YYYYMMDDHHMISS`.

### Example:

    docker run -d \
    	-e ACCESS_KEY=fakeawskey \
		-e SECRET_KEY=fakeawssecret \
		-e S3_PATH=s3://my-bucket/backup/ \
		-v /home/user/data:/data:ro	 \	
		 m-emm/docker-tgz-to-s3
		 
### Credit: istepanov - Ilya Stepanov and Rob N (robbydooo)

Heavily inspired by https://github.com/robbydooo/docker-backup-to-s3, with the following differences:
* tar-zips with a timestamp instead of sync
* no cron support
* based on alpine instead of ubuntu for a smaller image

		 