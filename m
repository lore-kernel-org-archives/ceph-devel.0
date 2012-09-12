From: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>
Subject: Re: Access Dienied for bucket upload - 403 code
Date: Wed, 12 Sep 2012 07:07:27 +0200
Message-ID: <-4633188138106760306@unknownmsgid>
References: <CAMwB3Tg6L1F8bg_DJ9g0ySGn5hjJsiCW0DmKANodrHbESpVqfg@mail.gmail.com>
 <CAC-hyiGYPJpMCLhW6t00ysxXYovAnsnztaxO8LL-dQLtgfbYUQ@mail.gmail.com>
 <CAC-hyiGo2D1oErBx3B3n9Vr=vT_R9L0qQ80vuuHKO_1gjbVPYg@mail.gmail.com>
 <CAMwB3TiPiwBCwwnFKZFeMAwKKAzc0rVWHKHoc9vnqkTXZL1P7w@mail.gmail.com>
 <CAMwB3ThhS5Y=GP259HTJbNDZudLmSVaCqD4jgWdhvQXCygPGcw@mail.gmail.com> <CAC-hyiFvMkwuA21H10J+_kmt2UujjpNCABA_jVF8b_hbWpocEg@mail.gmail.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:62435 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751938Ab2ILFHg convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Sep 2012 01:07:36 -0400
Received: by qaas11 with SMTP id s11so837887qaa.19
        for <ceph-devel@vger.kernel.org>; Tue, 11 Sep 2012 22:07:35 -0700 (PDT)
In-Reply-To: <CAC-hyiFvMkwuA21H10J+_kmt2UujjpNCABA_jVF8b_hbWpocEg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I grep only for 7faec76c6700

Where are stored acl data for bucket in ceph?? Maybe acl are broken
for anonymous user ??

Ceph supporting global acl for bucket??

Dnia 12 wrz 2012 o godz. 01:27 Yehuda Sadeh <yehuda@inktank.com> napisa=
=C5=82(a):

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
>
> missing some lines here, did you grep the output?
>
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
>
> and here also
>
>> 2012-09-11 22:37:34.712735 7faec76c6700 15 b64=3D7pIUzzJaX/EyTV89LMX=
wcqvS06w=3D
>> 2012-09-11 22:37:34.712742 7faec76c6700 15
>> auth_sign=3DxHPA2K5QvuehAvKH9WdOvf+ZKzE=3D
>> 2012-09-11 22:37:34.712744 7faec76c6700 15 compare=3D65
>> 2012-09-11 22:37:34.712747 7faec76c6700 10 failed to authorize reque=
st
>> 2012-09-11 22:37:34.712754 7faec76c6700 10 --> Status: 403
>> 2012-09-11 22:37:34.712766 7faec76c6700 10 --> Content-Length: 78
>> 2012-09-11 22:37:34.712769 7faec76c6700 10 --> Accept-Ranges: bytes
>> 2012-09-11 22:37:34.712772 7faec76c6700 10 --> Content-type: applica=
tion/xml
>> 2012-09-11 22:37:34.712887 7faec76c6700  2 req 71188:0.004554:s3:PUT
>> /ocdn/files/pulscms/MjU7MDA_/ecebacddde95224b96f46333912049b1:put_ob=
j:http
>> status=3D403
>> 2012-09-11 22:37:34.713093 7faec76c6700  1 =3D=3D=3D=3D=3D=3D req do=
ne
>> req=3D0x1368860 http_status=3D403 =3D=3D=3D=3D=3D=3D
>>
>> On Tue, Sep 11, 2012 at 7:46 PM, S=C5=82awomir Skowron <szibis@gmail=
=2Ecom> wrote:
>>> On Tue, Sep 11, 2012 at 6:48 PM, Yehuda Sadeh <yehuda@inktank.com> =
wrote:
>>>> On Tue, Sep 11, 2012 at 9:45 AM, Yehuda Sadeh <yehuda@inktank.com>=
 wrote:
>>>>> On Tue, Sep 11, 2012 at 7:28 AM, S=C5=82awomir Skowron <szibis@gm=
ail.com> wrote:
>>>>>> Every acl operation ending with 403 in PUT.
>>>>>>
>>>>>> ~# s3 -u test oc
>>>>>>                         Bucket                                  =
Status
>>>>>> --------------------------------------------------------  ------=
--------------
>>>>>> oc                                                        Access=
 Denied
>>>>>>
>>>>>> Anyone know why, and how to enable this bucket ?? Now i have pro=
blems
>>>>>> with cluster, because there is no way to upload new file
>>>>>>
>>>>>> ~# s3 -u getacl oc
>>>>>>
>>>>>> ERROR: ErrorAccessDenied
>>>>>>
>>>>>
>>>>> User somehow lost bucket ownership (was it actually the owner?). =
Do
>>>>> you know how to reproduce the issue? any remaining logs?
>>>>>
>>>>> Try getting bucket info:
>>>>>
>>>>> # radosgw-admin bucket stats --bucket=3Doc
>>>>>
>>>>> If that doesn't fail and actually shows relevant info, try checki=
ng
>>>>> whether the user credentials match the s3 tool credentials.
>>>>>
>>>> Oh, and thinking about it some more.. 'oc' is a too short name for=
 a
>>>> bucket (requires min of 3 chars). How did you create it? The failu=
re
>>>> may be related.
>>>
>>> Yes i made a shortcut of name :))
>>>
>>> Right now every bucket in pool, are afected
>>>
>>> :~#radosgw-admin bucket stats --bucket=3Dlvstest
>>> { "bucket": "lvstest",
>>>  "pool": ".rgw.buckets",
>>>  "id": "1142048.1",
>>>  "marker": "1142048.1",
>>>  "owner": "0",
>>>  "usage": { "rgw.main": { "size_kb": 1,
>>>          "size_kb_actual": 4,
>>>          "num_objects": 1}}}
>>> :~# radosgw-admin bucket stats --bucket=3Docdn
>>> { "bucket": "ocdn",
>>>  "pool": ".rgw.buckets",
>>>  "id": "4168.2",
>>>  "marker": "4168.2",
>>>  "owner": "0",
>>>  "usage": { "rgw.main": { "size_kb": 513059717,
>>>          "size_kb_actual": 516402364,
>>>          "num_objects": 1606730}}}
>>>
>>> Credentials from radosgw-admin user info match that from clients re=
quests.
>>>
>>> Every GET, PUT, HEAD using this credentials works fine, but only on=
e
>>> operations does not work (403 from radosgw) - setting acl for objec=
t
>>> for a public-read. Setting canned acl with PUT for public-read from
>>> s3lib work good, but get/set acl failed.
>>>
>>> list bucket object works good, and list buckets via s3 client.
>>>
>>> Now i can't reproduce, but i will dig logs from radosgw, for relate=
d
>>> time, when this happend.
>>>
>>> Example 403 from radosgw log, before that PUT of object ends with 2=
00:
>>>
>>> 2012-09-11 19:36:34.346312 7fb25d7fa700  1 =3D=3D=3D=3D=3D=3D req d=
one
>>> req=3D0x1435980 http_status=3D403 =3D=3D=3D=3D=3D=3D
>>> 2012-09-11 19:37:04.342894 7fb25d7fa700 20 dequeued request req=3D0=
x13994c0
>>> 2012-09-11 19:37:04.342903 7fb25d7fa700 20 RGWWQ: empty
>>> 2012-09-11 19:37:04.342910 7fb25d7fa700  1 =3D=3D=3D=3D=3D=3D start=
ing new request
>>> req=3D0x13994c0 =3D=3D=3D=3D=3D
>>> 2012-09-11 19:37:04.342948 7fb25d7fa700  2 req 39665:0.000038::::in=
itializing
>>> 2012-09-11 19:37:04.342971 7fb25d7fa700 10
>>> s->object=3Dimages/pulscms/ZjM7MDA_/d6d6df3de5afa365d0fb7379fdbd75b=
8.jpg
>>> s->bucket=3Docdn
>>> 2012-09-11 19:37:04.342983 7fb25d7fa700 10 meta>> HTTP_X_AMZ_ACL=3D=
public-read
>>> 2012-09-11 19:37:04.342991 7fb25d7fa700 10 x>> x-amz-acl:public-rea=
d
>>> 2012-09-11 19:37:04.342996 7fb25d7fa700 20 FCGI_ROLE=3DRESPONDER
>>> 2012-09-11 19:37:04.342997 7fb25d7fa700 20 SCRIPT_FILENAME=3D/var/w=
ww/radosgw.fcgi
>>> 2012-09-11 19:37:04.342999 7fb25d7fa700 20 QUERY_STRING=3Dacl
>>> 2012-09-11 19:37:04.343001 7fb25d7fa700 20 REQUEST_METHOD=3DPUT
>>> 2012-09-11 19:37:04.343002 7fb25d7fa700 20 CONTENT_TYPE=3D
>>> 2012-09-11 19:37:04.343003 7fb25d7fa700 20 CONTENT_LENGTH=3D0
>>> 2012-09-11 19:37:04.343004 7fb25d7fa700 20 HTTP_CONTENT_LENGTH=3D0
>>> 2012-09-11 19:37:04.343005 7fb25d7fa700 20
>>> SCRIPT_NAME=3D/ocdn/images/pulscms/ZjM7MDA_/d6d6df3de5afa365d0fb737=
9fdbd75b8.jpg
>>> 2012-09-11 19:37:04.343006 7fb25d7fa700 20
>>> REQUEST_URI=3D/ocdn/images/pulscms/ZjM7MDA_/d6d6df3de5afa365d0fb737=
9fdbd75b8.jpg
>>> 2012-09-11 19:37:04.343007 7fb25d7fa700 20
>>> DOCUMENT_URI=3D/ocdn/images/pulscms/ZjM7MDA_/d6d6df3de5afa365d0fb73=
79fdbd75b8.jpg
>>> 2012-09-11 19:37:04.343008 7fb25d7fa700 20 DOCUMENT_ROOT=3D/var/www
>>> 2012-09-11 19:37:04.343009 7fb25d7fa700 20 SERVER_PROTOCOL=3DHTTP/1=
=2E1
>>> 2012-09-11 19:37:04.343010 7fb25d7fa700 20 GATEWAY_INTERFACE=3DCGI/=
1.1
>>> 2012-09-11 19:37:04.343011 7fb25d7fa700 20 SERVER_SOFTWARE=3Dnginx/=
1.2.0
>>> 2012-09-11 19:37:04.343012 7fb25d7fa700 20 REMOTE_ADDR=3D10.177.62.=
9
>>> 2012-09-11 19:37:04.343013 7fb25d7fa700 20 REMOTE_PORT=3D56378
>>> 2012-09-11 19:37:04.343014 7fb25d7fa700 20 SERVER_ADDR=3D10.177.0.3
>>> 2012-09-11 19:37:04.343015 7fb25d7fa700 20 SERVER_PORT=3D80
>>> 2012-09-11 19:37:04.343016 7fb25d7fa700 20 SERVER_NAME=3D
>>> 2012-09-11 19:37:04.343017 7fb25d7fa700 20 REDIRECT_STATUS=3D200
>>> 2012-09-11 19:37:04.343018 7fb25d7fa700 20 RGW_SHOULD_LOG=3Dno
>>> 2012-09-11 19:37:04.343019 7fb25d7fa700 20 HTTP_HOST=3D10.177.0.3
>>> 2012-09-11 19:37:04.343020 7fb25d7fa700 20 HTTP_ACCEPT_ENCODING=3Di=
dentity
>>> 2012-09-11 19:37:04.343021 7fb25d7fa700 20 HTTP_DATE=3DTue, 11 Sep =
2012
>>> 17:37:02 GMT
>>> 2012-09-11 19:37:04.343022 7fb25d7fa700 20 HTTP_X_AMZ_ACL=3Dpublic-=
read
>>> 2012-09-11 19:37:04.343023 7fb25d7fa700 20 HTTP_AUTHORIZATION=3DAWS
>>> 73VF66Q2JH5PT5K7QJ3A:mh7yBIFGPtdI1MAjW39/1ywV580=3D
>>> 2012-09-11 19:37:04.343024 7fb25d7fa700 20 HTTP_USER_AGENT=3DBoto/2=
=2E5.2 (linux2)
>>> 2012-09-11 19:37:04.343026 7fb25d7fa700  2 req 39665:0.000116:s3:PU=
T
>>> /ocdn/images/pulscms/ZjM7MDA_/d6d6df3de5afa365d0fb7379fdbd75b8.jpg:=
:getting
>>> op
>>> 2012-09-11 19:37:04.343031 7fb25d7fa700  2 req 39665:0.000121:s3:PU=
T
>>> /ocdn/images/pulscms/ZjM7MDA_/d6d6df3de5afa365d0fb7379fdbd75b8.jpg:=
put_obj:authorizing
>>> 2012-09-11 19:37:04.343047 7fb25d7fa700 20 get_obj_state:
>>> rctx=3D0x7fb23c006340 obj=3D.users:73VF66Q2JH5PT5K7QJ3A
>>> state=3D0x7fb23c00b468 s->prefetch_data=3D0
>>> 2012-09-11 19:37:04.344527 7fb25d7fa700 20 get_obj_state: s->obj_ta=
g
>>> was set empty
>>> 2012-09-11 19:37:04.344542 7fb25d7fa700 20 get_obj_state:
>>> rctx=3D0x7fb23c006340 obj=3D.users:73VF66Q2JH5PT5K7QJ3A
>>> state=3D0x7fb23c00b468 s->prefetch_data=3D0
>>> 2012-09-11 19:37:04.345847 7fb25d7fa700 20 get_obj_state: s->obj_ta=
g
>>> was set empty
>>> 2012-09-11 19:37:04.345858 7fb25d7fa700 20 get_obj_state:
>>> rctx=3D0x7fb23c006340 obj=3D.users:73VF66Q2JH5PT5K7QJ3A
>>> state=3D0x7fb23c00b468 s->prefetch_data=3D0
>>> 2012-09-11 19:37:04.345863 7fb25d7fa700 20 state for
>>> obj=3D.users:73VF66Q2JH5PT5K7QJ3A is not atomic, not appending atom=
ic
>>> test
>>> 2012-09-11 19:37:04.345866 7fb25d7fa700 20 rados->read obj-ofs=3D0
>>> read_ofs=3D0 read_len=3D16384
>>> 2012-09-11 19:37:04.347069 7fb25d7fa700 20 rados->read r=3D0 bl.len=
gth=3D231
>>> 2012-09-11 19:37:04.347121 7fb25d7fa700 10 get_canon_resource():
>>> dest=3D/ocdn/images/pulscms/ZjM7MDA_/d6d6df3de5afa365d0fb7379fdbd75=
b8.jpg
>>> 2012-09-11 19:37:04.347126 7fb25d7fa700 10 auth_hdr:
>>> 2012-09-11 19:37:04.347195 7fb25d7fa700 15 b64=3D9qJQCGmPbTXcT6a4qD=
3kED0PPdY=3D
>>> 2012-09-11 19:37:04.347198 7fb25d7fa700 15
>>> auth_sign=3Dmh7yBIFGPtdI1MAjW39/1ywV580=3D
>>> 2012-09-11 19:37:04.347199 7fb25d7fa700 15 compare=3D52
>>> 2012-09-11 19:37:04.347201 7fb25d7fa700 10 failed to authorize requ=
est
>>> 2012-09-11 19:37:04.347208 7fb25d7fa700 10 --> Status: 403
>>> 2012-09-11 19:37:04.347218 7fb25d7fa700 10 --> Content-Length: 78
>>> 2012-09-11 19:37:04.347220 7fb25d7fa700 10 --> Accept-Ranges: bytes
>>> 2012-09-11 19:37:04.347223 7fb25d7fa700 10 --> Content-type: applic=
ation/xml
>>> 2012-09-11 19:37:04.347346 7fb25d7fa700  2 req 39665:0.004436:s3:PU=
T
>>> /ocdn/images/pulscms/ZjM7MDA_/d6d6df3de5afa365d0fb7379fdbd75b8.jpg:=
put_obj:http
>>> status=3D403
>>> 2012-09-11 19:37:04.347600 7fb25d7fa700  1 =3D=3D=3D=3D=3D=3D req d=
one
>>> req=3D0x13994c0 http_status=3D403 =3D=3D=3D=3D=3D=3D
>>> 2012-09-11 19:40:04.354709 7fb25d7fa700 20 dequeued request req=3D0=
x13994c0
>>>
>>> Interesting is that second cluster, which is replicated via s3 clie=
nt,
>>> get the same issue, from that in production one. Is this can be
>>> generated by many error on radosgw layer ??
>>>
>>> I will try to find beginning of this problems in logs.
>>>
>>>>
>>>> Yehuda
>>>
>>>
>>>
>>> --
>>> -----
>>> Pozdrawiam
>>>
>>> S=C5=82awek "sZiBis" Skowron
>>
>>
>>
>> --
>> -----
>> Pozdrawiam
>>
>> S=C5=82awek "sZiBis" Skowron
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
