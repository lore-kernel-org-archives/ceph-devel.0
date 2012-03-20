From: Greg Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Problem in building Ceph on CentOS 6
Date: Mon, 19 Mar 2012 23:35:18 -0700
Message-ID: <2588ED1D12494B3EAD14CAD5D6787E9E@dreamhost.com>
References: <CALwGbPKfZSBGoTQT+3+3iDv4Bqt2orUTDahc6reObdnLq1cdsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:49290 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754808Ab2CTGfV convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Mar 2012 02:35:21 -0400
Received: by obbeh20 with SMTP id eh20so1388591obb.19
        for <ceph-devel@vger.kernel.org>; Mon, 19 Mar 2012 23:35:21 -0700 (PDT)
In-Reply-To: <CALwGbPKfZSBGoTQT+3+3iDv4Bqt2orUTDahc6reObdnLq1cdsw@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?utf-8?Q?=E8=83=A1=E7=80=9A=E6=A3=AE?= <softrank.net@gmail.com>
Cc: ceph-devel@vger.kernel.org, alex.elder@dreamhost.com

On Monday, March 19, 2012 at 11:21 PM, =E8=83=A1=E7=80=9A=E6=A3=AE wrot=
e:
> Hello everyone.
> =20
> I'm following the steps in
> http://ceph.newdream.net/wiki/Building_kernel_client?TPSecNotice&TPNo=
tCheck
> to build ceph on my CentOS.
> =20
> I've updated my kernel to version 3.2.12 without selecting any ceph
> related configuration options. Then I follow these steps until "$ mak=
e
> -C ceph".

If you're using such a new kernel version, why not just the built-in ve=
rsion of Ceph?

If you don't want to do that, what branch are you attempting to build f=
rom? What's the most recent patch?
The backports etc stuff isn't real well-maintained right now but this a=
nd the build error should let our kernel devs figure out what's going o=
n.
-Greg
 =20
> =20
> I get the following error message.
> =20
> =20
> > [deltamaster@localhost ceph-client-standalone]$ sudo make -C ceph
> > make: Entering directory `/home/deltamaster/ceph-client-standalone/=
ceph'
> > make -C /lib/modules/3.2.12/build M=3D/home/deltamaster/ceph-client=
-standalone/ceph CONFIG_CEPH_FS=3Dm modules
> > make[1]: Entering directory `/usr/src/linux-3.2.12'
> > CC [M] /home/deltamaster/ceph-client-standalone/ceph/inode.o
> > /home/deltamaster/ceph-client-standalone/ceph/inode.c:95: warning: =
initialization from incompatible pointer type
> > /home/deltamaster/ceph-client-standalone/ceph/inode.c: In function =
=E2=80=98fill_inode=E2=80=99:
> > /home/deltamaster/ceph-client-standalone/ceph/inode.c:623: error: a=
ssignment of read-only member =E2=80=98i_nlink=E2=80=99
> > /home/deltamaster/ceph-client-standalone/ceph/inode.c: In function =
=E2=80=98ceph_permission=E2=80=99:
> > /home/deltamaster/ceph-client-standalone/ceph/inode.c:1810: error: =
=E2=80=98IPERM_FLAG_RCU=E2=80=99 undeclared (first use in this function=
)
> > /home/deltamaster/ceph-client-standalone/ceph/inode.c:1810: error: =
(Each undeclared identifier is reported only once
> > /home/deltamaster/ceph-client-standalone/ceph/inode.c:1810: error: =
for each function it appears in.)
> > /home/deltamaster/ceph-client-standalone/ceph/inode.c:1816: error: =
too many arguments to function =E2=80=98generic_permission=E2=80=99
> > make[2]: *** [/home/deltamaster/ceph-client-standalone/ceph/inode.o=
] Error 1
> > make[1]: *** [_module_/home/deltamaster/ceph-client-standalone/ceph=
] Error 2
> > make[1]: Leaving directory `/usr/src/linux-3.2.12'
> > make: *** [all] Error 2
> > make: Leaving directory `/home/deltamaster/ceph-client-standalone/c=
eph'
> =20
> =20
> =20
> I've no idea how to solve this.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org (mailto:majordomo@=
vger.kernel.org)
> More majordomo info at http://vger.kernel.org/majordomo-info.html



--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
