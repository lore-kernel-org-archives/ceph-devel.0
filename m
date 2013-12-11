From: Loic Dachary <loic@dachary.org>
Subject: Re: Buffer alignment
Date: Wed, 11 Dec 2013 13:25:23 +0100
Message-ID: <52A859B3.10502@dachary.org>
References: <52A6D1B4.1010503@dachary.org> <3472A07E6605974CBC9BC573F1BC02E4AE6A9C35@PLOXCHG03.cern.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="rQGomJSannjsAvKAN1uJjSbsCqOsPBg9T"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:37062 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751030Ab3LKMZZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Dec 2013 07:25:25 -0500
In-Reply-To: <3472A07E6605974CBC9BC573F1BC02E4AE6A9C35@PLOXCHG03.cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rQGomJSannjsAvKAN1uJjSbsCqOsPBg9T
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 11/12/2013 10:50, Andreas Joachim Peters wrote:
> Hi Loic,=20
> if you pull the BPC extension this requires 128-bit aligned memory adre=
sses, maybe to prepare for future extensions they should be even 512-bit =
aligned. I can add an assertion if I see unaligned addresses.
>=20

Could you please remind me which branch of your repository I should look =
at ?

Cheers

> Cheers Andreas.
>=20
> ________________________________________
> From: Loic Dachary [loic@dachary.org]
> Sent: 10 December 2013 09:32
> To: Andreas Joachim Peters
> Cc: Ceph Development
> Subject: Buffer alignment
>=20
> Hi Andreas,
>=20
> In Ceph, buffers can be aligned if required using buffer::create_page_a=
ligned
>=20
> https://github.com/ceph/ceph/blob/master/src/common/buffer.cc#L519
> https://github.com/ceph/ceph/blob/master/src/common/buffer.cc#L230
>=20
> and although the Jerasure plugin has alignment requirements
>=20
> https://github.com/ceph/ceph/blob/master/src/osd/ErasureCodePluginJeras=
ure/ErasureCodeJerasure.cc#L79
>=20
> it did not occur to me that aligning the buffers used to stored the enc=
oded
>=20
> https://github.com/ceph/ceph/blob/master/src/osd/ErasureCodePluginJeras=
ure/ErasureCodeJerasure.cc#L87
>=20
> result would be needed. For decoding the caller is responsible for allo=
cating the buffers. For encoding it also is, except for the padding.
>=20
> Do you think the API should recommend something regarding alignment ?
>=20
> https://github.com/ceph/ceph/blob/master/src/osd/ErasureCodeInterface.h=
#L20
>=20
> Cheers
>=20
> --
> Lo=EFc Dachary, Artisan Logiciel Libre
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--rQGomJSannjsAvKAN1uJjSbsCqOsPBg9T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlKoWbMACgkQ8dLMyEl6F2354gCgtJdQ7wEYS5KKuBBlSCfTCUGp
KKsAn1XOLGhVQ+TkDqbRRHyiP9JosUO7
=ZTe+
-----END PGP SIGNATURE-----

--rQGomJSannjsAvKAN1uJjSbsCqOsPBg9T--
