From: Loic Dachary <loic@dachary.org>
Subject: Re: Deadline of Github pull request for Hammer release (question)
Date: Tue, 13 Jan 2015 11:26:08 +0100
Message-ID: <54B4F2C0.2040805@dachary.org>
References: <870DE8DBB716524BAE51B2D499EC81E40AA3F9AB@g01jpexmbyt24> <54AC048E.9040200@dachary.org> <870DE8DBB716524BAE51B2D499EC81E40AA40849@g01jpexmbyt24>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="5j3S4f5Ab5G8dv1GX5auuGA2ieVGaVUaV"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:38169 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751075AbbAMK0L (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Jan 2015 05:26:11 -0500
In-Reply-To: <870DE8DBB716524BAE51B2D499EC81E40AA40849@g01jpexmbyt24>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Miyamae, Takeshi" <miyamae.takeshi@jp.fujitsu.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "Shiozawa, Kensuke" <shiozawa.kennsu@jp.fujitsu.com>, "Nakao, Takanori" <nakao.takanori@jp.fujitsu.com>, "Paul Von-Stamwitz (PVonStamwitz@us.fujitsu.com)" <PVonStamwitz@us.fujitsu.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5j3S4f5Ab5G8dv1GX5auuGA2ieVGaVUaV
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On 13/01/2015 11:24, Miyamae, Takeshi wrote:
> Hi Loic,
>=20
>> Although we're late in the Hammer roadmap, it's a good time for an ear=
ly preview. It will help show what needs to be changed to accomodate the =
SHEC plugin.
>=20
> Thank you for your advices.
> We have uploaded our latest codes to the following folk repository for =
an early review.
>=20
> https://github.com/miyamae-takeshi/multiple-shec

It's 404 ? Is it a private repository maybe ?

>=20
> SHEC is located in src/erasure-code/shec directory.
>=20
> We are verifying SHEC's advantages on our Ceph cluster. It takes a litt=
le bit more.
> Would you please start the review before that?
>=20
> Best regards,
> Takeshi Miyamae
>=20
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.ke=
rnel.org] On Behalf Of Loic Dachary
> Sent: Wednesday, January 7, 2015 12:52 AM
> To: Miyamae, Takeshi/=E5=AE=AE=E5=89=8D =E5=89=9B
> Cc: Ceph Development; Shiozawa, Kensuke/=E5=A1=A9=E6=B2=A2 =E8=B3=A2=E8=
=BC=94; Nakao, Takanori/=E4=B8=AD=E5=B0=BE =E9=B7=B9=E8=A9=94
> Subject: Re: Deadline of Github pull request for Hammer release (questi=
on)
>=20
> Hi,
>=20
> On 06/01/2015 12:49, Miyamae, Takeshi wrote:
>> Dear Loic,
>>
>> I'm Takeshi Miyamae, one of the authors of SHEC's blueprint.
>>
>> Shingled Erasure Code (SHEC)
>> https://wiki.ceph.com/Planning/Blueprints/Hammer/Shingled_Erasure_Code=

>> _(SHEC)
>=20
> The work you have done is quite impressive :-)
>=20
>> We have revised our blueprint shown in the last CDS to extend our=20
>> erasure code layouts and describe the guideline for choosing SHEC amon=
g various EC plugins.
>> We believe the blueprint now answers all the comments given at the CDS=
=2E
>=20
> Great.
>=20
>> In addition, we would like to ask for your advice on the schedule of=20
>> our github pull request. More specifically, we would like to know its =

>> deadline for Hammer release.
>> (As we have not really completed our verification of SHEC, we are=20
>> wondering if we should make it open for early preview.)
>=20
> Although we're late in the Hammer roadmap, it's a good time for an earl=
y preview. It will help show what needs to be changed to accomodate the S=
HEC plugin.
>=20
> Cheers
>=20
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

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--5j3S4f5Ab5G8dv1GX5auuGA2ieVGaVUaV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlS08sAACgkQ8dLMyEl6F20PfQCgpSUxV7EJJlPSfOKgkBHoQO4a
koIAnjez2kTcoeMR9tCVzjtHdYwu7Bo0
=RXII
-----END PGP SIGNATURE-----

--5j3S4f5Ab5G8dv1GX5auuGA2ieVGaVUaV--
