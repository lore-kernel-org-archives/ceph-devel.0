From: Loic Dachary <loic@dachary.org>
Subject: Re: RFC: teuthology field in commit messages
Date: Sun, 29 Nov 2015 22:25:19 +0100
Message-ID: <565B6D3F.5080109@dachary.org>
References: <5659CE92.4000203@dachary.org>
 <CALe9h7edX3zQVri_KRRNRmjOnvcxhxq0EJXn=5nhF+AQY51g3g@mail.gmail.com>
 <565B5F4C.30308@dachary.org>
 <CALe9h7c6aB28o_1AiC_jDCw3ijdd7y07dW5zcpyu5XhSA2OuHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="ueRCH6oRPGjJK2h6AJwA8qPwc67CjWPR2"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:41078 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752353AbbK2VZW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 29 Nov 2015 16:25:22 -0500
In-Reply-To: <CALe9h7c6aB28o_1AiC_jDCw3ijdd7y07dW5zcpyu5XhSA2OuHg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ueRCH6oRPGjJK2h6AJwA8qPwc67CjWPR2
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 29/11/2015 21:47, John Spray wrote:
> On Sun, Nov 29, 2015 at 8:25 PM, Loic Dachary <loic@dachary.org> wrote:=

>>
>>
>> On 29/11/2015 21:08, John Spray wrote:
>>> On Sat, Nov 28, 2015 at 3:56 PM, Loic Dachary <loic@dachary.org> wrot=
e:
>>>> Hi Ceph,
>>>>
>>>> An optional teuthology field could be added to a commit message like=
 so:
>>>>
>>>> teuthology: --suite rbd
>>>>
>>>> to state that this commit should be tested with the rbd suite. It co=
uld be parsed by bots and humans.
>>>>
>>>> It would make it easy and cost effective to run partial teuthology s=
uites automatically on pull requests.
>>>>
>>>> What do you think ?
>>>
>>> Hmm, we are usually testing things at the branch/PR level rather than=

>>> on the per-commit level, so it feels a bit strange to have this in th=
e
>>> commit message.
>>
>> Indeed. But what is a branch if not the HEAD commit ?
>=20
> It's the HEAD commit, and its ancestors.  So in a typical PR (or
> branch) there are several commits since the base (i.e. since master),
> and perhaps only one of them has a test suite marked on it, or maybe
> they have different test suites marked on different commits in the
> branch.
>=20
> It's not necessarily a problem, just something that would need to have
> a defined behaviour (maybe when testing a PR collect the "teuthology:"
> tags from all commits in PR, and run all the suites mentioned?).

That's an interesting idea :-) My understanding is that we currently test=
 a PR by scheduling suites on its HEAD. But maybe you sometime schedule s=
uites using a commit that's in the middle of a PR ?

Cheers

>>
>>> However, if a system existed that would auto-test things when I put
>>> something magic in a commit message, I would probably use it!
>>>
>>> John
>>>
>>>
>>>>
>>>> --
>>>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>>>
>>
>> --
>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--ueRCH6oRPGjJK2h6AJwA8qPwc67CjWPR2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlZbbUAACgkQ8dLMyEl6F23FlACgs52IpjOCtexnzGyW20P6eIm8
VscAnAsCnz3OHXibzj4zpj4KI1eLYLJs
=7+Db
-----END PGP SIGNATURE-----

--ueRCH6oRPGjJK2h6AJwA8qPwc67CjWPR2--
