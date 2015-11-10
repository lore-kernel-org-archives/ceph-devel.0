From: Loic Dachary <loic@dachary.org>
Subject: Re: make check bot resumed
Date: Tue, 10 Nov 2015 07:20:03 +0100
Message-ID: <56418C93.4090402@dachary.org>
References: <5640AEB2.6030802@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="7IFSsSMnC79v01XsMQDpjhli6M86xDB2S"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:57811 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750825AbbKJGUG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Nov 2015 01:20:06 -0500
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id E8751420A4
	for <ceph-devel@vger.kernel.org>; Tue, 10 Nov 2015 07:20:03 +0100 (CET)
In-Reply-To: <5640AEB2.6030802@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7IFSsSMnC79v01XsMQDpjhli6M86xDB2S
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

For some reason jenkins thought it was necessary to reconsider all commit=
s merged weeks ago. It was silenced to not send test results about pull r=
equest already merged. It should now resume work on the current pull requ=
ests. If a pull request needs to be visited by the make check bot, it is =
enough to rebase and repush it.

Cheers

On 09/11/2015 15:33, Loic Dachary wrote:
> Hi,
>=20
> The machine sending notifications for the make check bot failed during =
the week-end. It was rebooted and it should resume its work.=20
>=20
> The virtual machine was actually re-built because the underlying OpenSt=
ack cloud was unable to find the volume used for root after a hard reboot=
=2E There were also issues with the devicemapper docker backend that was =
corrupted. Wiping them out was enough to resolve the problem: they did no=
t have any persistent data anyway.
>=20
> Cheers
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--7IFSsSMnC79v01XsMQDpjhli6M86xDB2S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlZBjJMACgkQ8dLMyEl6F20q1QCeMe96enSC1fx1Dp9FXZPTSkmv
89cAn0tiMg9NDZ+Mrv2/0HTFR7bCN88B
=ssoW
-----END PGP SIGNATURE-----

--7IFSsSMnC79v01XsMQDpjhli6M86xDB2S--
