From: Loic Dachary <loic@dachary.org>
Subject: Re: RFC: teuthology field in commit messages
Date: Sun, 29 Nov 2015 15:58:10 +0100
Message-ID: <565B1282.3050001@dachary.org>
References: <5659CE92.4000203@dachary.org> <565AE6BF.4040701@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="fhvAsBjICPbJ0EVwtcMDj4HS8IvN1oxeJ"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:40953 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752548AbbK2O6M (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 29 Nov 2015 09:58:12 -0500
In-Reply-To: <565AE6BF.4040701@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Joao Eduardo Luis <joao@suse.de>, Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fhvAsBjICPbJ0EVwtcMDj4HS8IvN1oxeJ
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Joao,

On 29/11/2015 12:51, Joao Eduardo Luis wrote:
> On 11/28/2015 03:56 PM, Loic Dachary wrote:
>> Hi Ceph,
>>
>> An optional teuthology field could be added to a commit message like s=
o:
>>
>> teuthology: --suite rbd
>>
>> to state that this commit should be tested with the rbd suite. It coul=
d be parsed by bots and humans.
>>
>> It would make it easy and cost effective to run partial teuthology sui=
tes automatically on pull requests.
>>
>> What do you think ?
>=20
> Can't we use git-notes for that instead?

It possible but few people understand how it works.

> I think this pollutes the history a bit. Especially considering this
> sort of metadata isn't necessarily specific to a given diff.

I think it is relevant in a permanent way. When running a suite, we do it=
 on a given diff. For instance,
in a 10 commit pull request, we run the suite on the head of the branch, =
which will later become the second parent of the merge. Should we want to=
 test at a later time, long after the pull request has been merged, we wi=
ll be able to do it using the same suite.=20

> Also should be considered that this is a field that may make sense toda=
y
> but may not make much sense in 10, 15 years. And while we have quite a
> few special-purpose fields (e.g., Fixes, Backport), those are currently=

> pretty explanatory and I believe will be still easily understandable in=

> a decade's time.

It also holds for stable branches since we maintain stable branches for c=
eph-qa-suite as well. So, for backporting 3 commits from a given pull req=
uest, it will also help to know that the backport could also be tested wi=
th this specific suite. And if the suite is missing the test, it's also a=
 good hint that this test needs to be backported as well.

> In any case, if there's absolutely no other way to do this and the othe=
r
> folk thinks it's important to have this, I will certainly not be the
> party pooper ;)

:-) FWIW, I think the Backport: field should not be used ( see http://tra=
cker.ceph.com/projects/ceph-releases/wiki/HOWTO_schedule_an_issue_for_bac=
kporting#Backport-field-in-the-commit-messages for the full rationale ). =
But I think the "teuthology" field being used *prior* to the pull request=
 being merged makes sense and is a valuable addition to the commit histor=
y.

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--fhvAsBjICPbJ0EVwtcMDj4HS8IvN1oxeJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlZbEoIACgkQ8dLMyEl6F23NVQCfVAAyhcXmgeSk3reZrj72Z+XX
nUEAnA4GuMGrXuhnSTEKHYFbqQsYL6nW
=FTnN
-----END PGP SIGNATURE-----

--fhvAsBjICPbJ0EVwtcMDj4HS8IvN1oxeJ--
