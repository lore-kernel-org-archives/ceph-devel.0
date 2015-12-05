From: Loic Dachary <loic@dachary.org>
Subject: new OSD re-using old OSD id fails to boot
Date: Sat, 5 Dec 2015 17:49:17 +0100
Message-ID: <5663158D.1010302@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="b2v8SJUgosVmoJlTWUruVpgk125d2b4Aj"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:44796 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753746AbbLEQtV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 5 Dec 2015 11:49:21 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--b2v8SJUgosVmoJlTWUruVpgk125d2b4Aj
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Sage,

The problem described at "new OSD re-using old OSD id fails to boot" http=
://tracker.ceph.com/issues/13988 consistently fails the ceph-disk suite o=
n master. I wonder if it could be a side effect of the recent optimizatio=
ns introduced in the monitor ?

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--b2v8SJUgosVmoJlTWUruVpgk125d2b4Aj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlZjFY0ACgkQ8dLMyEl6F23+7ACfdJq3hTBNMtpiZDVujDd4iEJy
zKEAn3JmMrLUs4pArGnfatkpKWDkeeA6
=VHIU
-----END PGP SIGNATURE-----

--b2v8SJUgosVmoJlTWUruVpgk125d2b4Aj--
