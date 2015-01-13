From: Loic Dachary <loic@dachary.org>
Subject: Re: Deadline of Github pull request for Hammer release (question)
Date: Tue, 13 Jan 2015 13:45:51 +0100
Message-ID: <54B5137F.7090902@dachary.org>
References: <870DE8DBB716524BAE51B2D499EC81E40AA3F9AB@g01jpexmbyt24> <54AC048E.9040200@dachary.org> <870DE8DBB716524BAE51B2D499EC81E40AA40849@g01jpexmbyt24> <54B4F2C0.2040805@dachary.org> <870DE8DBB716524BAE51B2D499EC81E40AA40872@g01jpexmbyt24>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="8kd0lu4QIuIbQP0Xapmmgl6tcupoTMG0U"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:38283 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750981AbbAMMp5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Jan 2015 07:45:57 -0500
In-Reply-To: <870DE8DBB716524BAE51B2D499EC81E40AA40872@g01jpexmbyt24>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Miyamae, Takeshi" <miyamae.takeshi@jp.fujitsu.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "Shiozawa, Kensuke" <shiozawa.kennsu@jp.fujitsu.com>, "Nakao, Takanori" <nakao.takanori@jp.fujitsu.com>, "Paul Von-Stamwitz (PVonStamwitz@us.fujitsu.com)" <PVonStamwitz@us.fujitsu.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8kd0lu4QIuIbQP0Xapmmgl6tcupoTMG0U
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

It's a great start :-) A few comments:

Could you reference the jerasure files (they are in the jerasure plugin a=
lready) instead of including them in your patch ?

In ::prepare you reuse the matrix, if possible. If your intention is to i=
mprove performances, you should consider using the same approach as the i=
sa plugin. See http://workbench.dachary.org/ceph/ceph/blob/giant/src/eras=
ure-code/isa/ErasureCodePluginIsa.cc#L36 which is and independent type ht=
tp://workbench.dachary.org/ceph/ceph/blob/giant/src/erasure-code/isa/Eras=
ureCodeIsaTableCache.h with only one instance and is populated as needed =
and protected by a lock to make it thread safe : http://workbench.dachary=
=2Eorg/ceph/ceph/blob/giant/src/erasure-code/isa/ErasureCodeIsaTableCache=
=2Eh#L101

I'll have more comments once you have unit / functional tests ( similar t=
o http://workbench.dachary.org/ceph/ceph/blob/giant/src/test/erasure-code=
/TestErasureCodeJerasure.cc ).=20

Regarding your initial question: I think it is too late for the Hammer re=
lease. But from what I read it looks like we'll be able to merge in the e=
arly stages of the next release and that will give us time to properly te=
st it.

Cheers

On 13/01/2015 11:34, Miyamae, Takeshi wrote:
> Hi Loic,
>=20
> I'm so sorry. The following is the correct repository.
>=20
> https://github.com/t-miyamae/ceph
>=20
> Best regards,
> Takeshi Miyamae
>=20
> -----Original Message-----
> From: Loic Dachary [mailto:loic@dachary.org]=20
> Sent: Tuesday, January 13, 2015 7:26 PM
> To: Miyamae, Takeshi/=E5=AE=AE=E5=89=8D =E5=89=9B
> Cc: Ceph Development; Shiozawa, Kensuke/=E5=A1=A9=E6=B2=A2 =E8=B3=A2=E8=
=BC=94; Nakao, Takanori/=E4=B8=AD=E5=B0=BE =E9=B7=B9=E8=A9=94; Paul Von-S=
tamwitz (PVonStamwitz@us.fujitsu.com)
> Subject: Re: Deadline of Github pull request for Hammer release (questi=
on)
>=20
> Hi,
>=20
> On 13/01/2015 11:24, Miyamae, Takeshi wrote:
>> Hi Loic,
>>
>>> Although we're late in the Hammer roadmap, it's a good time for an ea=
rly preview. It will help show what needs to be changed to accomodate the=
 SHEC plugin.
>>
>> Thank you for your advices.
>> We have uploaded our latest codes to the following folk repository for=
 an early review.
>>
>> https://github.com/miyamae-takeshi/multiple-shec
>=20
> It's 404 ? Is it a private repository maybe ?
>=20
>>
>> SHEC is located in src/erasure-code/shec directory.
>>
>> We are verifying SHEC's advantages on our Ceph cluster. It takes a lit=
tle bit more.
>> Would you please start the review before that?
>>
>> Best regards,
>> Takeshi Miyamae
>>
>> -----Original Message-----
>> From: ceph-devel-owner@vger.kernel.org=20
>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Loic Dachary
>> Sent: Wednesday, January 7, 2015 12:52 AM
>> To: Miyamae, Takeshi/=E5=AE=AE=E5=89=8D =E5=89=9B
>> Cc: Ceph Development; Shiozawa, Kensuke/=E5=A1=A9=E6=B2=A2 =E8=B3=A2=E8=
=BC=94; Nakao, Takanori/=E4=B8=AD=E5=B0=BE =E9=B7=B9=E8=A9=94
>> Subject: Re: Deadline of Github pull request for Hammer release=20
>> (question)
>>
>> Hi,
>>
>> On 06/01/2015 12:49, Miyamae, Takeshi wrote:
>>> Dear Loic,
>>>
>>> I'm Takeshi Miyamae, one of the authors of SHEC's blueprint.
>>>
>>> Shingled Erasure Code (SHEC)
>>> https://wiki.ceph.com/Planning/Blueprints/Hammer/Shingled_Erasure_Cod=

>>> e
>>> _(SHEC)
>>
>> The work you have done is quite impressive :-)
>>
>>> We have revised our blueprint shown in the last CDS to extend our=20
>>> erasure code layouts and describe the guideline for choosing SHEC amo=
ng various EC plugins.
>>> We believe the blueprint now answers all the comments given at the CD=
S.
>>
>> Great.
>>
>>> In addition, we would like to ask for your advice on the schedule of =

>>> our github pull request. More specifically, we would like to know its=
=20
>>> deadline for Hammer release.
>>> (As we have not really completed our verification of SHEC, we are=20
>>> wondering if we should make it open for early preview.)
>>
>> Although we're late in the Hammer roadmap, it's a good time for an ear=
ly preview. It will help show what needs to be changed to accomodate the =
SHEC plugin.
>>
>> Cheers
>>
>>> Thank you in advance,
>>> Takeshi Miyamae
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
=20
>>> in the body of a message to majordomo@vger.kernel.org More majordomo =

>>> info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>> --
>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>
>=20
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--8kd0lu4QIuIbQP0Xapmmgl6tcupoTMG0U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlS1E38ACgkQ8dLMyEl6F23KjgCgncDmvVFgMtxwaWjVPCN4OF+9
mf0AoJMvo7xvrJz0wTkCgtmM3sKj1tMW
=oUyr
-----END PGP SIGNATURE-----

--8kd0lu4QIuIbQP0Xapmmgl6tcupoTMG0U--
