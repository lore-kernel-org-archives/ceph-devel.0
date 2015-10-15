From: Loic Dachary <loic@dachary.org>
Subject: Re: make check bot delays
Date: Thu, 15 Oct 2015 11:55:35 +0200
Message-ID: <561F7817.2030607@dachary.org>
References: <561ED1D6.7060905@dachary.org> <561F6D1F.30603@dachary.org> <90559C83A9C7FA45B5846C975DFA612DDB5691095E@ABGEX73E.FSC.NET>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="ElDuPTw5V686O3DSpgGtrhID1P47oWRu9"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:43747 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751642AbbJOJzj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Oct 2015 05:55:39 -0400
In-Reply-To: <90559C83A9C7FA45B5846C975DFA612DDB5691095E@ABGEX73E.FSC.NET>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?IkRhxYJlaywgUGlvdHIi?= <Piotr.Dalek@ts.fujitsu.com>, Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ElDuPTw5V686O3DSpgGtrhID1P47oWRu9
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 15/10/2015 11:45, Da=C5=82ek, Piotr wrote:
>> -----Original Message-----
>> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
>> owner@vger.kernel.org] On Behalf Of Loic Dachary
>> Sent: Thursday, October 15, 2015 11:09 AM
>>
>> Hi,
>>
>> TL;DR: the make check bot is fixed (no more delays) but only keeps the=
 last
>> 30 runs
>> [..]=20
>> What I can't really explain is that it also kept 300 jobs two month ag=
o and that
>> was no issue. What changed in between... I have no clue.
>=20
> Maybe there was some change in Java configuration (memory bounds in par=
ticular)?

I don't think any kind of change or update or anything was done on the je=
nkins running the bot (and doing nothing else) in the past 9 months.

Weird.

>=20
> With best regards / Pozdrawiam
> Piotr Da=C5=82ek
>=20
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--ElDuPTw5V686O3DSpgGtrhID1P47oWRu9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlYfeBcACgkQ8dLMyEl6F20cPgCgmu7HY3xl0+MpZh+mDxXG0Kzu
hFUAnRVBKpNhhR3AyEdqtAr9wpjysN0S
=V43D
-----END PGP SIGNATURE-----

--ElDuPTw5V686O3DSpgGtrhID1P47oWRu9--
