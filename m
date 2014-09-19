From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: severe librbd performance degradation in Giant
Date: Fri, 19 Sep 2014 15:56:52 +0200 (CEST)
Message-ID: <260f7b0e-3db6-4c27-814a-9d2d690cd965@mailpro>
References: <541C3022.5040107@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:36640 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756943AbaISN5C convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Sep 2014 09:57:02 -0400
In-Reply-To: <541C3022.5040107@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: Sage Weil <sweil@redhat.com>, Josh Durgin <josh.durgin@inktank.com>, ceph-devel@vger.kernel.org, Xinxin Shu <xinxin.shu@intel.com>, Somnath Roy <Somnath.Roy@sandisk.com>, Haomai Wang <haomaiwang@gmail.com>

>>Crazy, I've 56 SSDs and can=C3=84t go above 20 000 iops.

I just notice than my fio benchmark is cpu bound...

I can reach around 40000iops. Don't have more client machines for the m=
oment to bench


----- Mail original -----=20

De: "Stefan Priebe - Profihost AG" <s.priebe@profihost.ag>=20
=C3=80: "Xinxin Shu" <xinxin.shu@intel.com>, "Somnath Roy" <Somnath.Roy=
@sandisk.com>, "Alexandre DERUMIER" <aderumier@odiso.com>, "Haomai Wang=
" <haomaiwang@gmail.com>=20
Cc: "Sage Weil" <sweil@redhat.com>, "Josh Durgin" <josh.durgin@inktank.=
com>, ceph-devel@vger.kernel.org=20
Envoy=C3=A9: Vendredi 19 Septembre 2014 15:31:14=20
Objet: Re: severe librbd performance degradation in Giant=20

Am 19.09.2014 um 15:02 schrieb Shu, Xinxin:=20
> 12 x Intel DC 3700 200GB, every SSD has two OSDs.=20

Crazy, I've 56 SSDs and can=C3=84t go above 20 000 iops.=20

Gr=C3=BC=C3=9Fe Stefan=20

> Cheers,=20
> xinxin=20
>=20
> -----Original Message-----=20
> From: Stefan Priebe [mailto:s.priebe@profihost.ag]=20
> Sent: Friday, September 19, 2014 2:54 PM=20
> To: Shu, Xinxin; Somnath Roy; Alexandre DERUMIER; Haomai Wang=20
> Cc: Sage Weil; Josh Durgin; ceph-devel@vger.kernel.org=20
> Subject: Re: severe librbd performance degradation in Giant=20
>=20
> Am 19.09.2014 03:08, schrieb Shu, Xinxin:=20
>> I also observed performance degradation on my full SSD setup , I can=
=20
>> got ~270K IOPS for 4KB random read with 0.80.4 , but with latest=20
>> master , I only got ~12K IOPS=20
>=20
> This are impressive numbers. Can you tell me how many OSDs you have a=
nd which SSDs you use?=20
>=20
> Thanks,=20
> Stefan=20
>=20
>=20
>> Cheers,=20
>> xinxin=20
>>=20
>> -----Original Message-----=20
>> From: ceph-devel-owner@vger.kernel.org=20
>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Somnath Roy=20
>> Sent: Friday, September 19, 2014 2:03 AM=20
>> To: Alexandre DERUMIER; Haomai Wang=20
>> Cc: Sage Weil; Josh Durgin; ceph-devel@vger.kernel.org=20
>> Subject: RE: severe librbd performance degradation in Giant=20
>>=20
>> Alexandre,=20
>> What tool are you using ? I used fio rbd.=20
>>=20
>> Also, I hope you have Giant package installed in the client side as =
well and rbd_cache =3Dtrue is set on the client conf file.=20
>> FYI, firefly librbd + librados and Giant cluster will work seamlessl=
y and I had to make sure fio rbd is really loading giant librbd (if you=
 have multiple copies around , which was in my case) for reproducing it=
=2E=20
>>=20
>> Thanks & Regards=20
>> Somnath=20
>>=20
>> -----Original Message-----=20
>> From: Alexandre DERUMIER [mailto:aderumier@odiso.com]=20
>> Sent: Thursday, September 18, 2014 2:49 AM=20
>> To: Haomai Wang=20
>> Cc: Sage Weil; Josh Durgin; ceph-devel@vger.kernel.org; Somnath Roy=20
>> Subject: Re: severe librbd performance degradation in Giant=20
>>=20
>>>> According http://tracker.ceph.com/issues/9513, do you mean that rb=
d=20
>>>> cache will make 10x performance degradation for random read?=20
>>=20
>> Hi, on my side, I don't see any degradation performance on read (seq=
 or rand) with or without.=20
>>=20
>> firefly : around 12000iops (with or without rbd_cache) giant : aroun=
d=20
>> 12000iops (with or without rbd_cache)=20
>>=20
>> (and I can reach around 20000-30000 iops on giant with disabling opt=
racker).=20
>>=20
>>=20
>> rbd_cache only improve write performance for me (4k block )=20
>>=20
>>=20
>>=20
>> ----- Mail original -----=20
>>=20
>> De: "Haomai Wang" <haomaiwang@gmail.com>=20
>> =C3=80: "Somnath Roy" <Somnath.Roy@sandisk.com>=20
>> Cc: "Sage Weil" <sweil@redhat.com>, "Josh Durgin"=20
>> <josh.durgin@inktank.com>, ceph-devel@vger.kernel.org=20
>> Envoy=C3=A9: Jeudi 18 Septembre 2014 04:27:56=20
>> Objet: Re: severe librbd performance degradation in Giant=20
>>=20
>> According http://tracker.ceph.com/issues/9513, do you mean that rbd =
cache will make 10x performance degradation for random read?=20
>>=20
>> On Thu, Sep 18, 2014 at 7:44 AM, Somnath Roy <Somnath.Roy@sandisk.co=
m> wrote:=20
>>> Josh/Sage,=20
>>> I should mention that even after turning off rbd cache I am getting=
 ~20% degradation over Firefly.=20
>>>=20
>>> Thanks & Regards=20
>>> Somnath=20
>>>=20
>>> -----Original Message-----=20
>>> From: Somnath Roy=20
>>> Sent: Wednesday, September 17, 2014 2:44 PM=20
>>> To: Sage Weil=20
>>> Cc: Josh Durgin; ceph-devel@vger.kernel.org=20
>>> Subject: RE: severe librbd performance degradation in Giant=20
>>>=20
>>> Created a tracker for this.=20
>>>=20
>>> http://tracker.ceph.com/issues/9513=20
>>>=20
>>> Thanks & Regards=20
>>> Somnath=20
>>>=20
>>> -----Original Message-----=20
>>> From: ceph-devel-owner@vger.kernel.org=20
>>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Somnath Roy=20
>>> Sent: Wednesday, September 17, 2014 2:39 PM=20
>>> To: Sage Weil=20
>>> Cc: Josh Durgin; ceph-devel@vger.kernel.org=20
>>> Subject: RE: severe librbd performance degradation in Giant=20
>>>=20
>>> Sage,=20
>>> It's a 4K random read.=20
>>>=20
>>> Thanks & Regards=20
>>> Somnath=20
>>>=20
>>> -----Original Message-----=20
>>> From: Sage Weil [mailto:sweil@redhat.com]=20
>>> Sent: Wednesday, September 17, 2014 2:36 PM=20
>>> To: Somnath Roy=20
>>> Cc: Josh Durgin; ceph-devel@vger.kernel.org=20
>>> Subject: RE: severe librbd performance degradation in Giant=20
>>>=20
>>> What was the io pattern? Sequential or random? For random a slowdow=
n makes sense (tho maybe not 10x!) but not for sequentail....=20
>>>=20
>>> s=20
>>>=20
>>> On Wed, 17 Sep 2014, Somnath Roy wrote:=20
>>>=20
>>>> I set the following in the client side /etc/ceph/ceph.conf where I=
 am running fio rbd.=20
>>>>=20
>>>> rbd_cache_writethrough_until_flush =3D false=20
>>>>=20
>>>> But, no difference. BTW, I am doing Random read, not write. Still =
this setting applies ?=20
>>>>=20
>>>> Next, I tried to tweak the rbd_cache setting to false and I *got b=
ack* the old performance. Now, it is similar to firefly throughput !=20
>>>>=20
>>>> So, loks like rbd_cache=3Dtrue was the culprit.=20
>>>>=20
>>>> Thanks Josh !=20
>>>>=20
>>>> Regards=20
>>>> Somnath=20
>>>>=20
>>>> -----Original Message-----=20
>>>> From: Josh Durgin [mailto:josh.durgin@inktank.com]=20
>>>> Sent: Wednesday, September 17, 2014 2:20 PM=20
>>>> To: Somnath Roy; ceph-devel@vger.kernel.org=20
>>>> Subject: Re: severe librbd performance degradation in Giant=20
>>>>=20
>>>> On 09/17/2014 01:55 PM, Somnath Roy wrote:=20
>>>>> Hi Sage,=20
>>>>> We are experiencing severe librbd performance degradation in Gian=
t over firefly release. Here is the experiment we did to isolate it as =
a librbd problem.=20
>>>>>=20
>>>>> 1. Single OSD is running latest Giant and client is running fio r=
bd on top of firefly based librbd/librados. For one client it is giving=
 ~11-12K iops (4K RR).=20
>>>>> 2. Single OSD is running Giant and client is running fio rbd on t=
op of Giant based librbd/librados. For one client it is giving ~1.9K io=
ps (4K RR).=20
>>>>> 3. Single OSD is running latest Giant and client is running Giant=
 based ceph_smaiobench on top of giant librados. For one client it is g=
iving ~11-12K iops (4K RR).=20
>>>>> 4. Giant RGW on top of Giant OSD is also scaling.=20
>>>>>=20
>>>>>=20
>>>>> So, it is obvious from the above that recent librbd has issues. I=
 will raise a tracker to track this.=20
>>>>=20
>>>> For giant the default cache settings changed to:=20
>>>>=20
>>>> rbd cache =3D true=20
>>>> rbd cache writethrough until flush =3D true=20
>>>>=20
>>>> If fio isn't sending flushes as the test is running, the cache wil=
l stay in writethrough mode. Does the difference remain if you set rbd =
cache writethrough until flush =3D false ?=20
>>>>=20
>>>> Josh=20
>>>>=20
>>>> ________________________________=20
>>>>=20
>>>> PLEASE NOTE: The information contained in this electronic mail mes=
sage is intended only for the use of the designated recipient(s) named =
above. If the reader of this message is not the intended recipient, you=
 are hereby notified that you have received this message in error and t=
hat any review, dissemination, distribution, or copying of this message=
 is strictly prohibited. If you have received this communication in err=
or, please notify the sender by telephone or e-mail (as shown above) im=
mediately and destroy any and all copies of this message in your posses=
sion (whether hard copies or electronically stored copies).=20
>>>>=20
>>>> --=20
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el"=20
>>>> in the body of a message to majordomo@vger.kernel.org More majordo=
mo=20
>>>> info at http://vger.kernel.org/majordomo-info.html=20
>>>>=20
>>>>=20
>>> --=20
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l"=20
>>> in the body of a message to majordomo@vger.kernel.org More majordom=
o=20
>>> info at http://vger.kernel.org/majordomo-info.html=20
>>> --=20
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l"=20
>>> in the body of a message to majordomo@vger.kernel.org More majordom=
o=20
>>> info at http://vger.kernel.org/majordomo-info.html=20
>>=20
>>=20
>>=20
>> --=20
>> Best Regards,=20
>>=20
>> Wheat=20
>> --=20
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in the body of a message to majordomo@vger.kernel.org More majordomo =
info at http://vger.kernel.org/majordomo-info.html=20
>> N r y b X =C7=A7v ^ )=DE=BA{.n + z ]z {ay =CA=87=DA=99 ,j f h z w j:=
+v w j m zZ+ =DD=A2j" ! i=20
>> N r y b X =C7=A7v ^ )=DE=BA{.n + z ]z {ay =CA=87=DA=99 ,j f h z w=20
> j:+v w j m zZ+ =DD=A2j" !tml=3D=20
>>=20
> N=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDr=EF=BF=BD=EF=BF=BDy=EF=
=BF=BD=EF=BF=BD=EF=BF=BDb=EF=BF=BDX=EF=BF=BD=EF=BF=BD=C7=A7v=EF=BF=BD^=EF=
=BF=BD)=DE=BA{.n=EF=BF=BD+=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD]z=EF=BF=
=BD=EF=BF=BD=EF=BF=BD{ay=EF=BF=BD=CA=87=DA=99=EF=BF=BD,j=EF=BF=BD=EF=BF=
=BDf=EF=BF=BD=EF=BF=BD=EF=BF=BDh=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD=EF=
=BF=BDw=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDj:+v=EF=BF=
=BD=EF=BF=BD=EF=BF=BDw=EF=BF=BDj=EF=BF=BDm=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDzZ+=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=DD=A2j"=EF=BF=BD=EF=BF=BD!tml=3D=20
>=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
