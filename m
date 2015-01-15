From: Loic Dachary <loic@dachary.org>
Subject: Re: upcoming release giant v0.87.1 : leads feedback needed
Date: Thu, 15 Jan 2015 18:03:27 +0100
Message-ID: <54B7F2DF.9060003@dachary.org>
References: <54B7E6DC.8010905@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="MeMJQxCcHBIqnHx73Ww8T6ATmLFxmBHOU"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:41135 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755354AbbAORD3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Jan 2015 12:03:29 -0500
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id BA60742B25
	for <ceph-devel@vger.kernel.org>; Thu, 15 Jan 2015 18:03:27 +0100 (CET)
In-Reply-To: <54B7E6DC.8010905@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MeMJQxCcHBIqnHx73Ww8T6ATmLFxmBHOU
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Again,

Well, this is a little embarassing but here it is : there won't be a poin=
t release for giant. I'll update the redmine tickets to remove the "giant=
" backport targets as well as the github milestone list accordingly.

Sorry for the noise.

On 15/01/2015 17:12, Loic Dachary wrote:
> Hi Ceph,
>=20
> The https://github.com/ceph/ceph/tree/giant-backports branch was tested=
 with the rgw, rados and rbd suites. The results of each suite have been =
analyzed and summarized in http://tracker.ceph.com/issues/10501. The next=
 steps are either:
>=20
> a) Yehuda for rgw, Josh for rbd and Sam for rados all agree that the er=
rors are unrelated to the backports
> b) The https://github.com/ceph/ceph/tree/giant-backports branch is give=
n to QE for final tests and merge into giant
>=20
> OR
>=20
> a) At least of the lead thinks more work is needed to stabilize the gia=
nt branch
> b) A new set of tests will be run and analyzed after adding/removing on=
e or more backports to/from the https://github.com/ceph/ceph/tree/giant-b=
ackports branch
>=20
> The description of http://tracker.ceph.com/issues/10501 shows a detaile=
d list of all commits / issues that are in the giant backport branch. To =
get a global view of what the next giant point release will be, the descr=
iption also includes the commits that have already been merged in the gia=
nt branch. The list of pull requests that are candidate for inclusion in =
the giant release but have not been included in the integration branch ar=
e also listed: maybe one of them could contribute to resolve a problem fo=
und during the tests. And finally all redmine issues that have been marke=
d to be backported to giant but do not yet have a candidate pull request =
are listed: this is the backport backlog so to speak ;-)
>=20
> Cheers
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--MeMJQxCcHBIqnHx73Ww8T6ATmLFxmBHOU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlS38t8ACgkQ8dLMyEl6F2266QCfYi9FHRvn6RNywVc3ye6h0CJ8
CvAAnjM0S+wTKhtBDdKov7ZQrLuNvp2s
=kw8f
-----END PGP SIGNATURE-----

--MeMJQxCcHBIqnHx73Ww8T6ATmLFxmBHOU--
