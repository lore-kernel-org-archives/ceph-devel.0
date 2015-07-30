From: Loic Dachary <loic@dachary.org>
Subject: merging pr 5311 was a noop
Date: Thu, 30 Jul 2015 22:15:27 +0200
Message-ID: <55BA85DF.2010907@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="82KaDVR6uvchUlrdjJLqaw8eXDg5lIcUu"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:59012 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751351AbbG3UPa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Jul 2015 16:15:30 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--82KaDVR6uvchUlrdjJLqaw8eXDg5lIcUu
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Yan,

This actually is an interesting case :-) Yesterday you merged https://git=
hub.com/ceph/ceph/pull/5311 into hammer-12088. But you did it after hamme=
r-12088 was merged into hammer ( https://github.com/ceph/ceph/pull/5222#i=
ssuecomment-125881146 ). Therefore the commit from pr 5311 never actually=
 made it to hammer.

Fortunately it's easy to sort out: you just need to review https://github=
=2Ecom/ceph/ceph/pull/5427 which has the same commit as https://github.co=
m/ceph/ceph/pull/5311 (I just took the liberty of editing the commit mess=
age to add <> around the mail name and a reference to the commit that int=
roduced the leak).

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--82KaDVR6uvchUlrdjJLqaw8eXDg5lIcUu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlW6hd8ACgkQ8dLMyEl6F21YcwCgxYzSJzh9nk9+ljLawAO1PPiV
srIAnAz1JQE80a69FHLIeU6eNkiz4Hth
=jxAy
-----END PGP SIGNATURE-----

--82KaDVR6uvchUlrdjJLqaw8eXDg5lIcUu--
