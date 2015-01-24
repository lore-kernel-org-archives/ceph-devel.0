From: Loic Dachary <loic@dachary.org>
Subject: Re: mSHEC r33 release
Date: Sat, 24 Jan 2015 17:20:27 +0100
Message-ID: <54C3C64B.4080804@dachary.org>
References: <870DE8DBB716524BAE51B2D499EC81E40AA64D91@g01jpexmbyt24> <54C25D3E.3080202@dachary.org> <870DE8DBB716524BAE51B2D499EC81E40AA64EC2@g01jpexmbyt24>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="D3kGOK9fh2hpo12Nn7F5BAcHXC989o4xv"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:46566 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752381AbbAXQUa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 24 Jan 2015 11:20:30 -0500
In-Reply-To: <870DE8DBB716524BAE51B2D499EC81E40AA64EC2@g01jpexmbyt24>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Miyamae, Takeshi" <miyamae.takeshi@jp.fujitsu.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "Shiozawa, Kensuke" <shiozawa.kennsu@jp.fujitsu.com>, "Nakao, Takanori" <nakao.takanori@jp.fujitsu.com>, "Paul Von-Stamwitz (PVonStamwitz@us.fujitsu.com)" <PVonStamwitz@us.fujitsu.com>, "Kaga, Yoshihiro" <y-kaga@jp.fujitsu.com>, "Kawaguchi, Shotaro" <kawaguchi.s@jp.fujitsu.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--D3kGOK9fh2hpo12Nn7F5BAcHXC989o4xv
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On 24/01/2015 10:09, Miyamae, Takeshi wrote:
> Hi Loic,
>=20
> I have created a pull request of wip-mSHEC.
>=20
> wip-mSHEC pull request #3484
> https://github.com/ceph/ceph/pull/3484
>=20
> Besides, we changed the name of our fork repository.
> https://github.com/t-miyamae/wip-mSHEC
>=20
> I'm not sure that it was done correctly because I am a beginner.
> Would you check it, please?

It looks like the branch from which you created the pull request still is=
 master and not wip-mSHEC. That's not a problem. It only really becomes a=
 problem if you have more than one pull request going on.

Cheers

>=20
> Best regards,
> Takeshi Miyamae
>=20
> -----Original Message-----
> From: Loic Dachary [mailto:loic@dachary.org]=20
> Sent: Friday, January 23, 2015 11:40 PM
> To: Miyamae, Takeshi/=E5=AE=AE=E5=89=8D =E5=89=9B
> Cc: Ceph Development; Shiozawa, Kensuke/=E5=A1=A9=E6=B2=A2 =E8=B3=A2=E8=
=BC=94; Nakao, Takanori/=E4=B8=AD=E5=B0=BE =E9=B7=B9=E8=A9=94; Paul Von-S=
tamwitz (PVonStamwitz@us.fujitsu.com); Kaga, Yoshihiro/=E5=8A=A0=E8=B3=80=
 =E8=8A=B3=E5=AE=8F; Kawaguchi, Shotaro/=E5=B7=9D=E5=8F=A3 =E7=BF=94=E5=A4=
=AA=E6=9C=97
> Subject: Re: mSHEC r33 release
>=20
> Thanks, I'll take a look. Could you please create a pull request agains=
t the master branch ? When you do so, it will be convenient if you submit=
 from a branch that has a descriptive name such as wip-mSHEC or something=
 similar.
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
>=20
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--D3kGOK9fh2hpo12Nn7F5BAcHXC989o4xv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTDxksACgkQ8dLMyEl6F22XOgCeK5GJUBjrzf1q5v2hCMYLjwiH
1mQAni6pJ0D7LdNE+WkJt3a7UHlHFfJv
=1ZXJ
-----END PGP SIGNATURE-----

--D3kGOK9fh2hpo12Nn7F5BAcHXC989o4xv--
