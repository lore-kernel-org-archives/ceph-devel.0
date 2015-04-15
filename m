From: Loic Dachary <loic@dachary.org>
Subject: make check bot paused
Date: Wed, 15 Apr 2015 13:55:17 +0200
Message-ID: <552E51A5.2060501@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="QH9cUdOBWk5wAkNQ3WNq3u7CBcuXwpwN7"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:47090 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754633AbbDOLz2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Apr 2015 07:55:28 -0400
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id C2A2642B23
	for <ceph-devel@vger.kernel.org>; Wed, 15 Apr 2015 13:55:17 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QH9cUdOBWk5wAkNQ3WNq3u7CBcuXwpwN7
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

The make check bot [1] that executes run-make-check.sh [2] on pull reques=
ts and reports results as comments [3] is experiencing problems. It may b=
e a hardware issue and the bot is paused while the issue is investigated =
[4] to avoid sending confusing false negatives. In the meantime the run-m=
ake-check.sh [2] script can be run locally, before sending the pull reque=
st, to confirm the commits to be sent do not break them. It is expected t=
o run in less than 15 minutes including compilation on a fast machine wit=
h a SSD (or RAM disk) and 8 cores and 32GB of RAM and may take up to two =
hours on a machine with a spinner and two cores.

Thanks for your patience.

Cheers

[1] bot running on pull requests http://jenkins.ceph.dachary.org/job/ceph=
/
[2] run-make-check.sh http://workbench.dachary.org/ceph/ceph/blob/master/=
run-make-check.sh
[3] make check results example : https://github.com/ceph/ceph/pull/3946#i=
ssuecomment-93286840
[4] possible RAM failure http://tracker.ceph.com/issues/11399
--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--QH9cUdOBWk5wAkNQ3WNq3u7CBcuXwpwN7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlUuUaUACgkQ8dLMyEl6F22WmACgsK0QxZ69KB+gRLnRLmQbrv4O
7c4AoLypSPDXp/6I7e+Cd6QGkJt3XYKt
=x0Sk
-----END PGP SIGNATURE-----

--QH9cUdOBWk5wAkNQ3WNq3u7CBcuXwpwN7--
