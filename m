From: Loic Dachary <loic@dachary.org>
Subject: gitbuilder failure to generate packages
Date: Fri, 06 Mar 2015 19:36:11 +0100
Message-ID: <54F9F39B.6@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="1hVR2WOCllO23PGPa9lcKuNX9NxTJNFAS"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:54048 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755753AbbCFSgO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Mar 2015 13:36:14 -0500
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id F15834210B
	for <ceph-devel@vger.kernel.org>; Fri,  6 Mar 2015 19:36:11 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1hVR2WOCllO23PGPa9lcKuNX9NxTJNFAS
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Ceph,

In the past 24 hours gitbuilder did compile ceph but did not generate the=
 expected packages. This translated into 404 when trying to run teutholog=
y tests targeting the corresponding branch. It should be fixed now but st=
ill testing.

More information at http://tracker.ceph.com/issues/11052

Sorry for the inconvenience

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--1hVR2WOCllO23PGPa9lcKuNX9NxTJNFAS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlT585sACgkQ8dLMyEl6F216EwCfRvVLD8+LMtOMh0Eift5ddU3i
lp4An3gVOEM7W5ap0bdykZjjCkZstRZl
=krlY
-----END PGP SIGNATURE-----

--1hVR2WOCllO23PGPa9lcKuNX9NxTJNFAS--
