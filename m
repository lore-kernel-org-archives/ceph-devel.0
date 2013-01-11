From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: radosgw / fail to authorized request
Date: Fri, 11 Jan 2013 12:41:10 -0800
Message-ID: <CAC-hyiF5cUETb9mGLbwnxyQDE_eVE+ww6mbq9JiXHKktS81MKw@mail.gmail.com>
References: <50F076BF.2020800@novanet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:47243 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753377Ab3AKUlL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Jan 2013 15:41:11 -0500
Received: by mail-ie0-f171.google.com with SMTP id 17so2867660iea.16
        for <ceph-devel@vger.kernel.org>; Fri, 11 Jan 2013 12:41:11 -0800 (PST)
In-Reply-To: <50F076BF.2020800@novanet.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Shailesh Tyagi <shailesh@novanet.net>
Cc: ceph-devel@vger.kernel.org

The following hints at the issue:

2013-01-11 15:15:38.534527 7f0ef54f7700  0 NOTICE: request time skew
too big now=2013-01-11 15:15:38.000000 req_time=2013-01-11
14:18:50.000000

Could be a timezone issue: either not set correctly on your radosgw
machine, or on the client machine.

Yehuda


On Fri, Jan 11, 2013 at 12:31 PM, Shailesh Tyagi <shailesh@novanet.net> wrote:
> Hello,
>
> I have configured radosgw based on the doc available at ceph.com. getting
> "failed to authorized request" while trying to create bucket using s3 api.
> ceph.conf have "auth supported = none"
>
> will appreciate some direction.
>
> Thanks.
> ST
>
> Here is the radosgw log.
>
> 013-01-11 15:15:35.095862 7f0ef7fff700  1 -- 216.128.86.29:0/1025289 -->
> 216.128.86.26:6801/11539 -- ping v1 -- ?+0 0x7f0e9007fc00 con 0x7f0ef0000be0
> 2013-01-11 15:15:38.534022 7f0f14411780 20 enqueued request req=0x2df81e0
> 2013-01-11 15:15:38.534064 7f0f14411780 20 RGWWQ:
> 2013-01-11 15:15:38.534068 7f0f14411780 20 req: 0x2df81e0
> 2013-01-11 15:15:38.534140 7f0f14411780 10 allocated request req=0x2e0e9c0
> 2013-01-11 15:15:38.534157 7f0ef54f7700 20 dequeued request req=0x2df81e0
> 2013-01-11 15:15:38.534183 7f0ef54f7700 20 RGWWQ: empty
> 2013-01-11 15:15:38.534191 7f0ef54f7700  1 ====== starting new request
> req=0x2df81e0 =====
> 2013-01-11 15:15:38.534258 7f0ef54f7700  2 req 16:0.000068::::initializing
> 2013-01-11 15:15:38.534288 7f0ef54f7700 10 meta>> HTTP_X_AMZ_ACL=private
> 2013-01-11 15:15:38.534300 7f0ef54f7700 10 x>> x-amz-acl:private
> 2013-01-11 15:15:38.534323 7f0ef54f7700 10 s->object=<NULL> s->bucket=test
> 2013-01-11 15:15:38.534330 7f0ef54f7700 20 FCGI_ROLE=RESPONDER
> 2013-01-11 15:15:38.534332 7f0ef54f7700 20 SCRIPT_URL=/test/
> 2013-01-11 15:15:38.534333 7f0ef54f7700 20
> SCRIPT_URI=http://ceph-29.novanet.net/test/
> 2013-01-11 15:15:38.534334 7f0ef54f7700 20 HTTP_AUTHORIZATION=AWS
> 2LMOZT925CM56WG0G78M:eWXTBULc9bTxe041Vdqli9vW1sw=
> 2013-01-11 15:15:38.534335 7f0ef54f7700 20 HTTP_USER_AGENT=aws-sdk-php/1.3.3
> PHP/5.3.6 Linux/2.6.32-5-amd64 Arch/x86_64 SAPI/apache2handler
> Integer/9223372036854775807 Build/20110510205648 simplexml/0.1 json/1.2.1
> pcre/8.11 spl/0.2 curl/7.21.3 openssl/0.9.8o apc/3.1.11 pdo/1.0.4dev
> pdo_sqlite/1.0.1 sqlite/2.0-dev sqlite3/0.7-dev zlib/1.1
> 2013-01-11 15:15:38.534340 7f0ef54f7700 20 HTTP_HOST=ceph-29.novanet.net
> 2013-01-11 15:15:38.534342 7f0ef54f7700 20 HTTP_ACCEPT=*/*
> 2013-01-11 15:15:38.534343 7f0ef54f7700 20 HTTP_ACCEPT_ENCODING=deflate,
> gzip
> 2013-01-11 15:15:38.534344 7f0ef54f7700 20
> HTTP_REFERER=http://ceph-29.novanet.net/test/
> 2013-01-11 15:15:38.534345 7f0ef54f7700 20 HTTP_EXPECT=100-continue
> 2013-01-11 15:15:38.534346 7f0ef54f7700 20 CONTENT_LENGTH=0
> 2013-01-11 15:15:38.534347 7f0ef54f7700 20
> HTTP_CONTENT_MD5=1B2M2Y8AsgTpgAmY7PhCfg==
> 2013-01-11 15:15:38.534348 7f0ef54f7700 20 CONTENT_TYPE=application/xml
> 2013-01-11 15:15:38.534349 7f0ef54f7700 20 HTTP_DATE=Fri, 11 Jan 2013
> 19:18:50 GMT
> 2013-01-11 15:15:38.534350 7f0ef54f7700 20 HTTP_X_AMZ_ACL=private
> 2013-01-11 15:15:38.534351 7f0ef54f7700 20
> PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games
> 2013-01-11 15:15:38.534352 7f0ef54f7700 20 SERVER_SIGNATURE=
> 2013-01-11 15:15:38.534353 7f0ef54f7700 20 SERVER_SOFTWARE=Apache/2.2.22
> (Unix) mod_ssl/2.2.22 OpenSSL/1.0.1 mod_fastcgi/mod_fastcgi-SNAP-0910052141
> 2013-01-11 15:15:38.534355 7f0ef54f7700 20 SERVER_NAME=ceph-29.novanet.net
> 2013-01-11 15:15:38.534356 7f0ef54f7700 20 SERVER_ADDR=216.128.86.29
> 2013-01-11 15:15:38.534357 7f0ef54f7700 20 SERVER_PORT=80
> 2013-01-11 15:15:38.534358 7f0ef54f7700 20 REMOTE_ADDR=203.153.53.187
> 2013-01-11 15:15:38.534359 7f0ef54f7700 20 DOCUMENT_ROOT=/var/www
> 2013-01-11 15:15:38.534360 7f0ef54f7700 20
> SERVER_ADMIN=webmaster@novanet.net
> 2013-01-11 15:15:38.534361 7f0ef54f7700 20
> SCRIPT_FILENAME=/var/www/s3gw.fcgi
> 2013-01-11 15:15:38.534363 7f0ef54f7700 20 REMOTE_PORT=47829
> 2013-01-11 15:15:38.534364 7f0ef54f7700 20 GATEWAY_INTERFACE=CGI/1.1
> 2013-01-11 15:15:38.534365 7f0ef54f7700 20 SERVER_PROTOCOL=HTTP/1.1
> 2013-01-11 15:15:38.534366 7f0ef54f7700 20 REQUEST_METHOD=PUT
> 2013-01-11 15:15:38.534367 7f0ef54f7700 20 QUERY_STRING=page=test&params=/
> 2013-01-11 15:15:38.534368 7f0ef54f7700 20 REQUEST_URI=/test/
> 2013-01-11 15:15:38.534369 7f0ef54f7700 20 SCRIPT_NAME=/test/
> 2013-01-11 15:15:38.534372 7f0ef54f7700  2 req 16:0.000182:s3:PUT
> /test/::getting op
> 2013-01-11 15:15:38.534378 7f0ef54f7700  2 req 16:0.000188:s3:PUT
> /test/:create_bucket:authorizing
> 2013-01-11 15:15:38.534406 7f0ef54f7700 20 get_obj_state:
> rctx=0x7f0e9c005f80 obj=.users:2LMOZT925CM56WG0G78M state=0x7f0e9c00bc08
> s->prefetch_data=0
> 2013-01-11 15:15:38.534419 7f0ef54f7700 10 moving
> .users+2LMOZT925CM56WG0G78M to cache LRU end
> 2013-01-11 15:15:38.534423 7f0ef54f7700 10 cache get:
> name=.users+2LMOZT925CM56WG0G78M : hit
> 2013-01-11 15:15:38.534442 7f0ef54f7700 20 get_obj_state: s->obj_tag was set
> empty
> 2013-01-11 15:15:38.534451 7f0ef54f7700 10 moving
> .users+2LMOZT925CM56WG0G78M to cache LRU end
> 2013-01-11 15:15:38.534453 7f0ef54f7700 10 cache get:
> name=.users+2LMOZT925CM56WG0G78M : hit
> 2013-01-11 15:15:38.534517 7f0ef54f7700 10 get_canon_resource(): dest=/test/
> 2013-01-11 15:15:38.534521 7f0ef54f7700 10 auth_hdr:
> PUT
> 1B2M2Y8AsgTpgAmY7PhCfg==
> application/xml
> Fri, 11 Jan 2013 19:18:50 GMT
> x-amz-acl:private
> /test/
> 2013-01-11 15:15:38.534523 7f0ef54f7700 10 req_sec=1357931930
> now=1357935338; now - RGW_AUTH_GRACE_MINS=1357934438; now +
> RGW_AUTH_GRACE_MINS=1357936238
> 2013-01-11 15:15:38.534527 7f0ef54f7700  0 NOTICE: request time skew too big
> now=2013-01-11 15:15:38.000000 req_time=2013-01-11 14:18:50.000000
> 2013-01-11 15:15:38.534537 7f0ef54f7700 10 failed to authorize request
> 2013-01-11 15:15:38.534571 7f0ef54f7700  2 req 16:0.000381:s3:PUT
> /test/:create_bucket:http status=403
> 2013-01-11 15:15:38.534705 7f0ef54f7700  1 ====== req done req=0x2df81e0
> http_status=403 ======
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
