From: Loic Dachary <loic@dachary.org>
Subject: Re: mSHEC pull request (2nd challenge)
Date: Thu, 29 Jan 2015 15:37:39 +0100
Message-ID: <54CA45B3.7030309@dachary.org>
References: <870DE8DBB716524BAE51B2D499EC81E40AA68A90@g01jpexmbyt24>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="6UnRNGxHE9hKgXkB4ThqiAeptjT8V1Va0"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:49145 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751334AbbA2Ohm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Jan 2015 09:37:42 -0500
In-Reply-To: <870DE8DBB716524BAE51B2D499EC81E40AA68A90@g01jpexmbyt24>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Miyamae, Takeshi" <miyamae.takeshi@jp.fujitsu.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "Shiozawa, Kensuke" <shiozawa.kennsu@jp.fujitsu.com>, "Nakao, Takanori" <nakao.takanori@jp.fujitsu.com>, "Kawaguchi, Shotaro" <kawaguchi.s@jp.fujitsu.com>, "Kaga, Yoshihiro" <y-kaga@jp.fujitsu.com>, "Paul Von-Stamwitz (PVonStamwitz@us.fujitsu.com)" <PVonStamwitz@us.fujitsu.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6UnRNGxHE9hKgXkB4ThqiAeptjT8V1Va0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

It looks good and ready for integration testing :-) I just created http:/=
/tracker.ceph.com/issues/10686 to track this feature. Since we are late i=
n development cycle and unless someone has a different opinion, I will ma=
rk the SHEC plugin as experimental so people know it's new. I will howeve=
r do that after it is merged in master.

Cheers

On 29/01/2015 15:24, Miyamae, Takeshi wrote:
> Hi Loic,
>=20
> When I reset our commits on our fork repository, the 1st pull request w=
as automatically closed.
> So, I have issued another pull request of mSHEC.
>=20
> mSHEC : multiple Shingled Erasure Code #3534
> https://github.com/ceph/ceph/pull/3534
>=20
> As a result, I believe I have squashed our commits into one.
> I'm grad if you could restart the review.
>=20
> (You already noticed that and gave us labels, thank you!)
>=20
> Best regards,
> Takeshi Miyamae
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--6UnRNGxHE9hKgXkB4ThqiAeptjT8V1Va0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTKRbMACgkQ8dLMyEl6F22jMACfUim5FUw4xG/0ym98cupljOeG
vmEAnidT5IeiEcfgBC9zS2hvPpHsfa1q
=l/7c
-----END PGP SIGNATURE-----

--6UnRNGxHE9hKgXkB4ThqiAeptjT8V1Va0--
