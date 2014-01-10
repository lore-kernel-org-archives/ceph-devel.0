From: Dong Yuan <yuandong1222@gmail.com>
Subject: Re: Proposal for adding disable FileJournal option
Date: Fri, 10 Jan 2014 11:08:13 +0800
Message-ID: <CAMm-wcJ9_gbr6UJJhACpV3hA77Lw9Qega=AtnfU5j2w_OViJ-w@mail.gmail.com>
References: <08E73B64-A538-4A34-B0F6-1D7A2A00A8AF@gmail.com>
	<CAPYLRzgb1dEi=prb32mfVZ+=jDS72376GPU-pz7n3SPs7T-t1Q@mail.gmail.com>
	<CACJqLyY6L+f2DBq-dcJVphSRKegReHm0XoVhC-H_3Jg6shRmfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:52437 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751142AbaAJDIP convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Jan 2014 22:08:15 -0500
Received: by mail-wi0-f179.google.com with SMTP id z2so4299801wiv.0
        for <ceph-devel@vger.kernel.org>; Thu, 09 Jan 2014 19:08:14 -0800 (PST)
In-Reply-To: <CACJqLyY6L+f2DBq-dcJVphSRKegReHm0XoVhC-H_3Jg6shRmfQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomaiwang@gmail.com>
Cc: Gregory Farnum <greg@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

The Journal is the part of implementation of ObjectStore Transaction
Interface, while transaction is used by PG to write pglog with object
data in one transaction.
So I think if the FileJournal could be disabled, there must be
something else to implement the Transaction Interface. But it seems
hard while no local file-system provide such function in my opinion.


On 10 January 2014 10:04, Haomai Wang <haomaiwang@gmail.com> wrote:
> On Fri, Jan 10, 2014 at 1:28 AM, Gregory Farnum <greg@inktank.com> wr=
ote:
>>
>> The FileJournal is also for data safety whenever we're using write
>> ahead. To disable it we need a backing store that we know can provid=
e
>> us consistent checkpoints (i.e., we can use parallel journaling mode=
 =97
>> so for the FileJournal, we're using btrfs, or maybe zfs someday). Bu=
t
>> for those systems you can already configure the system not to use a
>> journal.
>
> Yes, it depends on backend. For example, FileStore can write a object=
 with sync
> to sure consistent. If adding a disable FileJournal option, we need
> some works on
> FileStore to implement it.
>
>> -Greg
>> Software Engineer #42 @ http://inktank.com | http://ceph.com
>>
>>
>> On Thu, Jan 9, 2014 at 12:13 AM, Haomai Wang <haomaiwang@gmail.com> =
wrote:
>> > Hi all,
>> >
>> > We know FileJournal plays a important role in FileStore backend, i=
t can
>> > hugely reduce write latency and improve small write operations.
>> >
>> > But in practice, there exists exceptions such as we already use Fl=
ashCache or cachepool(although it's not ready).
>> >
>> > If cachepool enabled, we may use use journal in cache_pool but may
>> > not like to use journal in base_pool. The main reason why drop jou=
rnal
>> > in base_pool is that journal take over a single physical device an=
d waste
>> > too much in base_pool.
>> >
>> > Like above, if I enable FlashCache or other cache, I'd not like to=
 enable
>> > journal in OSD layer.
>> >
>> > So is it necessary to disable journal in special(not really specia=
l) case?
>> >
>> > Best regards,
>> > Wheats
>> >
>> >
>> >
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
>
> --
>
> Best Regards,
>
> Wheat
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Dong Yuan
Email:yuandong1222@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
