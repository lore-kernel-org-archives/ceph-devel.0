From: Loic Dachary <loic@dachary.org>
Subject: verifying rpm packages for v0.80.11
Date: Wed, 02 Sep 2015 07:47:27 +0200
Message-ID: <55E68D6F.5050506@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="OpVI4rNO71LQU6lAxlvhAHXuJVuQmi4rk"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:47933 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751110AbbIBFre (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Sep 2015 01:47:34 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OpVI4rNO71LQU6lAxlvhAHXuJVuQmi4rk
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Nathan,

In order to verify that the ceph.spec.in change do not introduce a regres=
sion in v0.80.11, I scheduled an upgrade/firefly suite on CentOS 6 ( http=
://tracker.ceph.com/issues/11644#upgrade) and a ceph-deploy suite on all =
supported distributions (because we did not do it before http://tracker.c=
eph.com/issues/11644#ceph-deploy).=20

https://github.com/ceph/ceph/pull/5217
https://github.com/ceph/ceph/pull/5224
https://github.com/ceph/ceph/pull/5225

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--OpVI4rNO71LQU6lAxlvhAHXuJVuQmi4rk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXmjW8ACgkQ8dLMyEl6F23+AQCgnArRxL7/hW0dlaJMN4bHhgkb
XekAoLNJtPL/3y0IXoOlmqmAM9YUIbFx
=D8wu
-----END PGP SIGNATURE-----

--OpVI4rNO71LQU6lAxlvhAHXuJVuQmi4rk--
