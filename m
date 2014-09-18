From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: severe librbd performance degradation in Giant
Date: Thu, 18 Sep 2014 07:38:31 -0500
Message-ID: <541AD247.3040004@redhat.com>
References: <1ab9d756-bbc9-4fbe-8f51-0a33dbab1a8d@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:34610 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751080AbaIRMi2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Sep 2014 08:38:28 -0400
Received: by mail-ie0-f175.google.com with SMTP id lx4so1041797iec.20
        for <ceph-devel@vger.kernel.org>; Thu, 18 Sep 2014 05:38:27 -0700 (PDT)
In-Reply-To: <1ab9d756-bbc9-4fbe-8f51-0a33dbab1a8d@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>, Haomai Wang <haomaiwang@gmail.com>
Cc: Sage Weil <sweil@redhat.com>, Josh Durgin <josh.durgin@inktank.com>, ceph-devel@vger.kernel.org, Somnath Roy <Somnath.Roy@sandisk.com>

On 09/18/2014 04:49 AM, Alexandre DERUMIER wrote:
>>> According http://tracker.ceph.com/issues/9513, do you mean that rbd
>>> cache will make 10x performance degradation for random read?
>
> Hi, on my side, I don't see any degradation performance on read (seq =
or rand)  with or without.
>
> firefly : around 12000iops (with or without rbd_cache)
> giant : around 12000iops  (with or without rbd_cache)
>
> (and I can reach around 20000-30000 iops on giant with disabling optr=
acker).
>
>
> rbd_cache only improve write performance for me (4k block )

I can't do it right now since I'm in the middle of reinstalling fedora=20
on the test nodes, but I will try to replicate this as well if we=20
haven't figured it out before hand.

Mark

>
>
>
> ----- Mail original -----
>
> De: "Haomai Wang" <haomaiwang@gmail.com>
> =C3=80: "Somnath Roy" <Somnath.Roy@sandisk.com>
> Cc: "Sage Weil" <sweil@redhat.com>, "Josh Durgin" <josh.durgin@inktan=
k.com>, ceph-devel@vger.kernel.org
> Envoy=C3=A9: Jeudi 18 Septembre 2014 04:27:56
> Objet: Re: severe librbd performance degradation in Giant
>
> According http://tracker.ceph.com/issues/9513, do you mean that rbd
> cache will make 10x performance degradation for random read?
>
> On Thu, Sep 18, 2014 at 7:44 AM, Somnath Roy <Somnath.Roy@sandisk.com=
> wrote:
>> Josh/Sage,
>> I should mention that even after turning off rbd cache I am getting =
~20% degradation over Firefly.
>>
>> Thanks & Regards
>> Somnath
>>
>> -----Original Message-----
>> From: Somnath Roy
>> Sent: Wednesday, September 17, 2014 2:44 PM
>> To: Sage Weil
>> Cc: Josh Durgin; ceph-devel@vger.kernel.org
>> Subject: RE: severe librbd performance degradation in Giant
>>
>> Created a tracker for this.
>>
>> http://tracker.ceph.com/issues/9513
>>
>> Thanks & Regards
>> Somnath
>>
>> -----Original Message-----
>> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger=
=2Ekernel.org] On Behalf Of Somnath Roy
>> Sent: Wednesday, September 17, 2014 2:39 PM
>> To: Sage Weil
>> Cc: Josh Durgin; ceph-devel@vger.kernel.org
>> Subject: RE: severe librbd performance degradation in Giant
>>
>> Sage,
>> It's a 4K random read.
>>
>> Thanks & Regards
>> Somnath
>>
>> -----Original Message-----
>> From: Sage Weil [mailto:sweil@redhat.com]
>> Sent: Wednesday, September 17, 2014 2:36 PM
>> To: Somnath Roy
>> Cc: Josh Durgin; ceph-devel@vger.kernel.org
>> Subject: RE: severe librbd performance degradation in Giant
>>
>> What was the io pattern? Sequential or random? For random a slowdown=
 makes sense (tho maybe not 10x!) but not for sequentail....
>>
>> s
>>
>> On Wed, 17 Sep 2014, Somnath Roy wrote:
>>
>>> I set the following in the client side /etc/ceph/ceph.conf where I =
am running fio rbd.
>>>
>>> rbd_cache_writethrough_until_flush =3D false
>>>
>>> But, no difference. BTW, I am doing Random read, not write. Still t=
his setting applies ?
>>>
>>> Next, I tried to tweak the rbd_cache setting to false and I *got ba=
ck* the old performance. Now, it is similar to firefly throughput !
>>>
>>> So, loks like rbd_cache=3Dtrue was the culprit.
>>>
>>> Thanks Josh !
>>>
>>> Regards
>>> Somnath
>>>
>>> -----Original Message-----
>>> From: Josh Durgin [mailto:josh.durgin@inktank.com]
>>> Sent: Wednesday, September 17, 2014 2:20 PM
>>> To: Somnath Roy; ceph-devel@vger.kernel.org
>>> Subject: Re: severe librbd performance degradation in Giant
>>>
>>> On 09/17/2014 01:55 PM, Somnath Roy wrote:
>>>> Hi Sage,
>>>> We are experiencing severe librbd performance degradation in Giant=
 over firefly release. Here is the experiment we did to isolate it as a=
 librbd problem.
>>>>
>>>> 1. Single OSD is running latest Giant and client is running fio rb=
d on top of firefly based librbd/librados. For one client it is giving =
~11-12K iops (4K RR).
>>>> 2. Single OSD is running Giant and client is running fio rbd on to=
p of Giant based librbd/librados. For one client it is giving ~1.9K iop=
s (4K RR).
>>>> 3. Single OSD is running latest Giant and client is running Giant =
based ceph_smaiobench on top of giant librados. For one client it is gi=
ving ~11-12K iops (4K RR).
>>>> 4. Giant RGW on top of Giant OSD is also scaling.
>>>>
>>>>
>>>> So, it is obvious from the above that recent librbd has issues. I =
will raise a tracker to track this.
>>>
>>> For giant the default cache settings changed to:
>>>
>>> rbd cache =3D true
>>> rbd cache writethrough until flush =3D true
>>>
>>> If fio isn't sending flushes as the test is running, the cache will=
 stay in writethrough mode. Does the difference remain if you set rbd c=
ache writethrough until flush =3D false ?
>>>
>>> Josh
>>>
>>> ________________________________
>>>
>>> PLEASE NOTE: The information contained in this electronic mail mess=
age is intended only for the use of the designated recipient(s) named a=
bove. If the reader of this message is not the intended recipient, you =
are hereby notified that you have received this message in error and th=
at any review, dissemination, distribution, or copying of this message =
is strictly prohibited. If you have received this communication in erro=
r, please notify the sender by telephone or e-mail (as shown above) imm=
ediately and destroy any and all copies of this message in your possess=
ion (whether hard copies or electronically stored copies).
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l"
>>> in the body of a message to majordomo@vger.kernel.org More majordom=
o
>>> info at http://vger.kernel.org/majordomo-info.html
>>>
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in the body of a message to majordomo@vger.kernel.org More majordomo =
info at http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>
>
>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
