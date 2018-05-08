###
# Information and Instructions
###
# Dockerfile for running aws cli commands
# docker build -t awscli --build-arg aws_default_region=ap-northeast-1 --build-arg aws_access_key_id= --build-arg aws_secret_access_key= .
# Refer to the read me for usage.

FROM alpine:3.6

MAINTAINER fergus <fergusmacdermot@gmail.com>
RUN apk update && apk add tzdata bash curl less groff jq python py-pip py2-pip && \ 
     pip install --upgrade pip awscli s3cmd && \
     mkdir /root/.aws

RUN mkdir /script

# default value - this is overridden at build time or run time like this:
# --build-arg TIMEZONE="Asia/Tokyo', -e TIMEZONE="Asia/Tokyo"
ARG timezone="Asia/Shanghai"
ENV TIMEZONE ${timezone}

ARG aws_access_key_id=
ENV AWS_ACCESS_KEY_ID ${aws_access_key_id}

ARG aws_secret_access_key=
ENV AWS_SECRET_ACCESS_KEY ${aws_secret_access_key}

ARG aws_default_region="ap-southeast-1"
ENV AWS_DEFAULT_REGION ${aws_default_region}

ENV AWS_DEFAULT_OUTPUT json

WORKDIR /script
RUN ln -sf /usr/share/zoneinfo/$TIMEZONE /etc/localtime
COPY run.sh /script
