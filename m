From: Loic Dachary <loic@dachary.org>
Subject: Re: force pushes disabled for master in ceph.git and ceph-deploy.git
Date: Wed, 10 Dec 2014 23:25:37 +0100
Message-ID: <5488C861.1080005@dachary.org>
References: <5488C747.2000003@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="oLjVd5sEn4T1hImekLfNJ3tRAr0Vo3Evo"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:50903 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750744AbaLJWZj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Dec 2014 17:25:39 -0500
In-Reply-To: <5488C747.2000003@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>, ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oLjVd5sEn4T1hImekLfNJ3tRAr0Vo3Evo
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 10/12/2014 23:20, Ken Dreyer wrote:
> Thanks to GitHub Support, force-pushes are now disabled for master in
> ceph.git and ceph-deploy.git. This should save us from accidentally
> deleting history with a bad force-push to the wrong branch. (Not that
> any of us were going to do that, of course! :)

Thanks ! I did that last year and that makes me appreciate the precaution=
 ;-)

>=20
> - Ken
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--oLjVd5sEn4T1hImekLfNJ3tRAr0Vo3Evo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlSIyGEACgkQ8dLMyEl6F20duACfd6uYn1ghWcmRaC0+oKULXN4N
nbcAmwS0AsBJ34pquuKwHEPzhrK9xycC
=CZbX
-----END PGP SIGNATURE-----

--oLjVd5sEn4T1hImekLfNJ3tRAr0Vo3Evo--
