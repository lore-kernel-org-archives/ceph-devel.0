From: Loic Dachary <loic@dachary.org>
Subject: Re: make check bot paused
Date: Mon, 10 Aug 2015 15:22:27 +0200
Message-ID: <55C8A593.6030703@dachary.org>
References: <55C55500.3000303@dachary.org> <alpine.DEB.2.00.1508080449510.22099@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="kAOQTeHDRD4dsJmQOSSDMH5ssfdLgaBtT"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:35931 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753694AbbHJNW3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Aug 2015 09:22:29 -0400
Received: from [10.9.0.14] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id A510B420B6
	for <ceph-devel@vger.kernel.org>; Mon, 10 Aug 2015 15:22:27 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.00.1508080449510.22099@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kAOQTeHDRD4dsJmQOSSDMH5ssfdLgaBtT
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi,

The make check bot is back to work. It will not send any report for anoth=
er 24h to 48h to avoid a burst false negative. In the meantime you can ru=
n it locally with:

  run-make-check.sh

It is the same script that the bot uses and should work from a fresh git =
clone of Ceph.

Cheers

On 08/08/2015 13:50, Sage Weil wrote:
> On Sat, 8 Aug 2015, Loic Dachary wrote:
>> Hi,
>>
>> The make check bot is paused until the master branch passes make check=
=20
>> again.
>=20
> Several fixes here that need review:
>=20
> 	https://github.com/ceph/ceph/pull/5515
>=20
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--kAOQTeHDRD4dsJmQOSSDMH5ssfdLgaBtT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXIpZMACgkQ8dLMyEl6F221TgCgsQhWRRZYWZd0E/XLFzQfmh/K
PbEAoMBDBPKt/BBeWsrX4HZ+wotoHJHK
=mQvg
-----END PGP SIGNATURE-----

--kAOQTeHDRD4dsJmQOSSDMH5ssfdLgaBtT--
