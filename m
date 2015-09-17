From: Loic Dachary <loic@dachary.org>
Subject: install-deps.sh failures on Ubuntu 14.04
Date: Thu, 17 Sep 2015 09:46:14 +0200
Message-ID: <55FA6FC6.9090105@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="RmhIpCHXVf4lwGl6lmaG28oj944I0AMCS"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:56760 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753528AbbIQHqX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Sep 2015 03:46:23 -0400
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id AF4594210B
	for <ceph-devel@vger.kernel.org>; Thu, 17 Sep 2015 09:46:14 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RmhIpCHXVf4lwGl6lmaG28oj944I0AMCS
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

Because a bug appeared in the last 24h when running pip wheel coverage wi=
th python3[1], the install-deps.sh[2] script now fails on Ubuntu 14.04. T=
his causes failure on http://ceph.com/gitbuilder.cgi as well as the make =
check bot that runs on pull requests.

A workaround is prepared at http://tracker.ceph.com/issues/13136

Cheers

[1] pip wheel coverage fails with python3 https://bugs.launchpad.net/ubun=
tu/+source/python-coverage/+bug/1496715
[2] install-deps.sh https://github.com/ceph/ceph/blob/master/install-deps=
=2Esh

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--RmhIpCHXVf4lwGl6lmaG28oj944I0AMCS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlX6b8YACgkQ8dLMyEl6F20iTQCeO9yVRdojzxQMC0tezodxf9TE
iSIAn0oZxKYelGYTC/vphmkrCkSfwezI
=jlRO
-----END PGP SIGNATURE-----

--RmhIpCHXVf4lwGl6lmaG28oj944I0AMCS--
