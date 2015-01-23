From: Loic Dachary <loic@dachary.org>
Subject: Re: Deadline of Github pull request for Hammer release (question)
Date: Fri, 23 Jan 2015 14:38:12 +0100
Message-ID: <54C24EC4.4090902@dachary.org>
References: <870DE8DBB716524BAE51B2D499EC81E40AA3F9AB@g01jpexmbyt24> <54AC048E.9040200@dachary.org> <870DE8DBB716524BAE51B2D499EC81E40AA40849@g01jpexmbyt24> <54B4F2C0.2040805@dachary.org> <870DE8DBB716524BAE51B2D499EC81E40AA40872@g01jpexmbyt24> <54B5137F.7090902@dachary.org> <870DE8DBB716524BAE51B2D499EC81E40AA40983@g01jpexmbyt24> <54B55DE8.6010003@dachary.org> <870DE8DBB716524BAE51B2D499EC81E40AA5B1F2@g01jpexmbyt24> <54BE0243.60301@dachary.org> <870DE8DBB716524BAE51B2D499EC81E40AA5D363@g01jpexmbyt24> <54BFB3DF.3080305@dachary.org> <870DE8DBB716524BAE51B2D499EC81E40AA62928@g01jpexmbyt24> <54C0C2B8.90907@dachary.org> <870DE8DBB716524BAE51B2D499EC81E40AA62A31@g01jpexmbyt24> <54C13377.8020907@dachary.org> <870DE8DBB716524BAE51B2D499EC81E40AA63B38@g01jpexmbyt24> <54C20F9D.9080806@dachary.org>
 <870DE8DBB716524BAE51B2D499EC81E40AA64D3D@g01jpexmbyt24>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="amBhgAtCKcjH35Xrfbd2BIB1j9Cu8PMes"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:45981 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752662AbbAWNiP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Jan 2015 08:38:15 -0500
In-Reply-To: <870DE8DBB716524BAE51B2D499EC81E40AA64D3D@g01jpexmbyt24>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Miyamae, Takeshi" <miyamae.takeshi@jp.fujitsu.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "Shiozawa, Kensuke" <shiozawa.kennsu@jp.fujitsu.com>, "Nakao, Takanori" <nakao.takanori@jp.fujitsu.com>, "Paul Von-Stamwitz (PVonStamwitz@us.fujitsu.com)" <PVonStamwitz@us.fujitsu.com>, "Kaga, Yoshihiro" <y-kaga@jp.fujitsu.com>, "Kawaguchi, Shotaro" <kawaguchi.s@jp.fujitsu.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--amBhgAtCKcjH35Xrfbd2BIB1j9Cu8PMes
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On 23/01/2015 13:47, Miyamae, Takeshi wrote:
> Hi Loic,
>=20
>> But for a given PG, minimum_to_decode will always return the same chun=
ks, right ?
>=20
> To be precise, PG, broken OSDs, generator matrix and complicated calcul=
ation logic are
> required to predict the size of minimum_chunks.
> Because those are almost equivalent to whole implementation of minimum_=
to_decode,
> we feel that might be no longer a testing.

Ok, I get it :-) I was suggesting that in addition to=20

EXPECT_NE(want_to_decode,minimum_chunks);

you could add

expected_minimum_chunks.insert(3)
expected_minimum_chunks.insert(5)
expected_minimum_chunks.insert(8)
EXPECT_EQ(expected_minimum_chunks,minimum_chunks);

because this will always be true for this test since the input is always =
the same. And if for some reason it comes out different, then it means we=
 have a problem.

Do you see a problem with that ?

Cheers


>=20
> If you mentioned quantitative evaluation of SHEC's read data during rec=
overy, we have
> already evaluated it as an average size of minimum_chunks by calling mi=
nimum_to_decode
> with all input patterns.
>=20
> Best regards,
> Takeshi Miyamae
>=20
> -----Original Message-----
> From: Loic Dachary [mailto:loic@dachary.org]=20
> Sent: Friday, January 23, 2015 6:09 PM
> To: Miyamae, Takeshi/=E5=AE=AE=E5=89=8D =E5=89=9B
> Cc: Ceph Development; Shiozawa, Kensuke/=E5=A1=A9=E6=B2=A2 =E8=B3=A2=E8=
=BC=94; Nakao, Takanori/=E4=B8=AD=E5=B0=BE =E9=B7=B9=E8=A9=94; Paul Von-S=
tamwitz (PVonStamwitz@us.fujitsu.com); Kaga, Yoshihiro/=E5=8A=A0=E8=B3=80=
 =E8=8A=B3=E5=AE=8F; Kawaguchi, Shotaro/=E5=B7=9D=E5=8F=A3 =E7=BF=94=E5=A4=
=AA=E6=9C=97
> Subject: Re: Deadline of Github pull request for Hammer release (questi=
on)
>=20
>=20
> Hi,
>=20
> On 23/01/2015 02:16, Miyamae, Takeshi wrote:
>> Hi Loic,
>>
>>> Could you give me the definition of a "lace bug" ?
>>
>> I'm sorry I meant "race bug". It was just a typo (I'm farthest from a =
native English speaker ...).
>>
>>> Note that there are two kind of tests in Ceph : ...
>>
>> OK. I understand the Ceph's style of testing.
>>
>>> Do you mean that two consecutive runs of minimum_to_decode will provi=
de different results ?
>>
>> Yes, they will. The reason is that SHEC's layout (=3Dcalculation range=
s=20
>> of parities) can be asymmetric, which means that the size of=20
>> minimum_chunks (=3Dthe number of chunks that must be read at least fro=
m the disks) depends on IDs of the broken chunks.
>> For instance, in case of SHEC(5,3,2) as described below, two chunks=20
>> would be needed in some PG cases (where single broken chunk were 1, 2,=
=20
>> or b), while three chunks in other PG cases (where single broken chunk=
 were 3, 4, 5, or c).
>>
>> SHEC(5,3,2)'s layout :
>>   data chunks     12345
>>   parity chunk a  -----
>>   parity chunk b  --
>>   parity chunk c    ---
>>   ("---" means calculation ranges of each parity)
>>
>> We called it a random aspect of SHEC's minimum_chunks.
>=20
> But for a given PG, minimum_to_decode will always return the same chunk=
s, right ?
>=20
> Cheers
>=20
>>
>> Best regards,
>> Takeshi Miyamae
>>
>> -----Original Message-----
>> From: Loic Dachary [mailto:loic@dachary.org]
>> Sent: Friday, January 23, 2015 2:29 AM
>> To: Miyamae, Takeshi/=E5=AE=AE=E5=89=8D =E5=89=9B
>> Cc: Ceph Development; Shiozawa, Kensuke/=E5=A1=A9=E6=B2=A2 =E8=B3=A2=E8=
=BC=94; Nakao, Takanori/=E4=B8=AD=E5=B0=BE =E9=B7=B9=E8=A9=94;=20
>> Paul Von-Stamwitz (PVonStamwitz@us.fujitsu.com); Kaga, Yoshihiro/=E5=8A=
=A0=E8=B3=80=20
>> =E8=8A=B3=E5=AE=8F; Kawaguchi, Shotaro/=E5=B7=9D=E5=8F=A3 =E7=BF=94=E5=
=A4=AA=E6=9C=97
>> Subject: Re: Deadline of Github pull request for Hammer release=20
>> (question)
>>
>> Hi,
>>
>> On 22/01/2015 17:34, Miyamae, Takeshi wrote:
>>> Hi Loic,
>>>
>>> Thank you for the code reference. We will use it to improve our codes=
=2E
>>>
>>>> However, I'm not sure I understand why you need threads at all to te=
st the plugin. Could you explain ?
>>>
>>> Sure. The purpose of using threads is just to find lace bugs and ensu=
re thread safety.
>>
>> I'm not familiar with the expression "lace bug" and all I could find i=
s http://en.wiktionary.org/wiki/lace which does not help me (I'm french, =
english is not my native language). Could you give me the definition of a=
 "lace bug" ?=20
>>
>>> However, I suppose those tests may be a little adhoc and be far from =
completeness.
>>> Actually, we couldn't detect some init lace bugs including #7914 (We =
will fix those bugs at the next release).
>>> Do you have any better ideas to combat these kind of bugs systematica=
lly?
>>>
>>
>> Race conditions such as http://tracker.ceph.com/issues/7914 are quite =
difficult detect with tests and I don't know of a sure method to do so. C=
arefully proofreading the code and keeping the logic simple is probably t=
he most effective way ;-) Once a race condition has been fixed, however, =
it should be possible to recreate the conditions for it to appear in a fu=
nctional test that can be run with make check.
>>
>> Note that there are two kind of tests in Ceph : the unit / functional =
tests that are run with make check, locally on the developer machine or b=
y a bot on each pull request. These tests run quickly and do not include =
any benchmarking or stress tests, nor integration tests. The second kind =
is what you find in teuthology : these tests include stress tests, error =
injections etc. Most race conditions are discovered by running these teut=
hology tests and analyzing their output.
>>
>>>> What do you think of my comments (about minimum_to_decode_3 and mini=
mum_to_decode_2 ) ?
>>>
>>> I don't think current minimum_to_decode_2 is adequate, as you mention=
ed.
>>> The verification of return codes is required and we will compare it w=
ith expectations (EINVAL or EIO).
>>> However, as for the size of minimum_chunks, as it is hard to=20
>>> pre-estimate without knowing parity layout because of its random aspe=
ct, we won't improve it any more.
>>
>> Do you mean that two consecutive runs of minimum_to_decode will provid=
e different results ?=20
>>
>>> Then, as for minimum_to_decode_3, we found it meaningless to verify=20
>>> minimum_chunks because that is an error case when array size of want_=
to_decode and available_chunks are illegally large.
>>> We will verify only return code of minimum_to_decode and remove the=20
>>> current check of minimum_chunks in minimum_to_decode_3.
>>
>> Ok. I'll take a closer look as soon as I can run them and try things.
>>
>> Thanks for explaining !
>>
>>>
>>> Best regards,
>>> Takeshi Miyamae
>>>
>>> -----Original Message-----
>>> From: Loic Dachary [mailto:loic@dachary.org]
>>> Sent: Thursday, January 22, 2015 6:28 PM
>>> To: Miyamae, Takeshi/=E5=AE=AE=E5=89=8D =E5=89=9B
>>> Cc: Ceph Development; Shiozawa, Kensuke/=E5=A1=A9=E6=B2=A2 =E8=B3=A2=E8=
=BC=94; Nakao, Takanori/=E4=B8=AD=E5=B0=BE =E9=B7=B9=E8=A9=94;
>>> Paul Von-Stamwitz (PVonStamwitz@us.fujitsu.com)
>>> Subject: Re: Deadline of Github pull request for Hammer release
>>> (question)
>>>
>>> Hi,
>>>
>>> On 22/01/2015 09:42, Miyamae, Takeshi wrote:
>>>> Hi Loic,
>>>>
>>>> Thanks for your additional comments.
>>>>
>>>>> Would you be so kind as to update the=20
>>>>> https://github.com/t-miyamae/ceph/blob/master/src/test/erasure-code=

>>>>> /
>>>>> M
>>>>> akefile.am
>>>>
>>>> Sure. We'll do that.
>>>>
>>>>> This is likely to fail on a slow machine. Instead of waiting you sh=
ould use a lock.
>>>>
>>>> The purpose of sleep(1) is to ensure sequentiality between threads, =

>>>> but it's not enough on slow machines as you mentioned. So, we'd like=
=20
>>>> another example that uses a mutex lock. What files should we refer t=
o?
>>>
>>> src/test/common/test_sharedptr_registry.cc contains an example. The=20
>>> classes that are helpful in implementing thread safe are in=20
>>> src/common/Cond.h and src/common/Mutex.h
>>>
>>> However, I'm not sure I understand why you need threads at all to tes=
t the plugin. Could you explain ?
>>>
>>>>
>>>>> They however all have the same assert ( EXPECT_TRUE(shec->matrix =3D=
=3D=20
>>>>> NULL); )
>>>>
>>>> We agree that EINVAL is better than EIO on verifying input variables=
=2E=20
>>>> We'll review our whole sources and fix both our plugin and test code=
s.
>>>
>>> Thanks :-) What do you think of my comments (about minimum_to_decode_=
3 and minimum_to_decode_2 ) ?
>>>
>>> Cheers
>>>
>>>>
>>>> P.S. We are debugging thread safe mSHEC to release it tomorrow.
>>>>
>>>> Best regards,
>>>> Takeshi Miyamae
>>>>
>>>> -----Original Message-----
>>>> From: Loic Dachary [mailto:loic@dachary.org]
>>>> Sent: Wednesday, January 21, 2015 11:13 PM
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
>>>> I see them at https://github.com/t-miyamae/ceph/blob/master/src/test=
/erasure-code/TestErasureCodeShec.cc etc. thanks ! Would you be so kind a=
s to update the https://github.com/t-miyamae/ceph/blob/master/src/test/er=
asure-code/Makefile.am to add the compilation instructions for these file=
s ?
>>>>
>>>> I see the tests includes a few threads (thread1 to thread5). It look=
s like they are used for measuring performance, am I right ?=20
>>>>
>>>> 	pthread_t tid;
>>>> 	pthread_create(&tid,NULL,thread1,shec);
>>>> 	sleep(1);
>>>>
>>>> This is likely to fail on a slow machine. Instead of waiting you sho=
uld use a lock. You will find examples in other tests, using various tech=
niques depending on the context. If you'd like I could point to one. I'd =
have to better understand the intent of this test before I do.
>>>>
>>>> From init_5 to init_22 there are various combinations of parameters =
which suggest checking for all kinds of errors (m being negative, or a st=
ring instead of a number etc.). They however all have the same assert ( E=
XPECT_TRUE(shec->matrix =3D=3D NULL); ). It would be better to have an ex=
pectation that verifies the error has been caught as expected. Is it part=
 of what your completing at the moment ?
>>>>
>>>> minimum_to_decode_2 expectation for when it succeeds should be more =

>>>> precise that
>>>>
>>>> 	EXPECT_TRUE(minimum_chunks.size());
>>>>
>>>> since minimum_chunks is expecting to have a size that does not vary.=
 And if it does that would be a problem.
>>>>
>>>> In minimum_to_decode_3 after
>>>>
>>>> 	EXPECT_NE(want_to_decode,minimum_chunks);
>>>>
>>>> you could check the expected content of minimum_chunks also. Unless =
there is a random aspect to it ?=20
>>>>
>>>> Cheers
>>>>
>>>> On 20/01/2015 10:07, Miyamae, Takeshi wrote:
>>>>> Hi Loic,
>>>>>
>>>>> I'd appreciated your help very much.
>>>>> I have just uploaded 2 test files into the fork repository.
>>>>>
>>>>> https://github.com/t-miyamae/ceph
>>>>> files:
>>>>>   src/test/erasure-code/TestErasureCodeShec.cc
>>>>>   src/test/erasure-code/TestErasureCodeShec364.cc
>>>>>
>>>>> I'm sorry that tests for the thread safety codes has not been inclu=
ded yet.
>>>>>
>>>>> Thank you in advance,
>>>>> Takeshi Miyamae
>>>>>
>>>>> -----Original Message-----
>>>>> From: ceph-devel-owner@vger.kernel.org=20
>>>>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Loic Dachary=

>>>>> Sent: Tuesday, January 20, 2015 4:23 PM
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
>>>>> Thanks for the update. To speed up things, I could review what's al=
ready published. Did you add the tests already ?
>>>>>
>>>>> Cheers
>>>>>
>>>>> On 20/01/2015 01:48, Miyamae, Takeshi wrote:
>>>>>> Hi Loic,
>>>>>>
>>>>>> Thank you for your advice which suggested providing SHEC as an ext=
ra-package.
>>>>>> We believe it's generally a good idea, but we are hoping SHEC=20
>>>>>> would be merged into Hammer because that would have an apparent=20
>>>>>> advantage from a viewpoint of maintenance support.
>>>>>>
>>>>>> As for the thread safety issue, we totally agree with you and we a=
re trying to solve it.
>>>>>> We will complete it in a few days and we'd like to ask you to=20
>>>>>> review it again so that it might be in time for Hammer's feature f=
reeze (v0.93).
>>>>>>
>>>>>> Best regards,
>>>>>> Takeshi Miyamae
>>>>>>
>>>>>> -----Original Message-----
>>>>>> From: ceph-devel-owner@vger.kernel.org=20
>>>>>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Loic=20
>>>>>> Dachary
>>>>>> Sent: Wednesday, January 14, 2015 3:03 AM
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
>>>>>> On 13/01/2015 18:05, Miyamae, Takeshi wrote:
>>>>>>> Hi Loic,
>>>>>>>
>>>>>>> Thank you for your quick review.
>>>>>>>
>>>>>>>> Could you reference the jerasure files (they are in the jerasure=
=20
>>>>>>>> plugin already) instead of including them in your patch ?
>>>>>>>
>>>>>>> We had used the reference of jerasure v2.0 files before, but=20
>>>>>>> changed to including v1.2 files after the patent issue.
>>>>>>
>>>>>> If you are refering to http://erasure-code-patents.xyz/, it can sa=
fely be ignored.
>>>>>>
>>>>>>> However, we can restore the reference right away if we are needed=
=2E
>>>>>>>
>>>>>>>> In ::prepare you reuse the matrix, if possible. If your=20
>>>>>>>> intention is to improve performances, you should consider using =
the same approach as the isa plugin.
>>>>>>>
>>>>>>> We have found a performance issue caused by redundant=20
>>>>>>> initializations of the module, and solved it by caching the initi=
alized variables in memory.
>>>>>>> If that is the same approach as isa-plugin you mentioned, we also=
=20
>>>>>>> do not have the same issue any more.
>>>>>>
>>>>>> The ISA plugin approach is thread safe, that's the important part.=

>>>>>>
>>>>>>>> I'll have more comments once you have unit / functional tests
>>>>>>>
>>>>>>> We do have the those unit/functional tests, but the server is unr=
eachable at this moment.
>>>>>>> Please let us upload them to the repository tomorrow.
>>>>>>
>>>>>> Great.
>>>>>>
>>>>>>>> Regarding your initial question: I think it is too late for the =
Hammer release.
>>>>>>>
>>>>>>> We are so disappointed to hear that, but we must apologize for th=
e late request.
>>>>>>> If there would be any chance that SHEC be pulled into hammer, we =

>>>>>>> are very happy to conduct all the necessary tests by ourselves.
>>>>>>> Please let us know the detailed schedule if this is a feasible op=
tion.
>>>>>>
>>>>>> Note that since this is a plugin it will be easy for someone to in=
stall it on a Hammer cluster, simply by copying the plugin files to each =
OSD / MON and restarting them. If there is some kind of urgency for you t=
o be able to install this new plugin, I would advise making a package tha=
t contains just this file, restart the OSD once installed and recommend t=
hat the installation is done on all machines of the cluster (because ever=
y OSD / MON need to know about the plugin).=20
>>>>>>
>>>>>> Cheers
>>>>>>
>>>>>>> Best regards,
>>>>>>> Takeshi Miyamae
>>>>>>>
>>>>>>> -----Original Message-----
>>>>>>> From: ceph-devel-owner@vger.kernel.org=20
>>>>>>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Loic=20
>>>>>>> Dachary
>>>>>>> Sent: Tuesday, January 13, 2015 9:46 PM
>>>>>>> To: Miyamae, Takeshi/=E5=AE=AE=E5=89=8D =E5=89=9B
>>>>>>> Cc: Ceph Development; Shiozawa, Kensuke/=E5=A1=A9=E6=B2=A2 =E8=B3=
=A2=E8=BC=94; Nakao, Takanori/=E4=B8=AD=E5=B0=BE
>>>>>>> =E9=B7=B9=E8=A9=94;
>>>>>>> Paul Von-Stamwitz (PVonStamwitz@us.fujitsu.com)
>>>>>>> Subject: Re: Deadline of Github pull request for Hammer release
>>>>>>> (question)
>>>>>>>
>>>>>>> Hi,
>>>>>>>
>>>>>>> It's a great start :-) A few comments:
>>>>>>>
>>>>>>> Could you reference the jerasure files (they are in the jerasure =
plugin already) instead of including them in your patch ?
>>>>>>>
>>>>>>> In ::prepare you reuse the matrix, if possible. If your intention=
=20
>>>>>>> is to improve performances, you should consider using the same=20
>>>>>>> approach as the isa plugin. See=20
>>>>>>> http://workbench.dachary.org/ceph/ceph/blob/giant/src/erasure-cod=

>>>>>>> e
>>>>>>> /
>>>>>>> i
>>>>>>> s
>>>>>>> a
>>>>>>> /ErasureCodePluginIsa.cc#L36 which is and independent type=20
>>>>>>> http://workbench.dachary.org/ceph/ceph/blob/giant/src/erasure-cod=

>>>>>>> e / i s a /ErasureCodeIsaTableCache.h with only one instance and =

>>>>>>> is populated as needed and protected by a lock to make it thread =

>>>>>>> safe :
>>>>>>> http://workbench.dachary.org/ceph/ceph/blob/giant/src/erasure-cod=

>>>>>>> e
>>>>>>> /
>>>>>>> i
>>>>>>> s
>>>>>>> a
>>>>>>> /ErasureCodeIsaTableCache.h#L101
>>>>>>>
>>>>>>> I'll have more comments once you have unit / functional tests ( s=
imilar to http://workbench.dachary.org/ceph/ceph/blob/giant/src/test/eras=
ure-code/TestErasureCodeJerasure.cc ).=20
>>>>>>>
>>>>>>> Regarding your initial question: I think it is too late for the H=
ammer release. But from what I read it looks like we'll be able to merge =
in the early stages of the next release and that will give us time to pro=
perly test it.
>>>>>>>
>>>>>>> Cheers
>>>>>>>
>>>>>>> On 13/01/2015 11:34, Miyamae, Takeshi wrote:
>>>>>>>> Hi Loic,
>>>>>>>>
>>>>>>>> I'm so sorry. The following is the correct repository.
>>>>>>>>
>>>>>>>> https://github.com/t-miyamae/ceph
>>>>>>>>
>>>>>>>> Best regards,
>>>>>>>> Takeshi Miyamae
>>>>>>>>
>>>>>>>> -----Original Message-----
>>>>>>>> From: Loic Dachary [mailto:loic@dachary.org]
>>>>>>>> Sent: Tuesday, January 13, 2015 7:26 PM
>>>>>>>> To: Miyamae, Takeshi/=E5=AE=AE=E5=89=8D =E5=89=9B
>>>>>>>> Cc: Ceph Development; Shiozawa, Kensuke/=E5=A1=A9=E6=B2=A2 =E8=B3=
=A2=E8=BC=94; Nakao,=20
>>>>>>>> Takanori/=E4=B8=AD=E5=B0=BE
>>>>>>>> =E9=B7=B9=E8=A9=94;
>>>>>>>> Paul Von-Stamwitz (PVonStamwitz@us.fujitsu.com)
>>>>>>>> Subject: Re: Deadline of Github pull request for Hammer release
>>>>>>>> (question)
>>>>>>>>
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> On 13/01/2015 11:24, Miyamae, Takeshi wrote:
>>>>>>>>> Hi Loic,
>>>>>>>>>
>>>>>>>>>> Although we're late in the Hammer roadmap, it's a good time fo=
r an early preview. It will help show what needs to be changed to accomod=
ate the SHEC plugin.
>>>>>>>>>
>>>>>>>>> Thank you for your advices.
>>>>>>>>> We have uploaded our latest codes to the following folk reposit=
ory for an early review.
>>>>>>>>>
>>>>>>>>> https://github.com/miyamae-takeshi/multiple-shec
>>>>>>>>
>>>>>>>> It's 404 ? Is it a private repository maybe ?
>>>>>>>>
>>>>>>>>>
>>>>>>>>> SHEC is located in src/erasure-code/shec directory.
>>>>>>>>>
>>>>>>>>> We are verifying SHEC's advantages on our Ceph cluster. It take=
s a little bit more.
>>>>>>>>> Would you please start the review before that?
>>>>>>>>>
>>>>>>>>> Best regards,
>>>>>>>>> Takeshi Miyamae
>>>>>>>>>
>>>>>>>>> -----Original Message-----
>>>>>>>>> From: ceph-devel-owner@vger.kernel.org=20
>>>>>>>>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Loic=20
>>>>>>>>> Dachary
>>>>>>>>> Sent: Wednesday, January 7, 2015 12:52 AM
>>>>>>>>> To: Miyamae, Takeshi/=E5=AE=AE=E5=89=8D =E5=89=9B
>>>>>>>>> Cc: Ceph Development; Shiozawa, Kensuke/=E5=A1=A9=E6=B2=A2 =E8=B3=
=A2=E8=BC=94; Nakao,
>>>>>>>>> Takanori/=E4=B8=AD=E5=B0=BE
>>>>>>>>> =E9=B7=B9=E8=A9=94
>>>>>>>>> Subject: Re: Deadline of Github pull request for Hammer release=

>>>>>>>>> (question)
>>>>>>>>>
>>>>>>>>> Hi,
>>>>>>>>>
>>>>>>>>> On 06/01/2015 12:49, Miyamae, Takeshi wrote:
>>>>>>>>>> Dear Loic,
>>>>>>>>>>
>>>>>>>>>> I'm Takeshi Miyamae, one of the authors of SHEC's blueprint.
>>>>>>>>>>
>>>>>>>>>> Shingled Erasure Code (SHEC)
>>>>>>>>>> https://wiki.ceph.com/Planning/Blueprints/Hammer/Shingled_Eras=

>>>>>>>>>> u
>>>>>>>>>> r
>>>>>>>>>> e
>>>>>>>>>> _
>>>>>>>>>> C
>>>>>>>>>> o
>>>>>>>>>> d
>>>>>>>>>> e
>>>>>>>>>> _(SHEC)
>>>>>>>>>
>>>>>>>>> The work you have done is quite impressive :-)
>>>>>>>>>
>>>>>>>>>> We have revised our blueprint shown in the last CDS to extend =

>>>>>>>>>> our erasure code layouts and describe the guideline for choosi=
ng SHEC among various EC plugins.
>>>>>>>>>> We believe the blueprint now answers all the comments given at=
 the CDS.
>>>>>>>>>
>>>>>>>>> Great.
>>>>>>>>>
>>>>>>>>>> In addition, we would like to ask for your advice on the=20
>>>>>>>>>> schedule of our github pull request. More specifically, we=20
>>>>>>>>>> would like to know its deadline for Hammer release.
>>>>>>>>>> (As we have not really completed our verification of SHEC, we =

>>>>>>>>>> are wondering if we should make it open for early preview.)
>>>>>>>>>
>>>>>>>>> Although we're late in the Hammer roadmap, it's a good time for=
 an early preview. It will help show what needs to be changed to accomoda=
te the SHEC plugin.
>>>>>>>>>
>>>>>>>>> Cheers
>>>>>>>>>
>>>>>>>>>> Thank you in advance,
>>>>>>>>>> Takeshi Miyamae
>>>>>>>>>>
>>>>>>>>>> --
>>>>>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph=
-devel"=20
>>>>>>>>>> in the body of a message to majordomo@vger.kernel.org More=20
>>>>>>>>>> majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> --
>>>>>>>>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>>>>>>>>
>>>>>>>>
>>>>>>>> --
>>>>>>>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
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
>>>>> N     r  y   b X  =C7=A7v ^ )=DE=BA{.n +   z ]z   {ay =1D=CA=87=DA=99=
 ,j   f   h   z =1E w  =20
>>>>    j:+v   w j m         zZ+     =DD=A2j"  !tml=3D
>>>>>
>>>>
>>>> --
>>>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>>>
>>>> N     r  y   b X  =C7=A7v ^ )=DE=BA{.n +   z ]z   {ay =1D=CA=87=DA=99=
 ,j   f   h   z =1E w  =20
>>>    j:+v   w j m         zZ+     =DD=A2j"  !tml=3D
>>>>
>>>
>>> --
>>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
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


--amBhgAtCKcjH35Xrfbd2BIB1j9Cu8PMes
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTCTsQACgkQ8dLMyEl6F21h2ACgr+sb5X6W6IBE0uUT26c84flX
m9UAnA8TI51J67oqG5E++6RsFI+/k5Rd
=j7Af
-----END PGP SIGNATURE-----

--amBhgAtCKcjH35Xrfbd2BIB1j9Cu8PMes--
