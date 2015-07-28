From: Loic Dachary <loic@dachary.org>
Subject: Re: Requirements to become a Ceph project
Date: Tue, 28 Jul 2015 08:59:30 +0200
Message-ID: <55B72852.2000908@dachary.org>
References: <55B72352.9010407@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="8iaBemUirGdeFm6mx8G6ERtrTbpvuQw0Q"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:57246 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751176AbbG1G7i (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Jul 2015 02:59:38 -0400
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id 6BD46420B0
	for <ceph-devel@vger.kernel.org>; Tue, 28 Jul 2015 08:59:30 +0200 (CEST)
In-Reply-To: <55B72352.9010407@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8iaBemUirGdeFm6mx8G6ERtrTbpvuQw0Q
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The title sound even stranger with non-english words in it. Please excuse=
 the frenchism :-)

On 28/07/2015 08:38, Loic Dachary wrote:
> Hi Ceph,
>=20
> The title sounds a little strange (Citerias to become a Ceph project) b=
ecause I'm not aware of projects initiated by someone external to Ceph th=
at later became part of the Ceph nebula of projects (as found at http://t=
racker.ceph.com/projects/ or http://github.com/ceph/). I can however imag=
ine that a piece of software developed with no interaction with the Ceph =
development community could be contributed and become a valuable addition=
 (port to non GNU/Linux Operating Systems, monitoring applications for mo=
bile devices etc.).
>=20
> Although publishing the code of such a component under a Free Software =
license is a natural first step, there is more to do before it becomes pa=
rt of what we (the community of Ceph developers) care for on a regular ba=
sis. Borrowing the OpenStack requirements ( at http://governance.openstac=
k.org/reference/new-projects-requirements.html ), it could be expressed a=
s:
>=20
>     Free Software:
>         The proposed project uses a Free Software license as published =
at http://www.gnu.org/licenses/license-list.html#SoftwareLicenses
>         Project must have no library dependencies which effectively res=
trict how the project may be distributed or deployed
>     Open Community:
>         The leadership is chosen by the contributors to the project
>         The project has regular public meetings on IRC and those meetin=
gs are logged and published
>     Open Development:
>         The project uses public code reviews=20
>         The project has core reviewers and adopts a test-driven gate
>         The project provides liaisons that serve as contacts for the wo=
rk of cross-project teams in Ceph
>         Where it makes sense, the project cooperates with existing proj=
ects rather than gratuitously competing or reinventing the wheel
>         Where appropriate, the project adopts technology and patterns u=
sed by existing Ceph projects
>     Open Design:
>         The project direction is discussed at the Ceph Design Summit an=
d/or on public forums
>         The project uses the ceph-devel ML to discuss issues
>=20
> These requirements are formal in the case of OpenStack but they could a=
lso be used in the context of Ceph, not as requirements but as a guidelin=
e.
>=20
> What do you think ?
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--8iaBemUirGdeFm6mx8G6ERtrTbpvuQw0Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlW3KFIACgkQ8dLMyEl6F23pFQCeLlclOIxwGCwwGVSyKPQA5MLO
ExgAnRXuSAkEeg+mAROE2DTRaKVeT3Lo
=K5gJ
-----END PGP SIGNATURE-----

--8iaBemUirGdeFm6mx8G6ERtrTbpvuQw0Q--
