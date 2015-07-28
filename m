From: Loic Dachary <loic@dachary.org>
Subject: ceph.spec.in suse modifications in hammer
Date: Tue, 28 Jul 2015 23:05:37 +0200
Message-ID: <55B7EEA1.9060406@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="8LkJjWP1wBQE7cjh0131P3tibABXhHRTl"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:57829 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752714AbbG1VFl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Jul 2015 17:05:41 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>, Owen Synge <osynge@suse.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8LkJjWP1wBQE7cjh0131P3tibABXhHRTl
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Nathan & Owen,

A number of backports related to ceph.spec.in went in hammer today. A lar=
ge number deal with SUSE specific changes and it would be great if you co=
uld run an upgrade suite on SUSE to verify all is well.

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--8LkJjWP1wBQE7cjh0131P3tibABXhHRTl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlW37qEACgkQ8dLMyEl6F20xHwCeJ+kIGfvg56zcJeGB2B85U8KH
hYsAnjladfGokBdMHWtvAHo5ZGo62D1t
=X87z
-----END PGP SIGNATURE-----

--8LkJjWP1wBQE7cjh0131P3tibABXhHRTl--
