From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: radosgw create bucket yields HTTP error 500
Date: Mon, 3 Sep 2012 03:44:54 -0700
Message-ID: <CAC-hyiGmeMpyFojrJm=5cgz5O--n9S-JEMhFav56ZTNFBORPaw@mail.gmail.com>
References: <50440E4602000099000E9608@collaborate.seakr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:34296 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751208Ab2ICKo4 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Sep 2012 06:44:56 -0400
Received: by bkwj10 with SMTP id j10so2101326bkw.19
        for <ceph-devel@vger.kernel.org>; Mon, 03 Sep 2012 03:44:54 -0700 (PDT)
In-Reply-To: <50440E4602000099000E9608@collaborate.seakr.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nick Couchman <Nick.Couchman@seakr.com>
Cc: ceph-devel@vger.kernel.org

Error 5 means EIO. Can you set 'debug ms =3D 1' on the radosgw (and
probably also on the osd to correlate)?

Thanks,
Yehuda

On Mon, Sep 3, 2012 at 12:56 AM, Nick Couchman <Nick.Couchman@seakr.com=
> wrote:
> So, after much trial and error I finally got ceph up and running and =
radosgw up and running.  However, I'm not running into a situation wher=
e, when I try to create a new bucket under my test account, I'm getting=
 an HTTP status 500 on the client.  I have radosgw running in debug mod=
e, and I get the below response.  I'm not exactly sure how to interpret=
 that - it looks to me like ceph gets the response, verifies credential=
s and access, verifies that a pool is available (.rgw.buckets), but the=
n, for some reason runs into a return value of -5 on the "rgw_create_bu=
cket" function.  I don't know what that value represents, but the next =
line has err_no=3D5, then it says that it's returning http status 500. =
 Any hints as to what return value of -5 means, error code 5, or why I'=
m getting an internal error trying to create a bucket?
>
> Thanks - Nick
>
> 2012-09-03 01:45:51.757251 7f8aa97f2700  1 =3D=3D=3D=3D=3D=3D startin=
g new request req=3D0xf62550 =3D=3D=3D=3D=3D
> 2012-09-03 01:45:51.757299 7f8aa97f2700  2 req 20:0.000048::::initial=
izing
> 2012-09-03 01:45:51.757320 7f8aa97f2700 10 s->object=3D s->bucket=3Dt=
est
> 2012-09-03 01:45:51.757329 7f8aa97f2700 20 FCGI_ROLE=3DRESPONDER
> 2012-09-03 01:45:51.757331 7f8aa97f2700 20 SCRIPT_URL=3D/test
> 2012-09-03 01:45:51.757334 7f8aa97f2700 20 SCRIPT_URI=3Dhttp://cloud.=
seakr.com/test
> 2012-09-03 01:45:51.757336 7f8aa97f2700 20 HTTP_AUTHORIZATION=3DAWS B=
EH8OJ2EM7Z2WDAFFRPI:4qdgNWUJ4+NBK+tMoK2FheFKuUg=3D
> 2012-09-03 01:45:51.757338 7f8aa97f2700 20 RGW_DNS_NAME=3Dcloud.
> 2012-09-03 01:45:51.757340 7f8aa97f2700 20 HTTP_USER_AGENT=3DCloudBer=
ryLab.Base.HttpUtil.Client 3.5.1 (http://www.cloudberrylab.com/)
> 2012-09-03 01:45:51.757344 7f8aa97f2700 20 HTTP_DATE=3DMon, 03 Sep 20=
12 07:45:52 GMT
> 2012-09-03 01:45:51.757346 7f8aa97f2700 20 HTTP_HOST=3Dcloud.seakr.co=
m
> 2012-09-03 01:45:51.757348 7f8aa97f2700 20 CONTENT_LENGTH=3D0
> 2012-09-03 01:45:51.757350 7f8aa97f2700 20 HTTP_CONNECTION=3DClose
> 2012-09-03 01:45:51.757352 7f8aa97f2700 20 PATH=3D/usr/local/sbin:/us=
r/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
> 2012-09-03 01:45:51.757355 7f8aa97f2700 20 SERVER_SIGNATURE=3D
> 2012-09-03 01:45:51.757357 7f8aa97f2700 20 SERVER_SOFTWARE=3DApache/2=
=2E2.21 (Linux/SUSE)
> 2012-09-03 01:45:51.757359 7f8aa97f2700 20 SERVER_NAME=3Dcloud.seakr.=
com
> 2012-09-03 01:45:51.757361 7f8aa97f2700 20 SERVER_ADDR=3D192.168.30.1=
02
> 2012-09-03 01:45:51.757363 7f8aa97f2700 20 SERVER_PORT=3D80
> 2012-09-03 01:45:51.757365 7f8aa97f2700 20 REMOTE_ADDR=3D192.168.10.2=
4
> 2012-09-03 01:45:51.757368 7f8aa97f2700 20 DOCUMENT_ROOT=3D/srv/www/h=
tdocs
> 2012-09-03 01:45:51.757370 7f8aa97f2700 20 SERVER_ADMIN=3D[no address=
 given]
> 2012-09-03 01:45:51.757372 7f8aa97f2700 20 SCRIPT_FILENAME=3D/srv/www=
/htdocs/s3gw.fcgi
> 2012-09-03 01:45:51.757374 7f8aa97f2700 20 REMOTE_PORT=3D51971
> 2012-09-03 01:45:51.757376 7f8aa97f2700 20 GATEWAY_INTERFACE=3DCGI/1.=
1
> 2012-09-03 01:45:51.757378 7f8aa97f2700 20 SERVER_PROTOCOL=3DHTTP/1.1
> 2012-09-03 01:45:51.757380 7f8aa97f2700 20 REQUEST_METHOD=3DPUT
> 2012-09-03 01:45:51.757383 7f8aa97f2700 20 QUERY_STRING=3Dpage=3Dtest=
=B6ms=3D
> 2012-09-03 01:45:51.757385 7f8aa97f2700 20 REQUEST_URI=3D/test
> 2012-09-03 01:45:51.757387 7f8aa97f2700 20 SCRIPT_NAME=3D/test
> 2012-09-03 01:45:51.757392 7f8aa97f2700  2 req 20:0.000140:s3:PUT /te=
st::getting op
> 2012-09-03 01:45:51.757398 7f8aa97f2700  2 req 20:0.000147:s3:PUT /te=
st:create_bucket:authorizing
> 2012-09-03 01:45:51.757417 7f8aa97f2700 20 get_obj_state: rctx=3D0x7f=
8ac0022540 obj=3D.users:BEH8OJ2EM7Z2WDAFFRPI state=3D0x7f8ac00225f8 s->=
prefetch_data=3D0
> 2012-09-03 01:45:51.757429 7f8aa97f2700 10 moving .users+BEH8OJ2EM7Z2=
WDAFFRPI to cache LRU end
> 2012-09-03 01:45:51.757433 7f8aa97f2700 10 cache get: name=3D.users+B=
EH8OJ2EM7Z2WDAFFRPI : hit
> 2012-09-03 01:45:51.757440 7f8aa97f2700 20 get_obj_state: s->obj_tag =
was set empty
> 2012-09-03 01:45:51.757447 7f8aa97f2700 10 moving .users+BEH8OJ2EM7Z2=
WDAFFRPI to cache LRU end
> 2012-09-03 01:45:51.757450 7f8aa97f2700 10 cache get: name=3D.users+B=
EH8OJ2EM7Z2WDAFFRPI : hit
> 2012-09-03 01:45:51.757484 7f8aa97f2700 10 get_canon_resource(): dest=
=3D/test
> 2012-09-03 01:45:51.757488 7f8aa97f2700 10 auth_hdr:
> PUT
>
>
> Mon, 03 Sep 2012 07:45:52 GMT
> /test
> 2012-09-03 01:45:51.757552 7f8aa97f2700 15 b64=3D4qdgNWUJ4+NBK+tMoK2F=
heFKuUg=3D
> 2012-09-03 01:45:51.757556 7f8aa97f2700 15 auth_sign=3D4qdgNWUJ4+NBK+=
tMoK2FheFKuUg=3D
> 2012-09-03 01:45:51.757558 7f8aa97f2700 15 compare=3D0
> 2012-09-03 01:45:51.757563 7f8aa97f2700  2 req 20:0.000311:s3:PUT /te=
st:create_bucket:reading permissions
> 2012-09-03 01:45:51.757569 7f8aa97f2700  2 req 20:0.000317:s3:PUT /te=
st:create_bucket:verifying op permissions
> 2012-09-03 01:45:51.759125 7f8aa97f2700  2 req 20:0.001873:s3:PUT /te=
st:create_bucket:verifying op params
> 2012-09-03 01:45:51.759131 7f8aa97f2700  2 req 20:0.001880:s3:PUT /te=
st:create_bucket:executing
> 2012-09-03 01:45:51.759147 7f8aa97f2700 20 get_obj_state: rctx=3D0x7f=
8ac0013060 obj=3D.rgw:test state=3D0x7f8ac00237c8 s->prefetch_data=3D0
> 2012-09-03 01:45:51.759155 7f8aa97f2700 10 moving .rgw+test to cache =
LRU end
> 2012-09-03 01:45:51.759158 7f8aa97f2700 10 cache get: name=3D.rgw+tes=
t : type miss (requested=3D6, cached=3D0)
> 2012-09-03 01:45:51.760342 7f8aa97f2700 10 cache put: name=3D.rgw+tes=
t
> 2012-09-03 01:45:51.760346 7f8aa97f2700 10 moving .rgw+test to cache =
LRU end
> 2012-09-03 01:45:51.760365 7f8aa97f2700 20 get_obj_state: rctx=3D0x7f=
8ac0018a00 obj=3D.rgw:.pools.avail state=3D0x7f8ac0028068 s->prefetch_d=
ata=3D0
> 2012-09-03 01:45:51.760372 7f8aa97f2700 10 moving .rgw+.pools.avail t=
o cache LRU end
> 2012-09-03 01:45:51.760376 7f8aa97f2700 10 cache get: name=3D.rgw+.po=
ols.avail : hit
> 2012-09-03 01:45:51.760381 7f8aa97f2700 20 get_obj_state: s->obj_tag =
was set empty
> 2012-09-03 01:45:51.760387 7f8aa97f2700 10 moving .rgw+.pools.avail t=
o cache LRU end
> 2012-09-03 01:45:51.760390 7f8aa97f2700 10 cache get: name=3D.rgw+.po=
ols.avail : hit
> 2012-09-03 01:45:51.761619 7f8aa97f2700 20 rgw_create_bucket returned=
 ret=3D-5 bucket=3Dtest(@.rgw.buckets[4180.12])
> 2012-09-03 01:45:51.761625 7f8aa97f2700  0 WARNING: set_req_state_err=
 err_no=3D5 resorting to 500
> 2012-09-03 01:45:51.761631 7f8aa97f2700 10 --> Status: 500
>
> 2012-09-03 01:45:51.761641 7f8aa97f2700 10 --> Content-Length: 78
>
> 2012-09-03 01:45:51.761645 7f8aa97f2700 10 --> Accept-Ranges: bytes
>
> 2012-09-03 01:45:51.761648 7f8aa97f2700 10 --> Content-type: applicat=
ion/xml
>
> 2012-09-03 01:45:51.761731 7f8aa97f2700  2 req 20:0.004480:s3:PUT /te=
st:create_bucket:http status=3D500
> 2012-09-03 01:45:51.762070 7f8aa97f2700  1 =3D=3D=3D=3D=3D=3D req don=
e req=3D0xf62550 http_status=3D500 =3D=3D=3D=3D=3D=3D
>
>
>
>
> --------
> This e-mail may contain confidential and privileged material for the =
sole use of the intended recipient.  If this email is not intended for =
you, or you are not responsible for the delivery of this message to the=
 intended recipient, please note that this message may contain SEAKR En=
gineering (SEAKR) Privileged/Proprietary Information.  In such a case, =
you are strictly prohibited from downloading, photocopying, distributin=
g or otherwise using this message, its contents or attachments in any w=
ay.  If you have received this message in error, please notify us immed=
iately by replying to this e-mail and delete the message from your mail=
box.  Information contained in this message that does not relate to the=
 business of SEAKR is neither endorsed by nor attributable to SEAKR.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
