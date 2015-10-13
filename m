From: Loic Dachary <loic@dachary.org>
Subject: Re: enable rbd on ec pool ?
Date: Tue, 13 Oct 2015 09:17:29 +0200
Message-ID: <561CB009.7090708@dachary.org>
References: <EBFBEFF470372547BAACF06D39FF53A54F5A8665@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="dLWC3mG2LuIrGUKtqs2fA6bilvcEG7Q9P"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:41899 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751298AbbJMHRd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Oct 2015 03:17:33 -0400
In-Reply-To: <EBFBEFF470372547BAACF06D39FF53A54F5A8665@SACMBXIP02.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tomy Cheru <Tomy.Cheru@sandisk.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dLWC3mG2LuIrGUKtqs2fA6bilvcEG7Q9P
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Tomy,

On 13/10/2015 06:13, Tomy Cheru wrote:
> Is there a patch available to enable rbd over an EC pool ?

You have to go through a cache tier instead of using it directly. See htt=
p://docs.ceph.com/docs/master/rados/operations/cache-tiering/ for more in=
formation.

Cheers

>=20
> Currently its restricted,
> 2015-10-12 10:52:23.042085 7f4721ca1840 -1 librbd: error adding image t=
o directory: (95) Operation not supported
> rbd: create error: (95) Operation not supported
>=20
> Thanks,
> tomy
>=20
>=20
> ________________________________
>=20
> PLEASE NOTE: The information contained in this electronic mail message =
is intended only for the use of the designated recipient(s) named above. =
If the reader of this message is not the intended recipient, you are here=
by notified that you have received this message in error and that any rev=
iew, dissemination, distribution, or copying of this message is strictly =
prohibited. If you have received this communication in error, please noti=
fy the sender by telephone or e-mail (as shown above) immediately and des=
troy any and all copies of this message in your possession (whether hard =
copies or electronically stored copies).
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--dLWC3mG2LuIrGUKtqs2fA6bilvcEG7Q9P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlYcsAoACgkQ8dLMyEl6F21wlACdHORZVEm9hu99nLVkvDia6Ul7
0rkAnj3jNN28Zogi5uWPjC+LvIUNt3Hm
=bszp
-----END PGP SIGNATURE-----

--dLWC3mG2LuIrGUKtqs2fA6bilvcEG7Q9P--
