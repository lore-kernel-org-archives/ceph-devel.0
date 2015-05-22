From: Loic Dachary <loic@dachary.org>
Subject: Re: Proposal for a Backport tracker
Date: Fri, 22 May 2015 09:23:59 +0200
Message-ID: <555ED98F.8020402@dachary.org>
References: <555DC080.8050508@dachary.org> <555ED569.2090604@suse.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="cjwlirL6uqj3oqGllNMK6hTCeJh0NpiiI"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:48963 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751046AbbEVHYC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 May 2015 03:24:02 -0400
In-Reply-To: <555ED569.2090604@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cjwlirL6uqj3oqGllNMK6hTCeJh0NpiiI
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Nathan,

On 22/05/2015 09:06, Nathan Cutler wrote:> Hi Loic:
>=20
> As I understand the new backport workflow, the process of creating tick=
ets in the Backport tracker will be automated. This raises a question:
>=20
> As the automation script loops over each Pending Backport ticket, it wi=
ll first create a corresponding ticket (or tickets) in the Backport track=
er. After that, I'm thinking it will need to change the status of the ori=
ginal ticket from Pending Backport to something else (so it doesn't pick =
up the same ticket again the next time the script is run).

We can probably keep the original ticket in the "Pending Backport" status=
 until all backports are resolved, as we currently do.=20

> So the question is, what will the original ticket's status be changed t=
o? Resolved?

When all backports are resolved, then we can also resolve the original ti=
cket. Do you forsee a problem with that ?

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--cjwlirL6uqj3oqGllNMK6hTCeJh0NpiiI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVe2Y8ACgkQ8dLMyEl6F23fLACeKLEI3gPsDo5uYnjudCNk6NiG
HGgAn2fxNkDSJLKLubuMpi6BFafeOakX
=kPqs
-----END PGP SIGNATURE-----

--cjwlirL6uqj3oqGllNMK6hTCeJh0NpiiI--
