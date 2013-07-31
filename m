From: Loic Dachary <loic@dachary.org>
Subject: Re: Blueprint: inline data support (step 2)
Date: Wed, 31 Jul 2013 02:17:57 +0200
Message-ID: <51F857B5.5070409@dachary.org>
References: <51F855D9.6070306@ubuntukylin.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig8781BDC66BB9E2E69DFFA3A2"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:54621 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752671Ab3GaASA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Jul 2013 20:18:00 -0400
In-Reply-To: <51F855D9.6070306@ubuntukylin.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Li Wang <liwang@ubuntukylin.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8781BDC66BB9E2E69DFFA3A2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

It would be nice to have URLs to the current implementation and the bench=
mark results you got in the blueprint.

http://wiki.ceph.com/01Planning/02Blueprints/Emperor/Inline_data_support_=
%28Step_2%29

Cheers

On 31/07/2013 02:10, Li Wang wrote:
> We have worked out a preliminary implementation for inline data support=
, and observed obvious speed up for small file access.
>=20
> The step 2 will focus on (1) Try to make things simpler to eliminate th=
e state of a file half-inlined; (2) To efficiently deal with the share wr=
ite or read/write; (3) Protocal backword compatability
>=20
> We submitted a blueprint for this, anyone interested is welcome to join=
 the discussion.
> --=20
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enig8781BDC66BB9E2E69DFFA3A2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlH4V7UACgkQ8dLMyEl6F21jMACdH2cMrbMsgDIH3RyRRyMJJdLE
7jMAnAyxbKhJIQqwVByEKk8iPIp3kxOH
=sR/g
-----END PGP SIGNATURE-----

--------------enig8781BDC66BB9E2E69DFFA3A2--
