From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: severe librbd performance degradation in Giant
Date: Fri, 19 Sep 2014 15:31:14 +0200
Message-ID: <541C3022.5040107@profihost.ag>
References: <CACJqLyYQDrHyxMEtiMKMNaBQ_fHuu-hGqO_ZNHra0+VsUZrzXQ@mail.gmail.com> <1ab9d756-bbc9-4fbe-8f51-0a33dbab1a8d@mailpro> <755F6B91B3BE364F9BCA11EA3F9E0C6F2784639B@SACMBXIP02.sdcorp.global.sandisk.com> <75674D092A819E4189E91166C74CB90D01440AE4@shsmsx102.ccr.corp.intel.com> <541BD2F2.9030500@profihost.ag> <75674D092A819E4189E91166C74CB90D0144104E@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:40607 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755978AbaISNbR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Sep 2014 09:31:17 -0400
In-Reply-To: <75674D092A819E4189E91166C74CB90D0144104E@shsmsx102.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Shu, Xinxin" <xinxin.shu@intel.com>, Somnath Roy <Somnath.Roy@sandisk.com>, Alexandre DERUMIER <aderumier@odiso.com>, Haomai Wang <haomaiwang@gmail.com>
Cc: Sage Weil <sweil@redhat.com>, Josh Durgin <josh.durgin@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 19.09.2014 um 15:02 schrieb Shu, Xinxin:
>  12 x Intel DC 3700 200GB, every SSD has two OSDs.

Crazy, I've 56 SSDs and can=C3=84t go above 20 000 iops.

Gr=C3=BC=C3=9Fe Stefan

> Cheers,
> xinxin
>=20
> -----Original Message-----
> From: Stefan Priebe [mailto:s.priebe@profihost.ag]=20
> Sent: Friday, September 19, 2014 2:54 PM
> To: Shu, Xinxin; Somnath Roy; Alexandre DERUMIER; Haomai Wang
> Cc: Sage Weil; Josh Durgin; ceph-devel@vger.kernel.org
> Subject: Re: severe librbd performance degradation in Giant
>=20
> Am 19.09.2014 03:08, schrieb Shu, Xinxin:
>> I also observed performance degradation on my full SSD setup ,  I ca=
n=20
>> got  ~270K IOPS for 4KB random read with 0.80.4 , but with latest=20
>> master , I only got ~12K IOPS
>=20
> This are impressive numbers. Can you tell me how many OSDs you have a=
nd which SSDs you use?
>=20
> Thanks,
> Stefan
>=20
>=20
>> Cheers,
>> xinxin
>>
>> -----Original Message-----
>> From: ceph-devel-owner@vger.kernel.org=20
>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Somnath Roy
>> Sent: Friday, September 19, 2014 2:03 AM
>> To: Alexandre DERUMIER; Haomai Wang
>> Cc: Sage Weil; Josh Durgin; ceph-devel@vger.kernel.org
>> Subject: RE: severe librbd performance degradation in Giant
>>
>> Alexandre,
>> What tool are you using ? I used fio rbd.
>>
>> Also, I hope you have Giant package installed in the client side as =
well and rbd_cache =3Dtrue is set on the client conf file.
>> FYI, firefly librbd + librados and Giant cluster will work seamlessl=
y and I had to make sure fio rbd is really loading giant librbd (if you=
 have multiple copies around , which was in my case) for reproducing it=
=2E
>>
>> Thanks & Regards
>> Somnath
>>
>> -----Original Message-----
>> From: Alexandre DERUMIER [mailto:aderumier@odiso.com]
>> Sent: Thursday, September 18, 2014 2:49 AM
>> To: Haomai Wang
>> Cc: Sage Weil; Josh Durgin; ceph-devel@vger.kernel.org; Somnath Roy
>> Subject: Re: severe librbd performance degradation in Giant
>>
>>>> According http://tracker.ceph.com/issues/9513, do you mean that rb=
d=20
>>>> cache will make 10x performance degradation for random read?
>>
>> Hi, on my side, I don't see any degradation performance on read (seq=
 or rand)  with or without.
>>
>> firefly : around 12000iops (with or without rbd_cache) giant : aroun=
d=20
>> 12000iops  (with or without rbd_cache)
>>
>> (and I can reach around 20000-30000 iops on giant with disabling opt=
racker).
>>
>>
>> rbd_cache only improve write performance for me (4k block )
>>
>>
>>
>> ----- Mail original -----
>>
>> De: "Haomai Wang" <haomaiwang@gmail.com>
>> =C3=80: "Somnath Roy" <Somnath.Roy@sandisk.com>
>> Cc: "Sage Weil" <sweil@redhat.com>, "Josh Durgin"=20
>> <josh.durgin@inktank.com>, ceph-devel@vger.kernel.org
>> Envoy=C3=A9: Jeudi 18 Septembre 2014 04:27:56
>> Objet: Re: severe librbd performance degradation in Giant
>>
>> According http://tracker.ceph.com/issues/9513, do you mean that rbd =
cache will make 10x performance degradation for random read?
>>
>> On Thu, Sep 18, 2014 at 7:44 AM, Somnath Roy <Somnath.Roy@sandisk.co=
m> wrote:
>>> Josh/Sage,
>>> I should mention that even after turning off rbd cache I am getting=
 ~20% degradation over Firefly.
>>>
>>> Thanks & Regards
>>> Somnath
>>>
>>> -----Original Message-----
>>> From: Somnath Roy
>>> Sent: Wednesday, September 17, 2014 2:44 PM
>>> To: Sage Weil
>>> Cc: Josh Durgin; ceph-devel@vger.kernel.org
>>> Subject: RE: severe librbd performance degradation in Giant
>>>
>>> Created a tracker for this.
>>>
>>> http://tracker.ceph.com/issues/9513
>>>
>>> Thanks & Regards
>>> Somnath
>>>
>>> -----Original Message-----
>>> From: ceph-devel-owner@vger.kernel.org=20
>>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Somnath Roy
>>> Sent: Wednesday, September 17, 2014 2:39 PM
>>> To: Sage Weil
>>> Cc: Josh Durgin; ceph-devel@vger.kernel.org
>>> Subject: RE: severe librbd performance degradation in Giant
>>>
>>> Sage,
>>> It's a 4K random read.
>>>
>>> Thanks & Regards
>>> Somnath
>>>
>>> -----Original Message-----
>>> From: Sage Weil [mailto:sweil@redhat.com]
>>> Sent: Wednesday, September 17, 2014 2:36 PM
>>> To: Somnath Roy
>>> Cc: Josh Durgin; ceph-devel@vger.kernel.org
>>> Subject: RE: severe librbd performance degradation in Giant
>>>
>>> What was the io pattern? Sequential or random? For random a slowdow=
n makes sense (tho maybe not 10x!) but not for sequentail....
>>>
>>> s
>>>
>>> On Wed, 17 Sep 2014, Somnath Roy wrote:
>>>
>>>> I set the following in the client side /etc/ceph/ceph.conf where I=
 am running fio rbd.
>>>>
>>>> rbd_cache_writethrough_until_flush =3D false
>>>>
>>>> But, no difference. BTW, I am doing Random read, not write. Still =
this setting applies ?
>>>>
>>>> Next, I tried to tweak the rbd_cache setting to false and I *got b=
ack* the old performance. Now, it is similar to firefly throughput !
>>>>
>>>> So, loks like rbd_cache=3Dtrue was the culprit.
>>>>
>>>> Thanks Josh !
>>>>
>>>> Regards
>>>> Somnath
>>>>
>>>> -----Original Message-----
>>>> From: Josh Durgin [mailto:josh.durgin@inktank.com]
>>>> Sent: Wednesday, September 17, 2014 2:20 PM
>>>> To: Somnath Roy; ceph-devel@vger.kernel.org
>>>> Subject: Re: severe librbd performance degradation in Giant
>>>>
>>>> On 09/17/2014 01:55 PM, Somnath Roy wrote:
>>>>> Hi Sage,
>>>>> We are experiencing severe librbd performance degradation in Gian=
t over firefly release. Here is the experiment we did to isolate it as =
a librbd problem.
>>>>>
>>>>> 1. Single OSD is running latest Giant and client is running fio r=
bd on top of firefly based librbd/librados. For one client it is giving=
 ~11-12K iops (4K RR).
>>>>> 2. Single OSD is running Giant and client is running fio rbd on t=
op of Giant based librbd/librados. For one client it is giving ~1.9K io=
ps (4K RR).
>>>>> 3. Single OSD is running latest Giant and client is running Giant=
 based ceph_smaiobench on top of giant librados. For one client it is g=
iving ~11-12K iops (4K RR).
>>>>> 4. Giant RGW on top of Giant OSD is also scaling.
>>>>>
>>>>>
>>>>> So, it is obvious from the above that recent librbd has issues. I=
 will raise a tracker to track this.
>>>>
>>>> For giant the default cache settings changed to:
>>>>
>>>> rbd cache =3D true
>>>> rbd cache writethrough until flush =3D true
>>>>
>>>> If fio isn't sending flushes as the test is running, the cache wil=
l stay in writethrough mode. Does the difference remain if you set rbd =
cache writethrough until flush =3D false ?
>>>>
>>>> Josh
>>>>
>>>> ________________________________
>>>>
>>>> PLEASE NOTE: The information contained in this electronic mail mes=
sage is intended only for the use of the designated recipient(s) named =
above. If the reader of this message is not the intended recipient, you=
 are hereby notified that you have received this message in error and t=
hat any review, dissemination, distribution, or copying of this message=
 is strictly prohibited. If you have received this communication in err=
or, please notify the sender by telephone or e-mail (as shown above) im=
mediately and destroy any and all copies of this message in your posses=
sion (whether hard copies or electronically stored copies).
>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el"
>>>> in the body of a message to majordomo@vger.kernel.org More majordo=
mo=20
>>>> info at http://vger.kernel.org/majordomo-info.html
>>>>
>>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l"
>>> in the body of a message to majordomo@vger.kernel.org More majordom=
o=20
>>> info at http://vger.kernel.org/majordomo-info.html
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l"
>>> in the body of a message to majordomo@vger.kernel.org More majordom=
o=20
>>> info at http://vger.kernel.org/majordomo-info.html
>>
>>
>>
>> --
>> Best Regards,
>>
>> Wheat
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in the body of a message to majordomo@vger.kernel.org More majordomo =
info at http://vger.kernel.org/majordomo-info.html
>> N     r  y   b X  =C7=A7v ^ )=DE=BA{.n +   z ]z   {ay =1D=CA=87=DA=99=
 ,j   f   h   z =1E w       j:+v   w j m         zZ+     =DD=A2j"  ! i
>> N     r  y   b X  =C7=A7v ^ )=DE=BA{.n +   z ]z   {ay =1D=CA=87=DA=99=
 ,j   f   h   z =1E w  =20
>    j:+v   w j m         zZ+     =DD=A2j"  !tml=3D
>>
> N=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDr=EF=BF=BD=EF=BF=BDy=EF=
=BF=BD=EF=BF=BD=EF=BF=BDb=EF=BF=BDX=EF=BF=BD=EF=BF=BD=C7=A7v=EF=BF=BD^=EF=
=BF=BD)=DE=BA{.n=EF=BF=BD+=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD]z=EF=BF=
=BD=EF=BF=BD=EF=BF=BD{ay=EF=BF=BD=1D=CA=87=DA=99=EF=BF=BD,j=07=EF=BF=BD=
=EF=BF=BDf=EF=BF=BD=EF=BF=BD=EF=BF=BDh=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=
=BD=1E=EF=BF=BDw=EF=BF=BD=EF=BF=BD=EF=BF=BD=0C=EF=BF=BD=EF=BF=BD=EF=BF=BD=
j:+v=EF=BF=BD=EF=BF=BD=EF=BF=BDw=EF=BF=BDj=EF=BF=BDm=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=07=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDzZ+=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=DD=A2j"=EF=BF=BD=EF=BF=BD!tml=3D
>=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
