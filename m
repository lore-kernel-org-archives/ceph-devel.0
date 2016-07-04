From: Yoann Moulin <yoann.moulin@epfl.ch>
Subject: Fwd: Re: performance issue with jewel on ubuntu xenial (kernel)
Date: Mon, 4 Jul 2016 09:13:47 +0200
Message-ID: <577A0CAB.10606@epfl.ch>
References: <57768035.6000101@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp0.epfl.ch ([128.178.224.218]:36952 "EHLO smtp0.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753077AbcGDHUd (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 4 Jul 2016 03:20:33 -0400
In-Reply-To: <57768035.6000101@epfl.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

just forward this here, there is a big performance drop with kernel 4.4=
 compare
to 4.2 on Jewel.

Does anyone here have seen that before ?

Best Regards,

Yoann Moulin

-------- Message transf=C3=A9r=C3=A9 --------
Sujet : Re: [ceph-users] performance issue with jewel on ubuntu xenial =
(kernel)
Date : Fri, 1 Jul 2016 16:37:41 +0200
De : Yoann Moulin <yoann.moulin@epfl.ch>

Hello,

>>>>>>> I found a performance drop between kernel 3.13.0-88 (default ke=
rnel on Ubuntu
>>>>>>> Trusty 14.04) and kernel 4.4.0.24.14 (default kernel on Ubuntu =
Xenial 16.04)
>>>>>>>
>>>>>>> ceph version is Jewel (10.2.2).
>>>>>>> All tests have been done under Ubuntu 14.04
>>>>>>
>>>>>> Knowing that you also have an internalis cluster on almost ident=
ical
>>>>>> hardware, can you please let the list know whether you see the s=
ame
>>>>>> behavior (severely reduced throughput on a 4.4 kernel, vs. 3.13)=
 on
>>>>>> that cluster as well?
>>>>>
>>>>> ceph version is infernalis (9.2.0)
>>>>>
>>>>> Ceph osd Benchmark:
>>>>>
>>>>> Kernel 3.13.0-88-generic : ceph tell osd.ID =3D> average ~84MB/s
>>>>> Kernel 4.2.0-38-generic  : ceph tell osd.ID =3D> average ~90MB/s
>>>>> Kernel 4.4.0-24-generic  : ceph tell osd.ID =3D> average ~75MB/s
>>>>>
>>>>> The slow down is not as much as I have with Jewel but it is still=
 present.
>>>>
>>>> But this is not on precisely identical hardware, is it?
>>>
>>> All the benchmarks were run on strictly identical hardware setups p=
er node.
>>> Clusters differ slightly in sizes (infernalis vs jewel) but nodes a=
nd OSDs are identical.
>>
>> One thing differ in the osd configuration, on the Jewel cluster, we =
have journal
>> on disk, on the Infernalis cluster, we have journal on SSD (S3500)
>>
>> I can restart my test on a Jewel cluster with journal on SSD if need=
ed.
>> I can do as well a test on an Infernalis cluster with journal on dis=
k.
>=20
> I'd suggest that the second option is probably more meaningful to tes=
t.

I did new benchmarks on 3 clusters. Each cluster has 3 nodes strictly i=
dentical.
Each node has 10 OSDs. Journals are on the disk.

bench5 : Ubuntu 14.04 / Ceph Infernalis
bench6 : Ubuntu 14.04 / Ceph Jewel
bench7 : Ubuntu 16.04 / Ceph jewel

this is the average of 2 runs of "ceph tell osd.* bench" on each cluste=
r (2 x 30
OSDs)

bench5 / 14.04 / Infernalis / kernel 3.13 :  54.35 MB/s
bench6 / 14.04 / Jewel      / kernel 3.13 :  86.47 MB/s

bench5 / 14.04 / Infernalis / kernel 4.2  :  63.38 MB/s
bench6 / 14.04 / Jewel      / kernel 4.2  : 107.75 MB/s
bench7 / 16.04 / Jewel      / kernel 4.2  : 101.54 MB/s

bench5 / 14.04 / Infernalis / kernel 4.4  :  53.61 MB/s
bench6 / 14.04 / Jewel      / kernel 4.4  :  65.82 MB/s
bench7 / 16.04 / Jewel      / kernel 4.4  :  61.57 MB/s

If needed, I have the raw output of "ceph tell osd.* bench"

> What I find curious is that no-one else on the list has apparently ru=
n
> into this. Any Ubuntu xenial users out there, or perhaps folks on
> trusty who choose to install linux-image-generic-lts-xenial?

Anyone to try on their side if they have the same behaviour ?

Cheers,

--=20
Yoann Moulin
EPFL IC-IT

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
