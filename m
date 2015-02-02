From: Loic Dachary <loic@dachary.org>
Subject: workloads/rbd_fsx_cache_writethrough.yaml hangs on dumpling
Date: Mon, 02 Feb 2015 14:18:31 +0100
Message-ID: <54CF7927.7010908@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="9igkI49MUWUCxUtmaqiUugcUAsnep1bL2"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:51219 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753790AbbBBNSd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Feb 2015 08:18:33 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jason Dillaman <dillaman@redhat.com>, Josh Durgin <jdurgin@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9igkI49MUWUCxUtmaqiUugcUAsnep1bL2
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

http://pulpito.ceph.com/loic-2015-01-29_15:39:38-rbd-dumpling-backports--=
-basic-multi/730029/ hangs on dumpling and got killed after two days.

Although workloads/rbd_fsx_cache_writethrough.yaml  was running with the =
thrasher, it does not seem to be related to http://tracker.ceph.com/issue=
s/10513 : it was running on a mira070 (16GB RAM) and plana78 (8GB RAM).=20

I don't see anything in https://github.com/ceph/ceph-qa-suite/blob/master=
/tasks/rbd_fsx.py that would suggest it needs backporting a fix to the ce=
ph-qa-suite branch of dumpling.

I browsed the commits related to RBD that are in the dumpling-backports b=
ranch ( see here for the list I used http://tracker.ceph.com/issues/10560=
 ). I don't see anything in the issues that need backporting to dumpling =
either.=20

Another run of this specific test has been scheduled to check if it alway=
s happens at http://pulpito.ceph.com/loic-2015-02-02_13:58:32-rbd:thrash:=
workloads:rbd_fsx_cache_writethrough.yaml-dumpling-backports---basic-mult=
i/

Does that ring a bell by any chance ?

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--9igkI49MUWUCxUtmaqiUugcUAsnep1bL2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTPeScACgkQ8dLMyEl6F229nQCfQxU2NbDGjjAn7/xkdi4pu9DH
FPoAnA4/hjN8vKcZYT3G6bqij0so8shB
=smIK
-----END PGP SIGNATURE-----

--9igkI49MUWUCxUtmaqiUugcUAsnep1bL2--
