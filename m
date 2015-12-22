From: Loic Dachary <loic@dachary.org>
Subject: Re: Time to move the make check bot to jenkins.ceph.com
Date: Tue, 22 Dec 2015 19:23:34 +0100
Message-ID: <56799526.1000404@dachary.org>
References: <5677D0D2.5090801@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="kprd11tMCerfmRTjrJcolvOvuKfl0RnIi"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:54454 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751559AbbLVSXg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Dec 2015 13:23:36 -0500
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id A79FF420A9
	for <ceph-devel@vger.kernel.org>; Tue, 22 Dec 2015 19:23:34 +0100 (CET)
In-Reply-To: <5677D0D2.5090801@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kprd11tMCerfmRTjrJcolvOvuKfl0RnIi
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

The make check bot moved to jenkins.ceph.com today and ran it's first suc=
cessfull job. You will no longer see comments from the bot: it will updat=
e the github status instead, which is less intrusive.

Cheers

On 21/12/2015 11:13, Loic Dachary wrote:
> Hi,
>=20
> The make check bot is broken in a way that I can't figure out right now=
=2E Maybe now is the time to move it to jenkins.ceph.com ? It should not =
be more difficult than launching the run-make-check.sh script. It does no=
t need network or root access.
>=20
> Cheers
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--kprd11tMCerfmRTjrJcolvOvuKfl0RnIi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlZ5lSYACgkQ8dLMyEl6F208IwCeP7ebAyeOZKizD3RNI+TrDxXV
i9oAnRtol/E/xHRvoVeYqe1ub97SvERE
=8DrI
-----END PGP SIGNATURE-----

--kprd11tMCerfmRTjrJcolvOvuKfl0RnIi--
