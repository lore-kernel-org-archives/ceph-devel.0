From: Loic Dachary <loic@dachary.org>
Subject: Re: coefficients
Date: Fri, 11 Jul 2014 20:19:39 +0300
Message-ID: <53C01CAB.5070208@dachary.org>
References: <CACUN8h2ixhb_yDq2mY=zMW=GPUV-wDEzkGLG9LVh-d3VT-2Hxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="MSKp3dv2xDkH1uclovr1gNLdEh89R3fsd"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:42222 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751114AbaGKRTp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Jul 2014 13:19:45 -0400
In-Reply-To: <CACUN8h2ixhb_yDq2mY=zMW=GPUV-wDEzkGLG9LVh-d3VT-2Hxg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Koleos Fuscus <koleosfuscus@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MSKp3dv2xDkH1uclovr1gNLdEh89R3fsd
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi koleosfuscus,

Thanks for the pointer, it is very helpful. I'm inclined to keep the simp=
ler approach for the first implementation while exploring and learning mo=
re about the smarter / more complex approach. This may change if someone =
willing to help comes on board in the meantime ;-)

Cheers

On 11/07/2014 13:48, Koleos Fuscus wrote:
> Hi Loic,
>=20
> If you still need to calculate more coefficients there is an
> explanation of how to construct the coding equations in the paper
> Erasure coding in Windows Azure Storage (unless you will keep your LRC
> implementation simple and do only the LRC (10,6,5) ). I undertand that
> the codes LRC in the mentioned paper are not exactly the same but at
> least the paper explains the coefficients. I think in Azure they used
> functional repair instead of exact repair as you wish.
>=20
> koleosfuscus
>=20
> ________________________________________________________________
> "My reply is: the software has no known bugs, therefore it has not
> been updated."
> Wietse Venema
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--MSKp3dv2xDkH1uclovr1gNLdEh89R3fsd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlPAHKsACgkQ8dLMyEl6F22uaQCgh8Goe28l/iTydZYXO2Btbi6m
aT4AoMF6ZIbgSBvw0dkTNZtE7y6Wh3p/
=FpNH
-----END PGP SIGNATURE-----

--MSKp3dv2xDkH1uclovr1gNLdEh89R3fsd--
