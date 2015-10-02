From: Loic Dachary <loic@dachary.org>
Subject: rados and the next hammer release v0.94.4
Date: Fri, 02 Oct 2015 22:35:14 +0200
Message-ID: <560EEA82.7060503@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="PXXE4JG4Qqrx9Ce2GVR9F2dRNt6Fl06bi"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:36670 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750944AbbJBUfR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Oct 2015 16:35:17 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Abhishek Varshney <abhishek.varshney@flipkart.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PXXE4JG4Qqrx9Ce2GVR9F2dRNt6Fl06bi
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Sam,

The next hammer release as found at https://github.com/ceph/ceph/tree/ham=
mer passed the rados suite (http://tracker.ceph.com/issues/12701#note-62)=
=2E Do you think the hammer branch is ready for QE to start their own rou=
nd of testing ?

Cheers

P.S. http://tracker.ceph.com/issues/12701#Release-information has direct =
links to the pull requests merged into hammer since v0.94.3 in case you n=
eed more context about one of them.

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre




















--PXXE4JG4Qqrx9Ce2GVR9F2dRNt6Fl06bi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlYO6oIACgkQ8dLMyEl6F20vLgCfQW7odOpYQ8ONVurl3IMr5vVB
YxMAoKcOkXxfl+LCQMF+Ut4sMvDSIWYv
=Ewmz
-----END PGP SIGNATURE-----

--PXXE4JG4Qqrx9Ce2GVR9F2dRNt6Fl06bi--
