From: Zhao zhiming <zhaozhiming003@gmail.com>
Subject: rgw create bucket 403 error
Date: Mon, 29 Sep 2014 13:38:17 +0800
Message-ID: <C126F1F6-28C3-4C47-B124-75756011AC98@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:57768 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836AbaI2Fif convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Sep 2014 01:38:35 -0400
Received: by mail-pd0-f182.google.com with SMTP id y10so4709165pdj.41
        for <ceph-devel@vger.kernel.org>; Sun, 28 Sep 2014 22:38:35 -0700 (PDT)
Received: from [172.31.206.47] ([119.122.18.53])
        by mx.google.com with ESMTPSA id t6sm2556444pds.66.2014.09.28.22.38.31
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 28 Sep 2014 22:38:33 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

HI ALL,

I use java code to invoke s3 api to create bucket, but I get some error=
 as follow. And I found many hours with google but can=92t solve it.=20

The access_key,  secret_key and the java code is no problem, because I =
change to another rgw (use the same code only change the rgw url) is OK=
=2E=20

My ceph version is 0.80.5.

Please help. Thank you.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
2014-09-29 19:30:58.206898 7f265e1fc700 20 enqueued request req=3D0x7f2=
644011e40
2014-09-29 19:30:58.206913 7f265e1fc700 20 RGWWQ:
2014-09-29 19:30:58.206915 7f265e1fc700 20 req: 0x7f2644011e40
2014-09-29 19:30:58.206920 7f265e1fc700 10 allocated request req=3D0x7f=
26440124f0
2014-09-29 19:30:58.206953 7f26417fb700 20 dequeued request req=3D0x7f2=
644011e40
2014-09-29 19:30:58.206964 7f26417fb700 20 RGWWQ: empty
2014-09-29 19:30:58.207005 7f26417fb700 20 CONTENT_LENGTH=3D0
2014-09-29 19:30:58.207007 7f26417fb700 20 CONTENT_TYPE=3Dapplication/x=
-www-form-urlencoded; charset=3Dutf-8
2014-09-29 19:30:58.207009 7f26417fb700 20 DOCUMENT_ROOT=3D/var/www/htm=
l
2014-09-29 19:30:58.207010 7f26417fb700 20 FCGI_ROLE=3DRESPONDER
2014-09-29 19:30:58.207010 7f26417fb700 20 GATEWAY_INTERFACE=3DCGI/1.1
2014-09-29 19:30:58.207011 7f26417fb700 20 HTTP_AUTHORIZATION=3DAWS ESW=
EOCEAYEYSB59JROLB:odBmvMAX+LWeWsP/8Ak/sEnVTuI=3D
2014-09-29 19:30:58.207012 7f26417fb700 20 HTTP_CONNECTION=3DKeep-Alive
2014-09-29 19:30:58.207014 7f26417fb700 20 HTTP_DATE=3DMon, 29 Sep 2014=
 03:30:29 GMT
2014-09-29 19:30:58.207014 7f26417fb700 20 HTTP_HOST=3D10.42.36.44
2014-09-29 19:30:58.207015 7f26417fb700 20 HTTP_USER_AGENT=3Daws-sdk-ja=
va/1.8.9.1 Windows_7/6.1 Java_HotSpot(TM)_Client_VM/14.0-b16/1.6.0_14
2014-09-29 19:30:58.207018 7f26417fb700 20 PATH=3D/sbin:/usr/sbin:/bin:=
/usr/bin
2014-09-29 19:30:58.207019 7f26417fb700 20 QUERY_STRING=3D
2014-09-29 19:30:58.207020 7f26417fb700 20 REMOTE_ADDR=3D10.42.8.57
2014-09-29 19:30:58.207020 7f26417fb700 20 REMOTE_PORT=3D51343
2014-09-29 19:30:58.207021 7f26417fb700 20 REQUEST_METHOD=3DPUT
2014-09-29 19:30:58.207022 7f26417fb700 20 REQUEST_URI=3D/zzm-bucket3/
2014-09-29 19:30:58.207023 7f26417fb700 20 SCRIPT_FILENAME=3D/var/www/h=
tml/s3gw.fcgi
2014-09-29 19:30:58.207024 7f26417fb700 20 SCRIPT_NAME=3D/zzm-bucket3/
2014-09-29 19:30:58.207025 7f26417fb700 20 SCRIPT_URI=3Dhttp://10.42.36=
=2E44/zzm-bucket3/
2014-09-29 19:30:58.207026 7f26417fb700 20 SCRIPT_URL=3D/zzm-bucket3/
2014-09-29 19:30:58.207027 7f26417fb700 20 SERVER_ADDR=3D10.42.36.44
2014-09-29 19:30:58.207027 7f26417fb700 20 SERVER_ADMIN=3Dtiankai517@pi=
ngan.com.cn
2014-09-29 19:30:58.207028 7f26417fb700 20 SERVER_NAME=3D10.42.36.44
2014-09-29 19:30:58.207029 7f26417fb700 20 SERVER_PORT=3D80
2014-09-29 19:30:58.207030 7f26417fb700 20 SERVER_PROTOCOL=3DHTTP/1.1
2014-09-29 19:30:58.207030 7f26417fb700 20 SERVER_SIGNATURE=3D
2014-09-29 19:30:58.207031 7f26417fb700 20 SERVER_SOFTWARE=3DApache/2.2=
=2E22 (Fedora)
2014-09-29 19:30:58.207033 7f26417fb700  1 =3D=3D=3D=3D=3D=3D starting =
new request req=3D0x7f2644011e40 =3D=3D=3D=3D=3D
2014-09-29 19:30:58.207048 7f26417fb700  2 req 100:0.000015::PUT /zzm-b=
ucket3/::initializing
2014-09-29 19:30:58.207082 7f26417fb700 10 s->object=3D<NULL> s->bucket=
=3Dzzm-bucket3
2014-09-29 19:30:58.207088 7f26417fb700  2 req 100:0.000056:s3:PUT /zzm=
-bucket3/::getting op
2014-09-29 19:30:58.207094 7f26417fb700  2 req 100:0.000062:s3:PUT /zzm=
-bucket3/:create_bucket:authorizing
2014-09-29 19:30:58.207133 7f26417fb700 20 get_obj_state: rctx=3D0x7f25=
d80074d0 obj=3D.users:ESWEOCEAYEYSB59JROLB state=3D0x7f25d8009d58 s->pr=
efetch_data=3D0
2014-09-29 19:30:58.207143 7f26417fb700 10 cache get: name=3D.users+ESW=
EOCEAYEYSB59JROLB : type miss (requested=3D6, cached=3D0)
2014-09-29 19:30:58.208548 7f26417fb700 10 cache put: name=3D.users+ESW=
EOCEAYEYSB59JROLB
2014-09-29 19:30:58.208562 7f26417fb700 10 moving .users+ESWEOCEAYEYSB5=
9JROLB to cache LRU end
2014-09-29 19:30:58.208572 7f26417fb700  5 error reading user info, uid=
=3DESWEOCEAYEYSB59JROLB can't authenticate
2014-09-29 19:30:58.208575 7f26417fb700 10 failed to authorize request
2014-09-29 19:30:58.208706 7f26417fb700  2 req 100:0.001673:s3:PUT /zzm=
-bucket3/:create_bucket:http status=3D403
2014-09-29 19:30:58.208715 7f26417fb700  1 =3D=3D=3D=3D=3D=3D req done =
req=3D0x7f2644011e40 http_status=3D403 =3D=3D=3D=3D=3D=3D
2014-09-29 19:30:58.208723 7f26417fb700 20 process_request() returned -=
1--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
