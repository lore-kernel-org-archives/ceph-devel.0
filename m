From: Andre Noll <maan@systemlinux.org>
Subject: Re: Linux 2.6.35-rc5
Date: Wed, 14 Jul 2010 20:05:51 +0200
Message-ID: <20100714180551.GK16603@skl-net.de>
References: <AANLkTikro3L1Hy3BYmY-KE8-KviZIrWOCAb54FkF7eX-@mail.gmail.com> <20100714174138.GC27457@skl-net.de> <AANLkTilbabX3IoxHvC5ljAsNpKRg6YRhJ0GjyspIEh47@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x+RZeZVNR8VILNfK"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from systemlinux.org ([83.151.29.59]:50428 "EHLO m18s25.vlinux.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756982Ab0GNSGA (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 14 Jul 2010 14:06:00 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTilbabX3IoxHvC5ljAsNpKRg6YRhJ0GjyspIEh47@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org


--x+RZeZVNR8VILNfK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 14, 10:49, Gregory Farnum wrote:
> Check out the backports at
> http://git.kernel.org/?p=3Dlinux/kernel/git/sage/ceph-client-standalone.g=
it;a=3Dsummary.

Thanks. In order to compile e.g. the master branch of this repo,
one has to replace fs/ceph dir of the kernel tree by the checked-out
copy of the ceph-client-standalone repo. Is that correct?

Another question: How do I tell which kernel version is compatible with
any of the the various branches of the ceph-client-standalone repo?

Thanks again
Andre
--=20
The only person who always got his work done by Friday was Robinson Crusoe

--x+RZeZVNR8VILNfK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFMPfx/Wto1QDEAkw8RAsEEAJ0VvEYrB7KO7RIfO5KoDHjMDcE8ZACbBVjC
MRT4VlaDyUWpdIQ2l8vBU5U=
=hPEC
-----END PGP SIGNATURE-----

--x+RZeZVNR8VILNfK--
