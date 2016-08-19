#!/bin/sh
aws s3 cp /tmp/motion/`ls -t1 /tmp/motion/ | head -n 1` s3://forest-storage/images/now.jpg --acl public-read --profile=/etc/aws-forest.conf
aws s3 cp s3://forest-storage/images/now.jpg s3://forest-storage/images/`date "+%Y%m%d_%H%M%S"`.jpg --acl public-read --profile=/etc/aws-forest.conf

