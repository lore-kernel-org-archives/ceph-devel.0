From: Loic Dachary <loic@dachary.org>
Subject: Re: EC-ISA buffer alignment
Date: Thu, 25 Sep 2014 17:52:34 +0200
Message-ID: <54243A42.8070506@dachary.org>
References: <3472A07E6605974CBC9BC573F1BC02E4AE7D9EC3@CERNXCHG44.cern.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="gK8qdjbv82G2bkqLEf5ojO9GfbMrvV8De"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:59920 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753028AbaIYPwl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Sep 2014 11:52:41 -0400
In-Reply-To: <3472A07E6605974CBC9BC573F1BC02E4AE7D9EC3@CERNXCHG44.cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gK8qdjbv82G2bkqLEf5ojO9GfbMrvV8De
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

It looks good :-) It is being tested as part of https://github.com/ceph/c=
eph/pull/2531

A few comments at https://github.com/ceph/ceph/pull/2573#issuecomment-568=
38604

Cheers

On 25/09/2014 17:18, Andreas Joachim Peters wrote:
> Hi all,=20
> find attached a pull request to honor 32 byte buffer alignment independ=
ent of compilation environment (vector size) as it was discussed on the l=
ist beforehand.
>=20
> https://github.com/ceph/ceph/pull/2573
>=20
> Cheers Andreas.
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--gK8qdjbv82G2bkqLEf5ojO9GfbMrvV8De
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlQkOkMACgkQ8dLMyEl6F22FfgCaAvW0/fehvR/dLcUs4sPv8Y46
A/oAoLF+krCdR5Ze5Bv76wMYCWpZoXjU
=EONV
-----END PGP SIGNATURE-----

--gK8qdjbv82G2bkqLEf5ojO9GfbMrvV8De--
