From: Loic Dachary <loic@dachary.org>
Subject: make check bot runs centos-7 and ubuntu-14.04
Date: Tue, 07 Apr 2015 15:06:37 +0200
Message-ID: <5523D65D.1070401@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="XiMwusJWl7ehDjuGm1RUJnkDlEJNTinrK"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:42735 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755110AbbDGNGs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Apr 2015 09:06:48 -0400
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id 38F29420A3
	for <ceph-devel@vger.kernel.org>; Tue,  7 Apr 2015 15:06:38 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XiMwusJWl7ehDjuGm1RUJnkDlEJNTinrK
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

As of today the make check bot that executes the run-make-check.sh comman=
d on pull requests (see https://github.com/ceph/ceph/pull/4284#issuecomme=
nt-90481256 for instance) will do it on ubuntu-14.04 in addition to cento=
s-7.=20

The bot formerly ran from https://about.gitlab.com/gitlab-ci/ and now run=
s from a dedicated http://jenkins-ci.org/ instance. The idea is for the b=
ot to run make check on centos-7 first. If it passes it will then do the =
same, in parallel, on all supported distributions. And once they all comp=
lete, a report is added to the pull requests with URLs to view the output=
 of each run.

If someone is interested in details, I'd be happy to discuss more ;-)

Cheers
--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--XiMwusJWl7ehDjuGm1RUJnkDlEJNTinrK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlUj1l0ACgkQ8dLMyEl6F22z5wCgk+tugUdESbg9udgjgh5BCoVo
LTgAmwchXFI5Vq2Fy2WgZRzlfvvWAGBk
=3sVE
-----END PGP SIGNATURE-----

--XiMwusJWl7ehDjuGm1RUJnkDlEJNTinrK--
