From: Gregory Farnum <greg@inktank.com>
Subject: Re: Proposal for adding disable FileJournal option
Date: Thu, 9 Jan 2014 19:13:55 -0800
Message-ID: <CAPYLRzhVbBJRhTsuO00vTWasaxjE1Sqrj+8S_HtSdB++kJ82ZQ@mail.gmail.com>
References: <08E73B64-A538-4A34-B0F6-1D7A2A00A8AF@gmail.com>
	<CAPYLRzgb1dEi=prb32mfVZ+=jDS72376GPU-pz7n3SPs7T-t1Q@mail.gmail.com>
	<CACJqLyY6L+f2DBq-dcJVphSRKegReHm0XoVhC-H_3Jg6shRmfQ@mail.gmail.com>
	<CAMm-wcJ9_gbr6UJJhACpV3hA77Lw9Qega=AtnfU5j2w_OViJ-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qe0-f44.google.com ([209.85.128.44]:51376 "EHLO
	mail-qe0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027AbaAJDN4 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Jan 2014 22:13:56 -0500
Received: by mail-qe0-f44.google.com with SMTP id nd7so4024014qeb.17
        for <ceph-devel@vger.kernel.org>; Thu, 09 Jan 2014 19:13:55 -0800 (PST)
In-Reply-To: <CAMm-wcJ9_gbr6UJJhACpV3hA77Lw9Qega=AtnfU5j2w_OViJ-w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dong Yuan <yuandong1222@gmail.com>
Cc: Haomai Wang <haomaiwang@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Exactly. We can't do a safe update without a journal =97 what if power
goes out while the write is happening? When we boot back up, we don't
know what version the object is actually at. So if you're using btrfs,
you can run without a journal already (and depend on snapshots for
recovering after failures); if you are using xfs or ext4 a journal is
required for any safety at all, even when it's fronted by a cache
pool.

On Thu, Jan 9, 2014 at 7:08 PM, Dong Yuan <yuandong1222@gmail.com> wrot=
e:
> The Journal is the part of implementation of ObjectStore Transaction
> Interface, while transaction is used by PG to write pglog with object
> data in one transaction.
> So I think if the FileJournal could be disabled, there must be
> something else to implement the Transaction Interface. But it seems
> hard while no local file-system provide such function in my opinion.
>
>
> On 10 January 2014 10:04, Haomai Wang <haomaiwang@gmail.com> wrote:
>> On Fri, Jan 10, 2014 at 1:28 AM, Gregory Farnum <greg@inktank.com> w=
rote:
>>>
>>> The FileJournal is also for data safety whenever we're using write
>>> ahead. To disable it we need a backing store that we know can provi=
de
>>> us consistent checkpoints (i.e., we can use parallel journaling mod=
e =97
>>> so for the FileJournal, we're using btrfs, or maybe zfs someday). B=
ut
>>> for those systems you can already configure the system not to use a
>>> journal.
>>
>> Yes, it depends on backend. For example, FileStore can write a objec=
t with sync
>> to sure consistent. If adding a disable FileJournal option, we need
>> some works on
>> FileStore to implement it.
>>
>>> -Greg
>>> Software Engineer #42 @ http://inktank.com | http://ceph.com
>>>
>>>
>>> On Thu, Jan 9, 2014 at 12:13 AM, Haomai Wang <haomaiwang@gmail.com>=
 wrote:
>>> > Hi all,
>>> >
>>> > We know FileJournal plays a important role in FileStore backend, =
it can
>>> > hugely reduce write latency and improve small write operations.
>>> >
>>> > But in practice, there exists exceptions such as we already use F=
lashCache or cachepool(although it's not ready).
>>> >
>>> > If cachepool enabled, we may use use journal in cache_pool but ma=
y
>>> > not like to use journal in base_pool. The main reason why drop jo=
urnal
>>> > in base_pool is that journal take over a single physical device a=
nd waste
>>> > too much in base_pool.
>>> >
>>> > Like above, if I enable FlashCache or other cache, I'd not like t=
o enable
>>> > journal in OSD layer.
>>> >
>>> > So is it necessary to disable journal in special(not really speci=
al) case?
>>> >
>>> > Best regards,
>>> > Wheats
>>> >
>>> >
>>> >
>>> > --
>>> > To unsubscribe from this list: send the line "unsubscribe ceph-de=
vel" in
>>> > the body of a message to majordomo@vger.kernel.org
>>> > More majordomo info at  http://vger.kernel.org/majordomo-info.htm=
l
>>
>>
>>
>>
>> --
>>
>> Best Regards,
>>
>> Wheat
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Dong Yuan
> Email:yuandong1222@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
