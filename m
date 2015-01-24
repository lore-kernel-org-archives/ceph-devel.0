From: Loic Dachary <loic@dachary.org>
Subject: Re: mSHEC r33 release
Date: Sat, 24 Jan 2015 17:21:21 +0100
Message-ID: <54C3C681.8040608@dachary.org>
References: <870DE8DBB716524BAE51B2D499EC81E40AA64D91@g01jpexmbyt24> <54C2DBCC.4050207@dachary.org> <870DE8DBB716524BAE51B2D499EC81E40AA64E92@g01jpexmbyt24>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="XBEe5vTBOULxBl8ReUqsbrUCGAeAqLQ4f"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:46570 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752381AbbAXQVY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 24 Jan 2015 11:21:24 -0500
In-Reply-To: <870DE8DBB716524BAE51B2D499EC81E40AA64E92@g01jpexmbyt24>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Miyamae, Takeshi" <miyamae.takeshi@jp.fujitsu.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "Shiozawa, Kensuke" <shiozawa.kennsu@jp.fujitsu.com>, "Nakao, Takanori" <nakao.takanori@jp.fujitsu.com>, "Paul Von-Stamwitz (PVonStamwitz@us.fujitsu.com)" <PVonStamwitz@us.fujitsu.com>, "Kaga, Yoshihiro" <y-kaga@jp.fujitsu.com>, "Kawaguchi, Shotaro" <kawaguchi.s@jp.fujitsu.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XBEe5vTBOULxBl8ReUqsbrUCGAeAqLQ4f
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 24/01/2015 09:13, Miyamae, Takeshi wrote:
> Hi Loic,
>=20
> Thank you for your advice and information.
> Both approaches are attractive and we have started to consider which on=
e to take.
> However, I'm afraid that we might not have enough time to implement and=
 test it
> until the first release of Hammer.

Ok, no problem.

>=20
> Best regards,
> Takeshi Miyamae
>=20
> -----Original Message-----
> From: Loic Dachary [mailto:loic@dachary.org]=20
> Sent: Saturday, January 24, 2015 8:40 AM
> To: Miyamae, Takeshi/=E5=AE=AE=E5=89=8D =E5=89=9B
> Cc: Ceph Development; Shiozawa, Kensuke/=E5=A1=A9=E6=B2=A2 =E8=B3=A2=E8=
=BC=94; Nakao, Takanori/=E4=B8=AD=E5=B0=BE =E9=B7=B9=E8=A9=94; Paul Von-S=
tamwitz (PVonStamwitz@us.fujitsu.com); Kaga, Yoshihiro/=E5=8A=A0=E8=B3=80=
 =E8=8A=B3=E5=AE=8F; Kawaguchi, Shotaro/=E5=B7=9D=E5=8F=A3 =E7=BF=94=E5=A4=
=AA=E6=9C=97
> Subject: Re: mSHEC r33 release
>=20
> Hi,
>=20
> Since the SHEC plugin depends on the jerasure plugin, it would be simpl=
er if it loaded it instead of including it. The main problem with the cur=
rent inclusion is that it does not compile any SIMD acceleration code and=
 loses the benefit of optimization when the CPU can provide it.=20
>=20
> There are two ways out of this=20
>=20
> a) add to the SHEC plugin the same selection that jerasure has (in the =
Makefile and with something like http://workbench.dachary.org/ceph/ceph/b=
lob/master/src/erasure-code/jerasure/ErasureCodePluginSelectJerasure.cc
>=20
> b) compile jerasure as a convenience library that can be included by bo=
th the jerasure and SHEC plugin.
>=20
> The LRC plugin loads the jerasure plugin but the SHEC plugin cannot do =
the same because the standard API at http://workbench.dachary.org/ceph/ce=
ph/blob/master/src/erasure-code/ErasureCodeInterface.h is not enough.
>=20
> Note that this is not a blocker for the inclusion of the plugin and can=
 be done afterwards.
>=20
> Cheers
>=20
> On 23/01/2015 15:30, Miyamae, Takeshi wrote:
>> Hi Loic,
>>
>> We have released mSHEC r33 just now.
>>
>> https://github.com/t-miyamae/ceph
>>
>> NOTABLE CHANGES
>>   - ensure thread safety
>>   - support generator matrix cache (added ErasureCodeShecTableCache.cc=
)
>>   - refer to the shared jerasure 2.0 library
>>   - improve verification of return code in test codes
>>   - add test code for verifying thread safety (added TestErasureCodeSh=
ec_thread.cc)
>>
>> LIMITATION
>>   - There are still lots of minor problems in test codes.
>>     We will fix it by 1/26(mon).
>>
>> Best regards,
>> Takeshi Miyamae
>>
>> N=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDr=EF=BF=BD=EF=BF=BDy=EF=BF=
=BD=EF=BF=BD=EF=BF=BDb=EF=BF=BDX=EF=BF=BD=EF=BF=BD=C7=A7v=EF=BF=BD^=EF=BF=
=BD)=DE=BA{.n=EF=BF=BD+=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD]z=EF=BF=BD=EF=
=BF=BD=EF=BF=BD{ay=EF=BF=BD=1D=CA=87=DA=99=EF=BF=BD,j
> =EF=BF=BD=EF=BF=BDf=EF=BF=BD=EF=BF=BD=EF=BF=BDh=EF=BF=BD=EF=BF=BD=EF=BF=
=BDz=EF=BF=BD=1E=EF=BF=BDw=EF=BF=BD=EF=BF=BD=EF=BF=BD
> =EF=BF=BD=EF=BF=BD=EF=BF=BDj:+v=EF=BF=BD=EF=BF=BD=EF=BF=BDw=EF=BF=BDj=EF=
=BF=BDm=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD
> =EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDzZ+=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=DD=A2j"=EF=BF=BD=EF=BF=BD!tml=3D
>>
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--XBEe5vTBOULxBl8ReUqsbrUCGAeAqLQ4f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTDxoEACgkQ8dLMyEl6F20jUACcDqU2Ci7yMS4XNY8XNUjKVT6x
/tUAoLHTMPNbFZnTFLVYLIYqU64nueRr
=V4qW
-----END PGP SIGNATURE-----

--XBEe5vTBOULxBl8ReUqsbrUCGAeAqLQ4f--
