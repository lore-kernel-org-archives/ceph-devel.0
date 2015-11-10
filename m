From: Loic Dachary <loic@dachary.org>
Subject: Backlog for the Ceph tracker
Date: Tue, 10 Nov 2015 16:28:01 +0100
Message-ID: <56420D01.1000708@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="HMvFjk3PRQG7s4Vo7iCi5XxSVEIMCfqkn"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:58080 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753820AbbKJP2G (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Nov 2015 10:28:06 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HMvFjk3PRQG7s4Vo7iCi5XxSVEIMCfqkn
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Sam,

I crafted a custom query that could be used as a replacement for the back=
log plugin

   http://tracker.ceph.com/projects/ceph/issues?query_id=3D86

It displays issues that are features or tasks, grouped by target version =
and ordered by priority.

I also created a v10.0.0 version so we can assign features we want for th=
is next version to it.

If you feel that's not good enough, we can just throw it away, it's merel=
y a proposal ;-)

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre



--HMvFjk3PRQG7s4Vo7iCi5XxSVEIMCfqkn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlZCDQIACgkQ8dLMyEl6F22/4QCfXgJpBV9T63yu5P1u2QjNxwjS
72YAnirWNj2XoYJOsopmsrXAwYRoahdN
=mUiZ
-----END PGP SIGNATURE-----

--HMvFjk3PRQG7s4Vo7iCi5XxSVEIMCfqkn--
