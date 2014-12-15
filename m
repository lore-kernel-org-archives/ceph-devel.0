From: Loic Dachary <loic@dachary.org>
Subject: Improving latency and ordering of the backfilling workload
Date: Mon, 15 Dec 2014 15:24:44 +0100
Message-ID: <548EEF2C.1010703@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="3vEAI3Wd3Om1smSD78PJr5GFpMVlUJHCq"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:53221 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750711AbaLOOYq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Dec 2014 09:24:46 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3vEAI3Wd3Om1smSD78PJr5GFpMVlUJHCq
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Sam,

Here is what could be done (in the context of http://tracker.ceph.com/iss=
ues/9566
), please let me know if that makes sense:

* ordering:

  * when dequeuing a pending local reservation, chose one that contains a=
 PG that belongs to the busiest OSD (i.e. the OSD for which there are mor=
e PGs waiting for a local reservation than any other)
  * when sending a remote reservation request, set the priority to reflec=
t the total number of pending PG (absolute workload) and the number local=
 pending PG for the destination OSD (workload queued locally for the remo=
te OSD)
  * on the receiving side, the priority of the remote reservation request=
 makes sure the busiest OSD gets a remote reservation before the others

* reducing latency:
 =20
  * if there are N pending remote reservations, reject a remote reservati=
on request instead of queuing it so that the local reservation can be use=
d instead of waiting.

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--3vEAI3Wd3Om1smSD78PJr5GFpMVlUJHCq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlSO7ywACgkQ8dLMyEl6F23TdgCgrV1e0mWsOuKyDdHFIJCcdWfY
cT0AmQHHpU84HW+aQxhmWIHUxT40Jl9z
=NsTa
-----END PGP SIGNATURE-----

--3vEAI3Wd3Om1smSD78PJr5GFpMVlUJHCq--
