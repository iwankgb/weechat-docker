Weechat image
=============

I use this image to run [Weechat](https://weechat.org/). It is built automatically on [https://quay.io/repository/iwankgb/weechat-docker](https://quay.io/repository/iwankgb/weechat-docker).

If you care about your ident then make sure that some information are passed into the container (IDs of user and group, and username):
````bash
docker run --env=USERNAME=`id -un` --env=USERID=`id -u` --env=GROUPID=`id -g` --network host -ti -v ~/.weechat:/home/`id -un`/.weechat quay.io/iwankgb/weechat-docker
````

If you don't give a shit then just run:
````bash
docker run -ti -v ~/.weechat:/home/weechat/.weechat quay.io/iwankgb/weechat-docker
````
