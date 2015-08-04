From: Loic Dachary <loic@dachary.org>
Subject: Re: CephFS and the next hammer release v0.94.3
Date: Tue, 04 Aug 2015 12:47:12 +0200
Message-ID: <55C09830.8040008@dachary.org>
References: <55BF8C21.5020204@dachary.org> <CAC6JEv91iRpTZivmaFME9iaeuJPrwaCpbriXY2kTpucPWGnXTg@mail.gmail.com> <55BF978B.9010604@dachary.org> <C7284C47-5C31-4AB5-8AFD-1DF901C7ED67@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="0RXUvmRSOtFmIPdBQASai3LFcmHO9BCXj"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:32910 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932150AbbHDKrP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Aug 2015 06:47:15 -0400
In-Reply-To: <C7284C47-5C31-4AB5-8AFD-1DF901C7ED67@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>
Cc: Gregory Farnum <greg@gregs42.com>, Ceph Development <ceph-devel@vger.kernel.org>, Abhishek L <abhishek.lekshmanan@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0RXUvmRSOtFmIPdBQASai3LFcmHO9BCXj
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Hi,

On 04/08/2015 04:01, Yan, Zheng wrote:> Hi Loic.
>=20
> Yes, https://github.com/ceph/ceph/pull/5222 is problematic.  Do you mea=
n should we include these RPs in v0.94.3?  These RPs fix a bug in rare co=
nfigure, I think it=E2=80=99s not a big deal to not include it in v0.94.3=
=20

Both https://github.com/ceph/ceph/pull/5222 and https://github.com/ceph/c=
eph/pull/5427 are already in the upcoming v0.94.3 release that is going t=
o be published. Do you think they will cause problem ?=20

Cheers

>=20
> Regards
> Yan, Zheng
>=20
>=20
>> On Aug 4, 2015, at 00:32, Loic Dachary <loic@dachary.org> wrote:
>>
>> Hi Greg,
>>
>> I assume the "file handle reference counting" is about http://tracker.=
ceph.com/issues/12088 which is backported as described at http://tracker.=
ceph.com/issues/12319. It was indeed somewhat problematic and required tw=
o pull requests: https://github.com/ceph/ceph/pull/5222 (authored by Yan =
Zheng) and https://github.com/ceph/ceph/pull/5427 (merged by Yan Zheng).
>>
>> Cheers
>>
>> On 03/08/2015 18:01, Gregory Farnum wrote:
>>> On Mon, Aug 3, 2015 at 6:43 PM Loic Dachary <loic@dachary.org> wrote:=

>>>>
>>>> Hi Greg,
>>>>
>>>> The next hammer release as found at https://github.com/ceph/ceph/tre=
e/hammer passed the fs suite (http://tracker.ceph.com/issues/11990#fs). D=
o you think it is ready for QE to start their own round of testing ?
>>>
>>> I'm on vacation right now, but the only thing I see there that might
>>> be iffy is the backport of the file handle reference counting. As lon=
g
>>> as that is all good (Zheng?) things look fine to me.
>>> -Greg
>>>
>>>>
>>>> Cheers
>>>>
>>>> P.S. http://tracker.ceph.com/issues/11990#Release-information has di=
rect links to the pull requests merged into hammer since v0.94.2 in case =
you need more context about one of them.
>>>>
>>>> --
>>>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>
>> --=20
>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--0RXUvmRSOtFmIPdBQASai3LFcmHO9BCXj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXAmDAACgkQ8dLMyEl6F22xiACgwqLs1pLuqFm7X7/hAE1nvRm2
HmYAoJEmylI4R8BTrZEgacUOjrPqOeZo
=4yEa
-----END PGP SIGNATURE-----

--0RXUvmRSOtFmIPdBQASai3LFcmHO9BCXj--
