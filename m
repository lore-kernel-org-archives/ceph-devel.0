From: Loic Dachary <loic@dachary.org>
Subject: gitbuilder make check errors
Date: Mon, 16 Dec 2013 10:46:05 +0100
Message-ID: <52AECBDD.9000705@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="tULS7bBNCnBCjXTxslVskECfQIuGiFqAE"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:41359 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751768Ab3LPJqH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Dec 2013 04:46:07 -0500
Received: from [10.9.0.6] (openvpn.novalocal [10.145.3.13])
	by smtp.dmail.dachary.org (Postfix) with ESMTPS id 3B56926394
	for <ceph-devel@vger.kernel.org>; Mon, 16 Dec 2013 10:46:06 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tULS7bBNCnBCjXTxslVskECfQIuGiFqAE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

http://gitbuilder.sepia.ceph.com/gitbuilder-ceph-tarball-saucy-amd64-basi=
c/log.cgi?log=3D58d68995c4b09c0ec10cd80cd2e16bdb4fdfffc8

Shows a failure. However the output of make check is hidden in the log fi=
les. Would it be possible to display the content of the log files if an e=
rror happens ?

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--tULS7bBNCnBCjXTxslVskECfQIuGiFqAE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlKuy90ACgkQ8dLMyEl6F23y4ACfR+AbHEfNE/Cc1UsqNJgZ+dGZ
MIAAoKgBUfAwSIQZlofkEjhezytYAdYs
=VHtk
-----END PGP SIGNATURE-----

--tULS7bBNCnBCjXTxslVskECfQIuGiFqAE--
