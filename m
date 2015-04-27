From: Loic Dachary <loic@dachary.org>
Subject: Re: Retiring GIant
Date: Tue, 28 Apr 2015 00:30:53 +0200
Message-ID: <553EB89D.1040102@dachary.org>
References: <553EB447.5070305@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="nbIdbiqWrKAC8njOdHWXrjpr4kkXCFc0s"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:53500 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965241AbbD0Wa5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Apr 2015 18:30:57 -0400
In-Reply-To: <553EB447.5070305@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek L <abhishek.lekshmanan@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nbIdbiqWrKAC8njOdHWXrjpr4kkXCFc0s
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 28/04/2015 00:12, Loic Dachary wrote:
> Hi Abhishek,
>=20
> The final Giant release has been published and we can now move to the l=
ast phase of the workflow: retirement :-) I summarized the steps at

(Hit Control-J by accident ;-)

http://tracker.ceph.com/projects/ceph-releases/wiki/HOWTO_retire_a_stable=
_release

* https://github.com/ceph/ceph/milestones/2 =3D> closed
* no more pull requests targetting giant
* updated http://tracker.ceph.com/projects/ceph-releases/wiki/HOWTO to re=
move the giant line
* removed the "giant" word from the backport field in http://tracker.ceph=
=2Ecom/issues/10976 http://tracker.ceph.com/issues/11358 http://tracker.c=
eph.com/issues/11335 http://tracker.ceph.com/issues/10863
* keep http://tracker.ceph.com/projects/ceph/issues?query_id=3D68 after v=
erifying it is empty (giant custom query) but make it non public
* did not close giant in http://tracker.ceph.com/rb/release/ because it d=
oes not show
* Update http://tracker.ceph.com/projects/ceph-releases/settings to remov=
e the release link

I think the only thing left is to close

http://tracker.ceph.com/issues/11153

Did I miss anything ?

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--nbIdbiqWrKAC8njOdHWXrjpr4kkXCFc0s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlU+uJ4ACgkQ8dLMyEl6F23gDACeNuDrIMpfMbY/3CJtmZ58D4D1
QwkAn1s/q8aeWocfftGef15yXmXyOccb
=y6R/
-----END PGP SIGNATURE-----

--nbIdbiqWrKAC8njOdHWXrjpr4kkXCFc0s--
