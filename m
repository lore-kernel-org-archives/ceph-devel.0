From: Loic Dachary <loic@dachary.org>
Subject: Re: Hammer backport and bypassing procedure
Date: Sat, 29 Aug 2015 10:03:37 +0200
Message-ID: <55E16759.2020909@dachary.org>
References: <55E0B396.2090602@dachary.org>	<55E0C803.8020402@redhat.com> <CAP3mxSx3E7_1SgwvEfbYftHsWT5_5U0cANiz4Hn7bm9qjjxkew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="uagmuW45TjKKwmq17dqoCsoRj5OrAquBU"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:45749 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752261AbbH2IDq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 29 Aug 2015 04:03:46 -0400
In-Reply-To: <CAP3mxSx3E7_1SgwvEfbYftHsWT5_5U0cANiz4Hn7bm9qjjxkew@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek Varshney <abhishek.varshney@flipkart.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uagmuW45TjKKwmq17dqoCsoRj5OrAquBU
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 29/08/2015 07:46, Abhishek Varshney wrote:> Hi Loic,
>=20
> How about marking the PRs which pass integration/upgrade tests with a p=
refix PT (Passed Tests) or something in the title after they are merged i=
nto the stable branch. This is probably how we can do it:
>=20
>  1. While preparing an integration branch, also get all the PRs which a=
re merged but do not have PT as prefix. These are essentially the PRs whi=
ch have bypassed tests.

Nathan had a similar idea and asked that the "Integration Passed" status =
is added to the Backport tracker (see http://tracker.ceph.com/issues/1182=
4). We should start using it.

>  2. Perform integration/update tests on all the other open PRs in the i=
ntegration branch.
>  3. If the integration branch passes all the tests, mark all the PRs as=
 PT, including the ones which had bypassed tests earlier. Now, we know th=
at the PRs which had bypassed tests are bug free.

That makes senses. We should amend http://tracker.ceph.com/projects/ceph-=
releases/wiki/HOWTO_populate_the_integration_branch to also select merged=
 commits that have not seen tests. Note that the hammer branch also is te=
sted, automatically (the test plan is documented at http://tracker.ceph.c=
om/projects/ceph-releases/wiki/HOWTO_monitor_the_automated_tests_AKA_nigh=
tlies). So, once a PR is merged, it will eventually be tested in this way=
=2E

>  4. If the integration branch encounters failures, we know it could be =
because of the PRs which had bypassed tests and we know what those PRs ar=
e from step 1.

This is going in the right direction :-) That's a lot of manual updating =
though and it would be great of teuthology could update the issues / PRs =
with test results so we don't have to manually maintain that inventory.=20

Cheers

>=20
> Thanks for the clarification on this scenario.
>=20
> Regards
> Abhishek
>=20
> On Sat, Aug 29, 2015 at 2:13 AM, Josh Durgin <jdurgin@redhat.com <mailt=
o:jdurgin@redhat.com>> wrote:
>=20
>     On 08/28/2015 12:16 PM, Loic Dachary wrote:
>=20
>         Hi Abhishek,
>=20
>         We've just had an example of a backport merged into hammer alth=
ough it did not follow the procedure : https://github.com/ceph/ceph/pull/=
5691
>=20
>         It's a key aspect of backports : we're bound to follow procedur=
e, but developers are allowed to bypass it entirely. It may seem like som=
ething leading to chaos and frustration but it turns out to be exactly th=
e opposite. In a nutshell, it would be constant source of frustration for=
 developers to learn and obey the rules documented at http://tracker.ceph=
=2Ecom/projects/ceph-releases/wiki/HOWTO because it would not benefit the=
m significantly. It would also be a problem for us, backporters, because =
developers would not be as interested in backporting and our workload wou=
ld significantly increase.
>=20
>         When a developer prepares a backport on his / her own, we updat=
e the pull request and the issues to obey the procedure so the (s)he does=
 not have to. Sure, it's a little tedious but it's a small price to pay f=
or the benefit of having a backport being dealt with. That's what I did f=
or https://github.com/ceph/ceph/pull/5691 : updaging the corresponding is=
sues, adding cross references to the pull request.
>=20
>         Samuel Just felt confident enough about the backport that it di=
d not need a rados run to verify it does the right thing. Since it's ulti=
mately Sam's responsibility, that's also ok. The only thing we need to ke=
ep in mind when analyzing the next rados run is that this backport did no=
t pass yet. We don't have a way to mark commits that bypassed tests just =
yet, if you have ideas let us know :-)
>=20
>=20
>     That was me merging it based on my local testing. I'll keep an eye =
out
>     for any fallout in the hammer runs.
>=20
>     Thanks for keeping everything updated Loic!
>     Josh
>=20
>=20
>=20
> -----------------------------------------------------------------------=
-------------------------------------------------------------------
>=20
> This email and any files transmitted with it are confidential and inten=
ded solely for the use of the individual or entity to whom they are addre=
ssed. If you have received this email in error please notify the system m=
anager. This message contains confidential information and is intended on=
ly for the individual named. If you are not the named addressee you shoul=
d not disseminate, distribute or copy this e-mail. Please notify the send=
er immediately by e-mail if you have received this e-mail by mistake and =
delete this e-mail from your system. If you are not the intended recipien=
t you are notified that disclosing, copying, distributing or taking any a=
ction in reliance on the contents of this information is strictly prohibi=
ted. Although Flipkart has taken reasonable precautions to ensure no viru=
ses are present in this email, the company cannot accept responsibility f=
or any loss or damage arising from the use of this email or attachments
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--uagmuW45TjKKwmq17dqoCsoRj5OrAquBU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXhZ1kACgkQ8dLMyEl6F23mlgCePJS0yM+17F+xabIvO3HukOwD
/MUAnAj7xsw0JxaPqTm4l+Gzn/hBkt0F
=SiGX
-----END PGP SIGNATURE-----

--uagmuW45TjKKwmq17dqoCsoRj5OrAquBU--
