From: Loic Dachary <loic@dachary.org>
Subject: Re: Ceph erasure coding
Date: Thu, 22 Oct 2015 18:59:40 +0200
Message-ID: <562915FC.9090401@dachary.org>
References: <CA+nGFBodcEq0vOvuFP1Od0zVCyk_9PufsRSYBJYi1W4p_vh+7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="1av8OecNnoqjJxX8mBgwVojqPsT5SEDNt"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:48304 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757779AbbJVQ7n (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Oct 2015 12:59:43 -0400
In-Reply-To: <CA+nGFBodcEq0vOvuFP1Od0zVCyk_9PufsRSYBJYi1W4p_vh+7g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kjetil Babington <babingto@gmail.com>, ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1av8OecNnoqjJxX8mBgwVojqPsT5SEDNt
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On 22/10/2015 18:44, Kjetil Babington wrote:
> Hi,
>=20
> I have a question about the capabilities of the erasure coding API in
> Ceph. Let's say that I have 10 data disks and 4 parity disks, is it
> possible to create an erasure coding plugin which creates 20 data
> chunks and 8 parity chunks, and then places two chunks on each osd?
>=20
> Or said maybe a bit simpler is it possible for two or more chunks from
> the same encode operation to be placed on the same osd?

This is more a question of creating a crush ruleset that does it. The era=
sure code plugin encodes chunks but the crush ruleset decides where they =
are placed.

Cheers

>=20
> - Kjetil Babington
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--1av8OecNnoqjJxX8mBgwVojqPsT5SEDNt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlYpFfwACgkQ8dLMyEl6F21xPwCeNicspPPhz/tWr/sNsBfQLcdj
YWwAnijw1FiVTeUIohltE73O+HLY6TrY
=4nLS
-----END PGP SIGNATURE-----

--1av8OecNnoqjJxX8mBgwVojqPsT5SEDNt--
