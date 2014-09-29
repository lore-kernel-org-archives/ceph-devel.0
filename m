From: Loic Dachary <loic@dachary.org>
Subject: Re: [PATCH v3 0/4] buffer alignment for erasure code SIMD
Date: Mon, 29 Sep 2014 15:15:02 +0200
Message-ID: <54295B56.6080203@dachary.org>
References: <1410796508-28711-1-git-send-email-j@jannau.net> <1411994072-18850-1-git-send-email-j@jannau.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="81rwhqeTxalJnBBA3t9nhNk33X4f2TFhs"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:33994 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753861AbaI2NPK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Sep 2014 09:15:10 -0400
In-Reply-To: <1411994072-18850-1-git-send-email-j@jannau.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Janne Grunau <j@jannau.net>, ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--81rwhqeTxalJnBBA3t9nhNk33X4f2TFhs
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

On 29/09/2014 14:34, Janne Grunau wrote:
> Hi,
>=20
> reworked patchset to address the comments in https://github.com/ceph/ce=
ph/pull/2558
>=20
> variable alignment instead of the hardcoded 32-byte alignment
> fixed copy and paste error in a comment
> change buffer alignment for decoding too (much simpler than the encodin=
g
> changes)
>=20
> I'll do a github pull request once the last make check run finishes
> locally.

I was too quick it seems : https://github.com/ceph/ceph/pull/2595

Looks great !

Cheers

>=20
> Also available from http://git.jannau.net/ceph.git/log/?h=3Dbuffer_alig=
n
>=20
> regards
>=20
> Janne
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--81rwhqeTxalJnBBA3t9nhNk33X4f2TFhs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlQpW1YACgkQ8dLMyEl6F22L1wCfUDJpl2IkibWkL5/klGhAu7tR
OEYAoIW/VGeo9iZxVjILV5H7LnXvryZb
=vQC3
-----END PGP SIGNATURE-----

--81rwhqeTxalJnBBA3t9nhNk33X4f2TFhs--
