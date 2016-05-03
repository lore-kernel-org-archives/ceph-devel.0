From: Mark Nelson <mnelson@redhat.com>
Subject: Re: mon switch from leveldb to rocksdb
Date: Tue, 3 May 2016 12:01:19 -0500
Message-ID: <ffb1914f-0321-c5d7-bab6-4c5fb0f67441@redhat.com>
References: <alpine.DEB.2.11.1605021444320.26967@cpach.fuggernut.com>
 <5727A3DC.7070102@symas.com>
 <bee8107b-0d3e-3ebc-d029-ed27e0165137@redhat.com>
 <CAJ4mKGbsJBk_8N8tkmqhYOipXXQC-LdiV=XOZ8S22HCCXh8_OA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42780 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756048AbcECRBX (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 3 May 2016 13:01:23 -0400
In-Reply-To: <CAJ4mKGbsJBk_8N8tkmqhYOipXXQC-LdiV=XOZ8S22HCCXh8_OA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Howard Chu <hyc@symas.com>, Sage Weil <sweil@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>



On 05/03/2016 11:41 AM, Gregory Farnum wrote:
> On Tue, May 3, 2016 at 6:34 AM, Mark Nelson <mnelson@redhat.com> wrot=
e:
>> On 05/02/2016 02:00 PM, Howard Chu wrote:
>>>
>>> Sage Weil wrote:
>>>>
>>>> 1) Thoughts on moving to rocksdb in general?
>>>
>>>
>>> Are you actually prepared to undertake all of the measurement and t=
uning
>>> required to make RocksDB actually work well? You're switching from =
an
>>> (abandoned/unsupported) engine with only a handful of config parame=
ters
>>> to one with ~40-50 params, all of which have critical but unpredict=
able
>>> impact on resource consumption and performance.
>>>
>>
>> You are absolutely correct, and there are definitely pitfalls we nee=
d to
>> watch out for with the number of tunables in rocksdb.  At least on t=
he
>> performance side two of the big issues we've hit with leveldb compac=
tion
>> related.  In some scenarios compaction happens slower than the numbe=
r of
>> writes coming in resulting in ever-growing db sizes.  The other issu=
e is
>> that compaction is single threaded and this can cause stalls and gen=
eral
>> mayhem when things get really heavily loaded.  My hope is that if we=
 do go
>> with rocksdb, even in a sub-optimally tuned state, we'll be better o=
ff than
>> we were with leveldb.
>>
>> We did some very preliminary benchmarks a couple of years ago (admit=
tedly a
>> too-small dataset size) basically comparing the (at the time) stock =
ceph
>> leveldb settings vs rocksdb.  On this set size, leveldb looked much =
better
>> for reads, but much worse for writes.
>
> That's actually a bit troubling =E2=80=94 many of our monitor problem=
s have
> arisen from slow reads, rather than slow writes. I suspect we want to
> eliminate this before switching, if it's a concern.
>
> ...Although I think I did see a monitor caching layer go by, so maybe
> it's a moot point now?

Yeah, I suspect that's helping significantly.  I think based at least=20
one what I remember seeing I'm more concerned about high latency events=
=20
than average read performance though.  IE if there is a compaction=20
storm, which store is going to handle it more gracefully with less=20
spikey behavior?

In those leveldb tests we only saw writes and write trims hit by those=20
periodic 10-60 second high-latency spikes, but if I recall the mon has=20
(or at least had?) a global lock where write stalls would basically mak=
e=20
the whole monitor stall.  I think Joao might have improved that after w=
e=20
did this testing but I don't remember the details at this point.

> -Greg
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
