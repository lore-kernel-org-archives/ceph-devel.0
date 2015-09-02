From: Loic Dachary <loic@dachary.org>
Subject: jerasure.org disaster recovery plan
Date: Wed, 02 Sep 2015 20:57:41 +0200
Message-ID: <55E746A5.7040303@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="tASRUHRiwefNjSoWcJcm1xdgOOBcPp5Js"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:48417 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755159AbbIBS5t (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Sep 2015 14:57:49 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>
Cc: Kevin Greenan <kmgreen2@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tASRUHRiwefNjSoWcJcm1xdgOOBcPp5Js
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Ceph,

The jerasure.org web site, gitlab and gitlab-ci is hosted on a single vir=
tual machine on an OpenStack + Ceph cluster I maintain on my spare time. =
Kevin Greenan has access in case I'm not available. It is a set of docker=
 containers and the installation is documented on my blog[1].

It would be great if someone was willing to mirror the virtual machine wh=
ere all this is running (rsync / will do) , just in case something bad ha=
ppens and there is a need to switch hosting. I'm also willing to share ac=
cess to the DNS server so that resurecting jerasure.org is not more compl=
icated than:

   * docker start
   * update the IP of jerasure.org

Cheers

[1] Gitlab CI runner installation http://dachary.org/?p=3D3481 http://dac=
hary.org/?p=3D3401 http://dachary.org/?p=3D3409

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre



--tASRUHRiwefNjSoWcJcm1xdgOOBcPp5Js
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXnRqUACgkQ8dLMyEl6F22V0gCgtwE+fbZHZAlZA56J8rhTcm97
pF4An1ViWzsRlQ79T7R8AEyDxbzZc2lh
=lUP7
-----END PGP SIGNATURE-----

--tASRUHRiwefNjSoWcJcm1xdgOOBcPp5Js--
