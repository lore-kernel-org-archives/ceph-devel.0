From: Loic Dachary <loic@dachary.org>
Subject: Re: Deadline of Github pull request for Hammer release (question)
Date: Fri, 23 Jan 2015 14:46:41 +0100
Message-ID: <54C250C1.2010703@dachary.org>
References: <870DE8DBB716524BAE51B2D499EC81E40AA3F9AB@g01jpexmbyt24>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="JMmlmBkcHQ9464VCDLeWS25AniwQReX8U"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:45986 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752249AbbAWNqn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Jan 2015 08:46:43 -0500
In-Reply-To: <870DE8DBB716524BAE51B2D499EC81E40AA3F9AB@g01jpexmbyt24>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Miyamae, Takeshi" <miyamae.takeshi@jp.fujitsu.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "Shiozawa, Kensuke" <shiozawa.kennsu@jp.fujitsu.com>, "Nakao, Takanori" <nakao.takanori@jp.fujitsu.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JMmlmBkcHQ9464VCDLeWS25AniwQReX8U
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

Note that you also need to update=20

https://github.com/dachary/ceph-erasure-code-corpus/blob/master/v0.85-764=
-gf3a1532/non-regression.sh

to include non regression tests for the most common cases of the SHEC plu=
gin encoding / decoding. This is run by make check (this repository is a =
submodule of Ceph). It helps make sure that content encoded / decoded wit=
h a given version of the plugin can be encoded / decoded exactly in the s=
ame way by all future versions.

Cheers

On 06/01/2015 12:49, Miyamae, Takeshi wrote:
> Dear Loic,
>=20
> I'm Takeshi Miyamae, one of the authors of SHEC's blueprint.
>=20
> Shingled Erasure Code (SHEC)
> https://wiki.ceph.com/Planning/Blueprints/Hammer/Shingled_Erasure_Code_=
(SHEC)
>=20
> We have revised our blueprint shown in the last CDS to extend our erasu=
re code
> layouts and describe the guideline for choosing SHEC among various EC p=
lugins.
> We believe the blueprint now answers all the comments given at the CDS.=

>=20
> In addition, we would like to ask for your advice on the schedule of ou=
r github
> pull request. More specifically, we would like to know its deadline for=
 Hammer
> release.
> (As we have not really completed our verification of SHEC, we are wonde=
ring if
> we should make it open for early preview.)
>=20
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


--JMmlmBkcHQ9464VCDLeWS25AniwQReX8U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTCUMEACgkQ8dLMyEl6F213VwCgicCLQPYIbnTQ61Q/e+KuFJBW
os8AoJQFQwqsfeW30NGw0kbCrHohHxXa
=9a99
-----END PGP SIGNATURE-----

--JMmlmBkcHQ9464VCDLeWS25AniwQReX8U--
