From: Loic Dachary <loic@dachary.org>
Subject: reducing the size of Ceph debug packages
Date: Mon, 14 Sep 2015 10:35:38 +0200
Message-ID: <55F686DA.5000606@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="2IMfs3OoaxpsfnNK9J4r8XNmAJ8BlwArp"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:54944 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752291AbbINIfn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Sep 2015 04:35:43 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: James Page <james.page@ubuntu.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2IMfs3OoaxpsfnNK9J4r8XNmAJ8BlwArp
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi James,

https://fedoraproject.org/wiki/Features/DwarfCompressor is packaged for U=
buntu (http://packages.ubuntu.com/trusty/dwz) and could be used to reduce=
 the size of the Ceph debug packages. This is how it's done for RPM : htt=
ps://github.com/ceph/autobuild-ceph/commit/193864ec69edb4dbb0112bb3ea54e6=
d2f20b30dd but I could not find a  page explaining how to do the same for=
 Ubuntu. Do you happen to have more information on that topic ?

About half the time required to build Ceph packages is used to compress t=
he debug packages (ceph-dbg, ceph-test-dbg) and it would be great if we c=
ould reduce that :-)

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--2IMfs3OoaxpsfnNK9J4r8XNmAJ8BlwArp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlX2htoACgkQ8dLMyEl6F20P6wCgh33eEvi333pPRZ4XFupy8rIF
kr0An3FF9SChnTkFUij3H2FZGMJXcxpt
=1bcQ
-----END PGP SIGNATURE-----

--2IMfs3OoaxpsfnNK9J4r8XNmAJ8BlwArp--
