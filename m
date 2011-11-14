From: Mario van der Linde <linde@b1-systems.de>
Subject: Re: [solved] rbd - input/output error
Date: Mon, 14 Nov 2011 23:17:07 +0100
Message-ID: <4EC19363.5010402@b1-systems.de>
References: <4EBF98B5.7040706@b1-systems.de> <Pine.LNX.4.64.1111141148220.29742@cobra.newdream.net> <4EC18864.4010308@b1-systems.de> <Pine.LNX.4.64.1111141338160.3717@cobra.newdream.net> <4EC18F46.70102@b1-systems.de> <CAORUGqAvxApfP660yFpLUdqXbQ6SYy-iMfkOGt_RB-AotHdR8A@mail.gmail.com>
Reply-To: linde@b1-systems.de
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig150AD5F04B772A51EC691794"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from schattenjagd.systems.b1-systems.de ([217.11.58.34]:59533 "EHLO
	mx1.b1-systems.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754362Ab1KNWRH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Nov 2011 17:17:07 -0500
In-Reply-To: <CAORUGqAvxApfP660yFpLUdqXbQ6SYy-iMfkOGt_RB-AotHdR8A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig150AD5F04B772A51EC691794
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello,

On 14.11.2011 23:05, Tommi Virtanen wrote:
> On Mon, Nov 14, 2011 at 13:59, Mario van der Linde <linde@b1-systems.de=
> wrote:
>> At first, on all Systems this file exists, but in /usr/lib64, not /usr=
/lib:
[...]
>=20
> Ah, new-style multi-arch. We haven't tested with an environment like th=
at yet.
>=20
> You should be able to put this in ceph.conf and work around it:
>=20
> [global]
> osd class dir =3D /usr/lib64/rados-classes

This fixed it magically :)


Thank you
Mario


--=20
Mario van der Linde
Linux Consultant & Trainer
Tel.: +49-151-16879485
Mail: linde@b1-systems.de

B1 Systems GmbH
Osterfeldstra=C3=9Fe 7 / 85088 Vohburg / http://www.b1-systems.de
GF: Ralph Dehner / Unternehmenssitz: Vohburg / AG: Ingolstadt,HRB 3537


--------------enig150AD5F04B772A51EC691794
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk7Bk2YACgkQ0xt2iESAuwRS+wCePfquOMoafwhpVM2ce/das8Wi
8xEAoITKqFTCGyy2p0Ab2ZVdRf8+h364
=8PyH
-----END PGP SIGNATURE-----

--------------enig150AD5F04B772A51EC691794--
