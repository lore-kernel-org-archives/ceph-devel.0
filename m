From: Loic Dachary <loic@dachary.org>
Subject: Re: Deadline of Github pull request for Hammer release (question)
Date: Mon, 26 Jan 2015 12:02:45 +0100
Message-ID: <54C61ED5.5040603@dachary.org>
References: <870DE8DBB716524BAE51B2D499EC81E40AA3F9AB@g01jpexmbyt24> <54C250C1.2010703@dachary.org> <870DE8DBB716524BAE51B2D499EC81E40AA66142@g01jpexmbyt24>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="EeB6GTPUBC1oDaNuHO7eAuXpHft6xfjB0"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:47096 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753351AbbAZLCs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 26 Jan 2015 06:02:48 -0500
In-Reply-To: <870DE8DBB716524BAE51B2D499EC81E40AA66142@g01jpexmbyt24>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Miyamae, Takeshi" <miyamae.takeshi@jp.fujitsu.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "Shiozawa, Kensuke" <shiozawa.kennsu@jp.fujitsu.com>, "Nakao, Takanori" <nakao.takanori@jp.fujitsu.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EeB6GTPUBC1oDaNuHO7eAuXpHft6xfjB0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks for the snippet, I'll add it to the non regression from the pull r=
equest you sent :-)

Cheers

On 26/01/2015 06:43, Miyamae, Takeshi wrote:
> Hi Loic,
>=20
>> Note that you also need to update
>=20
> We have prepared mSHEC's parameter sets which we think will be commonly=
 used.
> Because I'm not sure how to update another person's repository, we will=
 write down
> those parameter sets in this mail.
> If we are required to do something, please let us know.
>=20
> while read k m c ; do
>     for stripe_width in $STRIPE_WIDTHS ; do
>         ceph_erasure_code_non_regression --stripe-width $stripe_width -=
-plugin shec --parameter technique=3Dmultiple --parameter k=3D$k --parame=
ter m=3D$m --parameter c=3D$c $ACTION $VERBOSE $MYDIR
>     done
> done <<EOF
> 1 1 1
> 2 1 1
> 3 2 1
> 3 2 2
> 3 3 2
> 4 1 1
> 4 2 2
> 4 3 2
> 5 2 1
> 6 3 2
> 6 4 2
> 6 4 3
> 7 2 1
> 8 3 2
> 8 4 2
> 8 4 3
> 9 4 2
> 9 5 3
> 12 7 4
> EOF
>=20
> Best regards,
> Takeshi Miyamae
>=20
> -----Original Message-----
> From: Loic Dachary [mailto:loic@dachary.org]=20
> Sent: Friday, January 23, 2015 10:47 PM
> To: Miyamae, Takeshi/=E5=AE=AE=E5=89=8D =E5=89=9B
> Cc: Ceph Development; Shiozawa, Kensuke/=E5=A1=A9=E6=B2=A2 =E8=B3=A2=E8=
=BC=94; Nakao, Takanori/=E4=B8=AD=E5=B0=BE =E9=B7=B9=E8=A9=94
> Subject: Re: Deadline of Github pull request for Hammer release (questi=
on)
>=20
> Hi,
>=20
> Note that you also need to update=20
>=20
> https://github.com/dachary/ceph-erasure-code-corpus/blob/master/v0.85-7=
64-gf3a1532/non-regression.sh
>=20
> to include non regression tests for the most common cases of the SHEC p=
lugin encoding / decoding. This is run by make check (this repository is =
a submodule of Ceph). It helps make sure that content encoded / decoded w=
ith a given version of the plugin can be encoded / decoded exactly in the=
 same way by all future versions.
>=20
> Cheers
>=20
> On 06/01/2015 12:49, Miyamae, Takeshi wrote:
>> Dear Loic,
>>
>> I'm Takeshi Miyamae, one of the authors of SHEC's blueprint.
>>
>> Shingled Erasure Code (SHEC)
>> https://wiki.ceph.com/Planning/Blueprints/Hammer/Shingled_Erasure_Code=

>> _(SHEC)
>>
>> We have revised our blueprint shown in the last CDS to extend our=20
>> erasure code layouts and describe the guideline for choosing SHEC amon=
g various EC plugins.
>> We believe the blueprint now answers all the comments given at the CDS=
=2E
>>
>> In addition, we would like to ask for your advice on the schedule of=20
>> our github pull request. More specifically, we would like to know its =

>> deadline for Hammer release.
>> (As we have not really completed our verification of SHEC, we are=20
>> wondering if we should make it open for early preview.)
>>
>> Thank you in advance,
>> Takeshi Miyamae
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =

>> in the body of a message to majordomo@vger.kernel.org More majordomo=20
>> info at  http://vger.kernel.org/majordomo-info.html
>>
>=20
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>=20
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


--EeB6GTPUBC1oDaNuHO7eAuXpHft6xfjB0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTGHtUACgkQ8dLMyEl6F22VkwCeO1+xdD/h5WxTNZuIOJQogbrM
mKIAoIrXxtuggKOy+uJaHbsn+ZN2MAG6
=YysZ
-----END PGP SIGNATURE-----

--EeB6GTPUBC1oDaNuHO7eAuXpHft6xfjB0--
