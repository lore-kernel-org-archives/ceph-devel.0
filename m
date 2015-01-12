From: Loic Dachary <loic@dachary.org>
Subject: ceph_test_librbd_fsx fails with thrasher
Date: Mon, 12 Jan 2015 15:26:56 +0100
Message-ID: <54B3D9B0.2050906@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="2ks6sWT2M4uJTNghOAqN9XEG3rK5KUG94"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:37333 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751361AbbALO07 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Jan 2015 09:26:59 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2ks6sWT2M4uJTNghOAqN9XEG3rK5KUG94
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Josh,

While looking at errors from a giant (plus backports) run of the RBD suit=
e, I stumbled upon:

   http://tracker.ceph.com/issues/10513

and the error is unclear (at least to me ;-). Would you have an idea ? Fo=
r information the backports included are all the pull requests mentionned=
 at http://tracker.ceph.com/issues/10501.

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--2ks6sWT2M4uJTNghOAqN9XEG3rK5KUG94
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlSz2bAACgkQ8dLMyEl6F22XdwCeObVYvTSUEJDhZWH4GctRGg/d
asEAoKFTwY/3OBGyyxEUmnbvruCD53Nh
=746S
-----END PGP SIGNATURE-----

--2ks6sWT2M4uJTNghOAqN9XEG3rK5KUG94--
