From: Loic Dachary <loic@dachary.org>
Subject: Re: Deadline of Github pull request for Hammer release (question)
Date: Tue, 06 Jan 2015 16:51:42 +0100
Message-ID: <54AC048E.9040200@dachary.org>
References: <870DE8DBB716524BAE51B2D499EC81E40AA3F9AB@g01jpexmbyt24>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="n5UC0GakqB9mQOp5QsaK0qxE6r438fT41"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:34342 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755410AbbAFPvp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Jan 2015 10:51:45 -0500
In-Reply-To: <870DE8DBB716524BAE51B2D499EC81E40AA3F9AB@g01jpexmbyt24>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Miyamae, Takeshi" <miyamae.takeshi@jp.fujitsu.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "Shiozawa, Kensuke" <shiozawa.kennsu@jp.fujitsu.com>, "Nakao, Takanori" <nakao.takanori@jp.fujitsu.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--n5UC0GakqB9mQOp5QsaK0qxE6r438fT41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On 06/01/2015 12:49, Miyamae, Takeshi wrote:
> Dear Loic,
>=20
> I'm Takeshi Miyamae, one of the authors of SHEC's blueprint.
>=20
> Shingled Erasure Code (SHEC)
> https://wiki.ceph.com/Planning/Blueprints/Hammer/Shingled_Erasure_Code_=
(SHEC)

The work you have done is quite impressive :-)

> We have revised our blueprint shown in the last CDS to extend our erasu=
re code
> layouts and describe the guideline for choosing SHEC among various EC p=
lugins.
> We believe the blueprint now answers all the comments given at the CDS.=


Great.

> In addition, we would like to ask for your advice on the schedule of ou=
r github
> pull request. More specifically, we would like to know its deadline for=
 Hammer
> release.
> (As we have not really completed our verification of SHEC, we are wonde=
ring if
> we should make it open for early preview.)

Although we're late in the Hammer roadmap, it's a good time for an early =
preview. It will help show what needs to be changed to accomodate the SHE=
C plugin.

Cheers

> Thank you in advance,
> Takeshi Miyamae
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--n5UC0GakqB9mQOp5QsaK0qxE6r438fT41
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlSsBI4ACgkQ8dLMyEl6F20MkwCgg8r+wG1S7h3rxXq6cxc1dsV2
qN0An02plY/ZxoNM14yLz4tKjEQFsN8C
=oTLQ
-----END PGP SIGNATURE-----

--n5UC0GakqB9mQOp5QsaK0qxE6r438fT41--
