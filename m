From: Dominik Mostowiec <dominikmostowiec@gmail.com>
Subject: Re: [ceph-users] Problem: silently corrupted RadosGW objects caused
 by slow requests
Date: Fri, 26 Feb 2016 15:32:49 +0100
Message-ID: <CAMNMNTxs46Hcaq-ZJZfYfF5m8aL9ETNjtBKr8UrdAxZFM7E=nw@mail.gmail.com>
References: <156923D1D92AF640829D4E847271EDAE522A46F435@MXMBON06.grupa.onet>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:33201 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753764AbcBZOcu convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Feb 2016 09:32:50 -0500
Received: by mail-ig0-f169.google.com with SMTP id y8so38772479igp.0
        for <ceph-devel@vger.kernel.org>; Fri, 26 Feb 2016 06:32:50 -0800 (PST)
In-Reply-To: <156923D1D92AF640829D4E847271EDAE522A46F435@MXMBON06.grupa.onet>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-users@ceph.com" <ceph-users@ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi,
Maybe this is the reason of another bug?
http://tracker.ceph.com/issues/13764
The situation is very similiar...

--
Regards
Dominik

2016-02-25 16:17 GMT+01:00 Ritter S=C5=82awomir <Slawomir.Ritter@dreaml=
ab.pl>:
> Hi,
>
>
>
> We have two CEPH clusters running on Dumpling 0.67.11 and some of our
> "multipart objects" are incompleted. It seems that some slow requests=
 could
> cause corruption of related S3 objects. Moveover GETs for that object=
s are
> working without any error messages. There are only HTTP 200 in logs a=
s well
> as no information about problems from popular client tools/libs.
>
>
>
> The situation looks very similiar to described in bug #8269, but we a=
re
> using fixed 0.67.11 version:  http://tracker.ceph.com/issues/8269
>
>
>
> Regards,
>
>
>
> S=C5=82awomir Ritter
>
>
>
>
>
>
>
> EXAMPLE#1
>
>
>
> slow_request
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> 2016-02-23 13:49:58.818640 osd.260 10.176.67.27:6800/688083 2119 : [W=
RN] 4
> slow requests, 4 included below; oldest blocked for > 30.727096 secs
>
> 2016-02-23 13:49:58.818673 osd.260 10.176.67.27:6800/688083 2120 : [W=
RN]
> slow request 30.727096 seconds old, received at 2016-02-23 13:49:28.0=
91460:
> osd_op(c
>
> lient.47792965.0:185007087
> default.14654.445__shadow_c9f8db1b-cee2-4ec8-8fb3-8b4bc7585d80.145623=
1572.877051.ismv.b73N3OmW4OhCjDYSR-RTkZNNIKA1C9Z.57_2
> [writef
>
> ull 0~524288] 10.ce729ebe e107594) v4 currently waiting for subops fr=
om
> [469,9]
>
>
>
>
>
> HTTP_500 in apache.log
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> 127.0.0.1 - - [23/Feb/2016:13:49:27 +0100] "PUT
> /video-shbc/c9f8db1b-cee2-4ec8-8fb3-8b4bc7585d80.1456231572.877051.is=
mv?uploadId=3Db73N3OmW4OhCjDYSR-RTkZNNIKA1C9Z&partNumber=3D56
> HTTP/1.0" 200 221 "-" "Boto/2.31.1 Python/2.7.3
> Linux/3.13.0-39-generic(syncworker)"
>
> 127.0.0.1 - - [23/Feb/2016:13:49:28 +0100] "PUT
> /video-shbc/c9f8db1b-cee2-4ec8-8fb3-8b4bc7585d80.1456231572.877051.is=
mv?uploadId=3Db73N3OmW4OhCjDYSR-RTkZNNIKA1C9Z&partNumber=3D57
> HTTP/1.0" 500 751 "-" "Boto/2.31.1 Python/2.7.3
> Linux/3.13.0-39-generic(syncworker)"
>
> 127.0.0.1 - - [23/Feb/2016:13:49:58 +0100] "PUT
> /video-shbc/c9f8db1b-cee2-4ec8-8fb3-8b4bc7585d80.1456231572.877051.is=
mv?uploadId=3Db73N3OmW4OhCjDYSR-RTkZNNIKA1C9Z&partNumber=3D57
> HTTP/1.0" 200 221 "-" "Boto/2.31.1 Python/2.7.3
> Linux/3.13.0-39-generic(syncworker)"
>
> 127.0.0.1 - - [23/Feb/2016:13:49:59 +0100] "PUT
> /video-shbc/c9f8db1b-cee2-4ec8-8fb3-8b4bc7585d80.1456231572.877051.is=
mv?uploadId=3Db73N3OmW4OhCjDYSR-RTkZNNIKA1C9Z&partNumber=3D58
> HTTP/1.0" 200 221 "-" "Boto/2.31.1 Python/2.7.3
> Linux/3.13.0-39-generic(syncworker)"
>
>
>
>
>
> Empty RADOS object (real size =3D 0 bytes), list generated basis on M=
ANIFEST
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>
> found
> default.14654.445__shadow_c9f8db1b-cee2-4ec8-8fb3-8b4bc7585d80.145623=
1572.877051.ismv.b73N3OmW4OhCjDYSR-RTkZNNIKA1C9Z.56_2
> 2097152   ok          2097152       10.7acc9476 (10.1476) [278,142,43=
6]
> [278,142,436]
>
> found
> default.14654.445__multipart_c9f8db1b-cee2-4ec8-8fb3-8b4bc7585d80.145=
6231572.877051.ismv.b73N3OmW4OhCjDYSR-RTkZNNIKA1C9Z.57
> 0         diff        4194304       10.4f5be025 (10.25)   [57,310,428=
]
> [57,310,428]
>
> found
> default.14654.445__shadow_c9f8db1b-cee2-4ec8-8fb3-8b4bc7585d80.145623=
1572.877051.ismv.b73N3OmW4OhCjDYSR-RTkZNNIKA1C9Z.57_1
> 4194304   ok          4194304       10.81191602 (10.1602) [441,109,42=
0]
> [441,109,420]
>
> found
> default.14654.445__shadow_c9f8db1b-cee2-4ec8-8fb3-8b4bc7585d80.145623=
1572.877051.ismv.b73N3OmW4OhCjDYSR-RTkZNNIKA1C9Z.57_2
> 2097152   ok          2097152       10.ce729ebe (10.1ebe) [260,469,9]
> [260,469,9]
>
>
>
>
>
> "Silent" GETs
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> # object size from headers
>
> $ s3 -u head
> video-shbc/c9f8db1b-cee2-4ec8-8fb3-8b4bc7585d80.1456231572.877051.ism=
v
> Content-Type: binary/octet-stream
>
> Content-Length: 641775701
>
> Server: nginx
>
>
>
> # but GETs only 637581397 (641775701 - missing 4194304 =3D 637581397)
>
> $ s3 -u get
> video-shbc/c9f8db1b-cee2-4ec8-8fb3-8b4bc7585d80.1456231572.877051.ism=
v >
> /tmp/test
>
> $  ls -al /tmp/test
>
> -rw-r--r-- 1 root root 637581397 Feb 23 17:05 /tmp/test
>
>
>
> # no error in logs
>
> 127.0.0.1 - - [23/Feb/2016:17:05:00 +0100] "GET
> /video-shbc/c9f8db1b-cee2-4ec8-8fb3-8b4bc7585d80.1456231572.877051.is=
mv
> HTTP/1.0" 200 637581711 "-" "Mozilla/4.0 (Compatible; s3; libs3 2.0; =
Linux
> x86_64)"
>
>
>
> # wget - retry for missing part, but there is no missing part, so it =
GETs
> head/tail of the file again....
>
> $ wget
> http://127.0.0.1:88/video-shbc/c9f8db1b-cee2-4ec8-8fb3-8b4bc7585d80.1=
456231572.877051.ismv
>
> --2016-02-23 17:10:11--
> http://127.0.0.1:88/video-shbc/c9f8db1b-cee2-4ec8-8fb3-8b4bc7585d80.1=
456231572.877051.ismv
>
> Connecting to 127.0.0.1:88... connected.
>
> HTTP request sent, awaiting response... 200 OK
>
> Length: 641775701 (612M) [binary/octet-stream]
>
> Saving to: `c9f8db1b-cee2-4ec8-8fb3-8b4bc7585d80.1456231572.877051.is=
mv'
>
>
>
> 99%
> [=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D>
> ] 637,581,397 63.9M/s   in 9.5s
>
>
>
> 2016-02-23 17:10:20 (64.1 MB/s) - Connection closed at byte 637581397=
=2E
> Retrying.
>
>
>
> --2016-02-23 17:10:21--  (try: 2)
> http://127.0.0.1:88/video-shbc/c9f8db1b-cee2-4ec8-8fb3-8b4bc7585d80.1=
456231572.877051.ismv
>
> Connecting to 127.0.0.1:88... connected.
>
> HTTP request sent, awaiting response... 206 Partial Content
>
> Length: 641775701 (612M), 4194304 (4.0M) remaining [binary/octet-stre=
am]
>
> Saving to: `c9f8db1b-cee2-4ec8-8fb3-8b4bc7585d80.1456231572.877051.is=
mv'
>
>
>
> 100%[++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++>]
> 641,775,701 --.-K/s   in 0.007s
>
>
>
> 2016-02-23 17:10:21 (601 MB/s) -
> `c9f8db1b-cee2-4ec8-8fb3-8b4bc7585d80.1456231572.877051.ismv' saved
> [641775701/641775701]
>
>
>
>
>
>
>
>
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>



--=20
Pozdrawiam
Dominik
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
