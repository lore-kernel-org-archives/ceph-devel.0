From: Loic Dachary <loic@dachary.org>
Subject: automated make check, now on centos7
Date: Sun, 11 Jan 2015 13:56:19 +0100
Message-ID: <54B272F3.6080300@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="EbcjmbJF5JuCajhmQJnNjQHWeQDDhIiBD"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:36724 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751803AbbAKM4V (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 11 Jan 2015 07:56:21 -0500
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id 681FF4291B
	for <ceph-devel@vger.kernel.org>; Sun, 11 Jan 2015 13:56:19 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EbcjmbJF5JuCajhmQJnNjQHWeQDDhIiBD
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

The bot that runs "make check" on pull requests moved from running them i=
n a Ubuntu 14.04 container (itself running on a Fedora 20 bare metal) to =
running in a Centos 7 container. The operating system shows in the messag=
e posted on GitHub like so:

https://github.com/ceph/ceph/pull/3194#issuecomment-69491205

Once it's stable the idea is to run both (Ubuntu 14.04 and Centos 7) simu=
ltaneously to get more input on cross distribution problems.

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--EbcjmbJF5JuCajhmQJnNjQHWeQDDhIiBD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlSycvMACgkQ8dLMyEl6F21EmQCeP6Ng1Az2N3kTqkbRvJ4nBjFk
wF8AoIB1M51cn6y6oH/1WBc2xP2bW6NB
=8Cw1
-----END PGP SIGNATURE-----

--EbcjmbJF5JuCajhmQJnNjQHWeQDDhIiBD--
