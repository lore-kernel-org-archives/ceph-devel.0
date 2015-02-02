From: Loic Dachary <loic@dachary.org>
Subject: Re: workloads/rbd_fsx_cache_writethrough.yaml hangs on dumpling
Date: Mon, 02 Feb 2015 18:10:49 +0100
Message-ID: <54CFAF99.9020903@dachary.org>
References: <54CF7927.7010908@dachary.org>	<CAAM7YAmrh_DeJgPY-QECbiZqO4w0R=ummQBug=5B8dyoZrkjWw@mail.gmail.com>	<54CF9120.30509@dachary.org> <CAC6JEv9y=2A3Q80bGbTtWam7ESf8_pGBG6L_VSs2B1Z=n--rDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="8hstdmRwlDb4fUs9UU3OtHRls8beh8ptL"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:51375 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751662AbbBBRKw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Feb 2015 12:10:52 -0500
In-Reply-To: <CAC6JEv9y=2A3Q80bGbTtWam7ESf8_pGBG6L_VSs2B1Z=n--rDA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: "Yan, Zheng" <ukernel@gmail.com>, Jason Dillaman <dillaman@redhat.com>, Josh Durgin <jdurgin@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8hstdmRwlDb4fUs9UU3OtHRls8beh8ptL
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 02/02/2015 17:46, Gregory Farnum wrote:
> On Mon, Feb 2, 2015 at 7:00 AM, Loic Dachary <loic@dachary.org> wrote:
>>
>>
>> On 02/02/2015 14:48, Yan, Zheng wrote:
>>> On Mon, Feb 2, 2015 at 9:18 PM, Loic Dachary <loic@dachary.org> wrote=
:
>>>> Hi,
>>>>
>>>> http://pulpito.ceph.com/loic-2015-01-29_15:39:38-rbd-dumpling-backpo=
rts---basic-multi/730029/ hangs on dumpling and got killed after two days=
=2E
>>>>
>>>> Although workloads/rbd_fsx_cache_writethrough.yaml  was running with=
 the thrasher, it does not seem to be related to http://tracker.ceph.com/=
issues/10513 : it was running on a mira070 (16GB RAM) and plana78 (8GB RA=
M).
>>>>
>>>> I don't see anything in https://github.com/ceph/ceph-qa-suite/blob/m=
aster/tasks/rbd_fsx.py that would suggest it needs backporting a fix to t=
he ceph-qa-suite branch of dumpling.
>>>>
>>>> I browsed the commits related to RBD that are in the dumpling-backpo=
rts branch ( see here for the list I used http://tracker.ceph.com/issues/=
10560 ). I don't see anything in the issues that need backporting to dump=
ling either.
>>>>
>>>> Another run of this specific test has been scheduled to check if it =
always happens at http://pulpito.ceph.com/loic-2015-02-02_13:58:32-rbd:th=
rash:workloads:rbd_fsx_cache_writethrough.yaml-dumpling-backports---basic=
-multi/
>>>>
>>>> Does that ring a bell by any chance ?
>>>>
>>>
>>> maybe it's the same as http://tracker.ceph.com/issues/10498
>>>
>>
>> I hoped it would be but from what I read the bug crashes and creates a=
 core dump, right ? What I'm seeing is the test hanging indefinitely and =
no core.
>=20
> Whether it's crashing or not depends on the nature of the test. The
> root cause is just a hang; some things might crash on timeouts but
> others won't. (I don't think I recall seeing a crash on that bug
> report anyway, though.)

Ah, you are correct, thanks for correcting me. I got confused by another =
livelock bug http://tracker.ceph.com/issues/9854 and wrongly assumed just=
 by the keyword that they were the same.

Cheers

> -Greg
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--8hstdmRwlDb4fUs9UU3OtHRls8beh8ptL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTPr5kACgkQ8dLMyEl6F203wwCglxWd26js8WgyFx5mbD3B7Y14
cVoAoLHtnOTggZtowTXyqzUZcq6ZrJtL
=3bGf
-----END PGP SIGNATURE-----

--8hstdmRwlDb4fUs9UU3OtHRls8beh8ptL--
