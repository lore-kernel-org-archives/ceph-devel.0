From: Loic Dachary <loic@dachary.org>
Subject: Running the rbd suite on OpenStack
Date: Wed, 30 Sep 2015 23:34:59 +0200
Message-ID: <560C5583.9070005@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="WtXffxEWdVb6p0HcTrbolF388blL4Ulq8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:35453 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754995AbbI3VfC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Sep 2015 17:35:02 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jason Dillaman <dillaman@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WtXffxEWdVb6p0HcTrbolF388blL4Ulq8
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Jason,

The hammer rbd suite runs ok. The infernalis rbd suite revealed a few iss=
ues (the details are at http://tracker.ceph.com/issues/13270):

CentOS 7 and Ubuntu 14.04 : http://tracker.ceph.com/issues/13310=20

CentOS 7 specific: http://tracker.ceph.com/issues/13309 and http://tracke=
r.ceph.com/issues/13308

Note that they also happen when running on a VPS in the Sepia lab which i=
s convenient for fixing them with no access to an OpenStack tenant.

There also is an ansible issue: http://tracker.ceph.com/issues/13305 and =
a teuthology issue: http://tracker.ceph.com/issues/13187.

One job needs more than the default 40GB disk ( rbd/qemu/{cache/none.yaml=
 cachepool/none.yaml clusters/fixed-3.yaml fs/btrfs.yaml msgr-failures/fe=
w.yaml workloads/qemu_xfstests.yaml} ) each OpenStack instance is given (=
http://tracker.ceph.com/issues/13270):=20

I'm not sure which priority these issues should be given so I set them to=
 Normal. The goal was to figure out how much work is required on the RBD =
suite to make it run solely on OpenStack. All in all it's not too bad :)

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--WtXffxEWdVb6p0HcTrbolF388blL4Ulq8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlYMVYMACgkQ8dLMyEl6F23lVwCgvUPbvxyaLRfIqaCtMhujkoWc
g98AoKtP/i6RZ8/qp0tZ/6LYTa/dHScN
=7t66
-----END PGP SIGNATURE-----

--WtXffxEWdVb6p0HcTrbolF388blL4Ulq8--
