## AWS CLI in Docker
This image allows you to run aws cli commands either from the container itself,
or as a simple command piped to the container. The advantage is that you do not 
need to install aws cli and each container connects to a different aws account, thereby 
avoiding multiple profiles.
Build time options:
 - change timezone (default is Hong Kong)
 - aws default region
 - aws access key id
 - aws secret access key

At build time, the aws access key id and aws secret access can be passed in. Take care not to
push an image to a registry with your details in! Timezone can be configured too. This is important as
if the host and Docker image times are not close, the aws commands will be rejected.

### Starting Out
Copy or download the github project. The commands below assume you have done this.
Alternatively you could extend with
FROM mononoke/aws-cli:latest

### Building the Image
Simple build, with keys:

$ docker build -t --build-arg aws_access_key_id=<id> --build-arg aws_secret_access_key=<key>  awscli .

Change the timezone

$ docker build -t --build-arg timezone="Asia/Tokyo" awscli .
 
### Running the Image
You can run the image and set the keys, timezone etc at run time. This is the safer option.

#### In the background
Run in the background and set the access keys:

docker run -d -e AWS_ACCESS_KEY_ID=1234 -e AWS_SECRET_ACCESS_KEY=1234 --name aws-home-account awscli /script/./run.sh

#### then exec in
$ docker exec -it <image-id> sh

#### Run a command inside the container
$ aws ec2 describe-instance

#### Single commands

$ docker run -it awscli aws ec2 describe-instances

### Other commands

#### Stop the container

$ docker container stop <container-id>


#### Start the Container

$ docker container start <container-id>


### Other Information
Changing timezone is a build time parameter, based on the documentation:
https://wiki.alpinelinux.org/wiki/Setting_the_timezone
Default output for aws results is json
Profiles are not supported to prevent the image being overloaded. If you want to do that, I would suggest
giving the containers names.
