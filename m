From: Loic Dachary <loic@dachary.org>
Subject: Firefly integration branch : OK
Date: Mon, 27 Apr 2015 10:05:39 +0200
Message-ID: <553DEDD3.2030202@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="P2elooP6HU9jG9bUF76visRbBfa81KeSh"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:53044 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751384AbbD0IFn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Apr 2015 04:05:43 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Shu, Xinxin" <xinxin.shu@intel.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--P2elooP6HU9jG9bUF76visRbBfa81KeSh
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

I saw this morning the firefly integration branch passed rados and rbd su=
ites :-)=20

http://tracker.ceph.com/issues/11090#rados
http://tracker.ceph.com/issues/11090#rbd

The issue has been updated accordingly. It means the following pull reque=
sts passed:

$ git log --merges --oneline 12143ff9b25fdd96f8d1a9cecb1329c7f354d414..b9=
1bbb434e6363a99a632cf3841f70f1f2549f79
b91bbb4 Merge 4245: librbd: snap_remove should ignore -ENOENT errors
6245bed Merge 4206: librbd: acquire cache_lock before refreshing parent
ef08aa9 Merge 4185: FAILED assert(soid < scrubber.start || soid >=3D scru=
bber.end)
ae1b18a Merge 3963: Rados.shutdown() dies with Illegal instruction (core =
dumped)
056db0f Merge 4385: osd: ENOENT on clone
e4b1fd1 Merge 4384: pg stuck stale after create with activation delay
597124b Merge 4383: erasure-code-profile set races with erasure-code-prof=
ile rm
b7bbd43 Merge 4382: osd/PGLog.h: 279: FAILED assert(log.log.size() =3D=3D=
 log_keys_debug.size())

Ouf ot these, three are backports ready to be reviewed by their original =
authors:

056db0f Merge 4385: osd: ENOENT on clone https://github.com/ceph/ceph/pul=
l/4385
e4b1fd1 Merge 4384: pg stuck stale after create with activation delay htt=
ps://github.com/ceph/ceph/pull/4384
b7bbd43 Merge 4382: osd/PGLog.h: 279: FAILED assert(log.log.size() =3D=3D=
 log_keys_debug.size())

The simplest way would be to ask for their review with a comment in the p=
ull request, with a reference to the test suite results so they know it p=
assed the suites. Will you have time to do this today ? If you don't have=
 time, just let me know and I'll do it for you.

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--P2elooP6HU9jG9bUF76visRbBfa81KeSh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlU97dMACgkQ8dLMyEl6F22RHQCcDbnhlpYIJmx8z5oVHPGtPHo0
NVsAoKBxYhjQ+sAPUMQu/aLWWZRtBMBM
=yxHc
-----END PGP SIGNATURE-----

--P2elooP6HU9jG9bUF76visRbBfa81KeSh--
