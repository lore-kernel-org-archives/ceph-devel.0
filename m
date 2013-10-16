From: Loic Dachary <loic@dachary.org>
Subject: Ceph puppet module
Date: Wed, 16 Oct 2013 10:00:42 +0200
Message-ID: <525E47AA.8060006@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="vc62aU9I7rfIIsqaGD2GJr5etHSIaOLSs"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:36805 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753622Ab3JPIAo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Oct 2013 04:00:44 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>
Cc: Dan Bode <bodepd@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vc62aU9I7rfIIsqaGD2GJr5etHSIaOLSs
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Ceph,

How about creating=20

https://github.com/ceph/puppet-ceph=20

to federate the development efforts for a puppet module exclusively focus=
ed on deploying / maintaining a Ceph cluster ? It looks like we are at a =
point in time where the fragmentation of the work created a desire for a =
central place. And the https://github.com/ceph/ seems agreeable to everyo=
ne involved.

The discussion initialy started on Ceph + OpenStack + puppet but it seems=
 sensible to separate the OpenStack specific part and host it on https://=
github.com/stackforge/

The full thread that leads to this proposal is at:

https://groups.google.com/a/puppetlabs.com/d/msg/puppet-openstack/ibnrmXB=
AxVg/Y3Z3e6sZoa4J

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--vc62aU9I7rfIIsqaGD2GJr5etHSIaOLSs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJeR6oACgkQ8dLMyEl6F21sTgCfX4EXo8uqU6AziHhVSV6FU4Yu
+UwAoMQAwfwb1Bol2dU6fiF2EUDI+Vo9
=YDgS
-----END PGP SIGNATURE-----

--vc62aU9I7rfIIsqaGD2GJr5etHSIaOLSs--
