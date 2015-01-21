From: Loic Dachary <loic@dachary.org>
Subject: Re: Deadline of Github pull request for Hammer release (question)
Date: Wed, 21 Jan 2015 15:31:02 +0100
Message-ID: <54BFB826.6010102@dachary.org>
References: <870DE8DBB716524BAE51B2D499EC81E40AA3F9AB@g01jpexmbyt24> <54AC048E.9040200@dachary.org> <870DE8DBB716524BAE51B2D499EC81E40AA40849@g01jpexmbyt24> <54B4F2C0.2040805@dachary.org> <870DE8DBB716524BAE51B2D499EC81E40AA40872@g01jpexmbyt24> <54B5137F.7090902@dachary.org> <870DE8DBB716524BAE51B2D499EC81E40AA40983@g01jpexmbyt24> <54B55DE8.6010003@dachary.org> <870DE8DBB716524BAE51B2D499EC81E40AA5B1F2@g01jpexmbyt24> <54BE0243.60301@dachary.org> <870DE8DBB716524BAE51B2D499EC81E40AA5D363@g01jpexmbyt24>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="shPeCpaVShoDQpo8dLqqUNli044hEjAK1"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:44540 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753079AbbAUObF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Jan 2015 09:31:05 -0500
In-Reply-To: <870DE8DBB716524BAE51B2D499EC81E40AA5D363@g01jpexmbyt24>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Miyamae, Takeshi" <miyamae.takeshi@jp.fujitsu.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "Shiozawa, Kensuke" <shiozawa.kennsu@jp.fujitsu.com>, "Nakao, Takanori" <nakao.takanori@jp.fujitsu.com>, "Paul Von-Stamwitz (PVonStamwitz@us.fujitsu.com)" <PVonStamwitz@us.fujitsu.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--shPeCpaVShoDQpo8dLqqUNli044hEjAK1
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi again,

int ErasureCodeShec::decode(const set<int> &want_to_read,
			    const map<int, bufferlist> &chunks,
			    map<int, bufferlist> *decoded)
{
  vector<int> have;

  if (!decoded || !decoded->empty()){
    return -EIO;
  }


could you add this with return -EINVAL instead of -EIO to the ErasureCode=
::decode function instead ? It's a good sanity check in all cases.

Cheers

On 20/01/2015 10:07, Miyamae, Takeshi wrote:
> Hi Loic,
>=20
> I'd appreciated your help very much.
> I have just uploaded 2 test files into the fork repository.
>=20
> https://github.com/t-miyamae/ceph
> files:
>   src/test/erasure-code/TestErasureCodeShec.cc
>   src/test/erasure-code/TestErasureCodeShec364.cc
>=20
> I'm sorry that tests for the thread safety codes has not been included =
yet.
>=20
> Thank you in advance,
> Takeshi Miyamae
>=20
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.ke=
rnel.org] On Behalf Of Loic Dachary
> Sent: Tuesday, January 20, 2015 4:23 PM
> To: Miyamae, Takeshi/=E5=AE=AE=E5=89=8D =E5=89=9B
> Cc: Ceph Development; Shiozawa, Kensuke/=E5=A1=A9=E6=B2=A2 =E8=B3=A2=E8=
=BC=94; Nakao, Takanori/=E4=B8=AD=E5=B0=BE =E9=B7=B9=E8=A9=94; Paul Von-S=
tamwitz (PVonStamwitz@us.fujitsu.com)
> Subject: Re: Deadline of Github pull request for Hammer release (questi=
on)
>=20
> Hi,
>=20
> Thanks for the update. To speed up things, I could review what's alread=
y published. Did you add the tests already ?
>=20
> Cheers
>=20
> On 20/01/2015 01:48, Miyamae, Takeshi wrote:
>> Hi Loic,
>>
>> Thank you for your advice which suggested providing SHEC as an extra-p=
ackage.
>> We believe it's generally a good idea, but we are hoping SHEC would be=
=20
>> merged into Hammer because that would have an apparent advantage from =

>> a viewpoint of maintenance support.
>>
>> As for the thread safety issue, we totally agree with you and we are t=
rying to solve it.
>> We will complete it in a few days and we'd like to ask you to review=20
>> it again so that it might be in time for Hammer's feature freeze (v0.9=
3).
>>
>> Best regards,
>> Takeshi Miyamae
>>
>> -----Original Message-----
>> From: ceph-devel-owner@vger.kernel.org=20
>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Loic Dachary
>> Sent: Wednesday, January 14, 2015 3:03 AM
>> To: Miyamae, Takeshi/=E5=AE=AE=E5=89=8D =E5=89=9B
>> Cc: Ceph Development; Shiozawa, Kensuke/=E5=A1=A9=E6=B2=A2 =E8=B3=A2=E8=
=BC=94; Nakao, Takanori/=E4=B8=AD=E5=B0=BE =E9=B7=B9=E8=A9=94;=20
>> Paul Von-Stamwitz (PVonStamwitz@us.fujitsu.com)
>> Subject: Re: Deadline of Github pull request for Hammer release=20
>> (question)
>>
>> Hi,
>>
>> On 13/01/2015 18:05, Miyamae, Takeshi wrote:
>>> Hi Loic,
>>>
>>> Thank you for your quick review.
>>>
>>>> Could you reference the jerasure files (they are in the jerasure=20
>>>> plugin already) instead of including them in your patch ?
>>>
>>> We had used the reference of jerasure v2.0 files before, but changed =

>>> to including v1.2 files after the patent issue.
>>
>> If you are refering to http://erasure-code-patents.xyz/, it can safely=
 be ignored.
>>
>>> However, we can restore the reference right away if we are needed.
>>>
>>>> In ::prepare you reuse the matrix, if possible. If your intention is=
=20
>>>> to improve performances, you should consider using the same approach=
 as the isa plugin.
>>>
>>> We have found a performance issue caused by redundant initializations=
=20
>>> of the module, and solved it by caching the initialized variables in =
memory.
>>> If that is the same approach as isa-plugin you mentioned, we also do =

>>> not have the same issue any more.
>>
>> The ISA plugin approach is thread safe, that's the important part.
>>
>>>> I'll have more comments once you have unit / functional tests
>>>
>>> We do have the those unit/functional tests, but the server is unreach=
able at this moment.
>>> Please let us upload them to the repository tomorrow.
>>
>> Great.
>>
>>>> Regarding your initial question: I think it is too late for the Hamm=
er release.
>>>
>>> We are so disappointed to hear that, but we must apologize for the la=
te request.
>>> If there would be any chance that SHEC be pulled into hammer, we are =

>>> very happy to conduct all the necessary tests by ourselves.
>>> Please let us know the detailed schedule if this is a feasible option=
=2E
>>
>> Note that since this is a plugin it will be easy for someone to instal=
l it on a Hammer cluster, simply by copying the plugin files to each OSD =
/ MON and restarting them. If there is some kind of urgency for you to be=
 able to install this new plugin, I would advise making a package that co=
ntains just this file, restart the OSD once installed and recommend that =
the installation is done on all machines of the cluster (because every OS=
D / MON need to know about the plugin).=20
>>
>> Cheers
>>
>>> Best regards,
>>> Takeshi Miyamae
>>>
>>> -----Original Message-----
>>> From: ceph-devel-owner@vger.kernel.org=20
>>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Loic Dachary
>>> Sent: Tuesday, January 13, 2015 9:46 PM
>>> To: Miyamae, Takeshi/=E5=AE=AE=E5=89=8D =E5=89=9B
>>> Cc: Ceph Development; Shiozawa, Kensuke/=E5=A1=A9=E6=B2=A2 =E8=B3=A2=E8=
=BC=94; Nakao, Takanori/=E4=B8=AD=E5=B0=BE =E9=B7=B9=E8=A9=94;
>>> Paul Von-Stamwitz (PVonStamwitz@us.fujitsu.com)
>>> Subject: Re: Deadline of Github pull request for Hammer release
>>> (question)
>>>
>>> Hi,
>>>
>>> It's a great start :-) A few comments:
>>>
>>> Could you reference the jerasure files (they are in the jerasure plug=
in already) instead of including them in your patch ?
>>>
>>> In ::prepare you reuse the matrix, if possible. If your intention is =

>>> to improve performances, you should consider using the same approach =

>>> as the isa plugin. See=20
>>> http://workbench.dachary.org/ceph/ceph/blob/giant/src/erasure-code/is=

>>> a
>>> /ErasureCodePluginIsa.cc#L36 which is and independent type=20
>>> http://workbench.dachary.org/ceph/ceph/blob/giant/src/erasure-code/is=

>>> a /ErasureCodeIsaTableCache.h with only one instance and is populated=
=20
>>> as needed and protected by a lock to make it thread safe :
>>> http://workbench.dachary.org/ceph/ceph/blob/giant/src/erasure-code/is=

>>> a
>>> /ErasureCodeIsaTableCache.h#L101
>>>
>>> I'll have more comments once you have unit / functional tests ( simil=
ar to http://workbench.dachary.org/ceph/ceph/blob/giant/src/test/erasure-=
code/TestErasureCodeJerasure.cc ).=20
>>>
>>> Regarding your initial question: I think it is too late for the Hamme=
r release. But from what I read it looks like we'll be able to merge in t=
he early stages of the next release and that will give us time to properl=
y test it.
>>>
>>> Cheers
>>>
>>> On 13/01/2015 11:34, Miyamae, Takeshi wrote:
>>>> Hi Loic,
>>>>
>>>> I'm so sorry. The following is the correct repository.
>>>>
>>>> https://github.com/t-miyamae/ceph
>>>>
>>>> Best regards,
>>>> Takeshi Miyamae
>>>>
>>>> -----Original Message-----
>>>> From: Loic Dachary [mailto:loic@dachary.org]
>>>> Sent: Tuesday, January 13, 2015 7:26 PM
>>>> To: Miyamae, Takeshi/=E5=AE=AE=E5=89=8D =E5=89=9B
>>>> Cc: Ceph Development; Shiozawa, Kensuke/=E5=A1=A9=E6=B2=A2 =E8=B3=A2=
=E8=BC=94; Nakao, Takanori/=E4=B8=AD=E5=B0=BE=20
>>>> =E9=B7=B9=E8=A9=94;
>>>> Paul Von-Stamwitz (PVonStamwitz@us.fujitsu.com)
>>>> Subject: Re: Deadline of Github pull request for Hammer release
>>>> (question)
>>>>
>>>> Hi,
>>>>
>>>> On 13/01/2015 11:24, Miyamae, Takeshi wrote:
>>>>> Hi Loic,
>>>>>
>>>>>> Although we're late in the Hammer roadmap, it's a good time for an=
 early preview. It will help show what needs to be changed to accomodate =
the SHEC plugin.
>>>>>
>>>>> Thank you for your advices.
>>>>> We have uploaded our latest codes to the following folk repository =
for an early review.
>>>>>
>>>>> https://github.com/miyamae-takeshi/multiple-shec
>>>>
>>>> It's 404 ? Is it a private repository maybe ?
>>>>
>>>>>
>>>>> SHEC is located in src/erasure-code/shec directory.
>>>>>
>>>>> We are verifying SHEC's advantages on our Ceph cluster. It takes a =
little bit more.
>>>>> Would you please start the review before that?
>>>>>
>>>>> Best regards,
>>>>> Takeshi Miyamae
>>>>>
>>>>> -----Original Message-----
>>>>> From: ceph-devel-owner@vger.kernel.org=20
>>>>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Loic Dachary=

>>>>> Sent: Wednesday, January 7, 2015 12:52 AM
>>>>> To: Miyamae, Takeshi/=E5=AE=AE=E5=89=8D =E5=89=9B
>>>>> Cc: Ceph Development; Shiozawa, Kensuke/=E5=A1=A9=E6=B2=A2 =E8=B3=A2=
=E8=BC=94; Nakao, Takanori/=E4=B8=AD=E5=B0=BE=20
>>>>> =E9=B7=B9=E8=A9=94
>>>>> Subject: Re: Deadline of Github pull request for Hammer release
>>>>> (question)
>>>>>
>>>>> Hi,
>>>>>
>>>>> On 06/01/2015 12:49, Miyamae, Takeshi wrote:
>>>>>> Dear Loic,
>>>>>>
>>>>>> I'm Takeshi Miyamae, one of the authors of SHEC's blueprint.
>>>>>>
>>>>>> Shingled Erasure Code (SHEC)
>>>>>> https://wiki.ceph.com/Planning/Blueprints/Hammer/Shingled_Erasure_=

>>>>>> C
>>>>>> o
>>>>>> d
>>>>>> e
>>>>>> _(SHEC)
>>>>>
>>>>> The work you have done is quite impressive :-)
>>>>>
>>>>>> We have revised our blueprint shown in the last CDS to extend our =

>>>>>> erasure code layouts and describe the guideline for choosing SHEC =
among various EC plugins.
>>>>>> We believe the blueprint now answers all the comments given at the=
 CDS.
>>>>>
>>>>> Great.
>>>>>
>>>>>> In addition, we would like to ask for your advice on the schedule =

>>>>>> of our github pull request. More specifically, we would like to=20
>>>>>> know its deadline for Hammer release.
>>>>>> (As we have not really completed our verification of SHEC, we are =

>>>>>> wondering if we should make it open for early preview.)
>>>>>
>>>>> Although we're late in the Hammer roadmap, it's a good time for an =
early preview. It will help show what needs to be changed to accomodate t=
he SHEC plugin.
>>>>>
>>>>> Cheers
>>>>>
>>>>>> Thank you in advance,
>>>>>> Takeshi Miyamae
>>>>>>
>>>>>> --
>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el"=20
>>>>>> in the body of a message to majordomo@vger.kernel.org More=20
>>>>>> majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>>
>>>>>
>>>>> --
>>>>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>>>>
>>>>
>>>> --
>>>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
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


--shPeCpaVShoDQpo8dLqqUNli044hEjAK1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlS/uCYACgkQ8dLMyEl6F22zRACcDZR+zqiCLdV9sb4xUplW3mLE
DzMAnigiwsQPBRDS+e9jVUkXMgO66WV9
=l/Hv
-----END PGP SIGNATURE-----

--shPeCpaVShoDQpo8dLqqUNli044hEjAK1--
