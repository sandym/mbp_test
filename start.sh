#!/bin/sh



docker build -t mbp_test .
docker build --platform linux/amd64 -t mbp_test_x86_64 .

docker run --rm \
		-ti \
		--mount 'type=volume,src=vmbp_test,dst=/work' \
		mbp_test_x86_64 bash
