From: Loic Dachary <loic@dachary.org>
Subject: Re: RFC: teuthology field in commit messages
Date: Mon, 30 Nov 2015 00:15:54 +0100
Message-ID: <565B872A.2050700@dachary.org>
References: <5659CE92.4000203@dachary.org>
 <CALe9h7edX3zQVri_KRRNRmjOnvcxhxq0EJXn=5nhF+AQY51g3g@mail.gmail.com>
 <565B5F4C.30308@dachary.org>
 <CALe9h7c6aB28o_1AiC_jDCw3ijdd7y07dW5zcpyu5XhSA2OuHg@mail.gmail.com>
 <565B6D3F.5080109@dachary.org>
 <CALe9h7eFM982XsrRtnoA9=Vfq3OXbbYdAV_dFEUcPukg97mt8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="1kiQ6fIBn7b0MLGv4c7u7U23evf8mWtnk"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:41103 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751203AbbK2XP4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 29 Nov 2015 18:15:56 -0500
In-Reply-To: <CALe9h7eFM982XsrRtnoA9=Vfq3OXbbYdAV_dFEUcPukg97mt8w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1kiQ6fIBn7b0MLGv4c7u7U23evf8mWtnk
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 29/11/2015 23:55, John Spray wrote:
> On Sun, Nov 29, 2015 at 9:25 PM, Loic Dachary <loic@dachary.org> wrote:=

>>
>>
>> On 29/11/2015 21:47, John Spray wrote:
>>> On Sun, Nov 29, 2015 at 8:25 PM, Loic Dachary <loic@dachary.org> wrot=
e:
>>>>
>>>>
>>>> On 29/11/2015 21:08, John Spray wrote:
>>>>> On Sat, Nov 28, 2015 at 3:56 PM, Loic Dachary <loic@dachary.org> wr=
ote:
>>>>>> Hi Ceph,
>>>>>>
>>>>>> An optional teuthology field could be added to a commit message li=
ke so:
>>>>>>
>>>>>> teuthology: --suite rbd
>>>>>>
>>>>>> to state that this commit should be tested with the rbd suite. It =
could be parsed by bots and humans.
>>>>>>
>>>>>> It would make it easy and cost effective to run partial teuthology=
 suites automatically on pull requests.
>>>>>>
>>>>>> What do you think ?
>>>>>
>>>>> Hmm, we are usually testing things at the branch/PR level rather th=
an
>>>>> on the per-commit level, so it feels a bit strange to have this in =
the
>>>>> commit message.
>>>>
>>>> Indeed. But what is a branch if not the HEAD commit ?
>>>
>>> It's the HEAD commit, and its ancestors.  So in a typical PR (or
>>> branch) there are several commits since the base (i.e. since master),=

>>> and perhaps only one of them has a test suite marked on it, or maybe
>>> they have different test suites marked on different commits in the
>>> branch.
>>>
>>> It's not necessarily a problem, just something that would need to hav=
e
>>> a defined behaviour (maybe when testing a PR collect the "teuthology:=
"
>>> tags from all commits in PR, and run all the suites mentioned?).
>>
>> That's an interesting idea :-) My understanding is that we currently t=
est a PR by scheduling suites on its HEAD. But maybe you sometime schedul=
e suites using a commit that's in the middle of a PR ?
>=20
> I think I've made this too complicated...
>=20
> What I meant was that while one would schedule suites against the HEAD
> of the PR, that might not be the same commit that has the logical
> testing information in.  For example, I might have main commit that
> has the "Fixes: " and "teuthology: " tags, and then a second commit
> (that would be HEAD) which e.g. tweaks a unit test.  It would be weird
> if I had to put the teuthology: tag on the unit test commit rather
> than the functional test, so I guess it would make sense to look at
> the teuthology: tags from all the commits in a PR when scheduling it.

Thanks for explaining, it's cristal clear.=20

My initial idea of having a teuthology: tag on the top level commit was i=
ndeed naive and wrong. And looking through all commits and scheduling the=
 suites found on the HEAD as you suggest reflect what we manually do and =
sound right :-)=20

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--1kiQ6fIBn7b0MLGv4c7u7U23evf8mWtnk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlZbhyoACgkQ8dLMyEl6F20rxQCfZU1ZRbWShiidbnHZyPHkXvtq
SPkAn3dFD0Ud1+EL7DU4gTkZBph5hxj9
=fhp4
-----END PGP SIGNATURE-----

--1kiQ6fIBn7b0MLGv4c7u7U23evf8mWtnk--
