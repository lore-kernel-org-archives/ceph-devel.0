From: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>
Subject: Re: Access Dienied for bucket upload - 403 code
Date: Tue, 11 Sep 2012 23:28:14 +0200
Message-ID: <CAMwB3Tjg-Oyb9CRMDWY8EXCNfTC9aB6w=qGOC=Rz5O0yfn27YA@mail.gmail.com>
References: <CAMwB3Tg6L1F8bg_DJ9g0ySGn5hjJsiCW0DmKANodrHbESpVqfg@mail.gmail.com>
	<CAC-hyiGYPJpMCLhW6t00ysxXYovAnsnztaxO8LL-dQLtgfbYUQ@mail.gmail.com>
	<CAC-hyiGo2D1oErBx3B3n9Vr=vT_R9L0qQ80vuuHKO_1gjbVPYg@mail.gmail.com>
	<CAMwB3TiPiwBCwwnFKZFeMAwKKAzc0rVWHKHoc9vnqkTXZL1P7w@mail.gmail.com>
	<CAMwB3ThhS5Y=GP259HTJbNDZudLmSVaCqD4jgWdhvQXCygPGcw@mail.gmail.com>
	<CAC-hyiGF4yt1vewrZQNNcrqvCJJZBWMTukefq5BDBuYR7U1CEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:48705 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752964Ab2IKV2P convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Sep 2012 17:28:15 -0400
Received: by qcro28 with SMTP id o28so591619qcr.19
        for <ceph-devel@vger.kernel.org>; Tue, 11 Sep 2012 14:28:15 -0700 (PDT)
In-Reply-To: <CAC-hyiGF4yt1vewrZQNNcrqvCJJZBWMTukefq5BDBuYR7U1CEg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: ceph-devel@vger.kernel.org

:~# s3 -u put ocdn/test3 cannedAcl=3Dpublic-read < /tmp/testdl
:~# s3 -u get ocdn/test3 > /tmp/test3
:~# HEAD http://127.0.0.1/ocdn/test3
200 OK
Connection: close
Date: Tue, 11 Sep 2012 21:23:19 GMT
Accept-Ranges: bytes
ETag: "a241f32b8cf07f90d36b5199629b8829"
Server: nginx
Content-Length: 6713
Last-Modified: Tue, 11 Sep 2012 21:22:48 GMT
Client-Date: Tue, 11 Sep 2012 21:23:19 GMT
Client-Peer: 127.0.0.1:80
Client-Response-Num: 1

put with cannedacl forpublic works on this object.

2012-09-11 23:22:48.288059 7f67bd722700 10 s->object=3Dtest3 s->bucket=3D=
ocdn
2012-09-11 23:22:48.288064 7f67bd722700 10 meta>> HTTP_X_AMZ_ACL=3Dpubl=
ic-read
2012-09-11 23:22:48.288070 7f67bd722700 10 meta>> HTTP_X_AMZ_DATE=3DTue=
,
11 Sep 2012 21:22:48 GMT
2012-09-11 23:22:48.288074 7f67bd722700 10 x>> x-amz-acl:public-read
2012-09-11 23:22:48.288076 7f67bd722700 10 x>> x-amz-date:Tue, 11 Sep
2012 21:22:48 GMT
2012-09-11 23:22:48.288080 7f67bd722700 20 FCGI_ROLE=3DRESPONDER
2012-09-11 23:22:48.288081 7f67bd722700 20 SCRIPT_FILENAME=3D/var/www/r=
adosgw.fcgi
2012-09-11 23:22:48.288083 7f67bd722700 20 QUERY_STRING=3D
2012-09-11 23:22:48.288084 7f67bd722700 20 REQUEST_METHOD=3DPUT
2012-09-11 23:22:48.288085 7f67bd722700 20 CONTENT_TYPE=3D
2012-09-11 23:22:48.288086 7f67bd722700 20 CONTENT_LENGTH=3D6713
2012-09-11 23:22:48.288087 7f67bd722700 20 HTTP_CONTENT_LENGTH=3D6713
2012-09-11 23:22:48.288088 7f67bd722700 20 SCRIPT_NAME=3D/ocdn/test3
2012-09-11 23:22:48.288089 7f67bd722700 20 REQUEST_URI=3D/ocdn/test3
2012-09-11 23:22:48.288089 7f67bd722700 20 DOCUMENT_URI=3D/ocdn/test3
2012-09-11 23:22:48.288090 7f67bd722700 20 DOCUMENT_ROOT=3D/var/www
2012-09-11 23:22:48.288091 7f67bd722700 20 SERVER_PROTOCOL=3DHTTP/1.1
2012-09-11 23:22:48.288092 7f67bd722700 20 GATEWAY_INTERFACE=3DCGI/1.1
2012-09-11 23:22:48.288092 7f67bd722700 20 SERVER_SOFTWARE=3Dnginx/1.2.=
0
2012-09-11 23:22:48.288093 7f67bd722700 20 REMOTE_ADDR=3D127.0.0.1
2012-09-11 23:22:48.288095 7f67bd722700 20 REMOTE_PORT=3D40421
2012-09-11 23:22:48.288096 7f67bd722700 20 SERVER_ADDR=3D127.0.0.1
2012-09-11 23:22:48.288097 7f67bd722700 20 SERVER_PORT=3D80
2012-09-11 23:22:48.288098 7f67bd722700 20 SERVER_NAME=3D
2012-09-11 23:22:48.288099 7f67bd722700 20 REDIRECT_STATUS=3D200
2012-09-11 23:22:48.288099 7f67bd722700 20 RGW_SHOULD_LOG=3Dno
2012-09-11 23:22:48.288100 7f67bd722700 20 HTTP_USER_AGENT=3DMozilla/4.=
0
(Compatible; s3; libs3 2.0; Linux x86_64)
2012-09-11 23:22:48.288101 7f67bd722700 20 HTTP_HOST=3Ds3.amazonaws.com
2012-09-11 23:22:48.288102 7f67bd722700 20 HTTP_ACCEPT=3D*/*
2012-09-11 23:22:48.288103 7f67bd722700 20 HTTP_AUTHORIZATION=3DAWS
73VF66Q2JH5PT5K7QJ3A:MuMc3TusY8KsVkYUZENVU+FLs6Q=3D
2012-09-11 23:22:48.288104 7f67bd722700 20 HTTP_X_AMZ_ACL=3Dpublic-read
2012-09-11 23:22:48.288104 7f67bd722700 20 HTTP_X_AMZ_DATE=3DTue, 11 Se=
p
2012 21:22:48 GMT
2012-09-11 23:22:48.288105 7f67bd722700 20 HTTP_EXPECT=3D100-continue
2012-09-11 23:22:48.288107 7f67bd722700  2 req 75477:0.000112:s3:PUT
/ocdn/test3::getting op
2012-09-11 23:22:48.288111 7f67bd722700  2 req 75477:0.000116:s3:PUT
/ocdn/test3:put_obj:authorizing
2012-09-11 23:22:48.288126 7f67bd722700 20 get_obj_state:
rctx=3D0x7f6a88002120 obj=3D.users:73VF66Q2JH5PT5K7QJ3A
state=3D0x7f6a880021d8 s->prefetch_data=3D0
2012-09-11 23:22:48.290419 7f67bd722700 20 get_obj_state: s->obj_tag
was set empty
2012-09-11 23:22:48.290434 7f67bd722700 20 get_obj_state:
rctx=3D0x7f6a88002120 obj=3D.users:73VF66Q2JH5PT5K7QJ3A
state=3D0x7f6a880021d8 s->prefetch_data=3D0
2012-09-11 23:22:48.292004 7f67bd722700 20 get_obj_state: s->obj_tag
was set empty
2012-09-11 23:22:48.292016 7f67bd722700 20 get_obj_state:
rctx=3D0x7f6a88002120 obj=3D.users:73VF66Q2JH5PT5K7QJ3A
state=3D0x7f6a880021d8 s->prefetch_data=3D0
2012-09-11 23:22:48.292023 7f67bd722700 20 state for
obj=3D.users:73VF66Q2JH5PT5K7QJ3A is not atomic, not appending atomic
test
2012-09-11 23:22:48.292026 7f67bd722700 20 rados->read obj-ofs=3D0
read_ofs=3D0 read_len=3D16384
2012-09-11 23:22:48.293258 7f67bd722700 20 rados->read r=3D0 bl.length=3D=
231
2012-09-11 23:22:48.293312 7f67bd722700 10 get_canon_resource():
dest=3D/ocdn/test3
2012-09-11 23:22:48.293316 7f67bd722700 10 auth_hdr:
2012-09-11 23:22:48.293397 7f67bd722700 15 b64=3DMuMc3TusY8KsVkYUZENVU+=
=46Ls6Q=3D
2012-09-11 23:22:48.293403 7f67bd722700 15
auth_sign=3DMuMc3TusY8KsVkYUZENVU+FLs6Q=3D
2012-09-11 23:22:48.293405 7f67bd722700 15 compare=3D0
2012-09-11 23:22:48.293408 7f67bd722700  2 req 75477:0.005412:s3:PUT
/ocdn/test3:put_obj:reading permissions
2012-09-11 23:22:48.293420 7f67bd722700 20 get_obj_state:
rctx=3D0x7f6a8800a6f0 obj=3D.rgw:ocdn state=3D0x7f6a8800b3b8
s->prefetch_data=3D0
2012-09-11 23:22:48.294866 7f67bd722700 20 get_obj_state: s->obj_tag
was set empty
2012-09-11 23:22:48.294879 7f67bd722700 20 get_obj_state:
rctx=3D0x7f6a8800a6f0 obj=3D.rgw:ocdn state=3D0x7f6a8800b3b8
s->prefetch_data=3D0
2012-09-11 23:22:48.294886 7f67bd722700 20 get_obj_state:
rctx=3D0x7f6a8800a6f0 obj=3D.rgw:ocdn state=3D0x7f6a8800b3b8
s->prefetch_data=3D0
2012-09-11 23:22:48.294890 7f67bd722700 20 state for obj=3D.rgw:ocdn is
not atomic, not appending atomic test
2012-09-11 23:22:48.294892 7f67bd722700 20 rados->read obj-ofs=3D0
read_ofs=3D0 read_len=3D16384
2012-09-11 23:22:48.296079 7f67bd722700 20 rados->read r=3D0 bl.length=3D=
65
2012-09-11 23:22:48.296100 7f67bd722700 20 rgw_get_bucket_info:
bucket=3Docdn(@.rgw.buckets[4168.2]) owner 0
2012-09-11 23:22:48.296112 7f67bd722700 20 get_obj_state:
rctx=3D0x7f6a8800a6f0 obj=3Docdn: state=3D0x7f6a8800b3b8 s->prefetch_da=
ta=3D0
2012-09-11 23:22:48.296129 7f67bd722700 15 Read
AccessControlPolicy<AccessControlPolicy
xmlns=3D"http://s3.amazonaws.com/doc/2006-03-01/"><Owner><ID>0</ID><Dis=
playName>ocdn</DisplayName></Owner><AccessControlList><Grant><Grantee
xmlns:xsi=3D"http://www.w3.org/2001/XMLSchema-instance"
xsi:type=3D"Group"><URI>http://acs.amazonaws.com/groups/global/AllUsers=
</URI></Grantee><Permission>READ</Permission></Grant><Grant><Grantee
xmlns:xsi=3D"http://www.w3.org/2001/XMLSchema-instance"
xsi:type=3D"CanonicalUser"><ID>0</ID><DisplayName>ocdn</DisplayName></G=
rantee><Permission>FULL_CONTROL</Permission></Grant></AccessControlList=
></AccessControlPolicy>
2012-09-11 23:22:48.296142 7f67bd722700  2 req 75477:0.008146:s3:PUT
/ocdn/test3:put_obj:verifying op permissions
2012-09-11 23:22:48.296146 7f67bd722700  5 Searching permissions for
uid=3D0 mask=3D2
2012-09-11 23:22:48.296148 7f67bd722700  5 Found permission: 15
2012-09-11 23:22:48.296149 7f67bd722700 10  uid=3D0 requested perm
(type)=3D2, policy perm=3D2, user_perm_mask=3D2, acl perm=3D2
2012-09-11 23:22:48.296151 7f67bd722700  2 req 75477:0.008156:s3:PUT
/ocdn/test3:put_obj:verifying op params
2012-09-11 23:22:48.296154 7f67bd722700  2 req 75477:0.008159:s3:PUT
/ocdn/test3:put_obj:executing
2012-09-11 23:22:48.296240 7f67bd722700 10 x>> x-amz-acl:public-read
2012-09-11 23:22:48.296246 7f67bd722700 10 x>> x-amz-date:Tue, 11 Sep
2012 21:22:48 GMT
2012-09-11 23:22:48.296258 7f67bd722700 20 get_obj_state:
rctx=3D0x7f6a8800a6f0 obj=3Docdn:test3 state=3D0x7f6a8800d758
s->prefetch_data=3D0
2012-09-11 23:22:48.297443 7f67bd722700 20
prepare_atomic_for_write_impl: state is not atomic.
state=3D0x7f6a8800d758
2012-09-11 23:22:48.315654 7f67bd722700 10 --> ETag: "a241f32b8cf07f90d=
36b5199
2012-09-11 23:22:48.315678 7f67bd722700 10 --> Content-Length: 0
2012-09-11 23:22:48.315680 7f67bd722700 10 --> Accept-Ranges: bytes
2012-09-11 23:22:48.315682 7f67bd722700 10 --> Status: 200
2012-09-11 23:22:48.315685 7f67bd722700 10 --> Content-type: applicatio=
n/xml
2012-09-11 23:22:48.315801 7f67bd722700  2 req 75477:0.027806:s3:PUT
/ocdn/test3:put_obj:http status=3D200
2012-09-11 23:22:48.316010 7f67bd722700  1 =3D=3D=3D=3D=3D=3D req done
req=3D0x274a630 http_status=3D200 =3D=3D=3D=3D=3D=3D


On Tue, Sep 11, 2012 at 10:46 PM, Yehuda Sadeh <yehuda@inktank.com> wro=
te:
> On Tue, Sep 11, 2012 at 1:41 PM, S=C5=82awomir Skowron <szibis@gmail.=
com> wrote:
>> And more logs:
>>
>>
>> 2012-09-11 21:03:38.357304 7faf0bf4f700  1 =3D=3D=3D=3D=3D=3D req do=
ne
>> req=3D0x141a650 http_status=3D403 =3D=3D=3D=3D=3D=3D
>> 2012-09-11 21:23:54.423185 7faf0bf4f700 20 dequeued request req=3D0x=
139a3d0
>> 2012-09-11 21:23:54.423192 7faf0bf4f700 20 RGWWQ: empty
>> 2012-09-11 21:23:54.423198 7faf0bf4f700  1 =3D=3D=3D=3D=3D=3D starti=
ng new request
>> req=3D0x139a3d0 =3D=3D=3D=3D=3D
>> 2012-09-11 21:23:54.423237 7faf0bf4f700  2 req 58098:0.000039::::ini=
tializing
>> 2012-09-11 21:23:54.423258 7faf0bf4f700 10 s->object=3D<NULL> s->buc=
ket=3D<NULL>
>> 2012-09-11 21:23:54.423265 7faf0bf4f700 20 FCGI_ROLE=3DRESPONDER
>> 2012-09-11 21:23:54.423267 7faf0bf4f700 20 SCRIPT_FILENAME=3D/var/ww=
w/radosgw.fcgi
>> 2012-09-11 21:23:54.423269 7faf0bf4f700 20 QUERY_STRING=3D
>> 2012-09-11 21:23:54.423270 7faf0bf4f700 20 REQUEST_METHOD=3DGET
>> 2012-09-11 21:23:54.423272 7faf0bf4f700 20 CONTENT_TYPE=3D
>> 2012-09-11 21:23:54.423273 7faf0bf4f700 20 CONTENT_LENGTH=3D
>> 2012-09-11 21:23:54.423274 7faf0bf4f700 20 HTTP_CONTENT_LENGTH=3D
>> 2012-09-11 21:23:54.423276 7faf0bf4f700 20 SCRIPT_NAME=3D/
>> 2012-09-11 21:23:54.423277 7faf0bf4f700 20 REQUEST_URI=3D/
>> 2012-09-11 21:23:54.423279 7faf0bf4f700 20 DOCUMENT_URI=3D/
>> 2012-09-11 21:23:54.423280 7faf0bf4f700 20 DOCUMENT_ROOT=3D/var/www
>> 2012-09-11 21:23:54.423282 7faf0bf4f700 20 SERVER_PROTOCOL=3DHTTP/1.=
0
>> 2012-09-11 21:23:54.423283 7faf0bf4f700 20 GATEWAY_INTERFACE=3DCGI/1=
=2E1
>> 2012-09-11 21:23:54.423284 7faf0bf4f700 20 SERVER_SOFTWARE=3Dnginx/1=
=2E2.0
>> 2012-09-11 21:23:54.423286 7faf0bf4f700 20 REMOTE_ADDR=3D10.177.95.1=
9
>> 2012-09-11 21:23:54.423287 7faf0bf4f700 20 REMOTE_PORT=3D60477
>> 2012-09-11 21:23:54.423289 7faf0bf4f700 20 SERVER_ADDR=3D10.177.64.4
>> 2012-09-11 21:23:54.423290 7faf0bf4f700 20 SERVER_PORT=3D80
>> ...skipping...
>> 2012-09-11 22:23:44.530567 7faf0bf4f700 10
>> s->object=3Dimages/pulscms/NjQ7MDMsMWUwLDAsMCwx/0a9915212e85062de613=
4566905cf252.jpg
>> s->bucket=3Docdn
>> 2012-09-11 22:23:44.530586 7faf0bf4f700 20 FCGI_ROLE=3DRESPONDER
>> 2012-09-11 22:23:44.530588 7faf0bf4f700 20 SCRIPT_FILENAME=3D/var/ww=
w/radosgw.fcgi
>> 2012-09-11 22:23:44.530589 7faf0bf4f700 20 QUERY_STRING=3D
>> 2012-09-11 22:23:44.530591 7faf0bf4f700 20 REQUEST_METHOD=3DGET
>> 2012-09-11 22:23:44.530592 7faf0bf4f700 20 CONTENT_TYPE=3D
>> 2012-09-11 22:23:44.530593 7faf0bf4f700 20 CONTENT_LENGTH=3D
>> 2012-09-11 22:23:44.530594 7faf0bf4f700 20 HTTP_CONTENT_LENGTH=3D
>> 2012-09-11 22:23:44.530595 7faf0bf4f700 20
>> SCRIPT_NAME=3D/ocdn/images/pulscms/NjQ7MDMsMWUwLDAsMCwx/0a9915212e85=
062de6134566905cf252.jpg
>> 2012-09-11 22:23:44.530596 7faf0bf4f700 20
>> REQUEST_URI=3D/ocdn/images/pulscms/NjQ7MDMsMWUwLDAsMCwx/0a9915212e85=
062de6134566905cf252.jpg
>> 2012-09-11 22:23:44.530598 7faf0bf4f700 20
>> DOCUMENT_URI=3D/ocdn/images/pulscms/NjQ7MDMsMWUwLDAsMCwx/0a9915212e8=
5062de6134566905cf252.jpg
>> 2012-09-11 22:23:44.530600 7faf0bf4f700 20 DOCUMENT_ROOT=3D/var/www
>> 2012-09-11 22:23:44.530603 7faf0bf4f700 20 SERVER_PROTOCOL=3DHTTP/1.=
1
>> 2012-09-11 22:23:44.530604 7faf0bf4f700 20 GATEWAY_INTERFACE=3DCGI/1=
=2E1
>> 2012-09-11 22:23:44.530605 7faf0bf4f700 20 SERVER_SOFTWARE=3Dnginx/1=
=2E2.0
>> 2012-09-11 22:23:44.530606 7faf0bf4f700 20 REMOTE_ADDR=3D10.167.14.5=
3
>> 2012-09-11 22:23:44.530607 7faf0bf4f700 20 REMOTE_PORT=3D62145
>> 2012-09-11 22:23:44.530608 7faf0bf4f700 20 SERVER_ADDR=3D10.177.64.4
>> 2012-09-11 22:23:44.530609 7faf0bf4f700 20 SERVER_PORT=3D80
>> 2012-09-11 22:23:44.530610 7faf0bf4f700 20 SERVER_NAME=3D
>> 2012-09-11 22:23:44.530610 7faf0bf4f700 20 REDIRECT_STATUS=3D200
>> 2012-09-11 22:23:44.530611 7faf0bf4f700 20 RGW_SHOULD_LOG=3Dno
>> 2012-09-11 22:23:44.530612 7faf0bf4f700 20 HTTP_HOST=3D10.177.64.4
>> 2012-09-11 22:23:44.530613 7faf0bf4f700 20 HTTP_CONNECTION=3Dkeep-al=
ive
>> 2012-09-11 22:23:44.530614 7faf0bf4f700 20 HTTP_USER_AGENT=3DMozilla=
/5.0
>> (Macintosh; Intel Mac OS X 10_7_4) AppleWebKit/537.1 (KHTML, like
>> Gecko) Chrome/21.0.1180.89 Safari/537.1
>> 2012-09-11 22:23:44.530615 7faf0bf4f700 20
>> HTTP_ACCEPT=3Dtext/html,application/xhtml+xml,application/xml;q=3D0.=
9,*/*;q=3D0.8
>> 2012-09-11 22:23:44.530616 7faf0bf4f700 20
>> HTTP_ACCEPT_ENCODING=3Dgzip,deflate,sdch
>> 2012-09-11 22:23:44.530617 7faf0bf4f700 20 HTTP_ACCEPT_LANGUAGE=3Den=
-US,en;q=3D0.8
>> 2012-09-11 22:23:44.530618 7faf0bf4f700 20
>> HTTP_ACCEPT_CHARSET=3DISO-8859-1,utf-8;q=3D0.7,*;q=3D0.3
>> 2012-09-11 22:23:44.530620 7faf0bf4f700  2 req 68518:0.000117:s3:GET
>> /ocdn/images/pulscms/NjQ7MDMsMWUwLDAsMCwx/0a9915212e85062de613456690=
5cf252.jpg::getting
>> op
>> 2012-09-11 22:23:44.530626 7faf0bf4f700  2 req 68518:0.000123:s3:GET
>> /ocdn/images/pulscms/NjQ7MDMsMWUwLDAsMCwx/0a9915212e85062de613456690=
5cf252.jpg:get_obj:authorizing
>> 2012-09-11 22:23:44.530630 7faf0bf4f700  2 req 68518:0.000127:s3:GET
>> /ocdn/images/pulscms/NjQ7MDMsMWUwLDAsMCwx/0a9915212e85062de613456690=
5cf252.jpg:get_obj:reading
>> permissions
>> 2012-09-11 22:23:44.530646 7faf0bf4f700 20 get_obj_state:
>> rctx=3D0x7fb01c0122c0 obj=3D.rgw:ocdn state=3D0x7fb01c013248
>> s->prefetch_data=3D0
>> 2012-09-11 22:23:44.531746 7faf0bf4f700 20 get_obj_state: s->obj_tag
>> was set empty
>> 2012-09-11 22:23:44.531760 7faf0bf4f700 20 get_obj_state:
>> rctx=3D0x7fb01c0122c0 obj=3D.rgw:ocdn state=3D0x7fb01c013248
>> s->prefetch_data=3D0
>> 2012-09-11 22:23:44.531767 7faf0bf4f700 20 get_obj_state:
>> rctx=3D0x7fb01c0122c0 obj=3D.rgw:ocdn state=3D0x7fb01c013248
>> s->prefetch_data=3D0
>> 2012-09-11 22:23:44.531771 7faf0bf4f700 20 state for obj=3D.rgw:ocdn=
 is
>> not atomic, not appending atomic test
>> 2012-09-11 22:23:44.531773 7faf0bf4f700 20 rados->read obj-ofs=3D0
>> read_ofs=3D0 read_len=3D16384
>> 2012-09-11 22:23:44.532701 7faf0bf4f700 20 rados->read r=3D0 bl.leng=
th=3D65
>> 2012-09-11 22:23:44.532721 7faf0bf4f700 20 rgw_get_bucket_info:
>> bucket=3Docdn(@.rgw.buckets[4168.2]) owner 0
>> 2012-09-11 22:23:44.532734 7faf0bf4f700 20 get_obj_state:
>> rctx=3D0x7fb01c0122c0 obj=3Docdn: state=3D0x7fb01c013248 s->prefetch=
_data=3D0
>> 2012-09-11 22:23:44.532750 7faf0bf4f700 15 Read
>> AccessControlPolicy<AccessControlPolicy
>> xmlns=3D"http://s3.amazonaws.com/doc/2006-03-01/"><Owner><ID>0</ID><=
DisplayName>ocdn</DisplayName></Owner><AccessControlList><Grant><Grante=
e
>> xmlns:xsi=3D"http://www.w3.org/2001/XMLSchema-instance"
>> xsi:type=3D"Group"><URI>http://acs.amazonaws.com/groups/global/AllUs=
ers</URI></Grantee><Permission>READ</Permission></Grant><Grant><Grantee
>> xmlns:xsi=3D"http://www.w3.org/2001/XMLSchema-instance"
>> xsi:type=3D"CanonicalUser"><ID>0</ID><DisplayName>ocdn</DisplayName>=
</Grantee><Permission>FULL_CONTROL</Permission></Grant></AccessControlL=
ist></AccessControlPolicy>
>> 2012-09-11 22:23:44.532770 7faf0bf4f700 20 get_obj_state:
>> rctx=3D0x7fb01c0122c0
>> obj=3Docdn:images/pulscms/NjQ7MDMsMWUwLDAsMCwx/0a9915212e85062de6134=
566905cf252.jpg
>> state=3D0x7fb01c00a608 s->prefetch_data=3D1
>> 2012-09-11 22:23:44.534298 7faf0bf4f700 20 get_obj_state: s->obj_tag
>> was set empty
>> 2012-09-11 22:23:44.534315 7faf0bf4f700 15 Read
>> AccessControlPolicy<AccessControlPolicy
>> xmlns=3D"http://s3.amazonaws.com/doc/2006-03-01/"><Owner><ID>0</ID><=
DisplayName>ocdn</DisplayName></Owner><AccessControlList><Grant><Grante=
e
>> xmlns:xsi=3D"http://www.w3.org/2001/XMLSchema-instance"
>> xsi:type=3D"CanonicalUser"><ID>0</ID><DisplayName>ocdn</DisplayName>=
</Grantee><Permission>FULL_CONTROL</Permission></Grant></AccessControlL=
ist></AccessControlPolicy>
>> 2012-09-11 22:23:44.534327 7faf0bf4f700  2 req 68518:0.003823:s3:GET
>> /ocdn/images/pulscms/NjQ7MDMsMWUwLDAsMCwx/0a9915212e85062de613456690=
5cf252.jpg:get_obj:verifying
>> op permissions
>> 2012-09-11 22:23:44.534334 7faf0bf4f700  5 Searching permissions for
>> uid=3Danonymous mask=3D1
>> 2012-09-11 22:23:44.534336 7faf0bf4f700  5 Permissions for user not =
found
>> 2012-09-11 22:23:44.534337 7faf0bf4f700  5 Searching permissions for
>> group=3D1 mask=3D1
>> 2012-09-11 22:23:44.534338 7faf0bf4f700  5 Permissions for group not=
 found
>> 2012-09-11 22:23:44.534339 7faf0bf4f700  5 Getting permissions
>> id=3Danonymous owner=3D0 perm=3D0
>> 2012-09-11 22:23:44.534341 7faf0bf4f700 10  uid=3Danonymous requeste=
d
>> perm (type)=3D1, policy perm=3D0, user_perm_mask=3D15, acl perm=3D0
>> 2012-09-11 22:23:44.534343 7faf0bf4f700  5 Searching permissions for
>> uid=3Danonymous mask=3D16
>> 2012-09-11 22:23:44.534344 7faf0bf4f700  5 Permissions for user not =
found
>> 2012-09-11 22:23:44.534345 7faf0bf4f700  5 Searching permissions for
>> group=3D1 mask=3D16
>> 2012-09-11 22:23:44.534347 7faf0bf4f700  5 Found permission: 1
>> 2012-09-11 22:23:44.534348 7faf0bf4f700  5 Getting permissions
>> id=3Danonymous owner=3D0 perm=3D0
>> 2012-09-11 22:23:44.534349 7faf0bf4f700 10  uid=3Danonymous requeste=
d
>> perm (type)=3D16, policy perm=3D0, user_perm_mask=3D16, acl perm=3D0
>> 2012-09-11 22:23:44.534357 7faf0bf4f700 10 --> Status: 403
>> 2012-09-11 22:23:44.534367 7faf0bf4f700 10 --> Content-Length: 78
>> 2012-09-11 22:23:44.534370 7faf0bf4f700 10 --> Accept-Ranges: bytes
>> 2012-09-11 22:23:44.534373 7faf0bf4f700 10 --> Content-type: applica=
tion/xml
>> 2012-09-11 22:23:44.534480 7faf0bf4f700  2 req 68518:0.003976:s3:GET
>> /ocdn/images/pulscms/NjQ7MDMsMWUwLDAsMCwx/0a9915212e85062de613456690=
5cf252.jpg:get_obj:http
>> status=3D403
>> 2012-09-11 22:23:44.534765 7faf0bf4f700  1 =3D=3D=3D=3D=3D=3D req do=
ne
>> req=3D0x13995c0 http_status=3D403 =3D=3D=3D=3D=3D=3D
>>
>> Good put, and 403 after:
>>
>> 2012-09-11 22:37:34.677422 7fafddffb700  1 =3D=3D=3D=3D=3D=3D starti=
ng new request
>> req=3D0x139a3d0 =3D=3D=3D=3D=3D
>> 2012-09-11 22:37:34.677466 7fafddffb700  2 req 71187:0.000044::::ini=
tializing
>> 2012-09-11 22:37:34.677492 7fafddffb700 10
>> s->object=3Dfiles/pulscms/MjU7MDA_/ecebacddde95224b96f46333912049b1
>> s->bucket=3Docdn
>> 2012-09-11 22:37:34.677501 7fafddffb700 20 FCGI_ROLE=3DRESPONDER
>> 2012-09-11 22:37:34.677502 7fafddffb700 20 SCRIPT_FILENAME=3D/var/ww=
w/radosgw.fcgi
>> 2012-09-11 22:37:34.677503 7fafddffb700 20 QUERY_STRING=3D
>> 2012-09-11 22:37:34.677504 7fafddffb700 20 REQUEST_METHOD=3DPUT
>> 2012-09-11 22:37:34.677505 7fafddffb700 20 CONTENT_TYPE=3Dtext/plain
>> 2012-09-11 22:37:34.677506 7fafddffb700 20 CONTENT_LENGTH=3D4721
>> 2012-09-11 22:37:34.677507 7fafddffb700 20 HTTP_CONTENT_LENGTH=3D472=
1
>> 2012-09-11 22:37:34.677508 7fafddffb700 20
>> SCRIPT_NAME=3D/ocdn/files/pulscms/MjU7MDA_/ecebacddde95224b96f463339=
12049b1
>> 2012-09-11 22:37:34.677509 7fafddffb700 20
>> REQUEST_URI=3D/ocdn/files/pulscms/MjU7MDA_/ecebacddde95224b96f463339=
12049b1
>> 2012-09-11 22:37:34.677510 7fafddffb700 20
>> DOCUMENT_URI=3D/ocdn/files/pulscms/MjU7MDA_/ecebacddde95224b96f46333=
912049b1
>> 2012-09-11 22:37:34.677511 7fafddffb700 20 DOCUMENT_ROOT=3D/var/www
>> 2012-09-11 22:37:34.677512 7fafddffb700 20 SERVER_PROTOCOL=3DHTTP/1.=
1
>> 2012-09-11 22:37:34.677512 7fafddffb700 20 GATEWAY_INTERFACE=3DCGI/1=
=2E1
>> 2012-09-11 22:37:34.677513 7fafddffb700 20 SERVER_SOFTWARE=3Dnginx/1=
=2E2.0
>> 2012-09-11 22:37:34.677514 7fafddffb700 20 REMOTE_ADDR=3D10.174.53.7=
7
>> 2012-09-11 22:37:34.677515 7fafddffb700 20 REMOTE_PORT=3D48588
>> 2012-09-11 22:37:34.677516 7fafddffb700 20 SERVER_ADDR=3D10.177.0.3
>> 2012-09-11 22:37:34.677516 7fafddffb700 20 SERVER_PORT=3D80
>> 2012-09-11 22:37:34.677517 7fafddffb700 20 SERVER_NAME=3D
>> 2012-09-11 22:37:34.677518 7fafddffb700 20 REDIRECT_STATUS=3D200
>> 2012-09-11 22:37:34.677519 7fafddffb700 20 RGW_SHOULD_LOG=3Dno
>> 2012-09-11 22:37:34.677520 7fafddffb700 20 HTTP_HOST=3D10.177.0.3
>> 2012-09-11 22:37:34.677520 7fafddffb700 20 HTTP_ACCEPT_ENCODING=3Did=
entity
>> 2012-09-11 22:37:34.677521 7fafddffb700 20
>> HTTP_CONTENT_MD5=3D7Ous3d6VIkuW9GMzkSBJsQ=3D=3D
>> 2012-09-11 22:37:34.677522 7fafddffb700 20 HTTP_EXPECT=3D100-Continu=
e
>> 2012-09-11 22:37:34.677523 7fafddffb700 20 HTTP_DATE=3DTue, 11 Sep 2=
012
>> 20:37:46 GMT
>> 2012-09-11 22:37:34.677524 7fafddffb700 20 HTTP_USER_AGENT=3DBoto/2.=
5.1 (linux2)
>> 2012-09-11 22:37:34.677525 7fafddffb700 20 HTTP_CONTENT_TYPE=3Dtext/=
plain
>> 2012-09-11 22:37:34.677526 7fafddffb700 20 HTTP_AUTHORIZATION=3DAWS
>> 73VF66Q2JH5PT5K7QJ3A:5ucLfRdtJtAdcIcns2pgMowWAEE=3D
>> 2012-09-11 22:37:34.677529 7fafddffb700  2 req 71187:0.000108:s3:PUT
>> /ocdn/files/pulscms/MjU7MDA_/ecebacddde95224b96f46333912049b1::getti=
ng
>> op
>> 2012-09-11 22:37:34.677534 7fafddffb700  2 req 71187:0.000113:s3:PUT
>> /ocdn/files/pulscms/MjU7MDA_/ecebacddde95224b96f46333912049b1:put_ob=
j:authorizing
>> 2012-09-11 22:37:34.677552 7fafddffb700 20 get_obj_state:
>> rctx=3D0x7fb00c004960 obj=3D.users:73VF66Q2JH5PT5K7QJ3A
>> state=3D0x7fb00c004a18 s->prefetch_data=3D0
>> 2012-09-11 22:37:34.679069 7fafddffb700 20 get_obj_state: s->obj_tag
>> was set empty
>> 2012-09-11 22:37:34.679086 7fafddffb700 20 get_obj_state:
>> rctx=3D0x7fb00c004960 obj=3D.users:73VF66Q2JH5PT5K7QJ3A
>> state=3D0x7fb00c004a18 s->prefetch_data=3D0
>> 2012-09-11 22:37:34.680427 7fafddffb700 20 get_obj_state: s->obj_tag
>> was set empty
>> 2012-09-11 22:37:34.680441 7fafddffb700 20 get_obj_state:
>> rctx=3D0x7fb00c004960 obj=3D.users:73VF66Q2JH5PT5K7QJ3A
>> state=3D0x7fb00c004a18 s->prefetch_data=3D0
>> 2012-09-11 22:37:34.680452 7fafddffb700 20 state for
>> obj=3D.users:73VF66Q2JH5PT5K7QJ3A is not atomic, not appending atomi=
c
>> test
>> 2012-09-11 22:37:34.680457 7fafddffb700 20 rados->read obj-ofs=3D0
>> read_ofs=3D0 read_len=3D16384
>> 2012-09-11 22:37:34.681685 7fafddffb700 20 rados->read r=3D0 bl.leng=
th=3D231
>> 2012-09-11 22:37:34.681748 7fafddffb700 10 get_canon_resource():
>> dest=3D/ocdn/files/pulscms/MjU7MDA_/ecebacddde95224b96f46333912049b1
>> 2012-09-11 22:37:34.681766 7fafddffb700 10 auth_hdr:
>> 2012-09-11 22:37:34.681911 7fafddffb700 15 b64=3D5ucLfRdtJtAdcIcns2p=
gMowWAEE=3D
>> 2012-09-11 22:37:34.681921 7fafddffb700 15
>> auth_sign=3D5ucLfRdtJtAdcIcns2pgMowWAEE=3D
>> 2012-09-11 22:37:34.681922 7fafddffb700 15 compare=3D0
>> 2012-09-11 22:37:34.681926 7fafddffb700  2 req 71187:0.004504:s3:PUT
>> /ocdn/files/pulscms/MjU7MDA_/ecebacddde95224b96f46333912049b1:put_ob=
j:reading
>> permissions
>> 2012-09-11 22:37:34.681941 7fafddffb700 20 get_obj_state:
>> rctx=3D0x7fb00c007050 obj=3D.rgw:ocdn state=3D0x7fb00c006578
>> s->prefetch_data=3D0
>> 2012-09-11 22:37:34.683575 7fafddffb700 20 get_obj_state: s->obj_tag
>> was set empty
>> 2012-09-11 22:37:34.683588 7fafddffb700 20 get_obj_state:
>> rctx=3D0x7fb00c007050 obj=3D.rgw:ocdn state=3D0x7fb00c006578
>> s->prefetch_data=3D0
>> 2012-09-11 22:37:34.683596 7fafddffb700 20 get_obj_state:
>> rctx=3D0x7fb00c007050 obj=3D.rgw:ocdn state=3D0x7fb00c006578
>> s->prefetch_data=3D0
>> 2012-09-11 22:37:34.683599 7fafddffb700 20 state for obj=3D.rgw:ocdn=
 is
>> not atomic, not appending atomic test
>> 2012-09-11 22:37:34.683601 7fafddffb700 20 rados->read obj-ofs=3D0
>> read_ofs=3D0 read_len=3D16384
>> 2012-09-11 22:37:34.684735 7fafddffb700 20 rados->read r=3D0 bl.leng=
th=3D65
>> 2012-09-11 22:37:34.684755 7fafddffb700 20 rgw_get_bucket_info:
>> bucket=3Docdn(@.rgw.buckets[4168.2]) owner 0
>> 2012-09-11 22:37:34.684769 7fafddffb700 20 get_obj_state:
>> rctx=3D0x7fb00c007050 obj=3Docdn: state=3D0x7fb00c006578 s->prefetch=
_data=3D0
>> 2012-09-11 22:37:34.684786 7fafddffb700 15 Read
>> AccessControlPolicy<AccessControlPolicy
>> xmlns=3D"http://s3.amazonaws.com/doc/2006-03-01/"><Owner><ID>0</ID><=
DisplayName>ocdn</DisplayName></Owner><AccessControlList><Grant><Grante=
e
>> xmlns:xsi=3D"http://www.w3.org/2001/XMLSchema-instance"
>> xsi:type=3D"Group"><URI>http://acs.amazonaws.com/groups/global/AllUs=
ers</URI></Grantee><Permission>READ</Permission></Grant><Grant><Grantee
>> xmlns:xsi=3D"http://www.w3.org/2001/XMLSchema-instance"
>> xsi:type=3D"CanonicalUser"><ID>0</ID><DisplayName>ocdn</DisplayName>=
</Grantee><Permission>FULL_CONTROL</Permission></Grant></AccessControlL=
ist></AccessControlPolicy>
>> 2012-09-11 22:37:34.684796 7fafddffb700  2 req 71187:0.007375:s3:PUT
>> /ocdn/files/pulscms/MjU7MDA_/ecebacddde95224b96f46333912049b1:put_ob=
j:verifying
>> op permissions
>> 2012-09-11 22:37:34.684801 7fafddffb700  5 Searching permissions for
>> uid=3D0 mask=3D2
>> 2012-09-11 22:37:34.684803 7fafddffb700  5 Found permission: 15
>> 2012-09-11 22:37:34.684804 7fafddffb700 10  uid=3D0 requested perm
>> (type)=3D2, policy perm=3D2, user_perm_mask=3D2, acl perm=3D2
>> 2012-09-11 22:37:34.684808 7fafddffb700  2 req 71187:0.007387:s3:PUT
>> /ocdn/files/pulscms/MjU7MDA_/ecebacddde95224b96f46333912049b1:put_ob=
j:verifying
>> op params
>> 2012-09-11 22:37:34.684811 7fafddffb700  2 req 71187:0.007390:s3:PUT
>> /ocdn/files/pulscms/MjU7MDA_/ecebacddde95224b96f46333912049b1:put_ob=
j:executing
>> 2012-09-11 22:37:34.684831 7fafddffb700 15
>> supplied_md5_b64=3D7Ous3d6VIkuW9GMzkSBJsQ=3D=3D
>> 2012-09-11 22:37:34.684834 7fafddffb700 15 ceph_armor ret=3D16
>> 2012-09-11 22:37:34.684841 7fafddffb700 15
>> supplied_md5=3Decebacddde95224b96f46333912049b1
>> 2012-09-11 22:37:34.684901 7fafddffb700 20 get_obj_state:
>> rctx=3D0x7fb00c007050
>> obj=3Docdn:files/pulscms/MjU7MDA_/ecebacddde95224b96f46333912049b1
>> state=3D0x7fb00c00bda8 s->prefetch_data=3D0
>> 2012-09-11 22:37:34.686278 7fafddffb700 20
>> prepare_atomic_for_write_impl: state is not atomic.
>> state=3D0x7fb00c00bda8
>> 2012-09-11 22:37:34.704899 7fafddffb700 10 --> ETag: "ecebacddde9522=
4b96f46333
>> 2012-09-11 22:37:34.704949 7fafddffb700 10 --> Content-Length: 0
>> 2012-09-11 22:37:34.704954 7fafddffb700 10 --> Accept-Ranges: bytes
>> 2012-09-11 22:37:34.704958 7fafddffb700 10 --> Status: 200
>> 2012-09-11 22:37:34.704963 7fafddffb700 10 --> Content-type: applica=
tion/xml
>> 2012-09-11 22:37:34.705099 7fafddffb700  2 req 71187:0.027678:s3:PUT
>> /ocdn/files/pulscms/MjU7MDA_/ecebacddde95224b96f46333912049b1:put_ob=
j:http
>> status=3D200
>> 2012-09-11 22:37:34.705454 7fafddffb700  1 =3D=3D=3D=3D=3D=3D req do=
ne
>> req=3D0x139a3d0 http_status=3D200 =3D=3D=3D=3D=3D=3D
>>
>>
>> 2012-09-11 22:37:34.708316 7faec76c6700 20 dequeued request req=3D0x=
1368860
>> 2012-09-11 22:37:34.708326 7faec76c6700 20 RGWWQ: empty
>> 2012-09-11 22:37:34.708333 7faec76c6700  1 =3D=3D=3D=3D=3D=3D starti=
ng new request
>> req=3D0x1368860 =3D=3D=3D=3D=3D
>> 2012-09-11 22:37:34.708375 7faec76c6700  2 req 71188:0.000042::::ini=
tializing
>> 2012-09-11 22:37:34.708402 7faec76c6700 10
>> s->object=3Dfiles/pulscms/MjU7MDA_/ecebacddde95224b96f46333912049b1
>> s->bucket=3Docdn
>> 2012-09-11 22:37:34.708408 7faec76c6700 10 meta>> HTTP_X_AMZ_ACL=3Dp=
ublic-read
>> 2012-09-11 22:37:34.708425 7faec76c6700 10 x>> x-amz-acl:public-read
>> 2012-09-11 22:37:34.708431 7faec76c6700 20 FCGI_ROLE=3DRESPONDER
>> 2012-09-11 22:37:34.708432 7faec76c6700 20 SCRIPT_FILENAME=3D/var/ww=
w/radosgw.fcgi
>> 2012-09-11 22:37:34.708434 7faec76c6700 20 QUERY_STRING=3Dacl
>> 2012-09-11 22:37:34.708435 7faec76c6700 20 REQUEST_METHOD=3DPUT
>> 2012-09-11 22:37:34.708437 7faec76c6700 20 CONTENT_TYPE=3D
>> 2012-09-11 22:37:34.708438 7faec76c6700 20 CONTENT_LENGTH=3D0
>> 2012-09-11 22:37:34.708439 7faec76c6700 20 HTTP_CONTENT_LENGTH=3D0
>> 2012-09-11 22:37:34.708440 7faec76c6700 20
>> SCRIPT_NAME=3D/ocdn/files/pulscms/MjU7MDA_/ecebacddde95224b96f463339=
12049b1
>> 2012-09-11 22:37:34.708441 7faec76c6700 20
>> REQUEST_URI=3D/ocdn/files/pulscms/MjU7MDA_/ecebacddde95224b96f463339=
12049b1
>> 2012-09-11 22:37:34.708441 7faec76c6700 20
>> DOCUMENT_URI=3D/ocdn/files/pulscms/MjU7MDA_/ecebacddde95224b96f46333=
912049b1
>> 2012-09-11 22:37:34.708442 7faec76c6700 20 DOCUMENT_ROOT=3D/var/www
>> 2012-09-11 22:37:34.708443 7faec76c6700 20 SERVER_PROTOCOL=3DHTTP/1.=
1
>> 2012-09-11 22:37:34.708444 7faec76c6700 20 GATEWAY_INTERFACE=3DCGI/1=
=2E1
>> 2012-09-11 22:37:34.708446 7faec76c6700 20 SERVER_SOFTWARE=3Dnginx/1=
=2E2.0
>> 2012-09-11 22:37:34.708447 7faec76c6700 20 REMOTE_ADDR=3D10.174.53.7=
7
>> 2012-09-11 22:37:34.708447 7faec76c6700 20 REMOTE_PORT=3D48588
>> 2012-09-11 22:37:34.708448 7faec76c6700 20 SERVER_ADDR=3D10.177.0.3
>> 2012-09-11 22:37:34.708450 7faec76c6700 20 SERVER_PORT=3D80
>> 2012-09-11 22:37:34.708451 7faec76c6700 20 SERVER_NAME=3D
>> 2012-09-11 22:37:34.708452 7faec76c6700 20 REDIRECT_STATUS=3D200
>> 2012-09-11 22:37:34.708453 7faec76c6700 20 RGW_SHOULD_LOG=3Dno
>> 2012-09-11 22:37:34.708454 7faec76c6700 20 HTTP_HOST=3D10.177.0.3
>> 2012-09-11 22:37:34.708455 7faec76c6700 20 HTTP_ACCEPT_ENCODING=3Did=
entity
>> 2012-09-11 22:37:34.708456 7faec76c6700 20 HTTP_DATE=3DTue, 11 Sep 2=
012
>> 20:37:46 GMT
>> 2012-09-11 22:37:34.708457 7faec76c6700 20 HTTP_X_AMZ_ACL=3Dpublic-r=
ead
>> 2012-09-11 22:37:34.708458 7faec76c6700 20 HTTP_AUTHORIZATION=3DAWS
>> 73VF66Q2JH5PT5K7QJ3A:xHPA2K5QvuehAvKH9WdOvf+ZKzE=3D
>> 2012-09-11 22:37:34.708458 7faec76c6700 20 HTTP_USER_AGENT=3DBoto/2.=
5.1 (linux2)
>> 2012-09-11 22:37:34.708462 7faec76c6700  2 req 71188:0.000129:s3:PUT
>> /ocdn/files/pulscms/MjU7MDA_/ecebacddde95224b96f46333912049b1::getti=
ng
>> op
>> 2012-09-11 22:37:34.708467 7faec76c6700  2 req 71188:0.000134:s3:PUT
>> /ocdn/files/pulscms/MjU7MDA_/ecebacddde95224b96f46333912049b1:put_ob=
j:authorizing
>> 2012-09-11 22:37:34.708486 7faec76c6700 20 get_obj_state:
>> rctx=3D0x7fb2a4007e60 obj=3D.users:73VF66Q2JH5PT5K7QJ3A
>> state=3D0x7fb2a4007f18 s->prefetch_data=3D0
>> 2012-09-11 22:37:34.709812 7faec76c6700 20 get_obj_state: s->obj_tag
>> was set empty
>> 2012-09-11 22:37:34.709828 7faec76c6700 20 get_obj_state:
>> rctx=3D0x7fb2a4007e60 obj=3D.users:73VF66Q2JH5PT5K7QJ3A
>> state=3D0x7fb2a4007f18 s->prefetch_data=3D0
>> 2012-09-11 22:37:34.711091 7faec76c6700 20 get_obj_state: s->obj_tag
>> was set empty
>> 2012-09-11 22:37:34.711101 7faec76c6700 20 get_obj_state:
>> rctx=3D0x7fb2a4007e60 obj=3D.users:73VF66Q2JH5PT5K7QJ3A
>> state=3D0x7fb2a4007f18 s->prefetch_data=3D0
>> 2012-09-11 22:37:34.711108 7faec76c6700 20 state for
>> obj=3D.users:73VF66Q2JH5PT5K7QJ3A is not atomic, not appending atomi=
c
>> test
>> 2012-09-11 22:37:34.711111 7faec76c6700 20 rados->read obj-ofs=3D0
>> read_ofs=3D0 read_len=3D16384
>> 2012-09-11 22:37:34.712485 7faec76c6700 20 rados->read r=3D0 bl.leng=
th=3D231
>> 2012-09-11 22:37:34.712655 7faec76c6700 10 get_canon_resource():
>> dest=3D/ocdn/files/pulscms/MjU7MDA_/ecebacddde95224b96f46333912049b1
>> 2012-09-11 22:37:34.712659 7faec76c6700 10 auth_hdr:
>> 2012-09-11 22:37:34.712735 7faec76c6700 15 b64=3D7pIUzzJaX/EyTV89LMX=
wcqvS06w=3D
>> 2012-09-11 22:37:34.712742 7faec76c6700 15
>> auth_sign=3DxHPA2K5QvuehAvKH9WdOvf+ZKzE=3D
>> 2012-09-11 22:37:34.712744 7faec76c6700 15 compare=3D65
>> 2012-09-11 22:37:34.712747 7faec76c6700 10 failed to authorize reque=
st
>
> The request itself fails to authorize. I think it's related to trying
> to do canned acl put_acl. Not sure if that's actually supposed to
> work.
>
> Yehuda



--=20
-----
Pozdrawiam

S=C5=82awek "sZiBis" Skowron
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
