From: Loic Dachary <loic@dachary.org>
Subject: Reducing backfilling/recovery long tail
Date: Fri, 12 Dec 2014 16:16:34 +0100
Message-ID: <548B06D2.90609@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="fJM1wkJ55O3BfkcpLi2pt4htGk5HlKsEV"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:52024 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933263AbaLLPQg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Dec 2014 10:16:36 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>, Sage Weil <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fJM1wkJ55O3BfkcpLi2pt4htGk5HlKsEV
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Sam & Sage,

In the context of http://tracker.ceph.com/issues/9566 I'm inclined to thi=
nk the best solution would be that the AsyncReserver choose a PG instead =
of just picking the next one in the list when there is a free slot. It wo=
uld always choose a PG that must move to/from an OSDs for which there are=
 more PGs waiting in the AsyncRerserver than any other OSD. The sort invo=
lved does not seem too expensive.

Calculating priorities before adding the PG to the AsyncReserver seems wr=
ong because the state of the system will change significantly while the P=
G is waiting to be processed. For instance the first PGs to be added have=
 a low priority while the next have increasing priorities when they accum=
ulate. If reservations are canceled because the OSD map changed again (ma=
ybe another OSD is decommissioned before recovery of the first one comple=
tes), you may end up having high priorities for PGs that are no longer as=
sociated with busy OSDs. That could backfire and create even more frequen=
t long tails.

What do you think ?

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--fJM1wkJ55O3BfkcpLi2pt4htGk5HlKsEV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlSLBtIACgkQ8dLMyEl6F221LwCghsacQQ4idxQ1XExG+rJy5UQp
JcEAnj2bYKP0l9Mxbc3VTn4yQqvtRJfA
=2BsI
-----END PGP SIGNATURE-----

--fJM1wkJ55O3BfkcpLi2pt4htGk5HlKsEV--
