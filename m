From: Sage Weil <sage@newdream.net>
Subject: Re: client-standalone/master-backport: "CEPH_VERSION" redefined
Date: Fri, 30 Jul 2010 09:50:13 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1007300944210.28085@cobra.newdream.net>
References: <i2u3ju$hnt$2@dough.gmane.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1050342262-1280508613=:28085"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54960 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753814Ab0G3Qri (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 30 Jul 2010 12:47:38 -0400
In-Reply-To: <i2u3ju$hnt$2@dough.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Thomas Mueller <thomas@chaschperli.ch>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1050342262-1280508613=:28085
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 30 Jul 2010, Thomas Mueller wrote:
> hi
>=20
> client-standalone/master-backport seems to be broken right now.

Are you sure you're on the master-backport and not the master branch? =20
Your error looks like it's missing the kernel version #ifdefs for the=20
recent vfs_fsync api change.

> and the unstable-backport seems to be behind master-backport (missing dkm=
s).

Yeah...

> what is the worklfow in client-standalone - not unstable to master? which=
=20
> one should be used for testing?

I have a script that mirrors just the commits affecting fs/ceph in the=20
kernel git tree (http://pastebin.org/433717), so the -standalone.git=20
unstable matches the ceph-client.git unstable branch.  Generally I don't=20
bother cleaning up and rebasing the unstable tree there until it's time to=
=20
send things upstream for the merge window or there is some other specific=
=20
reason to.  I'll do that as soon as 2.6.35 is out.  In the meantime, you=20
should be able to merge the -standalone.git unstable into master-backport=
=20
with minimal pain.

sage

>=20
>=20
> # make
> make -C /lib/modules/2.6.34/build M=3D/usr/src/ceph-client-standalone CON=
FIG_CEPH_FS=3Dm modules
> make[1]: Entering directory `/usr/src/redhat/BUILD/kernel-2.6.34'
>   CC [M]  /usr/src/ceph-client-standalone/super.o
> In file included from /usr/src/ceph-client-standalone/super.c:1087:
> /usr/src/ceph-client-standalone/upstream_version.h:10:1: warning: "CEPH_V=
ERSION" redefined
> In file included from /usr/src/ceph-client-standalone/types.h:10,
>                  from /usr/src/ceph-client-standalone/decode.h:7,
>                  from /usr/src/ceph-client-standalone/super.c:17:
> /usr/src/ceph-client-standalone/ceph_fs.h:29:1: warning: this is the loca=
tion of the previous definition
>   CC [M]  /usr/src/ceph-client-standalone/inode.o
>   CC [M]  /usr/src/ceph-client-standalone/dir.o
> /usr/src/ceph-client-standalone/dir.c:1220: warning: initialization from =
incompatible pointer type
>   CC [M]  /usr/src/ceph-client-standalone/file.o
> /usr/src/ceph-client-standalone/file.c: In function =FF=FFceph_aio_write=
=FF=FF:
> /usr/src/ceph-client-standalone/file.c:847: warning: passing argument 2 o=
f =FF=FFvfs_fsync_range=FF=FF makes pointer from integer without a cast
> /usr/src/ceph-client-standalone/file.c:847: error: too few arguments to f=
unction =FF=FFvfs_fsync_range=FF=FF
> /usr/src/ceph-client-standalone/file.c: At top level:
> /usr/src/ceph-client-standalone/file.c:932: warning: initialization from =
incompatible pointer type
> make[2]: *** [/usr/src/ceph-client-standalone/file.o] Error 1
> make[1]: *** [_module_/usr/src/ceph-client-standalone] Error 2
> make[1]: Leaving directory `/usr/src/redhat/BUILD/kernel-2.6.34'
> make: *** [all] Error 2
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-1050342262-1280508613=:28085--
