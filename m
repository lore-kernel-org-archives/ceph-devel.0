From: Loic Dachary <loic@dachary.org>
Subject: hammer branch for v0.94.2 ready for QE
Date: Mon, 18 May 2015 14:42:12 +0200
Message-ID: <5559DE24.4010601@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="cQoxl7WtXUeeP7HDXO4TO3sHQlnwfUTRM"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:37057 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751025AbbERMmQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 May 2015 08:42:16 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Abhishek L <abhishek.lekshmanan@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cQoxl7WtXUeeP7HDXO4TO3sHQlnwfUTRM
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Yuri,

The hammer branch for v0.94.2 as found at https://github.com/ceph/ceph/co=
mmits/hammer has been approved by Greg, Yehuda, Josh and Sam and is ready=
 for QE. For the record, the head is https://github.com/ceph/ceph/commit/=
63832d4039889b6b704b88b86eaba4aadcfceb2e and the details of the tests run=
 are at http://tracker.ceph.com/issues/11492

Note that it has two more commits compared to what you tested before:

https://github.com/ceph/ceph/commit/293affe992118ed6e04f685030b2d83a794ca=
624 fixing http://tracker.ceph.com/issues/11622
https://github.com/ceph/ceph/commit/a43d24861089a02f3b42061e482e05016a002=
1f6 fixing http://tracker.ceph.com/issues/11604

which address two blockers that you listed at http://tracker.ceph.com/iss=
ues/11492#QE-Validation

These two new commits only have influence, directly or indirectly, on rgw=
=2E They do not require or deserve a new run of the rados, fs or rbd suit=
e because none of them depend on rgw, directly or indirectly.

The other two issues listed as blockers are

http://tracker.ceph.com/issues/11613#note-4 do not need a backport to ham=
mer
http://tracker.ceph.com/issues/11591 is a teuthology related issue that c=
an be worked around and does not need to be a blocker for hammer

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre









--cQoxl7WtXUeeP7HDXO4TO3sHQlnwfUTRM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVZ3iQACgkQ8dLMyEl6F205VACgh06A0GRtXNtqDCHuHPpdgq6g
FeMAoKXBSXPwxPh0tWFFql9SkrTVebOh
=Z/xW
-----END PGP SIGNATURE-----

--cQoxl7WtXUeeP7HDXO4TO3sHQlnwfUTRM--
