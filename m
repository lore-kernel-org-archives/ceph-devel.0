From: Loic Dachary <loic@dachary.org>
Subject: Setting up teuthology with OpenStack
Date: Tue, 23 Jun 2015 21:12:01 -0400
Message-ID: <558A03E1.7010903@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="xDjODsjwBM6BuAbfVAoDk3wu36Vm9b7S1"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:39096 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751985AbbFXBML (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 23 Jun 2015 21:12:11 -0400
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id 4154242B2B
	for <ceph-devel@vger.kernel.org>; Wed, 24 Jun 2015 03:12:02 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xDjODsjwBM6BuAbfVAoDk3wu36Vm9b7S1
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Ceph,

There is an experimental OpenStack backend[1] for teuthology[2] (the Ceph=
 integration tests toolbox) with instructions to set it up[3] and some in=
tegration tests to verify it works as it should. I've run them successful=
ly on two different OpenStack clusters (http://the.re/ and https://enterc=
loudsuite.com/). It would be great if someone was brave enough to give it=
 a try at this very early stage :-) If you don't have access to an OpenSt=
ack cluster, https://entercloudsuite.com/ can provide an OpenStack tenant=
 within the hour (I had a few weird glitches during the registration but =
they went away magically).

Cheers

[1] teuthology OpenStack backend http://tracker.ceph.com/issues/6502
[2] teuthology https://github.com/ceph/teuthology/
[3] setting up teuthology with OpenStack https://github.com/dachary/teuth=
ology/tree/wip-6502-openstack#openstack-backend

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--xDjODsjwBM6BuAbfVAoDk3wu36Vm9b7S1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlWKA+EACgkQ8dLMyEl6F23lNACgt3QiBUz7UC/GJEJu0p+CAlyx
3AAAn2YAEyv9GvN+kprezuJrBQOx+/Nw
=VMoV
-----END PGP SIGNATURE-----

--xDjODsjwBM6BuAbfVAoDk3wu36Vm9b7S1--
