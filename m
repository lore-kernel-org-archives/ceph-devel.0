From: Dong Yuan <yuandong1222@gmail.com>
Subject: Re: Proposal for adding disable FileJournal option
Date: Sat, 11 Jan 2014 23:18:51 +0800
Message-ID: <CAMm-wcJn8=qe1W8c3-ff+JWwK-NLbD7e8-tP=X-QzT-DMXnWVw@mail.gmail.com>
References: <08E73B64-A538-4A34-B0F6-1D7A2A00A8AF@gmail.com>
	<CAPYLRzgb1dEi=prb32mfVZ+=jDS72376GPU-pz7n3SPs7T-t1Q@mail.gmail.com>
	<CACJqLyY6L+f2DBq-dcJVphSRKegReHm0XoVhC-H_3Jg6shRmfQ@mail.gmail.com>
	<CAMm-wcJ9_gbr6UJJhACpV3hA77Lw9Qega=AtnfU5j2w_OViJ-w@mail.gmail.com>
	<CAPYLRzhVbBJRhTsuO00vTWasaxjE1Sqrj+8S_HtSdB++kJ82ZQ@mail.gmail.com>
	<CACJqLyaLdjECGHvSozcZRbXNU1Drwtkp0oa2OQNgerb8dCSuSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:32975 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750902AbaAKPSw convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 11 Jan 2014 10:18:52 -0500
Received: by mail-wg0-f53.google.com with SMTP id k14so5216266wgh.32
        for <ceph-devel@vger.kernel.org>; Sat, 11 Jan 2014 07:18:51 -0800 (PST)
In-Reply-To: <CACJqLyaLdjECGHvSozcZRbXNU1Drwtkp0oa2OQNgerb8dCSuSA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomaiwang@gmail.com>
Cc: Gregory Farnum <greg@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

It is not only for consistent between memory and disk. The key point
is to implement the atomicity of an trancation.

That is when an trancation needs to write an object and update the
pglog at the same time, we must make sure the two IO do both or
nether.

With the journal, when osd restore from failure, the reply process can
redo the transcation. I think that is why the journal can not be
disabled.

On 11 January 2014 13:24, Haomai Wang <haomaiwang@gmail.com> wrote:
> On Fri, Jan 10, 2014 at 11:13 AM, Gregory Farnum <greg@inktank.com> w=
rote:
>> Exactly. We can't do a safe update without a journal =97 what if pow=
er
>> goes out while the write is happening? When we boot back up, we don'=
t
>> know what version the object is actually at. So if you're using btrf=
s,
>> you can run without a journal already (and depend on snapshots for
>> recovering after failures); if you are using xfs or ext4 a journal i=
s
>> required for any safety at all, even when it's fronted by a cache
>> pool.
>
> I'm not fully agree with it. Why we can't call "fdatasync()" during
> each transaction to
> ensure consistent if exists cache in the front of.
>
>>
>> On Thu, Jan 9, 2014 at 7:08 PM, Dong Yuan <yuandong1222@gmail.com> w=
rote:
>>> The Journal is the part of implementation of ObjectStore Transactio=
n
>>> Interface, while transaction is used by PG to write pglog with obje=
ct
>>> data in one transaction.
>>> So I think if the FileJournal could be disabled, there must be
>>> something else to implement the Transaction Interface. But it seems
>>> hard while no local file-system provide such function in my opinion=
=2E
>>>
>>>
>>> On 10 January 2014 10:04, Haomai Wang <haomaiwang@gmail.com> wrote:
>>>> On Fri, Jan 10, 2014 at 1:28 AM, Gregory Farnum <greg@inktank.com>=
 wrote:
>>>>>
>>>>> The FileJournal is also for data safety whenever we're using writ=
e
>>>>> ahead. To disable it we need a backing store that we know can pro=
vide
>>>>> us consistent checkpoints (i.e., we can use parallel journaling m=
ode =97
>>>>> so for the FileJournal, we're using btrfs, or maybe zfs someday).=
 But
>>>>> for those systems you can already configure the system not to use=
 a
>>>>> journal.
>>>>
>>>> Yes, it depends on backend. For example, FileStore can write a obj=
ect with sync
>>>> to sure consistent. If adding a disable FileJournal option, we nee=
d
>>>> some works on
>>>> FileStore to implement it.
>>>>
>>>>> -Greg
>>>>> Software Engineer #42 @ http://inktank.com | http://ceph.com
>>>>>
>>>>>
>>>>> On Thu, Jan 9, 2014 at 12:13 AM, Haomai Wang <haomaiwang@gmail.co=
m> wrote:
>>>>> > Hi all,
>>>>> >
>>>>> > We know FileJournal plays a important role in FileStore backend=
, it can
>>>>> > hugely reduce write latency and improve small write operations.
>>>>> >
>>>>> > But in practice, there exists exceptions such as we already use=
 FlashCache or cachepool(although it's not ready).
>>>>> >
>>>>> > If cachepool enabled, we may use use journal in cache_pool but =
may
>>>>> > not like to use journal in base_pool. The main reason why drop =
journal
>>>>> > in base_pool is that journal take over a single physical device=
 and waste
>>>>> > too much in base_pool.
>>>>> >
>>>>> > Like above, if I enable FlashCache or other cache, I'd not like=
 to enable
>>>>> > journal in OSD layer.
>>>>> >
>>>>> > So is it necessary to disable journal in special(not really spe=
cial) case?
>>>>> >
>>>>> > Best regards,
>>>>> > Wheats
>>>>> >
>>>>> >
>>>>> >
>>>>> > --
>>>>> > To unsubscribe from this list: send the line "unsubscribe ceph-=
devel" in
>>>>> > the body of a message to majordomo@vger.kernel.org
>>>>> > More majordomo info at  http://vger.kernel.org/majordomo-info.h=
tml
>>>>
>>>>
>>>>
>>>>
>>>> --
>>>>
>>>> Best Regards,
>>>>
>>>> Wheat
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
>>>
>>> --
>>> Dong Yuan
>>> Email:yuandong1222@gmail.com
>
>
>
> --
> Best Regards,
>
> Wheat



--=20
Dong Yuan
Email:yuandong1222@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
