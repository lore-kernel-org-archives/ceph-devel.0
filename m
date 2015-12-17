From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: Re: rgw subuser create and admin api
Date: Thu, 17 Dec 2015 12:15:14 -0800
Message-ID: <CADRKj5SqdHyBsnUUo=aFUtMwC1qKhuHyhi_b_v-NOYzKYUhm4A@mail.gmail.com>
References: <5672EB1F.9070209@umiacs.umd.edu>
	<CADRKj5Ru=HhbhYGXq829oKPiB6Wr+9b8qgxjtmCn207xfCdc0Q@mail.gmail.com>
	<56730775.3070906@umiacs.umd.edu>
	<CADRKj5Rs4DeVGuZ-9hhFLNW2bMHQ44jsKjUtHw66yHApGVzD2g@mail.gmail.com>
	<567315A8.7070905@umiacs.umd.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:33294 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755443AbbLQUPP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Dec 2015 15:15:15 -0500
Received: by mail-oi0-f45.google.com with SMTP id y66so49045520oig.0
        for <ceph-devel@vger.kernel.org>; Thu, 17 Dec 2015 12:15:15 -0800 (PST)
In-Reply-To: <567315A8.7070905@umiacs.umd.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Derek Yarnell <derek@umiacs.umd.edu>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Dec 17, 2015 at 12:06 PM, Derek Yarnell <derek@umiacs.umd.edu> wrote:
> On 12/17/15 2:36 PM, Yehuda Sadeh-Weinraub wrote:
>> Try 'section=user&key=cephtests'
>
> Doesn't seem to work either.
>
> # radosgw-admin metadata get user:cephtest
> {
>     "key": "user:cephtest",
>     "ver": {
>         "tag": "_dhpzgdOjqJI-OsR1MsYV5-p",
>         "ver": 1
>     },
>     "mtime": 1450378246,
>     "data": {
>         "user_id": "cephtest",
>         "display_name": "Ceph Test",
>         "email": "",
>         "suspended": 0,
>         "max_buckets": 1000,
>         "auid": 0,
>         "subusers": [],
>         "keys": [
>             {
>                 "user": "cephtest",
>                 "access_key": "eeeeeeeeeeeeeee",
>                 "secret_key": "jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj"
>             },
>             {
>                 "user": "cephtest",
>                 "access_key": "aaaaaaaaaaaaaaa",
>                 "secret_key": "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb"
>             }
>         ],
>         "swift_keys": [],
>         "caps": [],
>         "op_mask": "read, write, delete",
>         "default_placement": "",
>         "placement_tags": [],
>         "bucket_quota": {
>             "enabled": false,
>             "max_size_kb": -1,
>             "max_objects": -1
>         },
>         "user_quota": {
>             "enabled": false,
>             "max_size_kb": -1,
>             "max_objects": -1
>         },
>         "temp_url_keys": []
>     }
> }
>
>
> 2015-12-17 15:03:41.126024 7f88ef7e6700 20 RGWEnv::set(): HTTP_HOST:
> localhost:7480
> 2015-12-17 15:03:41.126056 7f88ef7e6700 20 RGWEnv::set(): HTTP_DATE:
> Thu, 17 Dec 2015 20:03:41 GMT
> 2015-12-17 15:03:41.126059 7f88ef7e6700 20 RGWEnv::set(): HTTP_ACCEPT: */*
> 2015-12-17 15:03:41.126064 7f88ef7e6700 20 RGWEnv::set():
> HTTP_ACCEPT_ENCODING: gzip, deflate
> 2015-12-17 15:03:41.126066 7f88ef7e6700 20 RGWEnv::set():
> HTTP_AUTHORIZATION: AWS RTJ1TL13CH613JRU2PJD:F6wMKxSrrFhl2m3fyo/M0yXIGT8=
> 2015-12-17 15:03:41.126070 7f88ef7e6700 20 RGWEnv::set():
> HTTP_USER_AGENT: python-requests/2.3.0 CPython/2.7.10 Darwin/14.5.0
> 2015-12-17 15:03:41.126071 7f88ef7e6700 20 RGWEnv::set():
> HTTP_X_FORWARDED_FOR: 192.168.86.254
> 2015-12-17 15:03:41.126073 7f88ef7e6700 20 RGWEnv::set():
> HTTP_X_FORWARDED_HOST: ceph.umiacs.umd.edu
> 2015-12-17 15:03:41.126075 7f88ef7e6700 20 RGWEnv::set():
> HTTP_X_FORWARDED_SERVER: cephproxy00.umiacs.umd.edu
> 2015-12-17 15:03:41.126077 7f88ef7e6700 20 RGWEnv::set():
> HTTP_CONNECTION: Keep-Alive
> 2015-12-17 15:03:41.126079 7f88ef7e6700 20 RGWEnv::set():
> REQUEST_METHOD: GET
> 2015-12-17 15:03:41.126080 7f88ef7e6700 20 RGWEnv::set(): REQUEST_URI:
> /admin/metadata/get
> 2015-12-17 15:03:41.126081 7f88ef7e6700 20 RGWEnv::set(): QUERY_STRING:
> section=user&key=cephtest
> 2015-12-17 15:03:41.126082 7f88ef7e6700 20 RGWEnv::set(): REMOTE_USER:
> 2015-12-17 15:03:41.126083 7f88ef7e6700 20 RGWEnv::set(): SCRIPT_URI:
> /admin/metadata/get
> 2015-12-17 15:03:41.126089 7f88ef7e6700 20 RGWEnv::set(): SERVER_PORT: 7480
> 2015-12-17 15:03:41.126090 7f88ef7e6700 20 HTTP_ACCEPT=*/*
> 2015-12-17 15:03:41.126093 7f88ef7e6700 20 HTTP_ACCEPT_ENCODING=gzip,
> deflate
> 2015-12-17 15:03:41.126094 7f88ef7e6700 20 HTTP_AUTHORIZATION=AWS
> RTJ1TL13CH613JRU2PJD:F6wMKxSrrFhl2m3fyo/M0yXIGT8=
> 2015-12-17 15:03:41.126094 7f88ef7e6700 20 HTTP_CONNECTION=Keep-Alive
> 2015-12-17 15:03:41.126095 7f88ef7e6700 20 HTTP_DATE=Thu, 17 Dec 2015
> 20:03:41 GMT
> 2015-12-17 15:03:41.126095 7f88ef7e6700 20 HTTP_HOST=localhost:7480
> 2015-12-17 15:03:41.126096 7f88ef7e6700 20
> HTTP_USER_AGENT=python-requests/2.3.0 CPython/2.7.10 Darwin/14.5.0
> 2015-12-17 15:03:41.126097 7f88ef7e6700 20
> HTTP_X_FORWARDED_FOR=192.168.86.254
> 2015-12-17 15:03:41.126097 7f88ef7e6700 20
> HTTP_X_FORWARDED_HOST=ceph.umiacs.umd.edu
> 2015-12-17 15:03:41.126098 7f88ef7e6700 20
> HTTP_X_FORWARDED_SERVER=cephproxy00.umiacs.umd.edu
> 2015-12-17 15:03:41.126099 7f88ef7e6700 20
> QUERY_STRING=section=user&key=cephtest
> 2015-12-17 15:03:41.126099 7f88ef7e6700 20 REMOTE_USER=
> 2015-12-17 15:03:41.126100 7f88ef7e6700 20 REQUEST_METHOD=GET
> 2015-12-17 15:03:41.126101 7f88ef7e6700 20 REQUEST_URI=/admin/metadata/get
> 2015-12-17 15:03:41.126101 7f88ef7e6700 20 SCRIPT_URI=/admin/metadata/get
> 2015-12-17 15:03:41.126102 7f88ef7e6700 20 SERVER_PORT=7480
> 2015-12-17 15:03:41.126104 7f88ef7e6700 20 RGWEnv::set(): HTTP_HOST:
> localhost:7480
> 2015-12-17 15:03:41.126105 7f88ef7e6700 20 RGWEnv::set(): HTTP_DATE:
> Thu, 17 Dec 2015 20:03:41 GMT
> 2015-12-17 15:03:41.126107 7f88ef7e6700 20 RGWEnv::set(): HTTP_ACCEPT: */*
> 2015-12-17 15:03:41.126108 7f88ef7e6700 20 RGWEnv::set():
> HTTP_ACCEPT_ENCODING: gzip, deflate
> 2015-12-17 15:03:41.126110 7f88ef7e6700 20 RGWEnv::set():
> HTTP_AUTHORIZATION: AWS RTJ1TL13CH613JRU2PJD:F6wMKxSrrFhl2m3fyo/M0yXIGT8=
> 2015-12-17 15:03:41.126113 7f88ef7e6700 20 RGWEnv::set():
> HTTP_USER_AGENT: python-requests/2.3.0 CPython/2.7.10 Darwin/14.5.0
> 2015-12-17 15:03:41.126115 7f88ef7e6700 20 RGWEnv::set():
> HTTP_X_FORWARDED_FOR: 192.168.86.254
> 2015-12-17 15:03:41.126117 7f88ef7e6700 20 RGWEnv::set():
> HTTP_X_FORWARDED_HOST: ceph.umiacs.umd.edu
> 2015-12-17 15:03:41.126119 7f88ef7e6700 20 RGWEnv::set():
> HTTP_X_FORWARDED_SERVER: cephproxy00.umiacs.umd.edu
> 2015-12-17 15:03:41.126121 7f88ef7e6700 20 RGWEnv::set():
> HTTP_CONNECTION: Keep-Alive
> 2015-12-17 15:03:41.126123 7f88ef7e6700 20 RGWEnv::set():
> REQUEST_METHOD: GET
> 2015-12-17 15:03:41.126124 7f88ef7e6700 20 RGWEnv::set(): REQUEST_URI:
> /admin/metadata/get
> 2015-12-17 15:03:41.126126 7f88ef7e6700 20 RGWEnv::set(): QUERY_STRING:
> section=user&key=cephtest
> 2015-12-17 15:03:41.126128 7f88ef7e6700 20 RGWEnv::set(): REMOTE_USER:
> 2015-12-17 15:03:41.126129 7f88ef7e6700 20 RGWEnv::set(): SCRIPT_URI:
> /admin/metadata/get
> 2015-12-17 15:03:41.126132 7f88ef7e6700 20 RGWEnv::set(): SERVER_PORT: 7480
> 2015-12-17 15:03:41.126133 7f88ef7e6700 20 HTTP_ACCEPT=*/*
> 2015-12-17 15:03:41.126134 7f88ef7e6700 20 HTTP_ACCEPT_ENCODING=gzip,
> deflate
> 2015-12-17 15:03:41.126135 7f88ef7e6700 20 HTTP_AUTHORIZATION=AWS
> RTJ1TL13CH613JRU2PJD:F6wMKxSrrFhl2m3fyo/M0yXIGT8=
> 2015-12-17 15:03:41.126136 7f88ef7e6700 20 HTTP_CONNECTION=Keep-Alive
> 2015-12-17 15:03:41.126137 7f88ef7e6700 20 HTTP_DATE=Thu, 17 Dec 2015
> 20:03:41 GMT
> 2015-12-17 15:03:41.126138 7f88ef7e6700 20 HTTP_HOST=localhost:7480
> 2015-12-17 15:03:41.126139 7f88ef7e6700 20
> HTTP_USER_AGENT=python-requests/2.3.0 CPython/2.7.10 Darwin/14.5.0
> 2015-12-17 15:03:41.126140 7f88ef7e6700 20
> HTTP_X_FORWARDED_FOR=192.168.86.254
> 2015-12-17 15:03:41.126141 7f88ef7e6700 20
> HTTP_X_FORWARDED_HOST=ceph.umiacs.umd.edu
> 2015-12-17 15:03:41.126142 7f88ef7e6700 20
> HTTP_X_FORWARDED_SERVER=cephproxy00.umiacs.umd.edu
> 2015-12-17 15:03:41.126143 7f88ef7e6700 20
> QUERY_STRING=section=user&key=cephtest
> 2015-12-17 15:03:41.126144 7f88ef7e6700 20 REMOTE_USER=
> 2015-12-17 15:03:41.126145 7f88ef7e6700 20 REQUEST_METHOD=GET
> 2015-12-17 15:03:41.126146 7f88ef7e6700 20 REQUEST_URI=/admin/metadata/get
> 2015-12-17 15:03:41.126147 7f88ef7e6700 20 SCRIPT_URI=/admin/metadata/get
> 2015-12-17 15:03:41.126148 7f88ef7e6700 20 SERVER_PORT=7480
> 2015-12-17 15:03:41.126150 7f88ef7e6700  1 ====== starting new request
> req=0x7f8904068010 =====
> 2015-12-17 15:03:41.126222 7f88ef7e6700  2 req 36:0.000072::GET
> /admin/metadata/get::initializing for trans_id =
> tx000000000000000000024-005673151d-5f7c-default
> 2015-12-17 15:03:41.126230 7f88ef7e6700 10 host=localhost
> 2015-12-17 15:03:41.126236 7f88ef7e6700 20 subdomain= domain=
> in_hosted_domain=0
> 2015-12-17 15:03:41.126289 7f88ef7e6700  2 req 36:0.000140::GET
> /admin/metadata/get::getting op
> 2015-12-17 15:03:41.126293 7f88ef7e6700  2 req 36:0.000143::GET
> /admin/metadata/get:get_metadata:authorizing
> 2015-12-17 15:03:41.126343 7f88ef7e6700 10 get_canon_resource():
> dest=/admin/metadata/get
> 2015-12-17 15:03:41.126346 7f88ef7e6700 10 auth_hdr:
> GET
>
>
> Thu, 17 Dec 2015 20:03:41 GMT
> /admin/metadata/get
> 2015-12-17 15:03:41.126438 7f88ef7e6700 15 calculated
> digest=F6wMKxSrrFhl2m3fyo/M0yXIGT8=
> 2015-12-17 15:03:41.126441 7f88ef7e6700 15
> auth_sign=F6wMKxSrrFhl2m3fyo/M0yXIGT8=
> 2015-12-17 15:03:41.126442 7f88ef7e6700 15 compare=0
> 2015-12-17 15:03:41.126444 7f88ef7e6700  2 req 36:0.000295::GET
> /admin/metadata/get:get_metadata:reading permissions
> 2015-12-17 15:03:41.126446 7f88ef7e6700  2 req 36:0.000297::GET
> /admin/metadata/get:get_metadata:init op
> 2015-12-17 15:03:41.126451 7f88ef7e6700  2 req 36:0.000302::GET
> /admin/metadata/get:get_metadata:verifying op mask
> 2015-12-17 15:03:41.126453 7f88ef7e6700 20 required_mask= 0 user.op_mask=7
> 2015-12-17 15:03:41.126454 7f88ef7e6700  2 req 36:0.000305::GET
> /admin/metadata/get:get_metadata:verifying op permissions
> 2015-12-17 15:03:41.126456 7f88ef7e6700  2 req 36:0.000307::GET
> /admin/metadata/get:get_metadata:verifying op params
> 2015-12-17 15:03:41.126458 7f88ef7e6700  2 req 36:0.000308::GET
> /admin/metadata/get:get_metadata:executing
> 2015-12-17 15:03:41.126467 7f88ef7e6700  5 ERROR: can't get key: (2) No
> such file or directory
> 2015-12-17 15:03:41.126603 7f88ef7e6700  2 req 36:0.000453::GET
> /admin/metadata/get:get_metadata:http status=404
> 2015-12-17 15:03:41.126607 7f88ef7e6700  1 ====== req done
> req=0x7f8904068010 http_status=404 ======
> 2015-12-17 15:03:41.126613 7f88ef7e6700 20 process_request() returned -2
> 2015-12-17 15:03:41.126727 7f88ef7e6700  1 civetweb: 0x7f890400ea60:
> 127.0.0.1 - - [17/Dec/2015:15:03:41 -0500] "GET /admin/metadata/get
> HTTP/1.1" 404 0 - python-requests/2.3.0 CPython/2.7.10 Darwin/14.5.0
>

Right. Reading the code again:

Try:
GET /admin/metadata/user&key=cephtest
