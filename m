From: Loic Dachary <loic@dachary.org>
Subject: Re: make check bot on pause
Date: Mon, 19 Jan 2015 07:56:04 +0100
Message-ID: <54BCAA84.1030102@dachary.org>
References: <54BC3D7F.8030901@dachary.org> <alpine.DEB.2.00.1501181651050.8527@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="FclafX1JJEqUXxAAngDx4bmO0vfbr82fl"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:42996 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751468AbbASG4H (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Jan 2015 01:56:07 -0500
In-Reply-To: <alpine.DEB.2.00.1501181651050.8527@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FclafX1JJEqUXxAAngDx4bmO0vfbr82fl
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Sage,

Thanks for the quick fix, the bot resumed :-)

Cheers

On 19/01/2015 01:51, Sage Weil wrote:
> On Mon, 19 Jan 2015, Loic Dachary wrote:
>> Hi Ceph,
>>
>> Master fails make check at the moment and the make check bot that=20
>> reports to github was paused to avoid sending false negative.
>=20
> https://github.com/ceph/ceph/pull/3397
>=20
> fixes it.  Can someone +1?
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


--FclafX1JJEqUXxAAngDx4bmO0vfbr82fl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlS8qoQACgkQ8dLMyEl6F239/wCfbObXrfpVmMmblBZgIuaJREim
/fAAn0Hw/fuFR8VtihcQsbWgz6pewJrx
=WUJQ
-----END PGP SIGNATURE-----

--FclafX1JJEqUXxAAngDx4bmO0vfbr82fl--
