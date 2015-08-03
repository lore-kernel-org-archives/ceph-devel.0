From: Loic Dachary <loic@dachary.org>
Subject: Re: CephFS and the next hammer release v0.94.3
Date: Mon, 03 Aug 2015 18:32:11 +0200
Message-ID: <55BF978B.9010604@dachary.org>
References: <55BF8C21.5020204@dachary.org> <CAC6JEv91iRpTZivmaFME9iaeuJPrwaCpbriXY2kTpucPWGnXTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="AK3SXoScWH49N2FkmgTT4kokvSQb3nJo3"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:60719 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752620AbbHCQcX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Aug 2015 12:32:23 -0400
In-Reply-To: <CAC6JEv91iRpTZivmaFME9iaeuJPrwaCpbriXY2kTpucPWGnXTg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>, =?UTF-8?B?5Lil5q2j?= <zyan@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Abhishek L <abhishek.lekshmanan@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AK3SXoScWH49N2FkmgTT4kokvSQb3nJo3
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Greg,

I assume the "file handle reference counting" is about http://tracker.cep=
h.com/issues/12088 which is backported as described at http://tracker.cep=
h.com/issues/12319. It was indeed somewhat problematic and required two p=
ull requests: https://github.com/ceph/ceph/pull/5222 (authored by Yan Zhe=
ng) and https://github.com/ceph/ceph/pull/5427 (merged by Yan Zheng).

Cheers

On 03/08/2015 18:01, Gregory Farnum wrote:
> On Mon, Aug 3, 2015 at 6:43 PM Loic Dachary <loic@dachary.org> wrote:
>>
>> Hi Greg,
>>
>> The next hammer release as found at https://github.com/ceph/ceph/tree/=
hammer passed the fs suite (http://tracker.ceph.com/issues/11990#fs). Do =
you think it is ready for QE to start their own round of testing ?
>=20
> I'm on vacation right now, but the only thing I see there that might
> be iffy is the backport of the file handle reference counting. As long
> as that is all good (Zheng?) things look fine to me.
> -Greg
>=20
>>
>> Cheers
>>
>> P.S. http://tracker.ceph.com/issues/11990#Release-information has dire=
ct links to the pull requests merged into hammer since v0.94.2 in case yo=
u need more context about one of them.
>>
>> --
>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--AK3SXoScWH49N2FkmgTT4kokvSQb3nJo3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlW/l4sACgkQ8dLMyEl6F22lcQCgnHzfsYbSxXWe4jQY2QZCiHnU
nmkAn0Zn4/9KxVyq/AAYJdB+FtBWDGCH
=+Yw7
-----END PGP SIGNATURE-----

--AK3SXoScWH49N2FkmgTT4kokvSQb3nJo3--
