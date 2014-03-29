From: Loic Dachary <loic@dachary.org>
Subject: Re: jerasure / gf-complete & 32 bits
Date: Sat, 29 Mar 2014 22:38:59 +0100
Message-ID: <53373D73.9030000@dachary.org>
References: <5335AE3D.1050104@dachary.org> <53368DA3.7080206@dachary.org> <BC86EB1E-D599-4286-A73E-29130DB0A5A2@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="r6gEshcQ9U3Ja8dFaAWBvjpVW5qB8lake"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:58528 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752007AbaC2VjF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 29 Mar 2014 17:39:05 -0400
In-Reply-To: <BC86EB1E-D599-4286-A73E-29130DB0A5A2@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kevin Greenan <kmgreen2@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--r6gEshcQ9U3Ja8dFaAWBvjpVW5qB8lake
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 29/03/2014 17:16, Kevin Greenan wrote:
> Hey Loic,
>=20
> I'll take a look on Monday.  I'll create a VM to try and reproduce (and=
 hopefully fix) this.

I'm not sure it's worth fixing : https://github.com/ceph/ceph/pull/1563

>=20
> Thanks!
> -kevin
>=20
> On Mar 29, 2014, at 2:08 AM, Loic Dachary wrote:
>=20
>> The gf-complete + jerasure tests run fine on Ubuntu saucy 32 bits. The=
 problem is when trying to compile on a 32 bits machine as shown here
>>
>> http://gitbuilder.sepia.ceph.com/gitbuilder-ceph-tarball-precise-i386-=
basic/log.cgi?log=3Dcb624fc9ed1e891e51cc0d20622d43f6fcd08cd5
>>
>>
>> On 28/03/2014 18:15, Loic Dachary wrote:
>>> Hi Kevin,
>>>
>>> Someone mentionned a problem (no more information at the moment ;-) a=
bout running jerasure / gf-complete on a 32 bits machine. Does that ring =
a bell ? I'll try it out with the test method you suggested:
>>>
>>> "'gf_methods <w> -A -U' to run all of the tests for w=3D[4,8,16,32,64=
,128]. Then, I install a fresh Jerasure and run test_all_gfs.sh and time_=
all_gfs_argv_init.sh. Finally, I install PyECLib (Python library that wra=
ps Jerasure, ISA-L (soon) and has some homegrown XOR- codes) and run the =
scripts under tests/."
>>>
>>> Cheers
>>>
>>
>> --=20
>> Lo=EFc Dachary, Artisan Logiciel Libre
>>
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--r6gEshcQ9U3Ja8dFaAWBvjpVW5qB8lake
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlM3PXYACgkQ8dLMyEl6F230KgCgv5xOEvz1aDQWiUVxIIVhfBqe
pnAAmwUmg5MFmEguPUFGZAlXLAbFtPbz
=/7uv
-----END PGP SIGNATURE-----

--r6gEshcQ9U3Ja8dFaAWBvjpVW5qB8lake--
