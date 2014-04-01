From: Loic Dachary <loic@dachary.org>
Subject: Re: jerasure crash
Date: Tue, 01 Apr 2014 09:58:13 +0200
Message-ID: <533A7195.20204@dachary.org>
References: <alpine.DEB.2.00.1403311735120.22715@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="nAe1XWn1OHIKG6QVLbdS747mrX5XuBwbF"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:60740 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751098AbaDAH6S (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Apr 2014 03:58:18 -0400
In-Reply-To: <alpine.DEB.2.00.1403311735120.22715@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nAe1XWn1OHIKG6QVLbdS747mrX5XuBwbF
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

I'll work on it right now.

Cheers

On 01/04/2014 02:38, Sage Weil wrote:
> Hey Loic,
>=20
> A new failure came up in QA over the weekend that looks like a problem =

> inside jerasure:
>=20
> 	http://tracker.ceph.com/issues/7914
>=20
> I think this is the first time this particular failure has come up.  Sa=
m=20
> suggests taking a hard look at the recent jerasure/gf-complete submodul=
e=20
> changes.  And/or we need to run one of the failing tests in a loop to g=
et=20
> a sense of frequency and then bisect.  Can you spearhead this one?
>=20
> sage
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--nAe1XWn1OHIKG6QVLbdS747mrX5XuBwbF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlM6cZgACgkQ8dLMyEl6F20rRACgxWPOyTFDWG2aFLl4t2RID06K
/QAAn1Nx5pJd0lxYwFuCsi8dxnfKyHaB
=DAty
-----END PGP SIGNATURE-----

--nAe1XWn1OHIKG6QVLbdS747mrX5XuBwbF--
