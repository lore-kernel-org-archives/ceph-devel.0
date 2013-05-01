From: "Matt W. Benjamin" <matt@linuxbox.com>
Subject: Re: userland nfs server
Date: Wed, 1 May 2013 19:40:53 -0400 (EDT)
Message-ID: <1061265189.171.1367451653939.JavaMail.root@thunderbeast.private.linuxbox.com>
References: <loom.20130502T011603-184@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aa.linuxbox.com ([69.128.83.226]:3543 "EHLO aa.linuxbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751275Ab3EAXk5 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 May 2013 19:40:57 -0400
In-Reply-To: <loom.20130502T011603-184@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Koffi Nogbe <knogbe@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi Koffi,

It looks like you're building the Ganesha "stable" branch.  You want to=
 be using the
pre-2.0 dev branch--that's the "next" branch from https://github.com/nf=
s-ganesha/nfs-ganesha.git .

There's some limitations with pNFS in this branch, but you can experime=
nt with ordinary
NFSv3, NFSv4, and 4.1 exports.

Thanks,

Matt

----- "Koffi Nogbe" <knogbe@gmail.com> wrote:

> >Matt W. Benjamin <matt <at> linuxbox.com> writes:
>=20
> >=20
> > Hi Sage,
> >=20
> > Yes, we're actively working on this.  We'd very much like
> assistance
> adapting the libceph changes for
> > inclusion.  We can start by updating for recent Ceph.
> >=20
> > FSAL_CEPH will definitely merge in Ganesha mainline in the next
> month or two.
> >=20
> > Matt
> >=20
> > ----- "Sage Weil" <sage <at> newdream.net> wrote:
> >=20
>=20
>=20
>=20
> >Matt W. Benjamin <matt <at> linuxbox.com> writes:
>=20
> I m trying to build the CEPH FSAL but apparently I m failing. I was
> able to
> pass the first issue about vinode struct that was resolved by using
> the ceph
> source from linuxbox but I m stopped by this one that I cannot figure
> out:
>=20
> /bin/sh ../../libtool --tag=3DCC   --mode=3Dcompile gcc -DHAVE_CONFIG=
_H
> -I.
> -I../../include    -D_FILE_OFFSET_BITS=3D64  -I/usr/include
> -D_FILE_OFFSET_BITS=3D64 -I/root/nfs-ganesha-1.5.1/libtirpc/tirpc/ -g
> -O2
> -D_REENTRANT -Wall -Wimplicit -Wformat -Wmissing-braces
> -Wno-pointer-sign
> -I../../RPCAL/gssd -MT fsal_dirs.lo -MD -MP -MF .deps/fsal_dirs.Tpo -=
c
> -o
> fsal_dirs.lo fsal_dirs.c
> libtool: compile:  gcc -DHAVE_CONFIG_H -I. -I../../include
> -D_FILE_OFFSET_BITS=3D64 -I/usr/include -D_FILE_OFFSET_BITS=3D64
> -I/root/nfs-ganesha-1.5.1/libtirpc/tirpc/ -g -O2 -D_REENTRANT -Wall
> -Wimplicit -Wformat -Wmissing-braces -Wno-pointer-sign
> -I../../RPCAL/gssd
> -MT fsal_dirs.lo -MD -MP -MF .deps/fsal_dirs.Tpo -c fsal_dirs.c  -fPI=
C
> -DPIC
> -o .libs/fsal_dirs.o
> fsal_dirs.c: In function =C3=A2CEPHFSAL_readdir=C3=A2:
> fsal_dirs.c:166: error: cannot convert to a pointer type
> fsal_dirs.c:166: error: =C3=A2cephfsal_cookie_t=C3=A2 has no member n=
amed
> =C3=A2cookie=C3=A2
> fsal_dirs.c:167: error: cannot convert to a pointer type
> fsal_dirs.c:167: error: =C3=A2cephfsal_cookie_t=C3=A2 has no member n=
amed
> =C3=A2cookie=C3=A2
> make[2]: *** [fsal_dirs.lo] Error 1
> make[2]: Leaving directory `/root/nfs-ganesha-1.5.1/FSAL/FSAL_CEPH'
> make[1]: *** [all-recursive] Error 1
> make[1]: Leaving directory `/root/nfs-ganesha-1.5.1/FSAL'
> make: *** [all-recursive] Error 1
>=20
>=20
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Matt Benjamin
The Linux Box
206 South Fifth Ave. Suite 150
Ann Arbor, MI  48104

http://linuxbox.com

tel.  734-761-4689=20
fax.  734-769-8938=20
cel.  734-216-5309=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
