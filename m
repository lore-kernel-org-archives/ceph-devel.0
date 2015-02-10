From: Loic Dachary <loic@dachary.org>
Subject: dumpling integration branch for v0.67.12 ready for QE
Date: Tue, 10 Feb 2015 18:05:31 +0100
Message-ID: <54DA3A5B.5050509@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="15vTVUKJSPObIrHW9ec1HNF44KdvaqCoN"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:41868 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750726AbbBJRFf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Feb 2015 12:05:35 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--15vTVUKJSPObIrHW9ec1HNF44KdvaqCoN
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Yuri,

The dumpling integration branch for v0.67.12 as found at https://github.c=
om/ceph/ceph/commits/dumpling-backports has been approved by Yehuda, Josh=
 and Sam and is ready for QE.=20

For the record, the head is https://github.com/ceph/ceph/commit/3944c77c4=
04c4a05886fe8276d5d0dd7e4f20410

I think it would be best for the QE tests to use the dumpling-backports. =
The alternative would be to merge dumpling-backports into dumpling. Howev=
er, since testing may take a long time and require more patches, it proba=
bly is better to not do that iterative process on the dumpling branch its=
elf. As it is now, there already are a number of commits in the dumpling =
branch that should really be in the dumpling-backports: they do not belon=
g to v0.67.11 and are going to be released in v0.67.12. In the future tho=
ugh, the dumpling branch will only receive commits that have been careful=
ly tested and all the integration work will be on the dumpling-backports =
branch exclusively. So that third parties do not have to worry that the d=
umpling branch contains commits that have not been tested yet.

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--15vTVUKJSPObIrHW9ec1HNF44KdvaqCoN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTaOlsACgkQ8dLMyEl6F20LLgCfY0sc6hkFeqK3sp6iD1yP5w0r
UW4An2dAUzK2jRippTcjrEspszRWVGZt
=dtBw
-----END PGP SIGNATURE-----

--15vTVUKJSPObIrHW9ec1HNF44KdvaqCoN--
