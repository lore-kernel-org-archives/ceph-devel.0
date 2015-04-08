From: Loic Dachary <loic@dachary.org>
Subject: Backporting to Firefly
Date: Wed, 08 Apr 2015 11:22:05 +0200
Message-ID: <5524F33D.9010303@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="w8FW2BAxvbmgPu9s9q47lhhxcv0T0JuAR"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:43274 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751662AbbDHJWK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Apr 2015 05:22:10 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Shu, Xinxin" <xinxin.shu@intel.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--w8FW2BAxvbmgPu9s9q47lhhxcv0T0JuAR
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

I see you have been busy backporting issues to Firefly today, this is gre=
at :-)=20

https://github.com/ceph/ceph/pulls/xinxinsh

It would be helpful if you could update the pull requests (and the corres=
ponding issues) as explained at http://tracker.ceph.com/projects/ceph-rel=
eases/wiki/HOWTO_backport_commits.=20

Once it's done I propose we move to the next step, as explained at http:/=
/tracker.ceph.com/projects/ceph-releases/wiki/HOWTO: merging your pull re=
quests in the integration branch ( step 5 http://tracker.ceph.com/project=
s/ceph-releases/wiki/HOWTO_populate_the_integration_branch ) and running =
tests on them ( step 6 http://tracker.ceph.com/projects/ceph-releases/wik=
i/HOWTO_run_integration_and_upgrade_tests).

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--w8FW2BAxvbmgPu9s9q47lhhxcv0T0JuAR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlUk8z0ACgkQ8dLMyEl6F20VBACfePWAtd+qYGaKnoct3zPotdsB
QaAAn2XJeBxmxkqPEj5khi+wMBWnrxT0
=DNK1
-----END PGP SIGNATURE-----

--w8FW2BAxvbmgPu9s9q47lhhxcv0T0JuAR--
