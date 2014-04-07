From: Loic Dachary <loic@dachary.org>
Subject: Re: Deterministic thrashing
Date: Mon, 07 Apr 2014 19:13:59 +0200
Message-ID: <5342DCD7.7020001@dachary.org>
References: <53412C8E.2070504@dachary.org> <CAPYLRzh4LhWS5VE8yur=5uQUB_T5F66VHeXNkgj+j_LCBTE1eA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="HQpt1dTK4aeQQqLw0oj3c6oLUa9HSbkVM"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:42888 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753777AbaDGROI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Apr 2014 13:14:08 -0400
In-Reply-To: <CAPYLRzh4LhWS5VE8yur=5uQUB_T5F66VHeXNkgj+j_LCBTE1eA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HQpt1dTK4aeQQqLw0oj3c6oLUa9HSbkVM
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 07/04/2014 18:55, Gregory Farnum wrote:
> This would be really nice but there are unfortunately even more
> hiccups than you've noted here:
> 1) Thrashing is both time and disk access sensitive, and hardware diffe=
rs
> 2) The teuthology thrashing is triggered largely based on PG state
> events (eg, "all PGs are clean, so restart an OSD")
> 3) The actual failures tend to involve a combination of PG state and
> inbound client operations, and I can't think of any realistic way to
> coordinate those.
>=20
> Those problems look technically insurmountable to me, but maybe I'm
> missing something?

There is no easy way to use the logs / events to significantly reduce the=
 randomness of the workload ? I honestly have no clue ;-)

Cheers

> -Greg
> Software Engineer #42 @ http://inktank.com | http://ceph.com
>=20
>=20
> On Sun, Apr 6, 2014 at 3:29 AM, Loic Dachary <loic@dachary.org> wrote:
>> Hi Ceph,
>>
>> It would be nice to have a way to replay the random events injected by=
 stanzas such as
>>
>> - thrashosds:
>>     chance_pgnum_grow: 2
>>     chance_pgpnum_fix: 1
>>
>> When a teuthology workload (such as tracker.ceph.com/issues/7914#note-=
34) crashes once a week and the error is not obvious, it would increase t=
he probability to reproduce the crash. Instead of the "trashosds" we coul=
d have something like "recorded-trashosds: trashosd.events" and instead o=
f being random they would happen more deterministically (same number of e=
vents and same number of seconds between events ?).
>>
>> I realize this is non trivial to implement but maybe someone already t=
hought about that and has a better idea ?
>>
>> Cheers
>>
>> --
>> Lo=EFc Dachary, Artisan Logiciel Libre
>>

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--HQpt1dTK4aeQQqLw0oj3c6oLUa9HSbkVM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlNC3NoACgkQ8dLMyEl6F20BjgCbB6ZnvecKgbhEXTnRDOe98Lea
fLMAnR45rkRt+lnxKl78XGhRpnETXgGV
=4DK6
-----END PGP SIGNATURE-----

--HQpt1dTK4aeQQqLw0oj3c6oLUa9HSbkVM--
