From: Loic Dachary <loic@dachary.org>
Subject: Re: What should be in the next hammer/firefly release ?
Date: Thu, 10 Sep 2015 13:12:24 +0200
Message-ID: <55F16598.2020002@dachary.org>
References: <870DE8DBB716524BAE51B2D499EC81E40AB98467@g01jpexmbyt24>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="abILqrrBmEvi8gpCjLltjbJDisVq7WQCk"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:53080 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753966AbbIJLM2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Sep 2015 07:12:28 -0400
In-Reply-To: <870DE8DBB716524BAE51B2D499EC81E40AB98467@g01jpexmbyt24>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Miyamae, Takeshi" <miyamae.takeshi@jp.fujitsu.com>, Ceph Development <ceph-devel@vger.kernel.org>
Cc: "PVonStamwitz@us.fujitsu.com" <PVonStamwitz@us.fujitsu.com>, "Toshine, Naoyoshi" <toshine@jp.fujitsu.com>, "Shiozawa, Kensuke" <shiozawa.kennsu@jp.fujitsu.com>, "Nakao, Takanori" <nakao.takanori@jp.fujitsu.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--abILqrrBmEvi8gpCjLltjbJDisVq7WQCk
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

Since SHEC really is a new feature in Infernalis (because it was experime=
ntal before), I'll leave it to Sam and Sage to decide if it's relevant to=
 backport to Hammer. Note that it depends on changes in the erasure code =
base that extend to all plugins. Backporting would unfortunately not be a=
s simple as cherry-picking the commits modifying the shec directories.

Cheers

On 10/09/2015 12:57, Miyamae, Takeshi wrote:
> Hi Loic,
>=20
> As the last pull request #5257 was committed into the main trunk,
> we believe all the SHEC codes in main trunk are ready to be backported =
into Hammer branch.
> What can we do at this moment?
>=20
> Best regards,
> Takeshi Miyamae
>=20
> -----Original Message-----
> From: Miyamae, Takeshi/=E5=AE=AE=E5=89=8D =E5=89=9B=20
> Sent: Thursday, September 3, 2015 4:09 PM
> To: 'ceph-devel-owner@vger.kernel.org'
> Cc: Paul Von-Stamwitz (PVonStamwitz@us.fujitsu.com); Toshine, Naoyoshi/=
=E5=88=A9=E6=A0=B9 =E7=9B=B4=E4=BD=B3; Shiozawa, Kensuke/=E5=A1=A9=E6=B2=A2=
 =E8=B3=A2=E8=BC=94; Nakao, Takanori/=E4=B8=AD=E5=B0=BE =E9=B7=B9=E8=A9=94=
 (nakao.takanori@jp.fujitsu.com)
> Subject: Re: What should be in the next hammer/firefly release ?
>=20
> Dear Loic,
>=20
> We would like to let following two patches be backported to hammer v0.9=
4.4.
> (And our wish is finally backporting these patches to RHCS v1.3.) Can i=
t be possible? If possible, please let us know what should be started at =
first.
> (Caution: #5257 has not been committed to master branch yet.)
>=20
> erasure-code: shec plugin feature #5493
> https://github.com/ceph/ceph/pull/5493
>=20
> erasure code: shec performance optimization by decoding cache #5257
> https://github.com/ceph/ceph/pull/5257
>=20
> Best regards,
> Takeshi Miyamae
>=20
> -----Original Message-----
> From: Loic Dachary <loic <at> dachary.org>
> Subject: What should be in the next hammer/firefly release ?
> Newsgroups: gmane.comp.file-systems.ceph.devel
> Date: 2015-09-02 11:00:53 GMT (15 hours and 32 minutes ago) Hi,
>=20
> I added a link to
>=20
> http://tracker.ceph.com/projects/ceph-releases/wiki/HOWTO#Overview-of-t=
he-backports-in-progress
>=20
> to show all issues that should be in the next point release for
>=20
> hammer v0.94.4 : http://tracker.ceph.com/versions/495
> firefly v0.80.11 : http://tracker.ceph.com/versions/480
>=20
> Cheers
>=20
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
> N=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDr=EF=BF=BD=EF=BF=BDy=EF=BF=
=BD=EF=BF=BD=EF=BF=BDb=EF=BF=BDX=EF=BF=BD=EF=BF=BD=C7=A7v=EF=BF=BD^=EF=BF=
=BD)=DE=BA{.n=EF=BF=BD+=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD]z=EF=BF=BD=EF=
=BF=BD=EF=BF=BD{ay=EF=BF=BD=1D=CA=87=DA=99=EF=BF=BD,j=07=EF=BF=BD=EF=BF=BD=
f=EF=BF=BD=EF=BF=BD=EF=BF=BDh=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD=1E=EF=BF=
=BDw=EF=BF=BD=EF=BF=BD=EF=BF=BD=0C=EF=BF=BD=EF=BF=BD=EF=BF=BDj:+v=EF=BF=BD=
=EF=BF=BD=EF=BF=BDw=EF=BF=BDj=EF=BF=BDm=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=07=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDzZ+=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=DD=A2j"=EF=BF=BD=EF=BF=BD!tml=3D
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--abILqrrBmEvi8gpCjLltjbJDisVq7WQCk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXxZZgACgkQ8dLMyEl6F23rggCfZj83tQ/OQ9lKmW6OsIooEhjW
VpIAoIEVaXnyuh63sOJ2+rryqq3VddaA
=0eMD
-----END PGP SIGNATURE-----

--abILqrrBmEvi8gpCjLltjbJDisVq7WQCk--
