From: Loic Dachary <loic@dachary.org>
Subject: Re: fecpp C++ forward error correction library
Date: Tue, 30 Apr 2013 10:11:59 +0200
Message-ID: <517F7CCF.1020107@dachary.org>
References: <517538D7.6050706@dachary.org> <DA7579B5-A82E-431B-99A0-89C4EE58A87E@asgaard.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig387928F38C1A858519CFEA84"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:39846 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757879Ab3D3IMD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Apr 2013 04:12:03 -0400
In-Reply-To: <DA7579B5-A82E-431B-99A0-89C4EE58A87E@asgaard.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christopher LILJENSTOLPE <cdl@asgaard.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Jack Lloyd <lloyd@randombit.net>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig387928F38C1A858519CFEA84
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 04/30/2013 02:08 AM, Christopher LILJENSTOLPE wrote:
> Supposedly, on 2013-Apr-22, at 06.19 PDT(-0700), someone claiming to be=
 Loic Dachary scribed:
>=20
>> Hi Christopher,
>>
>> Jack Lloyd is the author of fecpp ( http://www.randombit.net/code/fecp=
p/ ) and he tells me someone sent him a new SIMD approach a few weeks ago=
=2E I'm not sure what SIMD means yet, but I'll figure it out ;-). I tend =
to favor fecpp because it is more self contained and may be easier to emb=
ed than https://pypi.python.org/pypi/zfec
>=20
> I'll defer, provided that we don't incur a performance penalty (which i=
s one of the negatives in sharding).  As far as SIMD: Single Instruction =
Multiple Data.  Basically, if you think of a tiled processor (like a GPU)=
, then you set all the tiles to do the same instruction, and stream diffe=
rent data to each tile.  As opposed to MIMD, where each tile runs a diffe=
rent instruction on different data.   You don't need parallel processing =
CPUs to make use of SIMD, but you can get them going screamingly fast if =
you do=E2=80=A6

Hi Christopher,

Thanks for explaining :-) Although it seems disk / network I/O are the bo=
ttleneck, it's good to be able to reduce the processing footprint to a mi=
nimum.

Cheers

>=20
> 	Christopher
>=20
>>
>> Cheers
>>
>> --=20
>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>=20
>=20
> --
> =E6=9D=8E=E6=9F=AF=E7=9D=BF
> Check my PGP key here: http://www.asgaard.org/cdl/cdl.asc
> Current vCard here: http://www.asgaard.org/cdl/cdl.vcf

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre



--------------enig387928F38C1A858519CFEA84
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlF/fM8ACgkQ8dLMyEl6F22LPQCaAhno1eoRVOq+fBHRVn0nMuVz
gnIAoMLxNSUJUwadhOrnZGdcCNlCvPFo
=UiUx
-----END PGP SIGNATURE-----

--------------enig387928F38C1A858519CFEA84--
