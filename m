From: Loic Dachary <loic@dachary.org>
Subject: paddles query
Date: Sat, 28 Feb 2015 16:23:28 +0100
Message-ID: <54F1DD70.2000909@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="FehS7mLNVtISsnipFIQFp2t2umnVRva0x"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:50581 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751615AbbB1PXb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 28 Feb 2015 10:23:31 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zack Cerza <zack@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FehS7mLNVtISsnipFIQFp2t2umnVRva0x
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Zack,

Is there a way to ask paddles / pulpito ( http://pulpito.ceph.com/ ) for =
the list of failed/dead jobs in a given suite ? Here is a fiction example=
:

$ paddles --failed-or-dead http://pulpito.ceph.com/loic-2015-02-28_11:45:=
50-fs-firefly-backports---basic-multi/
http://pulpito.ceph.com/loic-2015-02-28_11:45:50-fs-firefly-backports---b=
asic-multi/783076
http://pulpito.ceph.com/loic-2015-02-28_11:45:50-fs-firefly-backports---b=
asic-multi/783102
http://pulpito.ceph.com/loic-2015-02-28_11:45:50-fs-firefly-backports---b=
asic-multi/783093

I would like to then grep 'description:' from the corresponding teutholog=
y.log and re-schedule those corresponding to environment failures with te=
uthology-suite --filter ( as in http://tracker.ceph.com/issues/10945#note=
-1 ). If you have a better way to achieve that, please let me know ;-)

Cheers
--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--FehS7mLNVtISsnipFIQFp2t2umnVRva0x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTx3XAACgkQ8dLMyEl6F22qkACdF6hjcfgwC+W1qmiV4oRfYcgV
6cMAoJ3as1otJd0dhVnLNpJDHLiS5aF1
=AMH7
-----END PGP SIGNATURE-----

--FehS7mLNVtISsnipFIQFp2t2umnVRva0x--
