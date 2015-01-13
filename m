From: Loic Dachary <loic@dachary.org>
Subject: Re: Deadline of Github pull request for Hammer release (question)
Date: Tue, 13 Jan 2015 19:03:20 +0100
Message-ID: <54B55DE8.6010003@dachary.org>
References: <870DE8DBB716524BAE51B2D499EC81E40AA3F9AB@g01jpexmbyt24> <54AC048E.9040200@dachary.org> <870DE8DBB716524BAE51B2D499EC81E40AA40849@g01jpexmbyt24> <54B4F2C0.2040805@dachary.org> <870DE8DBB716524BAE51B2D499EC81E40AA40872@g01jpexmbyt24> <54B5137F.7090902@dachary.org> <870DE8DBB716524BAE51B2D499EC81E40AA40983@g01jpexmbyt24>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="HbuXmR0ex5QlghWQmBOmwVEnsscKwqcMD"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:38570 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751446AbbAMSDX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Jan 2015 13:03:23 -0500
In-Reply-To: <870DE8DBB716524BAE51B2D499EC81E40AA40983@g01jpexmbyt24>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Miyamae, Takeshi" <miyamae.takeshi@jp.fujitsu.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "Shiozawa, Kensuke" <shiozawa.kennsu@jp.fujitsu.com>, "Nakao, Takanori" <nakao.takanori@jp.fujitsu.com>, "Paul Von-Stamwitz (PVonStamwitz@us.fujitsu.com)" <PVonStamwitz@us.fujitsu.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HbuXmR0ex5QlghWQmBOmwVEnsscKwqcMD
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On 13/01/2015 18:05, Miyamae, Takeshi wrote:
> Hi Loic,
>=20
> Thank you for your quick review.
>=20
>> Could you reference the jerasure files (they are in the jerasure plugi=
n already)
>> instead of including them in your patch ?
>=20
> We had used the reference of jerasure v2.0 files before, but changed to=
 including v1.2 files
> after the patent issue.

If you are refering to http://erasure-code-patents.xyz/, it can safely be=
 ignored.

> However, we can restore the reference right away if we are needed.
>=20
>> In ::prepare you reuse the matrix, if possible. If your intention is t=
o improve performances,
>> you should consider using the same approach as the isa plugin.
>=20
> We have found a performance issue caused by redundant initializations o=
f the module,
> and solved it by caching the initialized variables in memory.
> If that is the same approach as isa-plugin you mentioned, we also do no=
t have the same
> issue any more.

The ISA plugin approach is thread safe, that's the important part.

>> I'll have more comments once you have unit / functional tests
>=20
> We do have the those unit/functional tests, but the server is unreachab=
le at this moment.
> Please let us upload them to the repository tomorrow.

Great.

>> Regarding your initial question: I think it is too late for the Hammer=
 release.
>=20
> We are so disappointed to hear that, but we must apologize for the late=
 request.
> If there would be any chance that SHEC be pulled into hammer, we are ve=
ry happy to
> conduct all the necessary tests by ourselves.
> Please let us know the detailed schedule if this is a feasible option.

Note that since this is a plugin it will be easy for someone to install i=
t on a Hammer cluster, simply by copying the plugin files to each OSD / M=
ON and restarting them. If there is some kind of urgency for you to be ab=
le to install this new plugin, I would advise making a package that conta=
ins just this file, restart the OSD once installed and recommend that the=
 installation is done on all machines of the cluster (because every OSD /=
 MON need to know about the plugin).=20

Cheers

> Best regards,
> Takeshi Miyamae
>=20
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.ke=
rnel.org] On Behalf Of Loic Dachary
> Sent: Tuesday, January 13, 2015 9:46 PM
> To: Miyamae, Takeshi/=E5=AE=AE=E5=89=8D =E5=89=9B
> Cc: Ceph Development; Shiozawa, Kensuke/=E5=A1=A9=E6=B2=A2 =E8=B3=A2=E8=
=BC=94; Nakao, Takanori/=E4=B8=AD=E5=B0=BE =E9=B7=B9=E8=A9=94; Paul Von-S=
tamwitz (PVonStamwitz@us.fujitsu.com)
> Subject: Re: Deadline of Github pull request for Hammer release (questi=
on)
>=20
> Hi,
>=20
> It's a great start :-) A few comments:
>=20
> Could you reference the jerasure files (they are in the jerasure plugin=
 already) instead of including them in your patch ?
>=20
> In ::prepare you reuse the matrix, if possible. If your intention is to=
 improve performances, you should consider using the same approach as the=
 isa plugin. See http://workbench.dachary.org/ceph/ceph/blob/giant/src/er=
asure-code/isa/ErasureCodePluginIsa.cc#L36 which is and independent type =
http://workbench.dachary.org/ceph/ceph/blob/giant/src/erasure-code/isa/Er=
asureCodeIsaTableCache.h with only one instance and is populated as neede=
d and protected by a lock to make it thread safe : http://workbench.dacha=
ry.org/ceph/ceph/blob/giant/src/erasure-code/isa/ErasureCodeIsaTableCache=
=2Eh#L101
>=20
> I'll have more comments once you have unit / functional tests ( similar=
 to http://workbench.dachary.org/ceph/ceph/blob/giant/src/test/erasure-co=
de/TestErasureCodeJerasure.cc ).=20
>=20
> Regarding your initial question: I think it is too late for the Hammer =
release. But from what I read it looks like we'll be able to merge in the=
 early stages of the next release and that will give us time to properly =
test it.
>=20
> Cheers
>=20
> On 13/01/2015 11:34, Miyamae, Takeshi wrote:
>> Hi Loic,
>>
>> I'm so sorry. The following is the correct repository.
>>
>> https://github.com/t-miyamae/ceph
>>
>> Best regards,
>> Takeshi Miyamae
>>
>> -----Original Message-----
>> From: Loic Dachary [mailto:loic@dachary.org]
>> Sent: Tuesday, January 13, 2015 7:26 PM
>> To: Miyamae, Takeshi/=E5=AE=AE=E5=89=8D =E5=89=9B
>> Cc: Ceph Development; Shiozawa, Kensuke/=E5=A1=A9=E6=B2=A2 =E8=B3=A2=E8=
=BC=94; Nakao, Takanori/=E4=B8=AD=E5=B0=BE =E9=B7=B9=E8=A9=94;=20
>> Paul Von-Stamwitz (PVonStamwitz@us.fujitsu.com)
>> Subject: Re: Deadline of Github pull request for Hammer release=20
>> (question)
>>
>> Hi,
>>
>> On 13/01/2015 11:24, Miyamae, Takeshi wrote:
>>> Hi Loic,
>>>
>>>> Although we're late in the Hammer roadmap, it's a good time for an e=
arly preview. It will help show what needs to be changed to accomodate th=
e SHEC plugin.
>>>
>>> Thank you for your advices.
>>> We have uploaded our latest codes to the following folk repository fo=
r an early review.
>>>
>>> https://github.com/miyamae-takeshi/multiple-shec
>>
>> It's 404 ? Is it a private repository maybe ?
>>
>>>
>>> SHEC is located in src/erasure-code/shec directory.
>>>
>>> We are verifying SHEC's advantages on our Ceph cluster. It takes a li=
ttle bit more.
>>> Would you please start the review before that?
>>>
>>> Best regards,
>>> Takeshi Miyamae
>>>
>>> -----Original Message-----
>>> From: ceph-devel-owner@vger.kernel.org=20
>>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Loic Dachary
>>> Sent: Wednesday, January 7, 2015 12:52 AM
>>> To: Miyamae, Takeshi/=E5=AE=AE=E5=89=8D =E5=89=9B
>>> Cc: Ceph Development; Shiozawa, Kensuke/=E5=A1=A9=E6=B2=A2 =E8=B3=A2=E8=
=BC=94; Nakao, Takanori/=E4=B8=AD=E5=B0=BE =E9=B7=B9=E8=A9=94
>>> Subject: Re: Deadline of Github pull request for Hammer release
>>> (question)
>>>
>>> Hi,
>>>
>>> On 06/01/2015 12:49, Miyamae, Takeshi wrote:
>>>> Dear Loic,
>>>>
>>>> I'm Takeshi Miyamae, one of the authors of SHEC's blueprint.
>>>>
>>>> Shingled Erasure Code (SHEC)
>>>> https://wiki.ceph.com/Planning/Blueprints/Hammer/Shingled_Erasure_Co=

>>>> d
>>>> e
>>>> _(SHEC)
>>>
>>> The work you have done is quite impressive :-)
>>>
>>>> We have revised our blueprint shown in the last CDS to extend our=20
>>>> erasure code layouts and describe the guideline for choosing SHEC am=
ong various EC plugins.
>>>> We believe the blueprint now answers all the comments given at the C=
DS.
>>>
>>> Great.
>>>
>>>> In addition, we would like to ask for your advice on the schedule of=
=20
>>>> our github pull request. More specifically, we would like to know=20
>>>> its deadline for Hammer release.
>>>> (As we have not really completed our verification of SHEC, we are=20
>>>> wondering if we should make it open for early preview.)
>>>
>>> Although we're late in the Hammer roadmap, it's a good time for an ea=
rly preview. It will help show what needs to be changed to accomodate the=
 SHEC plugin.
>>>
>>> Cheers
>>>
>>>> Thank you in advance,
>>>> Takeshi Miyamae
>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
"=20
>>>> in the body of a message to majordomo@vger.kernel.org More majordomo=
=20
>>>> info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>
>>> --
>>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
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


--HbuXmR0ex5QlghWQmBOmwVEnsscKwqcMD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlS1XegACgkQ8dLMyEl6F21z0wCgiRmdsnNfhAGiFboDsK3OffUS
NX8An3T6FTxjuvXY5kGl35Tk1wSrsLoI
=D7yd
-----END PGP SIGNATURE-----

--HbuXmR0ex5QlghWQmBOmwVEnsscKwqcMD--
