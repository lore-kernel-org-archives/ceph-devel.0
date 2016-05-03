From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: mon switch from leveldb to rocksdb
Date: Tue, 3 May 2016 10:20:45 -0700
Message-ID: <CAJ4mKGahdrWPpz+DuC2993oerkdvwu1VD3y4sKWN2aQ_+f+8Eg@mail.gmail.com>
References: <alpine.DEB.2.11.1605021444320.26967@cpach.fuggernut.com>
	<5727A3DC.7070102@symas.com>
	<bee8107b-0d3e-3ebc-d029-ed27e0165137@redhat.com>
	<CAJ4mKGbsJBk_8N8tkmqhYOipXXQC-LdiV=XOZ8S22HCCXh8_OA@mail.gmail.com>
	<ffb1914f-0321-c5d7-bab6-4c5fb0f67441@redhat.com>
	<alpine.DEB.2.11.1605031314160.26967@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f174.google.com ([209.85.161.174]:35656 "EHLO
	mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756039AbcECRUr convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 May 2016 13:20:47 -0400
Received: by mail-yw0-f174.google.com with SMTP id g133so27471083ywb.2
        for <ceph-devel@vger.kernel.org>; Tue, 03 May 2016 10:20:46 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1605031314160.26967@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Mark Nelson <mnelson@redhat.com>, Howard Chu <hyc@symas.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Tue, May 3, 2016 at 10:17 AM, Sage Weil <sweil@redhat.com> wrote:
> On Tue, 3 May 2016, Mark Nelson wrote:
>> On 05/03/2016 11:41 AM, Gregory Farnum wrote:
>> > On Tue, May 3, 2016 at 6:34 AM, Mark Nelson <mnelson@redhat.com> w=
rote:
>> > > On 05/02/2016 02:00 PM, Howard Chu wrote:
>> > > >
>> > > > Sage Weil wrote:
>> > > > >
>> > > > > 1) Thoughts on moving to rocksdb in general?
>> > > >
>> > > >
>> > > > Are you actually prepared to undertake all of the measurement =
and tuning
>> > > > required to make RocksDB actually work well? You're switching =
from an
>> > > > (abandoned/unsupported) engine with only a handful of config p=
arameters
>> > > > to one with ~40-50 params, all of which have critical but unpr=
edictable
>> > > > impact on resource consumption and performance.
>> > > >
>> > >
>> > > You are absolutely correct, and there are definitely pitfalls we=
 need to
>> > > watch out for with the number of tunables in rocksdb.  At least =
on the
>> > > performance side two of the big issues we've hit with leveldb co=
mpaction
>> > > related.  In some scenarios compaction happens slower than the n=
umber of
>> > > writes coming in resulting in ever-growing db sizes.  The other =
issue is
>> > > that compaction is single threaded and this can cause stalls and=
 general
>> > > mayhem when things get really heavily loaded.  My hope is that i=
f we do go
>> > > with rocksdb, even in a sub-optimally tuned state, we'll be bett=
er off
>> > > than
>> > > we were with leveldb.
>> > >
>> > > We did some very preliminary benchmarks a couple of years ago (a=
dmittedly
>> > > a
>> > > too-small dataset size) basically comparing the (at the time) st=
ock ceph
>> > > leveldb settings vs rocksdb.  On this set size, leveldb looked m=
uch better
>> > > for reads, but much worse for writes.
>> >
>> > That's actually a bit troubling =E2=80=94 many of our monitor prob=
lems have
>> > arisen from slow reads, rather than slow writes. I suspect we want=
 to
>> > eliminate this before switching, if it's a concern.
>> >
>> > ...Although I think I did see a monitor caching layer go by, so ma=
ybe
>> > it's a moot point now?
>>
>> Yeah, I suspect that's helping significantly.  I think based at leas=
t one what
>> I remember seeing I'm more concerned about high latency events than =
average
>> read performance though.  IE if there is a compaction storm, which s=
tore is
>> going to handle it more gracefully with less spikey behavior?
>
> I'm most worried about the read storm that happens on each commit to =
fetch
> all the just-updated PG stat keys.  The other data in the mon is just
> noise in comparison, I think, with the exception of the OSDMaps... wh=
ich
> IIRC is what the cache you mention was for.
>
> The initial PR,
>
>         https://github.com/ceph/ceph/pull/8888
>
> just makes the backend choice persistent.  Rocksdb is still experimen=
tal.
> There's an accompanying ceph-qa-suite pr so that we test both.  Once =
we
> do some performance evaluation we can decide whether the switch is sa=
fe
> as-is, if more work (caching layer or tuning) is needed, or if it's a=
 bad
> idea.
>
>> In those leveldb tests we only saw writes and write trims hit by tho=
se
>> periodic 10-60 second high-latency spikes, but if I recall the mon h=
as (or at
>> least had?) a global lock where write stalls would basically make th=
e whole
>> monitor stall.  I think Joao might have improved that after we did t=
his
>> testing but I don't remember the details at this point.
>
> I don't think any of this locking has changed...

The paxos state machine is no longer blocked for reads while an
unrelated write is happening. Nor are older-version reads on the
writing subsystem. That fix is post-firefly, right?
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
