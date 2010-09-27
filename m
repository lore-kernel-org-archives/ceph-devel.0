From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Some problem of ceph and radosgw
Date: Mon, 27 Sep 2010 15:33:15 +0200
Message-ID: <1285594395.2280.17.camel@wido-desktop>
References: <AANLkTimTkphpGFqZ1R46CiJ5UFG394FQ=uy6SjiLXqho@mail.gmail.com>
	 <1285526953.5460.5.camel@wido-laptop.pcextreme.nl>
	 <AANLkTi=tsnPQRDWbQcTwvH7hA0GFt=8ZnFCisquQP9C6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:40461 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753373Ab0I0NdS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Sep 2010 09:33:18 -0400
In-Reply-To: <AANLkTi=tsnPQRDWbQcTwvH7hA0GFt=8ZnFCisquQP9C6@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: cang lin <fwdflywl@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi,

Please see my reply below.

On Mon, 2010-09-27 at 15:18 +0800, cang lin wrote:
> Hi Wido,
>=20
> 2010/9/27 Wido den Hollander <wido@widodh.nl>:
> > Hi,
> >
> > The OSD performance you are seeing is not network related, it's due=
 to
> > your hardware/drivers.
> >
> > Do you have a journal enabled?
> >
> The journal config in cepth.conf is as following
> [osd]
>         sudo =3D true
>         osd data =3D /mnt/ceph/osd$id/data
>         keyring =3D /etc/ceph/keyring.$name
>         osd journal =3D /mnt/ceph/osd$id/data/journal
>         osd journal size =3D 100
>=20
>=20
> As you can see as following,the journal file is full.
>=20
> root@ceph01:/mnt/ceph/osd0/data# ls -l
> total 102400
> -rw-r--r-- 1 root root        37 2010-08-26 03:27 ceph_fsid
> drwxr-xr-x 1 root root      9956 2010-09-25 22:47 current
> -rw-r--r-- 1 root root         8 2010-08-26 03:27 fsid
> -rw-r--r-- 1 root root 104857600 2010-09-26 20:10 journal
> -rw-r--r-- 1 root root        21 2010-08-26 03:27 magic
> -rw-r--r-- 1 root root         2 2010-08-26 03:27 whoami
>=20
> So I think the journal is enabled,is there anything else needed to do=
?
>=20
> > And could you try to do a benchmark with:
> >
> > hdparm -tT /dev/sdx
> >
> > Where /dev/sdx is the disk where your data is on. This will give yo=
u the
> > read performance.
> >
> > You could also do some write tests with dd, for example:
> >
> > dd if=3D/dev/zero of=3D1GB.bin bs=3D1024k count=3D1024 conv=3Dsync
> >
> > Run this in your OSD data directory.
> >
>=20
> I did as your example,the result of benchmark is as following
>=20
> root@ceph01:/#df Ch
> =E2=80=A6
> /dev/sde1             187G   45G  142G  24% /mnt/ceph/osd0/data
> root@ceph01:/ # hdparm -tT /dev/sde
> /dev/sde:
>  Timing cached reads:   1038 MB in  2.00 seconds =3D 518.85 MB/sec
>  Timing buffered disk reads:  166 MB in  3.01 seconds =3D  55.06 MB/s=
ec
>=20
> root@ceph01:/# cd /mnt/ceph/osd0/data
> root@ceph01:/mnt/ceph/osd0/data# dd if=3D/dev/zero of=3D1GB.bin bs=3D=
1024k
> count=3D1024 conv=3Dsync
> 1024+0 records in
> 1024+0 records out
> 1073741824 bytes (1.1 GB) copied, 87.08 s, 12.3 MB/s
>=20
> root@ceph02:/# df Ch
> =E2=80=A6
> /dev/sde1             466G   46G  420G  10% /mnt/ceph/osd1/data
> root@ceph02:/# hdparm -tT /dev/sde
> /dev/sde:
>  Timing cached reads:   1014 MB in  2.00 seconds =3D 506.76 MB/sec
>  Timing buffered disk reads:  198 MB in  3.02 seconds =3D  65.54 MB/s=
ec
>=20
> root@ceph02:/ # cd /mnt/ceph/osd1/data
> root@lz05:/mnt/ceph/osd1/data# dd if=3D/dev/zero of=3D1GB.bin bs=3D10=
24k
> count=3D1024 conv=3Dsync
> 1024+0 records in
> 1024+0 records out
> 1073741824 bytes (1.1 GB) copied, 78.3063 s, 13.7 MB/s
>=20
> From the test above,through the hardware/drivers is not very fast,but
> still much times fast than osd.so how to improve the speed of osd?

Since the journal is on the same disk as the OSD data, the write speed
you are seeing is slow.

I should fix that first, that is the explanation of your slow write OSD
speed.

>=20
> > About the RADOS Gateway, which libs3 are you using? I would recomme=
nd:
> > git://github.com/wido/libs3.git
> >
> Yes, I used the libs3 which supports alternative hostnames as
> http://ceph.newdream.net/wiki/RADOS_Gateway # Testing recommand,
>=20
> > Yesterday I found a bug in the RADOS Gateway, it might be that you =
are
> > also hitting it. Could you upload your error_log (Apache) somewhere=
 or
> > attach it? And please set RGW_LOG_LEVEL to 20 to get as much inform=
ation
> > as possible.

Add the following to your vhost:

SetEnv RGW_LOG_LEVEL 20

Please make sure mod_env is installed and loaded.

> >
>=20
> On the ceph01:
> web1@ceph01:~$ s3 -u create alpha
> ERROR: ConnectionFailed
>=20
> I find the following errors in apache=E2=80=99s error log:
> 10.09.27_11:44:10.678530 b784b6d0 auth: can't open key file(s)
> /etc/ceph/keyring.bin
> 10.09.27_11:44:10.681523 b784b6d0 librados: client.admin
> authentication error Operation not permitted
> Couldn't init storage provider (RADOS)
>=20
> Mon=EF=BC=8Cmds and ods were running on ceph01,and keyring.bin is in
> /etc/ceph/. The error occurs when I set keyring.bin is read/write onl=
y
> by root,so I try to set it can be read/write by anyone and restart
> apache,it turned out that the size of error.log increase fast.
>=20
> rw-r----- 1 root adm   1478013 2010-09-27 12:24 error.log
> rw-r----- 1 root adm   1482306 2010-09-27 12:24 error.log
> rw-r----- 1 root adm   1503771 2010-09-27 12:25 error.log
> rw-r----- 1 root adm   1520943 2010-09-27 12:25 error.log
> rw-r----- 1 root adm   1529529 2010-09-27 12:25 error.log
>=20
> So I have to stop apache
>=20
> root@lz04:/var/log/apache2# /etc/init.d/apache2 stop
> rw-r----- 1 root adm   1598283 2010-09-27 12:27 error.log
>=20
> After restart apache the error.log is as following
> =E2=80=A6
> [Mon Sep 27 11:45:20 2010] [notice] caught SIGTERM, shutting down
> [Mon Sep 27 11:45:21 2010] [notice] suEXEC mechanism enabled (wrapper=
:
> /usr/lib/apache2/suexec)
> [Mon Sep 27 11:45:21 2010] [notice] FastCGI: process manager
> initialized (pid 2753)
> [Mon Sep 27 11:45:22 2010] [notice] Apache/2.2.14 (Ubuntu)
> mod_fastcgi/2.4.6 PHP/5.3.2-1ubuntu4.5 with Suhosin-Patch
> mod_scgi/1.13 configured -- resuming normal operations
> [Mon Sep 27 12:13:28 2010] [notice] caught SIGTERM, shutting down
> [Mon Sep 27 12:13:29 2010] [notice] suEXEC mechanism enabled (wrapper=
:
> /usr/lib/apache2/suexec)
> [Mon Sep 27 12:13:29 2010] [notice] FastCGI: wrapper mechanism enable=
d
> (wrapper: /var/www/s3gw.fcgi)
> [Mon Sep 27 12:13:29 2010] [notice] FastCGI: process manager
> initialized (pid 4381)
> [Mon Sep 27 12:13:29 2010] [warn] FastCGI: server "/usr/bin/radosgw"
> (uid 33, gid 33) started (pid 4382)
> [Mon Sep 27 12:13:29 2010] [notice] Apache/2.2.14 (Ubuntu)
> mod_fastcgi/2.4.6 PHP/5.3.2-1ubuntu4.5 with Suhosin-Patch
> mod_scgi/1.13 configured -- resuming normal operations
> [Mon Sep 27 12:13:29 2010] [warn] FastCGI: (dynamic) server
> "/var/www/s3gw.fcgi" (uid 1004, gid 1004) started (pid 4389)
> RADOS S3 Gateway: FCGI_ROLE=3DRESPONDER
> RADOS S3 Gateway: SCRIPT_URL=3D/RPC2
> RADOS S3 Gateway: SCRIPT_URI=3Dhttp://localhost/RPC2
> RADOS S3 Gateway: HTTP_AUTHORIZATION=3D
> RADOS S3 Gateway: RGW_DNS_NAME=3Ds3.
> RADOS S3 Gateway: CONTENT_LENGTH=3D564
> RADOS S3 Gateway: HTTP_HOST=3Dlocalhost:80
> RADOS S3 Gateway: HTTP_ACCEPT=3D*/*
> RADOS S3 Gateway: HTTP_USER_AGENT=3DErlang XML-RPC Client 1.13
> RADOS S3 Gateway: CONTENT_TYPE=3Dtext/xml
> RADOS S3 Gateway: HTTP_CONNECTION=3Dclose
> RADOS S3 Gateway: PATH=3D/usr/local/bin:/usr/bin:/bin
> RADOS S3 Gateway: SERVER_SIGNATURE=3D
> RADOS S3 Gateway: SERVER_SOFTWARE=3DApache/2.2.14 (Ubuntu)
> RADOS S3 Gateway: SERVER_NAME=3Dlocalhost
> RADOS S3 Gateway: SERVER_ADDR=3D127.0.0.1
> RADOS S3 Gateway: SERVER_PORT=3D80
> RADOS S3 Gateway: REMOTE_ADDR=3D127.0.0.1
> RADOS S3 Gateway: DOCUMENT_ROOT=3D/var/www
> RADOS S3 Gateway: SERVER_ADMIN=3D[no address given]
> RADOS S3 Gateway: SCRIPT_FILENAME=3D/var/www/s3gw.fcgi
> RADOS S3 Gateway: REMOTE_PORT=3D53559
> RADOS S3 Gateway: GATEWAY_INTERFACE=3DCGI/1.1
> RADOS S3 Gateway: SERVER_PROTOCOL=3DHTTP/1.1
> RADOS S3 Gateway: REQUEST_METHOD=3DPOST
> RADOS S3 Gateway: QUERY_STRING=3Dpage=3DRPC2&params=3D
> RADOS S3 Gateway: REQUEST_URI=3D/RPC2
> RADOS S3 Gateway: SCRIPT_NAME=3D/RPC2
> RADOS S3 Gateway: gateway_dns_name =3D s3.
> RADOS S3 Gateway: host=3Dlocalhost:80
> RADOS S3 Gateway: parsed: name=3Dpage val=3DRPC2
> RADOS S3 Gateway: parsed: name=3Dparams val=3D
> RADOS S3 Gateway: in url_decode with RPC2
> RADOS S3 Gateway: s->object=3D<NULL> s->bucket=3DRPC2
>=20
> RADOS S3 Gateway: FCGI_ROLE=3DRESPONDER  loop from here
>=20
> RADOS S3 Gateway: FCGI_ROLE=3DRESPONDER
> =E2=80=A6
>=20
> The error.log is a attachment in this mail.
>=20
> The following error occurs on cl0(client):
>=20
> web1@cl0:~$ s3 -u create alpha
> ERROR: XmlParseFailure
>=20
> Couldn't init storage provider (RADOS) error occurred because I forgo=
t
> to copy keyring.bin.
> After the keyring.bin was copied to /etc/ceph and apache was restarte=
d
> the problem is solved.
>=20
> Error.log is as following

I can't find any issues in your error.log file, i'm not sure where this
is going wrong.

>=20
> 10.09.26_13:31:31.781936 b729c6d0 auth: can't open key file(s)
> /etc/ceph/keyring.bin
> 10.09.26_13:31:31.971516 b729c6d0 librados: client.admin
> authentication error Operation not permitted
> Couldn't init storage provider (RADOS)
> [Sun Sep 26 13:31:31 2010] [warn] FastCGI: server "/usr/bin/radosgw"
> (pid 23589) terminated by calling exit with status '5'
> [Sun Sep 26 13:31:31 2010] [warn] FastCGI: server "/usr/bin/radosgw"
> has failed to remain running for 30 seconds given 3 attempts, its
> restart interval has been backed off to 600 seconds
> [Sun Sep 26 13:36:31 2010] [warn] FastCGI: server "/usr/bin/radosgw"
> has failed to remain running for 30 seconds given 3 attempts, its
> restart interval has been backed off to 600 seconds
> [Sun Sep 26 13:41:31 2010] [warn] FastCGI: server "/usr/bin/radosgw"
> has failed to remain running for 30 seconds given 3 attempts, its
> restart interval has been backed off to 600 seconds
> [Sun Sep 26 13:41:31 2010] [warn] FastCGI: server "/usr/bin/radosgw"
> (uid 33, gid 33) restarted (pid 24103)
> [Sun Sep 26 20:26:58 2010] [notice] Graceful restart requested, doing=
 restart
> apache2: Could not reliably determine the server's fully qualified
> domain name, using 117.41.229.124 for ServerName
> [Sun Sep 26 20:26:58 2010] [notice] FastCGI: wrapper mechanism enable=
d
> (wrapper: /var/www/s3gw.fcgi)
> [Sun Sep 26 20:26:58 2010] [notice] FastCGI: process manager
> initialized (pid 27972)
> [Sun Sep 26 20:26:58 2010] [warn] FastCGI: server "/usr/bin/radosgw"
> (uid 33, gid 33) started (pid 27973)
> [Sun Sep 26 20:26:58 2010] [notice] Apache/2.2.14 (Ubuntu)
> mod_fastcgi/2.4.6 PHP/5.3.2-1ubuntu4.5 with Suhosin-Patch
> mod_scgi/1.13 configured -- resuming normal operations
>=20
> Please forgive my ignorance,but I don=E2=80=99t know which file that
> RGW_LOG_LEVEL set to 20 should be appended. Is it ceph.conf or
> fastcgi.conf or any other file?
>=20
>=20
> Thanks!
>=20
>  Lin

Thanks,

Wido

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
