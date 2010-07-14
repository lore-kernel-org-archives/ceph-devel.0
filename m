From: Andre Noll <maan@systemlinux.org>
Subject: Re: Linux 2.6.35-rc5
Date: Wed, 14 Jul 2010 19:41:38 +0200
Message-ID: <20100714174138.GC27457@skl-net.de>
References: <AANLkTikro3L1Hy3BYmY-KE8-KviZIrWOCAb54FkF7eX-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+nBD6E3TurpgldQp"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from systemlinux.org ([83.151.29.59]:36605 "EHLO m18s25.vlinux.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753902Ab0GNRmO (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 14 Jul 2010 13:42:14 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTikro3L1Hy3BYmY-KE8-KviZIrWOCAb54FkF7eX-@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org


--+nBD6E3TurpgldQp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Sage,

On Mon, Jul 12, 16:37, Linus Torvalds wrote:
> Sage Weil (10):
>       ceph: fix map handler error path
>       ceph: fix message memory leak, uninitialized variable
>       ceph: fix crush map update decoding
>       ceph: handle splice_dentry/d_materialize_unique error in
> readdir_prepopulate
>       ceph: delay umount until all mds requests drop inode+dentry refs
>       ceph: fix crush recursion
>       ceph: fix crush CHOOSE_LEAF when type is already a leaf
>       ceph: only release clean, unused caps with mds requests
>       ceph: fix caps usage accounting for import (non-reserved) case
>       ceph: fix crush device 'out' threshold to 1.0, not 0.1

Are you planning to backport any of these to the 2.6.34 stable tree?

Thanks
Andre
--=20
The only person who always got his work done by Friday was Robinson Crusoe

--+nBD6E3TurpgldQp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFMPfbSWto1QDEAkw8RAi7GAJ9o1oHBjrhcqOTmqVUblatXMk+0+gCeKwou
qWcQxvWt+2F5Zs6Y87EOi14=
=gDTp
-----END PGP SIGNATURE-----

--+nBD6E3TurpgldQp--
