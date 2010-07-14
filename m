From: Andre Noll <maan@systemlinux.org>
Subject: Re: Linux 2.6.35-rc5
Date: Wed, 14 Jul 2010 21:09:09 +0200
Message-ID: <20100714190909.GM16603@skl-net.de>
References: <AANLkTikro3L1Hy3BYmY-KE8-KviZIrWOCAb54FkF7eX-@mail.gmail.com> <20100714174138.GC27457@skl-net.de> <AANLkTilbabX3IoxHvC5ljAsNpKRg6YRhJ0GjyspIEh47@mail.gmail.com> <20100714180551.GK16603@skl-net.de> <AANLkTinnIr6Z9AhxvObLje3tmXonvVnrWQmsFUE8wFJT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MsEL38XAg4rx1uDx"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from systemlinux.org ([83.151.29.59]:38627 "EHLO m18s25.vlinux.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755029Ab0GNTJW (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 14 Jul 2010 15:09:22 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTinnIr6Z9AhxvObLje3tmXonvVnrWQmsFUE8wFJT@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Cc: Gregory Farnum <gregf@hq.newdream.net>, Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org


--MsEL38XAg4rx1uDx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 14, 11:46, Yehuda Sadeh Weinraub wrote:
> > Thanks. In order to compile e.g. the master branch of this repo,
> > one has to replace fs/ceph dir of the kernel tree by the checked-out
> > copy of the ceph-client-standalone repo. Is that correct?
>=20
> That's one option, although for older kernels you wouldn't have the
> fs/ceph directory and you'll also have to update the fs/Kconfig file.
> Another option for building the standalone is just running 'make
> KERNELDIR=3D<yourkerneldir>'  inside your ceph-client-standalone tree.
>=20
> >
> > Another question: How do I tell which kernel version is compatible with
> > any of the the various branches of the ceph-client-standalone repo?
>=20
> The backport branches currently support 2.6.28 and up.

Excellent. That's actually good news for us because some of our
server machines will be running a distro 2.6.32 kernel for the next
two years. With the backport branches it should be easy to create
and load a ceph kernel module on these servers that allows to mount
the native cephfs rather that re-exporting it over NFS.

Thanks
Andre
--=20
The only person who always got his work done by Friday was Robinson Crusoe

--MsEL38XAg4rx1uDx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFMPgtVWto1QDEAkw8RAmhaAJ9jiYUr9YWKZPSnemgErWJdYO0HigCgls9p
TVw6YrQWDRJ6fIPFmGurMwA=
=ZRhr
-----END PGP SIGNATURE-----

--MsEL38XAg4rx1uDx--
