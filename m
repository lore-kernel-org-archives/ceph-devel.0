From: Loic Dachary <loic@dachary.org>
Subject: Re: make check bot paused
Date: Thu, 16 Apr 2015 19:22:00 +0200
Message-ID: <552FEFB8.1040505@dachary.org>
References: <552E51A5.2060501@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="au6WorX1WrhLISNR2OkG5KwnlUxS8mlXo"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:47818 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755086AbbDPRWK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Apr 2015 13:22:10 -0400
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id 8B0FA42B23
	for <ceph-devel@vger.kernel.org>; Thu, 16 Apr 2015 19:22:00 +0200 (CEST)
In-Reply-To: <552E51A5.2060501@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--au6WorX1WrhLISNR2OkG5KwnlUxS8mlXo
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

It is back :-)

Cheers

On 15/04/2015 13:55, Loic Dachary wrote:
> Hi,
>=20
> The make check bot [1] that executes run-make-check.sh [2] on pull requ=
ests and reports results as comments [3] is experiencing problems. It may=
 be a hardware issue and the bot is paused while the issue is investigate=
d [4] to avoid sending confusing false negatives. In the meantime the run=
-make-check.sh [2] script can be run locally, before sending the pull req=
uest, to confirm the commits to be sent do not break them. It is expected=
 to run in less than 15 minutes including compilation on a fast machine w=
ith a SSD (or RAM disk) and 8 cores and 32GB of RAM and may take up to tw=
o hours on a machine with a spinner and two cores.
>=20
> Thanks for your patience.
>=20
> Cheers
>=20
> [1] bot running on pull requests http://jenkins.ceph.dachary.org/job/ce=
ph/
> [2] run-make-check.sh http://workbench.dachary.org/ceph/ceph/blob/maste=
r/run-make-check.sh
> [3] make check results example : https://github.com/ceph/ceph/pull/3946=
#issuecomment-93286840
> [4] possible RAM failure http://tracker.ceph.com/issues/11399
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--au6WorX1WrhLISNR2OkG5KwnlUxS8mlXo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlUv77gACgkQ8dLMyEl6F22uiwCgsMECtisF8bCJyl1lJBBTSYkL
f3EAnjfRbnLTLK9eg84giIlGyttpaMcG
=XA2K
-----END PGP SIGNATURE-----

--au6WorX1WrhLISNR2OkG5KwnlUxS8mlXo--
