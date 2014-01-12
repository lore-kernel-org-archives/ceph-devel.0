From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: Proposal for adding disable FileJournal option
Date: Sun, 12 Jan 2014 19:25:19 +0800
Message-ID: <CACJqLyYXZ-rjhhcriDKpo_AL6Z-0vQ9TP8UKEvQDN8RttOyK1Q@mail.gmail.com>
References: <08E73B64-A538-4A34-B0F6-1D7A2A00A8AF@gmail.com>
	<CAPYLRzgb1dEi=prb32mfVZ+=jDS72376GPU-pz7n3SPs7T-t1Q@mail.gmail.com>
	<CACJqLyY6L+f2DBq-dcJVphSRKegReHm0XoVhC-H_3Jg6shRmfQ@mail.gmail.com>
	<CAMm-wcJ9_gbr6UJJhACpV3hA77Lw9Qega=AtnfU5j2w_OViJ-w@mail.gmail.com>
	<CAPYLRzhVbBJRhTsuO00vTWasaxjE1Sqrj+8S_HtSdB++kJ82ZQ@mail.gmail.com>
	<CACJqLyaLdjECGHvSozcZRbXNU1Drwtkp0oa2OQNgerb8dCSuSA@mail.gmail.com>
	<CAMm-wcJn8=qe1W8c3-ff+JWwK-NLbD7e8-tP=X-QzT-DMXnWVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:48485 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751224AbaALLZU convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 12 Jan 2014 06:25:20 -0500
Received: by mail-pd0-f178.google.com with SMTP id y10so6318524pdj.23
        for <ceph-devel@vger.kernel.org>; Sun, 12 Jan 2014 03:25:20 -0800 (PST)
In-Reply-To: <CAMm-wcJn8=qe1W8c3-ff+JWwK-NLbD7e8-tP=X-QzT-DMXnWVw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dong Yuan <yuandong1222@gmail.com>
Cc: Gregory Farnum <greg@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sat, Jan 11, 2014 at 11:18 PM, Dong Yuan <yuandong1222@gmail.com> wr=
ote:
> It is not only for consistent between memory and disk. The key point
> is to implement the atomicity of an trancation.
>
> That is when an trancation needs to write an object and update the
> pglog at the same time, we must make sure the two IO do both or
> nether.
>
> With the journal, when osd restore from failure, the reply process ca=
n
> redo the transcation. I think that is why the journal can not be
> disabled.

Hmm, I missed it. Journal is the guarantee for the atomic of transactio=
n.

Thanks!

>
> On 11 January 2014 13:24, Haomai Wang <haomaiwang@gmail.com> wrote:
>> On Fri, Jan 10, 2014 at 11:13 AM, Gregory Farnum <greg@inktank.com> =
wrote:
>>> Exactly. We can't do a safe update without a journal =E2=80=94 what=
 if power
>>> goes out while the write is happening? When we boot back up, we don=
't
>>> know what version the object is actually at. So if you're using btr=
fs,
>>> you can run without a journal already (and depend on snapshots for
>>> recovering after failures); if you are using xfs or ext4 a journal =
is
>>> required for any safety at all, even when it's fronted by a cache
>>> pool.
>>
>> I'm not fully agree with it. Why we can't call "fdatasync()" during
>> each transaction to
>> ensure consistent if exists cache in the front of.
>>
>>>
>>> On Thu, Jan 9, 2014 at 7:08 PM, Dong Yuan <yuandong1222@gmail.com> =
wrote:
>>>> The Journal is the part of implementation of ObjectStore Transacti=
on
>>>> Interface, while transaction is used by PG to write pglog with obj=
ect
>>>> data in one transaction.
>>>> So I think if the FileJournal could be disabled, there must be
>>>> something else to implement the Transaction Interface. But it seem=
s
>>>> hard while no local file-system provide such function in my opinio=
n.
>>>>
>>>>
>>>> On 10 January 2014 10:04, Haomai Wang <haomaiwang@gmail.com> wrote=
:
>>>>> On Fri, Jan 10, 2014 at 1:28 AM, Gregory Farnum <greg@inktank.com=
> wrote:
>>>>>>
>>>>>> The FileJournal is also for data safety whenever we're using wri=
te
>>>>>> ahead. To disable it we need a backing store that we know can pr=
ovide
>>>>>> us consistent checkpoints (i.e., we can use parallel journaling =
mode =E2=80=94
>>>>>> so for the FileJournal, we're using btrfs, or maybe zfs someday)=
=2E But
>>>>>> for those systems you can already configure the system not to us=
e a
>>>>>> journal.
>>>>>
>>>>> Yes, it depends on backend. For example, FileStore can write a ob=
ject with sync
>>>>> to sure consistent. If adding a disable FileJournal option, we ne=
ed
>>>>> some works on
>>>>> FileStore to implement it.
>>>>>
>>>>>> -Greg
>>>>>> Software Engineer #42 @ http://inktank.com | http://ceph.com
>>>>>>
>>>>>>
>>>>>> On Thu, Jan 9, 2014 at 12:13 AM, Haomai Wang <haomaiwang@gmail.c=
om> wrote:
>>>>>> > Hi all,
>>>>>> >
>>>>>> > We know FileJournal plays a important role in FileStore backen=
d, it can
>>>>>> > hugely reduce write latency and improve small write operations=
=2E
>>>>>> >
>>>>>> > But in practice, there exists exceptions such as we already us=
e FlashCache or cachepool(although it's not ready).
>>>>>> >
>>>>>> > If cachepool enabled, we may use use journal in cache_pool but=
 may
>>>>>> > not like to use journal in base_pool. The main reason why drop=
 journal
>>>>>> > in base_pool is that journal take over a single physical devic=
e and waste
>>>>>> > too much in base_pool.
>>>>>> >
>>>>>> > Like above, if I enable FlashCache or other cache, I'd not lik=
e to enable
>>>>>> > journal in OSD layer.
>>>>>> >
>>>>>> > So is it necessary to disable journal in special(not really sp=
ecial) case?
>>>>>> >
>>>>>> > Best regards,
>>>>>> > Wheats
>>>>>> >
>>>>>> >
>>>>>> >
>>>>>> > --
>>>>>> > To unsubscribe from this list: send the line "unsubscribe ceph=
-devel" in
>>>>>> > the body of a message to majordomo@vger.kernel.org
>>>>>> > More majordomo info at  http://vger.kernel.org/majordomo-info.=
html
>>>>>
>>>>>
>>>>>
>>>>>
>>>>> --
>>>>>
>>>>> Best Regards,
>>>>>
>>>>> Wheat
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-de=
vel" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.htm=
l
>>>>
>>>>
>>>>
>>>> --
>>>> Dong Yuan
>>>> Email:yuandong1222@gmail.com
>>
>>
>>
>> --
>> Best Regards,
>>
>> Wheat
>
>
>
> --
> Dong Yuan
> Email:yuandong1222@gmail.com



--=20
Best Regards,

Wheat
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
