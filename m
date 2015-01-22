From: Loic Dachary <loic@dachary.org>
Subject: Re: Deadline of Github pull request for Hammer release (question)
Date: Thu, 22 Jan 2015 18:29:27 +0100
Message-ID: <54C13377.8020907@dachary.org>
References: <870DE8DBB716524BAE51B2D499EC81E40AA3F9AB@g01jpexmbyt24> <54AC048E.9040200@dachary.org> <870DE8DBB716524BAE51B2D499EC81E40AA40849@g01jpexmbyt24> <54B4F2C0.2040805@dachary.org> <870DE8DBB716524BAE51B2D499EC81E40AA40872@g01jpexmbyt24> <54B5137F.7090902@dachary.org> <870DE8DBB716524BAE51B2D499EC81E40AA40983@g01jpexmbyt24> <54B55DE8.6010003@dachary.org> <870DE8DBB716524BAE51B2D499EC81E40AA5B1F2@g01jpexmbyt24> <54BE0243.60301@dachary.org> <870DE8DBB716524BAE51B2D499EC81E40AA5D363@g01jpexmbyt24> <54BFB3DF.3080305@dachary.org> <870DE8DBB716524BAE51B2D499EC81E40AA62928@g01jpexmbyt24> <54C0C2B8.90907@dachary.org> <870DE8DBB716524BAE51B2D499EC81E40AA62A31@g01jpexmbyt24>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="jHlm1vEQBAl6Mp7klCsS5GcL8A7WeBiBw"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:45442 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752349AbbAVR33 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Jan 2015 12:29:29 -0500
In-Reply-To: <870DE8DBB716524BAE51B2D499EC81E40AA62A31@g01jpexmbyt24>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Miyamae, Takeshi" <miyamae.takeshi@jp.fujitsu.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "Shiozawa, Kensuke" <shiozawa.kennsu@jp.fujitsu.com>, "Nakao, Takanori" <nakao.takanori@jp.fujitsu.com>, "Paul Von-Stamwitz (PVonStamwitz@us.fujitsu.com)" <PVonStamwitz@us.fujitsu.com>, "Kaga, Yoshihiro" <y-kaga@jp.fujitsu.com>, "Kawaguchi, Shotaro" <kawaguchi.s@jp.fujitsu.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jHlm1vEQBAl6Mp7klCsS5GcL8A7WeBiBw
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On 22/01/2015 17:34, Miyamae, Takeshi wrote:
> Hi Loic,
>=20
> Thank you for the code reference. We will use it to improve our codes.
>=20
>> However, I'm not sure I understand why you need threads at all to test=
 the plugin. Could you explain ?
>=20
> Sure. The purpose of using threads is just to find lace bugs and ensure=
 thread safety.

I'm not familiar with the expression "lace bug" and all I could find is h=
ttp://en.wiktionary.org/wiki/lace which does not help me (I'm french, eng=
lish is not my native language). Could you give me the definition of a "l=
ace bug" ?=20

> However, I suppose those tests may be a little adhoc and be far from co=
mpleteness.
> Actually, we couldn't detect some init lace bugs including #7914 (We wi=
ll fix those bugs at the next release).
> Do you have any better ideas to combat these kind of bugs systematicall=
y?
>=20

Race conditions such as http://tracker.ceph.com/issues/7914 are quite dif=
ficult detect with tests and I don't know of a sure method to do so. Care=
fully proofreading the code and keeping the logic simple is probably the =
most effective way ;-) Once a race condition has been fixed, however, it =
should be possible to recreate the conditions for it to appear in a funct=
ional test that can be run with make check.

Note that there are two kind of tests in Ceph : the unit / functional tes=
ts that are run with make check, locally on the developer machine or by a=
 bot on each pull request. These tests run quickly and do not include any=
 benchmarking or stress tests, nor integration tests. The second kind is =
what you find in teuthology : these tests include stress tests, error inj=
ections etc. Most race conditions are discovered by running these teuthol=
ogy tests and analyzing their output.

>> What do you think of my comments (about minimum_to_decode_3 and minimu=
m_to_decode_2 ) ?
>=20
> I don't think current minimum_to_decode_2 is adequate, as you mentioned=
=2E
> The verification of return codes is required and we will compare it wit=
h expectations (EINVAL or EIO).
> However, as for the size of minimum_chunks, as it is hard to pre-estima=
te without knowing
> parity layout because of its random aspect, we won't improve it any mor=
e.

Do you mean that two consecutive runs of minimum_to_decode will provide d=
ifferent results ?=20

> Then, as for minimum_to_decode_3, we found it meaningless to verify min=
imum_chunks because
> that is an error case when array size of want_to_decode and available_c=
hunks are illegally large.
> We will verify only return code of minimum_to_decode and remove the cur=
rent check of
> minimum_chunks in minimum_to_decode_3.

Ok. I'll take a closer look as soon as I can run them and try things.

Thanks for explaining !

>=20
> Best regards,
> Takeshi Miyamae
>=20
> -----Original Message-----
> From: Loic Dachary [mailto:loic@dachary.org]=20
> Sent: Thursday, January 22, 2015 6:28 PM
> To: Miyamae, Takeshi/=E5=AE=AE=E5=89=8D =E5=89=9B
> Cc: Ceph Development; Shiozawa, Kensuke/=E5=A1=A9=E6=B2=A2 =E8=B3=A2=E8=
=BC=94; Nakao, Takanori/=E4=B8=AD=E5=B0=BE =E9=B7=B9=E8=A9=94; Paul Von-S=
tamwitz (PVonStamwitz@us.fujitsu.com)
> Subject: Re: Deadline of Github pull request for Hammer release (questi=
on)
>=20
> Hi,
>=20
> On 22/01/2015 09:42, Miyamae, Takeshi wrote:
>> Hi Loic,
>>
>> Thanks for your additional comments.
>>
>>> Would you be so kind as to update the=20
>>> https://github.com/t-miyamae/ceph/blob/master/src/test/erasure-code/M=

>>> akefile.am
>>
>> Sure. We'll do that.
>>
>>> This is likely to fail on a slow machine. Instead of waiting you shou=
ld use a lock.
>>
>> The purpose of sleep(1) is to ensure sequentiality between threads,=20
>> but it's not enough on slow machines as you mentioned. So, we'd like=20
>> another example that uses a mutex lock. What files should we refer to?=

>=20
> src/test/common/test_sharedptr_registry.cc contains an example. The cla=
sses that are helpful in implementing thread safe are in src/common/Cond.=
h and src/common/Mutex.h
>=20
> However, I'm not sure I understand why you need threads at all to test =
the plugin. Could you explain ?
>=20
>>
>>> They however all have the same assert ( EXPECT_TRUE(shec->matrix =3D=3D=
=20
>>> NULL); )
>>
>> We agree that EINVAL is better than EIO on verifying input variables. =

>> We'll review our whole sources and fix both our plugin and test codes.=

>=20
> Thanks :-) What do you think of my comments (about minimum_to_decode_3 =
and minimum_to_decode_2 ) ?
>=20
> Cheers
>=20
>>
>> P.S. We are debugging thread safe mSHEC to release it tomorrow.
>>
>> Best regards,
>> Takeshi Miyamae
>>
>> -----Original Message-----
>> From: Loic Dachary [mailto:loic@dachary.org]
>> Sent: Wednesday, January 21, 2015 11:13 PM
>> To: Miyamae, Takeshi/=E5=AE=AE=E5=89=8D =E5=89=9B
>> Cc: Ceph Development; Shiozawa, Kensuke/=E5=A1=A9=E6=B2=A2 =E8=B3=A2=E8=
=BC=94; Nakao, Takanori/=E4=B8=AD=E5=B0=BE =E9=B7=B9=E8=A9=94;=20
>> Paul Von-Stamwitz (PVonStamwitz@us.fujitsu.com)
>> Subject: Re: Deadline of Github pull request for Hammer release=20
>> (question)
>>
>> Hi,
>>
>> I see them at https://github.com/t-miyamae/ceph/blob/master/src/test/e=
rasure-code/TestErasureCodeShec.cc etc. thanks ! Would you be so kind as =
to update the https://github.com/t-miyamae/ceph/blob/master/src/test/eras=
ure-code/Makefile.am to add the compilation instructions for these files =
?
>>
>> I see the tests includes a few threads (thread1 to thread5). It looks =
like they are used for measuring performance, am I right ?=20
>>
>> 	pthread_t tid;
>> 	pthread_create(&tid,NULL,thread1,shec);
>> 	sleep(1);
>>
>> This is likely to fail on a slow machine. Instead of waiting you shoul=
d use a lock. You will find examples in other tests, using various techni=
ques depending on the context. If you'd like I could point to one. I'd ha=
ve to better understand the intent of this test before I do.
>>
>> From init_5 to init_22 there are various combinations of parameters wh=
ich suggest checking for all kinds of errors (m being negative, or a stri=
ng instead of a number etc.). They however all have the same assert ( EXP=
ECT_TRUE(shec->matrix =3D=3D NULL); ). It would be better to have an expe=
ctation that verifies the error has been caught as expected. Is it part o=
f what your completing at the moment ?
>>
>> minimum_to_decode_2 expectation for when it succeeds should be more=20
>> precise that
>>
>> 	EXPECT_TRUE(minimum_chunks.size());
>>
>> since minimum_chunks is expecting to have a size that does not vary. A=
nd if it does that would be a problem.
>>
>> In minimum_to_decode_3 after
>>
>> 	EXPECT_NE(want_to_decode,minimum_chunks);
>>
>> you could check the expected content of minimum_chunks also. Unless th=
ere is a random aspect to it ?=20
>>
>> Cheers
>>
>> On 20/01/2015 10:07, Miyamae, Takeshi wrote:
>>> Hi Loic,
>>>
>>> I'd appreciated your help very much.
>>> I have just uploaded 2 test files into the fork repository.
>>>
>>> https://github.com/t-miyamae/ceph
>>> files:
>>>   src/test/erasure-code/TestErasureCodeShec.cc
>>>   src/test/erasure-code/TestErasureCodeShec364.cc
>>>
>>> I'm sorry that tests for the thread safety codes has not been include=
d yet.
>>>
>>> Thank you in advance,
>>> Takeshi Miyamae
>>>
>>> -----Original Message-----
>>> From: ceph-devel-owner@vger.kernel.org=20
>>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Loic Dachary
>>> Sent: Tuesday, January 20, 2015 4:23 PM
>>> To: Miyamae, Takeshi/=E5=AE=AE=E5=89=8D =E5=89=9B
>>> Cc: Ceph Development; Shiozawa, Kensuke/=E5=A1=A9=E6=B2=A2 =E8=B3=A2=E8=
=BC=94; Nakao, Takanori/=E4=B8=AD=E5=B0=BE =E9=B7=B9=E8=A9=94;
>>> Paul Von-Stamwitz (PVonStamwitz@us.fujitsu.com)
>>> Subject: Re: Deadline of Github pull request for Hammer release
>>> (question)
>>>
>>> Hi,
>>>
>>> Thanks for the update. To speed up things, I could review what's alre=
ady published. Did you add the tests already ?
>>>
>>> Cheers
>>>
>>> On 20/01/2015 01:48, Miyamae, Takeshi wrote:
>>>> Hi Loic,
>>>>
>>>> Thank you for your advice which suggested providing SHEC as an extra=
-package.
>>>> We believe it's generally a good idea, but we are hoping SHEC would =

>>>> be merged into Hammer because that would have an apparent advantage =

>>>> from a viewpoint of maintenance support.
>>>>
>>>> As for the thread safety issue, we totally agree with you and we are=
 trying to solve it.
>>>> We will complete it in a few days and we'd like to ask you to review=
=20
>>>> it again so that it might be in time for Hammer's feature freeze (v0=
=2E93).
>>>>
>>>> Best regards,
>>>> Takeshi Miyamae
>>>>
>>>> -----Original Message-----
>>>> From: ceph-devel-owner@vger.kernel.org=20
>>>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Loic Dachary
>>>> Sent: Wednesday, January 14, 2015 3:03 AM
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
>>>> On 13/01/2015 18:05, Miyamae, Takeshi wrote:
>>>>> Hi Loic,
>>>>>
>>>>> Thank you for your quick review.
>>>>>
>>>>>> Could you reference the jerasure files (they are in the jerasure=20
>>>>>> plugin already) instead of including them in your patch ?
>>>>>
>>>>> We had used the reference of jerasure v2.0 files before, but=20
>>>>> changed to including v1.2 files after the patent issue.
>>>>
>>>> If you are refering to http://erasure-code-patents.xyz/, it can safe=
ly be ignored.
>>>>
>>>>> However, we can restore the reference right away if we are needed.
>>>>>
>>>>>> In ::prepare you reuse the matrix, if possible. If your intention =

>>>>>> is to improve performances, you should consider using the same app=
roach as the isa plugin.
>>>>>
>>>>> We have found a performance issue caused by redundant=20
>>>>> initializations of the module, and solved it by caching the initial=
ized variables in memory.
>>>>> If that is the same approach as isa-plugin you mentioned, we also=20
>>>>> do not have the same issue any more.
>>>>
>>>> The ISA plugin approach is thread safe, that's the important part.
>>>>
>>>>>> I'll have more comments once you have unit / functional tests
>>>>>
>>>>> We do have the those unit/functional tests, but the server is unrea=
chable at this moment.
>>>>> Please let us upload them to the repository tomorrow.
>>>>
>>>> Great.
>>>>
>>>>>> Regarding your initial question: I think it is too late for the Ha=
mmer release.
>>>>>
>>>>> We are so disappointed to hear that, but we must apologize for the =
late request.
>>>>> If there would be any chance that SHEC be pulled into hammer, we=20
>>>>> are very happy to conduct all the necessary tests by ourselves.
>>>>> Please let us know the detailed schedule if this is a feasible opti=
on.
>>>>
>>>> Note that since this is a plugin it will be easy for someone to inst=
all it on a Hammer cluster, simply by copying the plugin files to each OS=
D / MON and restarting them. If there is some kind of urgency for you to =
be able to install this new plugin, I would advise making a package that =
contains just this file, restart the OSD once installed and recommend tha=
t the installation is done on all machines of the cluster (because every =
OSD / MON need to know about the plugin).=20
>>>>
>>>> Cheers
>>>>
>>>>> Best regards,
>>>>> Takeshi Miyamae
>>>>>
>>>>> -----Original Message-----
>>>>> From: ceph-devel-owner@vger.kernel.org=20
>>>>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Loic Dachary=

>>>>> Sent: Tuesday, January 13, 2015 9:46 PM
>>>>> To: Miyamae, Takeshi/=E5=AE=AE=E5=89=8D =E5=89=9B
>>>>> Cc: Ceph Development; Shiozawa, Kensuke/=E5=A1=A9=E6=B2=A2 =E8=B3=A2=
=E8=BC=94; Nakao, Takanori/=E4=B8=AD=E5=B0=BE
>>>>> =E9=B7=B9=E8=A9=94;
>>>>> Paul Von-Stamwitz (PVonStamwitz@us.fujitsu.com)
>>>>> Subject: Re: Deadline of Github pull request for Hammer release
>>>>> (question)
>>>>>
>>>>> Hi,
>>>>>
>>>>> It's a great start :-) A few comments:
>>>>>
>>>>> Could you reference the jerasure files (they are in the jerasure pl=
ugin already) instead of including them in your patch ?
>>>>>
>>>>> In ::prepare you reuse the matrix, if possible. If your intention=20
>>>>> is to improve performances, you should consider using the same=20
>>>>> approach as the isa plugin. See=20
>>>>> http://workbench.dachary.org/ceph/ceph/blob/giant/src/erasure-code/=

>>>>> i
>>>>> s
>>>>> a
>>>>> /ErasureCodePluginIsa.cc#L36 which is and independent type=20
>>>>> http://workbench.dachary.org/ceph/ceph/blob/giant/src/erasure-code/=

>>>>> i s a /ErasureCodeIsaTableCache.h with only one instance and is=20
>>>>> populated as needed and protected by a lock to make it thread safe =
:
>>>>> http://workbench.dachary.org/ceph/ceph/blob/giant/src/erasure-code/=

>>>>> i
>>>>> s
>>>>> a
>>>>> /ErasureCodeIsaTableCache.h#L101
>>>>>
>>>>> I'll have more comments once you have unit / functional tests ( sim=
ilar to http://workbench.dachary.org/ceph/ceph/blob/giant/src/test/erasur=
e-code/TestErasureCodeJerasure.cc ).=20
>>>>>
>>>>> Regarding your initial question: I think it is too late for the Ham=
mer release. But from what I read it looks like we'll be able to merge in=
 the early stages of the next release and that will give us time to prope=
rly test it.
>>>>>
>>>>> Cheers
>>>>>
>>>>> On 13/01/2015 11:34, Miyamae, Takeshi wrote:
>>>>>> Hi Loic,
>>>>>>
>>>>>> I'm so sorry. The following is the correct repository.
>>>>>>
>>>>>> https://github.com/t-miyamae/ceph
>>>>>>
>>>>>> Best regards,
>>>>>> Takeshi Miyamae
>>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Loic Dachary [mailto:loic@dachary.org]
>>>>>> Sent: Tuesday, January 13, 2015 7:26 PM
>>>>>> To: Miyamae, Takeshi/=E5=AE=AE=E5=89=8D =E5=89=9B
>>>>>> Cc: Ceph Development; Shiozawa, Kensuke/=E5=A1=A9=E6=B2=A2 =E8=B3=A2=
=E8=BC=94; Nakao, Takanori/=E4=B8=AD=E5=B0=BE
>>>>>> =E9=B7=B9=E8=A9=94;
>>>>>> Paul Von-Stamwitz (PVonStamwitz@us.fujitsu.com)
>>>>>> Subject: Re: Deadline of Github pull request for Hammer release
>>>>>> (question)
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> On 13/01/2015 11:24, Miyamae, Takeshi wrote:
>>>>>>> Hi Loic,
>>>>>>>
>>>>>>>> Although we're late in the Hammer roadmap, it's a good time for =
an early preview. It will help show what needs to be changed to accomodat=
e the SHEC plugin.
>>>>>>>
>>>>>>> Thank you for your advices.
>>>>>>> We have uploaded our latest codes to the following folk repositor=
y for an early review.
>>>>>>>
>>>>>>> https://github.com/miyamae-takeshi/multiple-shec
>>>>>>
>>>>>> It's 404 ? Is it a private repository maybe ?
>>>>>>
>>>>>>>
>>>>>>> SHEC is located in src/erasure-code/shec directory.
>>>>>>>
>>>>>>> We are verifying SHEC's advantages on our Ceph cluster. It takes =
a little bit more.
>>>>>>> Would you please start the review before that?
>>>>>>>
>>>>>>> Best regards,
>>>>>>> Takeshi Miyamae
>>>>>>>
>>>>>>> -----Original Message-----
>>>>>>> From: ceph-devel-owner@vger.kernel.org=20
>>>>>>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Loic=20
>>>>>>> Dachary
>>>>>>> Sent: Wednesday, January 7, 2015 12:52 AM
>>>>>>> To: Miyamae, Takeshi/=E5=AE=AE=E5=89=8D =E5=89=9B
>>>>>>> Cc: Ceph Development; Shiozawa, Kensuke/=E5=A1=A9=E6=B2=A2 =E8=B3=
=A2=E8=BC=94; Nakao, Takanori/=E4=B8=AD=E5=B0=BE
>>>>>>> =E9=B7=B9=E8=A9=94
>>>>>>> Subject: Re: Deadline of Github pull request for Hammer release
>>>>>>> (question)
>>>>>>>
>>>>>>> Hi,
>>>>>>>
>>>>>>> On 06/01/2015 12:49, Miyamae, Takeshi wrote:
>>>>>>>> Dear Loic,
>>>>>>>>
>>>>>>>> I'm Takeshi Miyamae, one of the authors of SHEC's blueprint.
>>>>>>>>
>>>>>>>> Shingled Erasure Code (SHEC)
>>>>>>>> https://wiki.ceph.com/Planning/Blueprints/Hammer/Shingled_Erasur=

>>>>>>>> e
>>>>>>>> _
>>>>>>>> C
>>>>>>>> o
>>>>>>>> d
>>>>>>>> e
>>>>>>>> _(SHEC)
>>>>>>>
>>>>>>> The work you have done is quite impressive :-)
>>>>>>>
>>>>>>>> We have revised our blueprint shown in the last CDS to extend=20
>>>>>>>> our erasure code layouts and describe the guideline for choosing=
 SHEC among various EC plugins.
>>>>>>>> We believe the blueprint now answers all the comments given at t=
he CDS.
>>>>>>>
>>>>>>> Great.
>>>>>>>
>>>>>>>> In addition, we would like to ask for your advice on the=20
>>>>>>>> schedule of our github pull request. More specifically, we would=
=20
>>>>>>>> like to know its deadline for Hammer release.
>>>>>>>> (As we have not really completed our verification of SHEC, we=20
>>>>>>>> are wondering if we should make it open for early preview.)
>>>>>>>
>>>>>>> Although we're late in the Hammer roadmap, it's a good time for a=
n early preview. It will help show what needs to be changed to accomodate=
 the SHEC plugin.
>>>>>>>
>>>>>>> Cheers
>>>>>>>
>>>>>>>> Thank you in advance,
>>>>>>>> Takeshi Miyamae
>>>>>>>>
>>>>>>>> --
>>>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-d=
evel"=20
>>>>>>>> in the body of a message to majordomo@vger.kernel.org More=20
>>>>>>>> majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>>>>
>>>>>>>
>>>>>>> --
>>>>>>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>>>>>>
>>>>>>
>>>>>> --
>>>>>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
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
>>> N     r  y   b X  =C7=A7v ^ )=DE=BA{.n +   z ]z   {ay =1D=CA=87=DA=99=
 ,j   f   h   z =1E w  =20
>>    j:+v   w j m         zZ+     =DD=A2j"  !tml=3D
>>>
>>
>> --
>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>
>> N     r  y   b X  =C7=A7v ^ )=DE=BA{.n +   z ]z   {ay =1D=CA=87=DA=99 =
,j   f   h   z =1E w  =20
>    j:+v   w j m         zZ+     =DD=A2j"  !tml=3D
>>
>=20
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--jHlm1vEQBAl6Mp7klCsS5GcL8A7WeBiBw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTBM3cACgkQ8dLMyEl6F22FcgCcD48MFXqPV3mXE/mESjZQQQXl
DaoAnRaRqwFkYoVjiVk9D7d3MgE3eyhp
=c6jU
-----END PGP SIGNATURE-----

--jHlm1vEQBAl6Mp7klCsS5GcL8A7WeBiBw--
