From: Loic Dachary <loic@dachary.org>
Subject: Re: RHEL 6.5 shared library upgrade safety
Date: Mon, 18 Aug 2014 16:06:31 +0200
Message-ID: <53F20867.3090509@dachary.org>
References: <53F1EA1C.1020108@dachary.org> <53F1ED54.2020109@42on.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="J2uqBgnLCReCm5fQqEKbn1B63x6CKKMEA"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:33241 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751011AbaHROGi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Aug 2014 10:06:38 -0400
In-Reply-To: <53F1ED54.2020109@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>, Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--J2uqBgnLCReCm5fQqEKbn1B63x6CKKMEA
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Wido,

On 18/08/2014 14:11, Wido den Hollander wrote:> On 08/18/2014 01:57 PM, L=
oic Dachary wrote:
>> Hi Ceph,
>>
>> In RHEL 6.5, is the following scenario possible :
>>
>> a) an OSD dlopen a shared library for erasure-code,
>> b) the shared library file is replaced while the OSD is running,
>> c) the OSD starts using the new file instead of the old one.
>>
>> It seems unlikely but it would explain a weird stack trace at http://t=
racker.ceph.com/issues/9153#note-5 so I'm double checking ;-)
>>
>=20
> Well, it could be that it does so. I'm not 100% sure, but afaik it coul=
d happen that when you replace a library certain parts might not be in me=
mory.
>=20
> See: http://stackoverflow.com/questions/7767325/replacing-shared-object=
-so-file-while-main-program-is-running

As it turns out, the problem is a simpler, but I still have not clue how =
it can happen.

http://tracker.ceph.com/issues/9153 shows

537187718- ceph version 0.80.5-164-gcc4e625 (cc4e6258d67fb16d4a92c25078a0=
822a9849cd77)
537187795- 1: ceph-osd() [0x9b58c1]
537187821- 2: (()+0xf710) [0x7f06a3e24710]
537187854- 3: (memcpy()+0x15b) [0x7f06a2d4daab]
537187892- 4: (jerasure_matrix_dotprod()+0xc8) [0x7f067fd11618]
537187946- 5: (jerasure_matrix_encode()+0x75) [0x7f067fd11865]
537187999- 6: (ErasureCodeJerasureReedSolomonVandermonde::jerasure_encode=
(char**, char**, int)+0x21) [0x7f067fd294b1]
537188107- 7: (ErasureCodeJerasure::encode_chunks(std::set<int, std::less=
<int>, std::allocator<int> > const&, std::map<int, ceph::buffer::list, st=
d::less<int>, std::allocator<std::pair<int const, ceph::buffer::list> > >=
*)+0x607) [0x7f067fd2a807]

Meaning ceph-osd firefly crashed trying to use a jerasure plugin coming f=
rom master, which is no surprise because the API is incompatible although=
 the data coding / encoding is compatible.=20

Cheers

>> Cheers
>>
>=20
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--J2uqBgnLCReCm5fQqEKbn1B63x6CKKMEA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlPyCGcACgkQ8dLMyEl6F21rhgCgnY+tkWem2FxULtwEcZaZYhe8
pQ0AoLalqPspxAnasnKLLglF+qjwWxVC
=E8Md
-----END PGP SIGNATURE-----

--J2uqBgnLCReCm5fQqEKbn1B63x6CKKMEA--
