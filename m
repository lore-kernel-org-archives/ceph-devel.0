From: Loic Dachary <loic@dachary.org>
Subject: Re: erasure pool with isa plugin
Date: Mon, 22 Jun 2015 17:34:27 -0400
Message-ID: <55887F63.1000404@dachary.org>
References: <BC97738F8E7C8742BABED7F06FB9DF91669A9C09@SATLEXDAG01.amd.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="NcuqadE7Td8uxrsddDRaqBteGRjuQWFcH"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:38336 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751507AbbFVVe3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Jun 2015 17:34:29 -0400
In-Reply-To: <BC97738F8E7C8742BABED7F06FB9DF91669A9C09@SATLEXDAG01.amd.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Deneau, Tom" <tom.deneau@amd.com>, ceph-devel <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NcuqadE7Td8uxrsddDRaqBteGRjuQWFcH
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Tom,

On 22/06/2015 17:10, Deneau, Tom wrote:
> If one has a cluster with some nodes that can run with the ISA plugin
> and some that cannot, is there a way to define a pool such that the
> ISA-capable nodes can use the ISA plugin and the others can use say
> the jerasure plugin?

There is no way to do that, because there is no guarantee that an object =
encoded by jerasure can be decoded by isa and vice versa.

Cheers

>=20
> -- Tom Deneau
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--NcuqadE7Td8uxrsddDRaqBteGRjuQWFcH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlWIf2MACgkQ8dLMyEl6F22LMwCfXlvckrdu9wnemJiyQpagG42G
LHAAoIjSZCs7Ttk/1Ho2TY05aAdflXoa
=l7He
-----END PGP SIGNATURE-----

--NcuqadE7Td8uxrsddDRaqBteGRjuQWFcH--
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
