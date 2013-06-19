From: Loic Dachary <loic@dachary.org>
Subject: Re: New Defects reported by Coverity Scan for ceph (fwd)
Date: Wed, 19 Jun 2013 23:03:39 +0200
Message-ID: <51C21CAB.40303@dachary.org>
References: <alpine.DEB.2.00.1306191235300.27900@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig387A07592731D0EE0586FAC2"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:40057 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964788Ab3FSVDm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Jun 2013 17:03:42 -0400
In-Reply-To: <alpine.DEB.2.00.1306191235300.27900@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig387A07592731D0EE0586FAC2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Sage,

I believe
https://github.com/ceph/ceph/pull/366
fixes the issue. It was introduced by
https://github.com/ceph/ceph/commit/b16fdf23e5325623874ee1a02e134f577c5a7=
dcd#L0R364
which was merged in master yesterday.

Cheers

On 06/19/2013 09:36 PM, Sage Weil wrote:
> Dereferencing iterator "p" though it is already past the end of its con=
tainer.

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enig387A07592731D0EE0586FAC2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlHCHKsACgkQ8dLMyEl6F20x0wCfaRmnluD1Ck+Ih1pJeRA9u33y
giYAoJ5PWyGwHnk7rBZSQi3sAEtydcPM
=XdBw
-----END PGP SIGNATURE-----

--------------enig387A07592731D0EE0586FAC2--
