From: Loic Dachary <loic@dachary.org>
Subject: Re: [Ceph-qa] 1 hung, 11 passed in teuthology-2015-02-11_16:13:01-samba-giant-distro-basic-multi
Date: Sat, 14 Feb 2015 11:31:00 +0100
Message-ID: <54DF23E4.9010505@dachary.org>
References: <20150213035821.17712282150@teuthology.front.sepia.ceph.com>	<CAC6JEv9pUeCtjs_SBeqr5N=4aSUUuUsbDW3eMipVsBTq5AkZkQ@mail.gmail.com>	<54DEEC5C.4030605@dachary.org> <CAC6JEv_7OEsLkj1vm65Jxqh4e7LBnTQUAp6r0_5Tbs0-Z=YZZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="hI5lCQ0aosQNd8Sd8WvAv06u10ts68Rjl"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:43977 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753781AbbBNKbE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 14 Feb 2015 05:31:04 -0500
In-Reply-To: <CAC6JEv_7OEsLkj1vm65Jxqh4e7LBnTQUAp6r0_5Tbs0-Z=YZZQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hI5lCQ0aosQNd8Sd8WvAv06u10ts68Rjl
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 14/02/2015 08:56, Gregory Farnum wrote:
> On Fri, Feb 13, 2015 at 10:34 PM, Loic Dachary <loic@dachary.org> wrote=
:
>> Hi Greg,
>>
>> I'm curious to know how you handle the flow of mails from QA runs. Her=
e is a wild guess:
>>
>> * from time to time check that the nightlies run the suites that shoul=
d be run
>=20
> Uh, I guess?
>=20
>> * read the ceph-qa reports daily
>=20
> Yeah
>=20
>> * for each failed job, either relate it to an issue or create one or d=
eclare it noise
>=20
> Yeah
>=20
>> * if a job fails on an existing ticket store a link to the job if it's=
 rare occurrence and the cause is not yet known
>=20
> Yeah, or just to make clear it's still happening or whatever
>=20
>> * bi-weekly bug scrub makes sure no issue, old or new, is forgotten
>=20
> Hopefully!
>=20
>> * at release time you decide that it is ready based on:
>> ** the list of urgent/immediate issues that you can browse to ensure n=
o issue is a blocker
>> ** the last run of each suite to ensure they are recent enough and env=
ironmental noise did not permanently shadow anything
>=20
> Yeah. Well, the last run alone isn't so important; we want to see a
> string of clean runs because a lot of issues aren't reproduced in
> every run.

Do you check the string of clean runs with http://pulpito.ceph.com/?suite=
=3Dfs&branch=3Dgiant for instance ? Or do you have a command line that do=
es the same ?

Cheers

> -Greg
>=20
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--hI5lCQ0aosQNd8Sd8WvAv06u10ts68Rjl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTfI+QACgkQ8dLMyEl6F23fMQCgu+VsDZYmyFjTyNr0T+NBsY3u
cK4AniLNxsJcrCa8932HDhd9mAPdn+bk
=czHF
-----END PGP SIGNATURE-----

--hI5lCQ0aosQNd8Sd8WvAv06u10ts68Rjl--
