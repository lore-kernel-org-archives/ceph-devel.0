From: Loic Dachary <loic@dachary.org>
Subject: Re: hammer integration branch
Date: Sat, 29 Aug 2015 20:04:46 +0200
Message-ID: <55E1F43E.9000007@dachary.org>
References: <55E17F9E.4060507@dachary.org> <CAP3mxSzo1Bu0-f1HxaNw4KU3kqRC9DmNrfmAYYN+BhGisiHVsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="5IXb0hVPc9cdXX3vMMWRAMCLfNGf1sqot"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:45978 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751356AbbH2SEu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 29 Aug 2015 14:04:50 -0400
In-Reply-To: <CAP3mxSzo1Bu0-f1HxaNw4KU3kqRC9DmNrfmAYYN+BhGisiHVsw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek Varshney <abhishek.varshney@flipkart.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5IXb0hVPc9cdXX3vMMWRAMCLfNGf1sqot
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 29/08/2015 17:21, Abhishek Varshney wrote:
> Hi Loic,
>=20
> I have updated the tracker : http://tracker.ceph.com/issues/12701. Plea=
se review.
>=20
> Also, does it mean that the PRs in this integration branch are ready to=
 be merged to hammer now?

Not just yet. We've just confirmed that there is no issue with upgrades w=
hich is good. But we're still to analyze the results of the previous run =
at

http://tracker.ceph.com/issues/12701#teuthology-run-commit-e1dadd3da9e39d=
af669f94715c7833d2b280bbed-HAMMER-BACKPORTS-August-14


In a nutshell:

* http://tracker.ceph.com/issues/12701#fs pass and we can consider mergin=
g the CephFS pull requests

Unless I missed something, there is just one

* https://github.com/ceph/ceph/pull/5381

Since I authored the backport, we need to ask permission before merging. =
See

http://tracker.ceph.com/projects/ceph-releases/wiki/HOWTO_merge_commits_f=
rom_the_integration_branch

for how to do that. Would you like to do it ?

For the other suites, further analysis of the errors must be done to figu=
re out what's a false negative and what could be a genuine error.

Cheers

>=20
> Thanks
> Abhishek
>=20
> On Sat, Aug 29, 2015 at 3:17 PM, Loic Dachary <loic@dachary.org <mailto=
:loic@dachary.org>> wrote:
>=20
>     Hi Abhishek,
>=20
>     Good news : upgrade jobs pass when https://github.com/ceph/ceph/pul=
l/5361 is not included. We can set it aside for now :-)
>=20
>     Could you update your teuthology run results as explained at http:/=
/tracker.ceph.com/projects/ceph-releases/wiki/HOWTO_describe_a_test_resul=
t ? You should find that all failures are S3 related. We don't need to be=
 concerned about that, it's an OpenStack specific failure that needs to b=
e sorted out (http://tracker.ceph.com/issues/12471#note-4 probably).
>=20
>     Cheers
>     --
>     Lo=C3=AFc Dachary, Artisan Logiciel Libre
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


--5IXb0hVPc9cdXX3vMMWRAMCLfNGf1sqot
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXh9D4ACgkQ8dLMyEl6F20A7ACgrbsbegW0r5LkN5PAq5Ax7zKE
J/sAmwQXRKVHiMSqZ5xLol+7dKwuxdqC
=6S1c
-----END PGP SIGNATURE-----

--5IXb0hVPc9cdXX3vMMWRAMCLfNGf1sqot--
