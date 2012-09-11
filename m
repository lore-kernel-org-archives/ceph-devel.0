From: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>
Subject: Re: Access Dienied for bucket upload - 403 code
Date: Tue, 11 Sep 2012 19:46:40 +0200
Message-ID: <CAMwB3TiPiwBCwwnFKZFeMAwKKAzc0rVWHKHoc9vnqkTXZL1P7w@mail.gmail.com>
References: <CAMwB3Tg6L1F8bg_DJ9g0ySGn5hjJsiCW0DmKANodrHbESpVqfg@mail.gmail.com>
	<CAC-hyiGYPJpMCLhW6t00ysxXYovAnsnztaxO8LL-dQLtgfbYUQ@mail.gmail.com>
	<CAC-hyiGo2D1oErBx3B3n9Vr=vT_R9L0qQ80vuuHKO_1gjbVPYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:36408 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751824Ab2IKRql convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Sep 2012 13:46:41 -0400
Received: by qaas11 with SMTP id s11so1595906qaa.19
        for <ceph-devel@vger.kernel.org>; Tue, 11 Sep 2012 10:46:41 -0700 (PDT)
In-Reply-To: <CAC-hyiGo2D1oErBx3B3n9Vr=vT_R9L0qQ80vuuHKO_1gjbVPYg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Tue, Sep 11, 2012 at 6:48 PM, Yehuda Sadeh <yehuda@inktank.com> wrot=
e:
> On Tue, Sep 11, 2012 at 9:45 AM, Yehuda Sadeh <yehuda@inktank.com> wr=
ote:
>> On Tue, Sep 11, 2012 at 7:28 AM, S=C5=82awomir Skowron <szibis@gmail=
=2Ecom> wrote:
>>> Every acl operation ending with 403 in PUT.
>>>
>>> ~# s3 -u test oc
>>>                          Bucket                                  St=
atus
>>> --------------------------------------------------------  ---------=
-----------
>>> oc                                                        Access De=
nied
>>>
>>> Anyone know why, and how to enable this bucket ?? Now i have proble=
ms
>>> with cluster, because there is no way to upload new file
>>>
>>> ~# s3 -u getacl oc
>>>
>>> ERROR: ErrorAccessDenied
>>>
>>
>> User somehow lost bucket ownership (was it actually the owner?). Do
>> you know how to reproduce the issue? any remaining logs?
>>
>> Try getting bucket info:
>>
>> # radosgw-admin bucket stats --bucket=3Doc
>>
>> If that doesn't fail and actually shows relevant info, try checking
>> whether the user credentials match the s3 tool credentials.
>>
> Oh, and thinking about it some more.. 'oc' is a too short name for a
> bucket (requires min of 3 chars). How did you create it? The failure
> may be related.

Yes i made a shortcut of name :))

Right now every bucket in pool, are afected

:~#radosgw-admin bucket stats --bucket=3Dlvstest
{ "bucket": "lvstest",
  "pool": ".rgw.buckets",
  "id": "1142048.1",
  "marker": "1142048.1",
  "owner": "0",
  "usage": { "rgw.main": { "size_kb": 1,
          "size_kb_actual": 4,
          "num_objects": 1}}}
:~# radosgw-admin bucket stats --bucket=3Docdn
{ "bucket": "ocdn",
  "pool": ".rgw.buckets",
  "id": "4168.2",
  "marker": "4168.2",
  "owner": "0",
  "usage": { "rgw.main": { "size_kb": 513059717,
          "size_kb_actual": 516402364,
          "num_objects": 1606730}}}

Credentials from radosgw-admin user info match that from clients reques=
ts.

Every GET, PUT, HEAD using this credentials works fine, but only one
operations does not work (403 from radosgw) - setting acl for object
for a public-read. Setting canned acl with PUT for public-read from
s3lib work good, but get/set acl failed.

list bucket object works good, and list buckets via s3 client.

Now i can't reproduce, but i will dig logs from radosgw, for related
time, when this happend.

Example 403 from radosgw log, before that PUT of object ends with 200:

2012-09-11 19:36:34.346312 7fb25d7fa700  1 =3D=3D=3D=3D=3D=3D req done
req=3D0x1435980 http_status=3D403 =3D=3D=3D=3D=3D=3D
2012-09-11 19:37:04.342894 7fb25d7fa700 20 dequeued request req=3D0x139=
94c0
2012-09-11 19:37:04.342903 7fb25d7fa700 20 RGWWQ: empty
2012-09-11 19:37:04.342910 7fb25d7fa700  1 =3D=3D=3D=3D=3D=3D starting =
new request
req=3D0x13994c0 =3D=3D=3D=3D=3D
2012-09-11 19:37:04.342948 7fb25d7fa700  2 req 39665:0.000038::::initia=
lizing
2012-09-11 19:37:04.342971 7fb25d7fa700 10
s->object=3Dimages/pulscms/ZjM7MDA_/d6d6df3de5afa365d0fb7379fdbd75b8.jp=
g
s->bucket=3Docdn
2012-09-11 19:37:04.342983 7fb25d7fa700 10 meta>> HTTP_X_AMZ_ACL=3Dpubl=
ic-read
2012-09-11 19:37:04.342991 7fb25d7fa700 10 x>> x-amz-acl:public-read
2012-09-11 19:37:04.342996 7fb25d7fa700 20 FCGI_ROLE=3DRESPONDER
2012-09-11 19:37:04.342997 7fb25d7fa700 20 SCRIPT_FILENAME=3D/var/www/r=
adosgw.fcgi
2012-09-11 19:37:04.342999 7fb25d7fa700 20 QUERY_STRING=3Dacl
2012-09-11 19:37:04.343001 7fb25d7fa700 20 REQUEST_METHOD=3DPUT
2012-09-11 19:37:04.343002 7fb25d7fa700 20 CONTENT_TYPE=3D
2012-09-11 19:37:04.343003 7fb25d7fa700 20 CONTENT_LENGTH=3D0
2012-09-11 19:37:04.343004 7fb25d7fa700 20 HTTP_CONTENT_LENGTH=3D0
2012-09-11 19:37:04.343005 7fb25d7fa700 20
SCRIPT_NAME=3D/ocdn/images/pulscms/ZjM7MDA_/d6d6df3de5afa365d0fb7379fdb=
d75b8.jpg
2012-09-11 19:37:04.343006 7fb25d7fa700 20
REQUEST_URI=3D/ocdn/images/pulscms/ZjM7MDA_/d6d6df3de5afa365d0fb7379fdb=
d75b8.jpg
2012-09-11 19:37:04.343007 7fb25d7fa700 20
DOCUMENT_URI=3D/ocdn/images/pulscms/ZjM7MDA_/d6d6df3de5afa365d0fb7379fd=
bd75b8.jpg
2012-09-11 19:37:04.343008 7fb25d7fa700 20 DOCUMENT_ROOT=3D/var/www
2012-09-11 19:37:04.343009 7fb25d7fa700 20 SERVER_PROTOCOL=3DHTTP/1.1
2012-09-11 19:37:04.343010 7fb25d7fa700 20 GATEWAY_INTERFACE=3DCGI/1.1
2012-09-11 19:37:04.343011 7fb25d7fa700 20 SERVER_SOFTWARE=3Dnginx/1.2.=
0
2012-09-11 19:37:04.343012 7fb25d7fa700 20 REMOTE_ADDR=3D10.177.62.9
2012-09-11 19:37:04.343013 7fb25d7fa700 20 REMOTE_PORT=3D56378
2012-09-11 19:37:04.343014 7fb25d7fa700 20 SERVER_ADDR=3D10.177.0.3
2012-09-11 19:37:04.343015 7fb25d7fa700 20 SERVER_PORT=3D80
2012-09-11 19:37:04.343016 7fb25d7fa700 20 SERVER_NAME=3D
2012-09-11 19:37:04.343017 7fb25d7fa700 20 REDIRECT_STATUS=3D200
2012-09-11 19:37:04.343018 7fb25d7fa700 20 RGW_SHOULD_LOG=3Dno
2012-09-11 19:37:04.343019 7fb25d7fa700 20 HTTP_HOST=3D10.177.0.3
2012-09-11 19:37:04.343020 7fb25d7fa700 20 HTTP_ACCEPT_ENCODING=3Dident=
ity
2012-09-11 19:37:04.343021 7fb25d7fa700 20 HTTP_DATE=3DTue, 11 Sep 2012
17:37:02 GMT
2012-09-11 19:37:04.343022 7fb25d7fa700 20 HTTP_X_AMZ_ACL=3Dpublic-read
2012-09-11 19:37:04.343023 7fb25d7fa700 20 HTTP_AUTHORIZATION=3DAWS
73VF66Q2JH5PT5K7QJ3A:mh7yBIFGPtdI1MAjW39/1ywV580=3D
2012-09-11 19:37:04.343024 7fb25d7fa700 20 HTTP_USER_AGENT=3DBoto/2.5.2=
 (linux2)
2012-09-11 19:37:04.343026 7fb25d7fa700  2 req 39665:0.000116:s3:PUT
/ocdn/images/pulscms/ZjM7MDA_/d6d6df3de5afa365d0fb7379fdbd75b8.jpg::get=
ting
op
2012-09-11 19:37:04.343031 7fb25d7fa700  2 req 39665:0.000121:s3:PUT
/ocdn/images/pulscms/ZjM7MDA_/d6d6df3de5afa365d0fb7379fdbd75b8.jpg:put_=
obj:authorizing
2012-09-11 19:37:04.343047 7fb25d7fa700 20 get_obj_state:
rctx=3D0x7fb23c006340 obj=3D.users:73VF66Q2JH5PT5K7QJ3A
state=3D0x7fb23c00b468 s->prefetch_data=3D0
2012-09-11 19:37:04.344527 7fb25d7fa700 20 get_obj_state: s->obj_tag
was set empty
2012-09-11 19:37:04.344542 7fb25d7fa700 20 get_obj_state:
rctx=3D0x7fb23c006340 obj=3D.users:73VF66Q2JH5PT5K7QJ3A
state=3D0x7fb23c00b468 s->prefetch_data=3D0
2012-09-11 19:37:04.345847 7fb25d7fa700 20 get_obj_state: s->obj_tag
was set empty
2012-09-11 19:37:04.345858 7fb25d7fa700 20 get_obj_state:
rctx=3D0x7fb23c006340 obj=3D.users:73VF66Q2JH5PT5K7QJ3A
state=3D0x7fb23c00b468 s->prefetch_data=3D0
2012-09-11 19:37:04.345863 7fb25d7fa700 20 state for
obj=3D.users:73VF66Q2JH5PT5K7QJ3A is not atomic, not appending atomic
test
2012-09-11 19:37:04.345866 7fb25d7fa700 20 rados->read obj-ofs=3D0
read_ofs=3D0 read_len=3D16384
2012-09-11 19:37:04.347069 7fb25d7fa700 20 rados->read r=3D0 bl.length=3D=
231
2012-09-11 19:37:04.347121 7fb25d7fa700 10 get_canon_resource():
dest=3D/ocdn/images/pulscms/ZjM7MDA_/d6d6df3de5afa365d0fb7379fdbd75b8.j=
pg
2012-09-11 19:37:04.347126 7fb25d7fa700 10 auth_hdr:
2012-09-11 19:37:04.347195 7fb25d7fa700 15 b64=3D9qJQCGmPbTXcT6a4qD3kED=
0PPdY=3D
2012-09-11 19:37:04.347198 7fb25d7fa700 15
auth_sign=3Dmh7yBIFGPtdI1MAjW39/1ywV580=3D
2012-09-11 19:37:04.347199 7fb25d7fa700 15 compare=3D52
2012-09-11 19:37:04.347201 7fb25d7fa700 10 failed to authorize request
2012-09-11 19:37:04.347208 7fb25d7fa700 10 --> Status: 403
2012-09-11 19:37:04.347218 7fb25d7fa700 10 --> Content-Length: 78
2012-09-11 19:37:04.347220 7fb25d7fa700 10 --> Accept-Ranges: bytes
2012-09-11 19:37:04.347223 7fb25d7fa700 10 --> Content-type: applicatio=
n/xml
2012-09-11 19:37:04.347346 7fb25d7fa700  2 req 39665:0.004436:s3:PUT
/ocdn/images/pulscms/ZjM7MDA_/d6d6df3de5afa365d0fb7379fdbd75b8.jpg:put_=
obj:http
status=3D403
2012-09-11 19:37:04.347600 7fb25d7fa700  1 =3D=3D=3D=3D=3D=3D req done
req=3D0x13994c0 http_status=3D403 =3D=3D=3D=3D=3D=3D
2012-09-11 19:40:04.354709 7fb25d7fa700 20 dequeued request req=3D0x139=
94c0

Interesting is that second cluster, which is replicated via s3 client,
get the same issue, from that in production one. Is this can be
generated by many error on radosgw layer ??

I will try to find beginning of this problems in logs.

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
