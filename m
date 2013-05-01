From: Koffi Nogbe <knogbe@gmail.com>
Subject: Re: userland nfs server
Date: Wed, 1 May 2013 23:19:21 +0000 (UTC)
Message-ID: <loom.20130502T011603-184@post.gmane.org>
References: <Pine.LNX.4.64.1108301458300.16289@cobra.newdream.net> <1255412388.94.1314742079622.JavaMail.root@thunderbeast.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:59201 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757496Ab3EAXZI (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 1 May 2013 19:25:08 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1UXgOW-0001rg-4m
	for ceph-devel@vger.kernel.org; Thu, 02 May 2013 01:25:04 +0200
Received: from 23-31-152-73-static.hfc.comcastbusiness.net ([23-31-152-73-static.hfc.comcastbusiness.net])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 02 May 2013 01:25:04 +0200
Received: from knogbe by 23-31-152-73-static.hfc.comcastbusiness.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 02 May 2013 01:25:04 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

>Matt W. Benjamin <matt <at> linuxbox.com> writes:

>=20
> Hi Sage,
>=20
> Yes, we're actively working on this.  We'd very much like assistance
adapting the libceph changes for
> inclusion.  We can start by updating for recent Ceph.
>=20
> FSAL_CEPH will definitely merge in Ganesha mainline in the next month=
 or two.
>=20
> Matt
>=20
> ----- "Sage Weil" <sage <at> newdream.net> wrote:
>=20



>Matt W. Benjamin <matt <at> linuxbox.com> writes:

I m trying to build the CEPH FSAL but apparently I m failing. I was abl=
e to
pass the first issue about vinode struct that was resolved by using the=
 ceph
source from linuxbox but I m stopped by this one that I cannot figure o=
ut:

/bin/sh ../../libtool --tag=3DCC   --mode=3Dcompile gcc -DHAVE_CONFIG_H=
 -I.
-I../../include    -D_FILE_OFFSET_BITS=3D64  -I/usr/include
-D_FILE_OFFSET_BITS=3D64 -I/root/nfs-ganesha-1.5.1/libtirpc/tirpc/ -g -=
O2
-D_REENTRANT -Wall -Wimplicit -Wformat -Wmissing-braces -Wno-pointer-si=
gn
-I../../RPCAL/gssd -MT fsal_dirs.lo -MD -MP -MF .deps/fsal_dirs.Tpo -c =
-o
fsal_dirs.lo fsal_dirs.c
libtool: compile:  gcc -DHAVE_CONFIG_H -I. -I../../include
-D_FILE_OFFSET_BITS=3D64 -I/usr/include -D_FILE_OFFSET_BITS=3D64
-I/root/nfs-ganesha-1.5.1/libtirpc/tirpc/ -g -O2 -D_REENTRANT -Wall
-Wimplicit -Wformat -Wmissing-braces -Wno-pointer-sign -I../../RPCAL/gs=
sd
-MT fsal_dirs.lo -MD -MP -MF .deps/fsal_dirs.Tpo -c fsal_dirs.c  -fPIC =
-DPIC
-o .libs/fsal_dirs.o
fsal_dirs.c: In function =C3=A2CEPHFSAL_readdir=C3=A2:
fsal_dirs.c:166: error: cannot convert to a pointer type
fsal_dirs.c:166: error: =C3=A2cephfsal_cookie_t=C3=A2 has no member nam=
ed =C3=A2cookie=C3=A2
fsal_dirs.c:167: error: cannot convert to a pointer type
fsal_dirs.c:167: error: =C3=A2cephfsal_cookie_t=C3=A2 has no member nam=
ed =C3=A2cookie=C3=A2
make[2]: *** [fsal_dirs.lo] Error 1
make[2]: Leaving directory `/root/nfs-ganesha-1.5.1/FSAL/FSAL_CEPH'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/root/nfs-ganesha-1.5.1/FSAL'
make: *** [all-recursive] Error 1




--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
