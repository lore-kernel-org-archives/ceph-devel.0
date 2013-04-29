From: Loic Dachary <loic@dachary.org>
Subject: Re: fecpp C++ forward error correction library
Date: Mon, 29 Apr 2013 16:23:36 +0200
Message-ID: <517E8268.8030109@dachary.org>
References: <sfid-H20130422-141929-+033.82-1@marduk.tchpc.tcd.ie> <517538D7.6050706@dachary.org>  (sfid-H20130422-141929-+033.82-1@marduk.tchpc.tcd.ie) <DCA8968A-375A-4E51-84D3-425E22E81375@tchpc.tcd.ie>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9AE2E3553A71720DA549582C"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:49433 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753940Ab3D2OXl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Apr 2013 10:23:41 -0400
In-Reply-To: <DCA8968A-375A-4E51-84D3-425E22E81375@tchpc.tcd.ie>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jimmy Tang <jtang@tchpc.tcd.ie>
Cc: Christopher LILJENSTOLPE <cdl@asgaard.org>, Ceph Development <ceph-devel@vger.kernel.org>, Jack Lloyd <lloyd@randombit.net>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9AE2E3553A71720DA549582C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 04/29/2013 04:06 PM, Jimmy Tang wrote:
>=20
> On 22 Apr 2013, at 14:19, Loic Dachary wrote:
>=20
>> Hi Christopher,
>>
>> Jack Lloyd is the author of fecpp ( http://www.randombit.net/code/fecp=
p/ ) and he tells me someone sent him a new SIMD approach a few weeks ago=
=2E I'm not sure what SIMD means yet, but I'll figure it out ;-). I tend =
to favor fecpp because it is more self contained and may be easier to emb=
ed than https://pypi.python.org/pypi/zfec
>>
>> Cheers
>>
>> --=20
>> Lo=EFc Dachary, Artisan Logiciel Libre
>>
>=20
>=20
> Having played with zfec (more the underlying fec.[c,h] file) it's well =
written and self-contained as I remember it; but you will need to write a=
 bunch of wrapper functions to chunk up data and pad out blocks and of co=
urse turn it into a library before you can use the underlying zfec implem=
entation for ceph. If my memory is right, zfec's c code requires a C90 or=
 C99 compiler to build it, I'm not sure if you care about that.

Hi Jimmy,

fecpp and zfec compile and run using g++ 4.7 . The requirements for http:=
//code.google.com/p/holostor/ may be different but I suspect it also work=
s.=20

Cheers

>=20
> Regards,
> Jimmy Tang
>=20
> --
> Senior Software Engineer, Digital Repository of Ireland (DRI)
> High Performance & Research Computing, IS Services
> Lloyd Building, Trinity College Dublin, Dublin 2, Ireland.
> http://www.tchpc.tcd.ie/ | jtang@tchpc.tcd.ie
> Tel: +353-1-896-3847
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre



--------------enig9AE2E3553A71720DA549582C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlF+gmgACgkQ8dLMyEl6F234EgCeNahuQMZ4LOVfSSGXvzhMPh4u
3iAAn2lBe4tAXiKpdKUD93RidaD3+GXL
=xQuT
-----END PGP SIGNATURE-----

--------------enig9AE2E3553A71720DA549582C--
