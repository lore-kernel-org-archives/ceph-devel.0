From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: radosgw is Troublesome
Date: Tue, 23 Aug 2011 19:14:54 -0700
Message-ID: <CAC-hyiGkv2Z_SxNBHj4Y9e8q7k-cMLRvyqeuNs-Vb4hh_ohMsw@mail.gmail.com>
References: <CADSLUZnoBvPF5_CUSC4FiOpAZ4jwGejM1T_QuaKEziqqhMJtYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:47130 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751716Ab1HXCO4 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 23 Aug 2011 22:14:56 -0400
Received: by bke11 with SMTP id 11so544235bke.19
        for <ceph-devel@vger.kernel.org>; Tue, 23 Aug 2011 19:14:54 -0700 (PDT)
In-Reply-To: <CADSLUZnoBvPF5_CUSC4FiOpAZ4jwGejM1T_QuaKEziqqhMJtYQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?5p6X55Sx5riF?= <linyouqing7@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Aug 23, 2011 at 6:43 PM, =E6=9E=97=E7=94=B1=E6=B8=85 <linyouqin=
g7@gmail.com> wrote:
>
> Hi ,all
>
> =C2=A0 =C2=A0I fount it's so diffcult to set RADOS gateway up, becaus=
e of i didn't have
> external IP , domain name , One virtual machine is fedora 15 i368
> 2.6.40.3-0.fc15.i686.PAE that installed osd ,monitor and radosgw (cep=
h-3.3),
> with internal IP 192.168.1.81. Another virtual machine is centos 5.5 =
i386 which
> installed =C2=A0wido-libs3-31546de as client to access radosgw with
> internal IP 192.168.1.160.
>
> (1)
> # /var/www/s3gw.fcgi
> 2011-08-23 21:04:08.753979 b784c740 allocated request fcgx=3D0x98a55a=
8
> ./common/Mutex.h: In function 'Mutex::~Mutex()', in thread '0xb784c74=
0'
> ./common/Mutex.h: 89: FAILED assert(nlock =3D=3D 0)
> =C2=A0ceph version 0.33 (commit:340b4348bf620fe81f4c0d3a685fdc832663a=
4cf)
> =C2=A01: /usr/local/bin/radosgw() [0x807518f]
> =C2=A02: (RGWProcess::~RGWProcess()+0x231) [0x80c49e1]
> =C2=A03: (main()+0x139) [0x8075dc9]
> =C2=A04: (__libc_start_main()+0xf3) [0x4ed21413]
> =C2=A05: /usr/local/bin/radosgw() [0x80769e1]
> =C2=A0ceph version 0.33 (commit:340b4348bf620fe81f4c0d3a685fdc832663a=
4cf)
> =C2=A01: /usr/local/bin/radosgw() [0x807518f]
> =C2=A02: (RGWProcess::~RGWProcess()+0x231) [0x80c49e1]
> =C2=A03: (main()+0x139) [0x8075dc9]
> =C2=A04: (__libc_start_main()+0xf3) [0x4ed21413]
> =C2=A05: /usr/local/bin/radosgw() [0x80769e1]
> terminate called after throwing an instance of 'ceph::FailedAssertion=
'
> *** Caught signal (Aborted) **
> =C2=A0in thread 0xb784c740
> *** Caught signal (Segmentation fault) **
> =C2=A0in thread 0xb784c740
> /var/www/s3gw.fcgi: line 2: 21737 Segmentation fault =C2=A0 =C2=A0 =C2=
=A0(core
> dumped) /usr/local/bin/radosgw -c /usr/local/etc/ceph/ceph.conf
>

You're trying to run rgw manually. While it is possible nowadays, it
requires special non-default configuration. With default config
options you need to let the fastcgi process manager to manage its
execution.

> (2)
> At radosgw+mon+osd
>
> # /usr/local/apache2/bin/apachectl -S
> httpd: Could not reliably determine the server's fully qualified
> domain name, using 192.168.1.81 for ServerName
> VirtualHost configuration:
> wildcard NameVirtualHosts and _default_ servers:
> *:80 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 w=
ww.radosgw.com (/usr/local/apache2/conf/httpd.conf:57)
> Syntax OK
>
> (3)
> at client:
> # export
> declare -x S3_ACCESS_KEY_ID=3D"QZPCDFTMIW8K19XMUMP7"
> declare -x S3_HOSTNAME=3D"www.radosgw.com"
> declare -x S3_SECRET_ACCESS_KEY=3D"yHXEOzdx8SGpw0IYKeCifOFB6a1WQInUVE=
GrQeVO"
>
> #vim /etc/hosts
> =C2=A0192.168.1.81 =C2=A0www.radosgw.com
>
> # s3 -u create alpha
> ERROR: XmlParseFailure

Probably got a 500 error. Can  you paste your apache config, and both
radosgw and apache logs (error.log, access.log)?

Thanks,
Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
