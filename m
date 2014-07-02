From: Loic Dachary <loic@dachary.org>
Subject: Re: FW: Intel ISA-L EC plugin
Date: Wed, 02 Jul 2014 20:33:35 +0200
Message-ID: <53B4507F.5010206@dachary.org>
References: <3472A07E6605974CBC9BC573F1BC02E4AE747D5B@CERNXCHG44.cern.ch> <3472A07E6605974CBC9BC573F1BC02E4AE747D71@CERNXCHG44.cern.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Xo5mCBB3qAc7ClX4UNmt1qrxVvexT7hrj"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:36063 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754033AbaGBSdm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Jul 2014 14:33:42 -0400
In-Reply-To: <3472A07E6605974CBC9BC573F1BC02E4AE747D71@CERNXCHG44.cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Xo5mCBB3qAc7ClX4UNmt1qrxVvexT7hrj
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

On 02/07/2014 19:54, Andreas Joachim Peters wrote:> Hi Sage & Loic et al =
=2E..
> getting some support from Paul Luse I have finished the refactoring of =
the EC ISA-L plug-in.
>=20
>=20
> The essential ISA-L v 2.10 sources are now part of the source tree and =
it builds a single shared library which is portable on platforms with var=
ying CPU extensions (SSE2, AVX, AVX2). I tested on various Intel & AMD pr=
ocessor types.
>=20
> The build of the plug-in is coupled to the presence of 'yasm' similiar =
to the crc32c extension in common/ ... (I couldn't build ISA-L on ARM).
>=20
> It supports two encoding matrices Vandermonde & Cauchy. The techniques =
are called similar to the one used by Loic in Jerasure "reed_sol_van" & "=
cauchy". "cauchy" is the default.
>=20
> Greg Tucker from Intel pointed me to the proper ( and faster ) way of d=
ecoding if parity chunks are missing.

Great !

> ??? How do we proceed? I currently rebase against firefly and use its A=
PI definition or should this be for a later release with Loic's refactore=
d interface? Shall I make a pull request or shall I hand it over to Loic =
and he takes care to do the integration including QA etc ...?

It would be great if you could rebase against https://github.com/dachary/=
ceph/tree/wip-7238-lrc. It contains the base class that will help us shar=
e code common to plugins. I hope it will be merged in the next few days. =
During the last CDS the remapping of the data chunks has been agreed on a=
nd the only reason why it is not yet merged is that integration tests mus=
t first show it does not break anything and is fully backward compatible.=


Cheers

> ??? I have still an open question on the library optimization for decod=
ing(=3Drepair). If you call decoding for a certain set one needs to do a =
matrix inversion coupled to the given set. If the payload is like 1M the =
computation of the decoding matrix does not
>  play a role. If the payload is 4k it plays a role. Can I assume that t=
he plugin will be called concurrently for the same object with the same s=
et of chunks or would the plugin be called interleaved for many objects w=
ith changing chunk configurations? Is the
>  EC object called single-threaded or by a thread pool? Will backfilll u=
se 4k IOs or larger?
>=20
> I would either commit the simple cache mechanism caching the last compu=
ted erasure configuration & corresponding matrix or put an LRU cache for =
the last computed matrices. I prototyped both, but would stick to the sim=
plest required.
>=20
> Cheers Andreas.
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
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


--Xo5mCBB3qAc7ClX4UNmt1qrxVvexT7hrj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlO0UH8ACgkQ8dLMyEl6F20mzQCfbDccWqrNwgbFscCwNECXrkjB
zFoAoMZ/znsJYjOo6k6c1pPrKybb61tO
=e07A
-----END PGP SIGNATURE-----

--Xo5mCBB3qAc7ClX4UNmt1qrxVvexT7hrj--
