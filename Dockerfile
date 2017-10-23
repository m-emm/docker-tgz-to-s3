FROM alpine:3.5

MAINTAINER Markus Emmenegger <https://github.com/m-emm>

RUN apk update
RUN apk add python py-setuptools unzip curl

RUN curl --output master.zip https://codeload.github.com/s3tools/s3cmd/zip/master && \
   unzip master.zip && \
   cd s3cmd-master/ && \
   python setup.py install

ADD s3cfg /root/.s3cfg

ADD start.sh /start.sh
RUN chmod +x /start.sh

CMD ["/start.sh"]