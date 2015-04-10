From: Loic Dachary <loic@dachary.org>
Subject: preparing hammer v0.94.1
Date: Fri, 10 Apr 2015 12:06:58 +0200
Message-ID: <5527A0C2.8090403@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="PLaQssc9odTN0qXcp6QgrcR9SUeXHjD2K"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:44652 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754443AbbDJKHB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Apr 2015 06:07:01 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, LOPEZ Jean-Charles <jelopez@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PLaQssc9odTN0qXcp6QgrcR9SUeXHjD2K
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Sage,

The draft release notes are at https://github.com/ceph/ceph/pull/4330. A =
minimal (34 jobs, no thrasher or file system variation) was scheduled at =
http://pulpito.ceph.com/loic-2015-04-10_11:51:30-rados-hammer-backports--=
-basic-multi/ with a high priority, including a backport of the v4 bucket=
 feature detection fix from https://github.com/ceph/ceph/pull/4322. The b=
ackport is in the https://github.com/ceph/ceph/tree/hammer-backports inte=
gration branch which contains:

$ git log --graph --oneline ceph/master..ceph/hammer-backports
*   2d03afb Merge 4328: DNM: v4 bucket feature detection
|\ =20
| * 087c160 crush: fix has_v4_buckets()
| * 8e8cccc crush: fix dump of has_v4_buckets
|/ =20
* b5921d5 crush/mapper: fix divide-by-0 in straw2
* 93c8f43 osd: fix negative degraded objects during backfilling

The issue tracking progress for v0.94.1 is http://tracker.ceph.com/issues=
/11353

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--PLaQssc9odTN0qXcp6QgrcR9SUeXHjD2K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlUnoMIACgkQ8dLMyEl6F21iiQCgg0s7xe3c8HvJII7NbJij6SdN
o7MAn1RH3W/6GHGI5wuZwLJIh2MXdQI4
=Z5H7
-----END PGP SIGNATURE-----

--PLaQssc9odTN0qXcp6QgrcR9SUeXHjD2K--
