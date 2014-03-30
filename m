From: Loic Dachary <loic@dachary.org>
Subject: Re: jerasure / gf-complete & 32 bits
Date: Sun, 30 Mar 2014 18:01:13 +0200
Message-ID: <53383FC9.90707@dachary.org>
References: <5335AE3D.1050104@dachary.org>	<53368DA3.7080206@dachary.org>	<BC86EB1E-D599-4286-A73E-29130DB0A5A2@gmail.com>	<53373D73.9030000@dachary.org> <CAOGLoJOVtfFB24=DBJQ4YL-PbS-mfebKGRHypNJE9o98yvGuqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="kdMWWamLIUHkpOQ3lvKo4WqnXGALxdcBU"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:58990 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751581AbaC3QBR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 30 Mar 2014 12:01:17 -0400
In-Reply-To: <CAOGLoJOVtfFB24=DBJQ4YL-PbS-mfebKGRHypNJE9o98yvGuqw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Justin Erenkrantz <justin@erenkrantz.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kdMWWamLIUHkpOQ3lvKo4WqnXGALxdcBU
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Nice catch ! https://github.com/ceph/ceph/pull/1569

On 30/03/2014 16:58, Justin Erenkrantz wrote:
> On Sat, Mar 29, 2014 at 5:38 PM, Loic Dachary <loic@dachary.org> wrote:=

>> I'm not sure it's worth fixing : https://github.com/ceph/ceph/pull/156=
3
>=20
> Line 25 in https://github.com/ceph/ceph/pull/1563/files has a typo:
>=20
> +        INTEL_SSE3_FLAGS=3D"-mssse3 -DINTEL_SSE3"
>=20
> should be:
>=20
> +        INTEL_SSE3_FLAGS=3D"-msse3 -DINTEL_SSE3"
>=20
> (The AX_CHECK_COMPILE_FLAG call is correct.)
>=20
> Cheers.  -- justin
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--kdMWWamLIUHkpOQ3lvKo4WqnXGALxdcBU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlM4P8wACgkQ8dLMyEl6F23I3QCgsxJYP3gvzSPXOyZ6fRXEkfrY
gf4AnArbJ59ICczhefg9khAYasNGm8ZT
=LMId
-----END PGP SIGNATURE-----

--kdMWWamLIUHkpOQ3lvKo4WqnXGALxdcBU--
