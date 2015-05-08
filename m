From: Loic Dachary <loic@dachary.org>
Subject: long running workloads/rbd_fsx_cache_writeback.yaml on hammer
Date: Fri, 08 May 2015 11:07:49 +0200
Message-ID: <554C7CE5.4070600@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="n3f8KoqHELF1j75HwsMqSEB8FldvqN0h7"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:59816 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752075AbbEHJHy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 May 2015 05:07:54 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jason Dillaman <dillaman@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--n3f8KoqHELF1j75HwsMqSEB8FldvqN0h7
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Janson,

There is a long running (12h +) job at

http://pulpito.ceph.com/loic-2015-05-07_09:46:27-rbd-hammer-backports---b=
asic-multi/878799/

which is about

 rbd/thrash/{base/install.yaml clusters/fixed-2.yaml fs/xfs.yaml msgr-fai=
lures/few.yaml thrashers/default.yaml workloads/rbd_fsx_cache_writeback.y=
aml}=20

and runs on the current hammer-backports branch which contains a few libr=
bd backports

http://tracker.ceph.com/issues/11492#Teuthology-run-commit-commita79146fc=
3cae28bf4c07478fb4566b06942da60d-hammer-backports-branch-May-2015

I don't see an obvious cause for error in the logs. Does it ring a bell ?=
 Is it supposed to take that long ? Note that all other jobs completed su=
ccessfully (see http://pulpito.ceph.com/loic-2015-05-07_09:46:27-rbd-hamm=
er-backports---basic-multi/ for details).

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--n3f8KoqHELF1j75HwsMqSEB8FldvqN0h7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVMfOUACgkQ8dLMyEl6F22E6wCeObZz4l2Ri7M0BcNBkp2tA39U
HiUAn2xBmQ8tviWozNpbnhUM61Tg87Kr
=aogD
-----END PGP SIGNATURE-----

--n3f8KoqHELF1j75HwsMqSEB8FldvqN0h7--
