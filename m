From: Loic Dachary <loic@dachary.org>
Subject: Re: Setting up teuthology with OpenStack
Date: Sun, 28 Jun 2015 12:51:43 +0200
Message-ID: <558FD1BF.4010404@dachary.org>
References: <558A03E1.7010903@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="uX3VGLsW3wQW1WnHIeJ0hsGitlnbgWd2N"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:41421 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752282AbbF1Kvx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 28 Jun 2015 06:51:53 -0400
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id 18E86420B1
	for <ceph-devel@vger.kernel.org>; Sun, 28 Jun 2015 12:51:44 +0200 (CEST)
In-Reply-To: <558A03E1.7010903@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uX3VGLsW3wQW1WnHIeJ0hsGitlnbgWd2N
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

The OpenStack backend is being reworked to not require the neutron API, b=
ecause most OpenStack cluster do not provide it. Until it is complete the=
 neutron based backend can be found at

 https://github.com/dachary/teuthology/tree/wip-6502-openstack-neutron#op=
enstack-backend

The difference is that neutron allows to create an isolated network and t=
euthology can assume ownership of the IPv4 addresses. Without neutron, th=
e OpenStack backend has to adapt to whatever IPv4 is assigned to the inst=
ances created. It is not a significant problem, only the logic is quite d=
ifferent.

Cheers

On 24/06/2015 03:12, Loic Dachary wrote:
> Hi Ceph,
>=20
> There is an experimental OpenStack backend[1] for teuthology[2] (the Ce=
ph integration tests toolbox) with instructions to set it up[3] and some =
integration tests to verify it works as it should. I've run them successf=
ully on two different OpenStack clusters (http://the.re/ and https://ente=
rcloudsuite.com/). It would be great if someone was brave enough to give =
it a try at this very early stage :-) If you don't have access to an Open=
Stack cluster, https://entercloudsuite.com/ can provide an OpenStack tena=
nt within the hour (I had a few weird glitches during the registration bu=
t they went away magically).
>=20
> Cheers
>=20
> [1] teuthology OpenStack backend http://tracker.ceph.com/issues/6502
> [2] teuthology https://github.com/ceph/teuthology/
> [3] setting up teuthology with OpenStack https://github.com/dachary/teu=
thology/tree/wip-6502-openstack#openstack-backend
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--uX3VGLsW3wQW1WnHIeJ0hsGitlnbgWd2N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlWP0b8ACgkQ8dLMyEl6F22kRgCfaKQH8acJ2t8hINYI+QZtFwqq
AfkAn0YBF34tbaxM/gRgyBr08k3x6ePz
=oHUI
-----END PGP SIGNATURE-----

--uX3VGLsW3wQW1WnHIeJ0hsGitlnbgWd2N--
