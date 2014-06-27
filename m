From: Loic Dachary <loic@dachary.org>
Subject: Recommended teuthology upgrade test
Date: Fri, 27 Jun 2014 17:16:41 +0200
Message-ID: <53AD8AD9.8030809@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="POwDrNLFg2H3aTIt8UqcoIfxreWvKf047"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:58647 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752794AbaF0PYb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 27 Jun 2014 11:24:31 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--POwDrNLFg2H3aTIt8UqcoIfxreWvKf047
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Sam,

TL;DR: what oneliner do you recommend to run upgrade tests for https://gi=
thub.com/ceph/ceph/pull/1890 ?=20

Running the rados suite can be done with :

   ./schedule_suite.sh rados wip-8071 testing loic@dachary.org basic mast=
er plana=20

or something else since ./schedule_suite.sh was recently obsoleted ( http=
://tracker.ceph.com/issues/8678 ). Running something similar for upgrade =
will presumably run all of https://github.com/ceph/ceph-qa-suite/tree/mas=
ter/suites/upgrade

Is there a way to run minimal tests by limiting the upgrade suite so that=
 it only focuses on a firefly cluster that upgrades to https://github.com=
/ceph/ceph/pull/1890 so that it checks the behavior when running a mixed =
cluster (firefly + master with the change) ?

It looks like http://pulpito.ceph.com/?suite=3Dupgrade was never run ( at=
 least that's what appears to cause http://tracker.ceph.com/issues/8681 )=
 Is http://pulpito.ceph.com/?suite=3Dupgrade-rados a good fit ? If so is =
there a way to figure out how it was created ?

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--POwDrNLFg2H3aTIt8UqcoIfxreWvKf047
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlOtitkACgkQ8dLMyEl6F21/uwCdE/tLMMmq1L2Dxsi2wPeVIK0N
oVQAoKkSkw9qmWj4ZO58iUbeEDDil3iF
=x3kw
-----END PGP SIGNATURE-----

--POwDrNLFg2H3aTIt8UqcoIfxreWvKf047--
