From: Loic Dachary <loic@dachary.org>
Subject: docker targets for teuthology
Date: Fri, 02 Jan 2015 14:53:32 +0100
Message-ID: <54A6A2DC.90806@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="b3Pk3QTrmPH1J1dXCLn3Xnd40wkMxm6Er"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:60929 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752046AbbABNxg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Jan 2015 08:53:36 -0500
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id D37A942B4E
	for <ceph-devel@vger.kernel.org>; Fri,  2 Jan 2015 14:53:33 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--b3Pk3QTrmPH1J1dXCLn3Xnd40wkMxm6Er
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Ceph,

I'm pleased to announce that docker targets for teuthology are working [1=
]. My incentive is to run teuthology jobs quickly (docker images are a ma=
jor help) and with minimal resources. It may also be helpful for contribu=
tors who do not have time or resources to setup the default teuthology in=
stallation.

This effort was started three months ago and had to wait for docker to pr=
operly implement the exec [2] command to avoid running a ssh server in ea=
ch container. Although the teuthology patch is a hack, it turns out to be=
 not too complicated to isolate [3].

If someone is interested in turning this hack into a proper patch, let me=
 know :-)

Cheers

[1] Teuthology docker targets hack http://dachary.org/?p=3D3501 http://da=
chary.org/?p=3D3441 http://dachary.org/?p=3D3354 http://dachary.org/?p=3D=
3330
[2] Docker 1.4.0 December 2014 http://docs.docker.com/release-notes/#vers=
ion-140
[3] container.py in teuthology https://github.com/dachary/teuthology/comp=
are/wip-container#diff-24f45fc6782fb342bf422033c01e1b06R1
--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--b3Pk3QTrmPH1J1dXCLn3Xnd40wkMxm6Er
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlSmotwACgkQ8dLMyEl6F213sQCgj4ne9hebh7zy4A5a8vKRxTom
oakAoKWW3kl66XUNo20tWHBNREaQBdtU
=BtEG
-----END PGP SIGNATURE-----

--b3Pk3QTrmPH1J1dXCLn3Xnd40wkMxm6Er--
