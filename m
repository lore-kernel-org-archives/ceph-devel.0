From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: Proposal for adding disable FileJournal option
Date: Sat, 11 Jan 2014 13:24:31 +0800
Message-ID: <CACJqLyaLdjECGHvSozcZRbXNU1Drwtkp0oa2OQNgerb8dCSuSA@mail.gmail.com>
References: <08E73B64-A538-4A34-B0F6-1D7A2A00A8AF@gmail.com>
	<CAPYLRzgb1dEi=prb32mfVZ+=jDS72376GPU-pz7n3SPs7T-t1Q@mail.gmail.com>
	<CACJqLyY6L+f2DBq-dcJVphSRKegReHm0XoVhC-H_3Jg6shRmfQ@mail.gmail.com>
	<CAMm-wcJ9_gbr6UJJhACpV3hA77Lw9Qega=AtnfU5j2w_OViJ-w@mail.gmail.com>
	<CAPYLRzhVbBJRhTsuO00vTWasaxjE1Sqrj+8S_HtSdB++kJ82ZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f50.google.com ([209.85.160.50]:33084 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750848AbaAKFYb convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 11 Jan 2014 00:24:31 -0500
Received: by mail-pb0-f50.google.com with SMTP id rr13so5284959pbb.23
        for <ceph-devel@vger.kernel.org>; Fri, 10 Jan 2014 21:24:31 -0800 (PST)
In-Reply-To: <CAPYLRzhVbBJRhTsuO00vTWasaxjE1Sqrj+8S_HtSdB++kJ82ZQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Dong Yuan <yuandong1222@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Jan 10, 2014 at 11:13 AM, Gregory Farnum <greg@inktank.com> wro=
te:
> Exactly. We can't do a safe update without a journal =E2=80=94 what i=
f power
> goes out while the write is happening? When we boot back up, we don't
> know what version the object is actually at. So if you're using btrfs=
,
> you can run without a journal already (and depend on snapshots for
> recovering after failures); if you are using xfs or ext4 a journal is
> required for any safety at all, even when it's fronted by a cache
> pool.

I'm not fully agree with it. Why we can't call "fdatasync()" during
each transaction to
ensure consistent if exists cache in the front of.

>
> On Thu, Jan 9, 2014 at 7:08 PM, Dong Yuan <yuandong1222@gmail.com> wr=
ote:
>> The Journal is the part of implementation of ObjectStore Transaction
>> Interface, while transaction is used by PG to write pglog with objec=
t
>> data in one transaction.
>> So I think if the FileJournal could be disabled, there must be
>> something else to implement the Transaction Interface. But it seems
>> hard while no local file-system provide such function in my opinion.
>>
>>
>> On 10 January 2014 10:04, Haomai Wang <haomaiwang@gmail.com> wrote:
>>> On Fri, Jan 10, 2014 at 1:28 AM, Gregory Farnum <greg@inktank.com> =
wrote:
>>>>
>>>> The FileJournal is also for data safety whenever we're using write
>>>> ahead. To disable it we need a backing store that we know can prov=
ide
>>>> us consistent checkpoints (i.e., we can use parallel journaling mo=
de =E2=80=94
>>>> so for the FileJournal, we're using btrfs, or maybe zfs someday). =
But
>>>> for those systems you can already configure the system not to use =
a
>>>> journal.
>>>
>>> Yes, it depends on backend. For example, FileStore can write a obje=
ct with sync
>>> to sure consistent. If adding a disable FileJournal option, we need
>>> some works on
>>> FileStore to implement it.
>>>
>>>> -Greg
>>>> Software Engineer #42 @ http://inktank.com | http://ceph.com
>>>>
>>>>
>>>> On Thu, Jan 9, 2014 at 12:13 AM, Haomai Wang <haomaiwang@gmail.com=
> wrote:
>>>> > Hi all,
>>>> >
>>>> > We know FileJournal plays a important role in FileStore backend,=
 it can
>>>> > hugely reduce write latency and improve small write operations.
>>>> >
>>>> > But in practice, there exists exceptions such as we already use =
=46lashCache or cachepool(although it's not ready).
>>>> >
>>>> > If cachepool enabled, we may use use journal in cache_pool but m=
ay
>>>> > not like to use journal in base_pool. The main reason why drop j=
ournal
>>>> > in base_pool is that journal take over a single physical device =
and waste
>>>> > too much in base_pool.
>>>> >
>>>> > Like above, if I enable FlashCache or other cache, I'd not like =
to enable
>>>> > journal in OSD layer.
>>>> >
>>>> > So is it necessary to disable journal in special(not really spec=
ial) case?
>>>> >
>>>> > Best regards,
>>>> > Wheats
>>>> >
>>>> >
>>>> >
>>>> > --
>>>> > To unsubscribe from this list: send the line "unsubscribe ceph-d=
evel" in
>>>> > the body of a message to majordomo@vger.kernel.org
>>>> > More majordomo info at  http://vger.kernel.org/majordomo-info.ht=
ml
>>>
>>>
>>>
>>>
>>> --
>>>
>>> Best Regards,
>>>
>>> Wheat
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>>
>> --
>> Dong Yuan
>> Email:yuandong1222@gmail.com



--=20
Best Regards,

Wheat
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
