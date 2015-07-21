From: Gregory Farnum <greg@gregs42.com>
Subject: Re: The design of the eviction improvement
Date: Tue, 21 Jul 2015 15:25:21 +0100
Message-ID: <CAC6JEv8qaaGupcpU-sB1EtnR-K+WFwnp2UUEBRczFiw9uurbdw@mail.gmail.com>
References: <1539008200.49.1437488109510.JavaMail.root@thunderbeast.private.linuxbox.com>
	<1004223530.51.1437488157119.JavaMail.root@thunderbeast.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:37592 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752173AbbGUOZY convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Jul 2015 10:25:24 -0400
Received: by igbpg9 with SMTP id pg9so108340267igb.0
        for <ceph-devel@vger.kernel.org>; Tue, 21 Jul 2015 07:25:23 -0700 (PDT)
Received: from mail-ie0-f169.google.com (mail-ie0-f169.google.com. [209.85.223.169])
        by smtp.gmail.com with ESMTPSA id kk9sm7425621igb.7.2015.07.21.07.25.22
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jul 2015 07:25:22 -0700 (PDT)
Received: by iecri3 with SMTP id ri3so48562039iec.2
        for <ceph-devel@vger.kernel.org>; Tue, 21 Jul 2015 07:25:22 -0700 (PDT)
In-Reply-To: <1004223530.51.1437488157119.JavaMail.root@thunderbeast.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Matt W. Benjamin" <matt@cohortfs.com>
Cc: Zhiqiang Wang <zhiqiang.wang@intel.com>, "sjust@redhat.com" <sjust@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sage Weil <sweil@redhat.com>

On Tue, Jul 21, 2015 at 3:15 PM, Matt W. Benjamin <matt@cohortfs.com> w=
rote:
> Hi,
>
> Couple of points.
>
> 1) a successor to 2Q is MQ (Li et al).  We have an intrusive MQ LRU i=
mplementation
> with 2 levels currently, plus a pinned queue, that addresses stuff li=
ke partitioning ("sharding"), scan resistance, and coordination w/looku=
p tables.  We might extend/re-use it.
>
> 2) I'm a bit confused by active/inactive vocabulary, dimensioning of =
cache
> segments (are you proposing to/do we now always cache whole objects?)=
, and cost
> of "looking for" dirty objects;  I suspect that it makes sense to amo=
rtize the
> cost of locating segments eligible to be flushed, rather than minimiz=
e
> bookkeeping.

We make caching decisions in terms of whole objects right now, yeah.
There's really nothing in the system that's capable of doing segments
within an object, and it's not just about tracking a little more
metadata about dirty objects =E2=80=94 the way we handle snapshots, etc=
 would
have to be reworked if we were allowing partial-object caching. Plus
keep in mind the IO cost of the bookkeeping =E2=80=94 it needs to be ei=
ther
consistently persisted to disk or reconstructable from whatever
happens to be in the object. That can get expensive really fast.
-Greg

>
> Matt
>
> ----- "Zhiqiang Wang" <zhiqiang.wang@intel.com> wrote:
>
>> > -----Original Message-----
>> > From: ceph-devel-owner@vger.kernel.org
>> > [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Sage Weil
>> > Sent: Tuesday, July 21, 2015 6:38 AM
>> > To: Wang, Zhiqiang
>> > Cc: sjust@redhat.com; ceph-devel@vger.kernel.org
>> > Subject: Re: The design of the eviction improvement
>> >
>> > On Mon, 20 Jul 2015, Wang, Zhiqiang wrote:
>> > > Hi all,
>> > >
>> > > This is a follow-up of one of the CDS session at
>> >
>> http://tracker.ceph.com/projects/ceph/wiki/Improvement_on_the_cache_=
tieri
>> > ng_eviction. We discussed the drawbacks of the current eviction
>> algorithm and
>> > several ways to improve it. Seems like the LRU variants is the rig=
ht
>> way to go. I
>> > come up with some design points after the CDS, and want to discuss
>> it with you.
>> > It is an approximate 2Q algorithm, combining some benefits of the
>> clock
>> > algorithm, similar to what the linux kernel does for the page
>> cache.
>> >
>> > Unfortunately I missed this last CDS so I'm behind on the
>> discussion.  I have a
>> > few questions though...
>> >
>> > > # Design points:
>> > >
>> > > ## LRU lists
>> > > - Maintain LRU lists at the PG level.
>> > > The SharedLRU and SimpleLRU implementation in the current code
>> have a
>> > > max_size, which limits the max number of elements in the list.
>> This
>> > > mostly looks like a MRU, though its name implies they are LRUs.
>> Since
>> > > the object size may vary in a PG, it's not possible to caculate
>> the
>> > > total number of objects which the cache tier can hold ahead of
>> time.
>> > > We need a new LRU implementation with no limit on the size.
>> >
>> > This last sentence seems to me to be the crux of it.  Assuming we
>> have an
>> > OSD based by flash storing O(n) objects, we need a way to maintain
>> an LRU of
>> > O(n) objects in memory.  The current hitset-based approach was tak=
en
>> based
>> > on the assumption that this wasn't feasible--or at least we didn't
>> know how to
>> > implmement such a thing.  If it is, or we simply want to stipulate
>> that cache
>> > tier OSDs get gobs of RAM to make it possible, then lots of better
>> options
>> > become possible...
>> >
>> > Let's say you have a 1TB SSD, with an average object size of 1MB -=
-
>> that's
>> > 1 million objects.  At maybe ~100bytes per object of RAM for an LR=
U
>> entry
>> > that's 100MB... so not so unreasonable, perhaps!
>>
>> I was having the same question before proposing this. I did the
>> similar calculation and thought it would be ok to use this many memo=
ry
>> :-)
>>
>> >
>> > > - Two lists for each PG: active and inactive Objects are first
>> put
>> > > into the inactive list when they are accessed, and moved between
>> these two
>> > lists based on some criteria.
>> > > Object flag: active, referenced, unevictable, dirty.
>> > > - When an object is accessed:
>> > > 1) If it's not in both of the lists, it's put on the top of the
>> > > inactive list
>> > > 2) If it's in the inactive list, and the referenced flag is not
>> set, the referenced
>> > flag is set, and it's moved to the top of the inactive list.
>> > > 3) If it's in the inactive list, and the referenced flag is set,
>> the referenced flag
>> > is cleared, and it's removed from the inactive list, and put on to=
p
>> of the active
>> > list.
>> > > 4) If it's in the active list, and the referenced flag is not se=
t,
>> the referenced
>> > flag is set, and it's moved to the top of the active list.
>> > > 5) If it's in the active list, and the referenced flag is set,
>> it's moved to the top
>> > of the active list.
>> > > - When selecting objects to evict:
>> > > 1) Objects at the bottom of the inactive list are selected to
>> evict. They are
>> > removed from the inactive list.
>> > > 2) If the number of the objects in the inactive list becomes low=
,
>> some of the
>> > objects at the bottom of the active list are moved to the inactive
>> list. For those
>> > objects which have the referenced flag set, they are given one mor=
e
>> chance in
>> > the active list. They are moved to the top of the active list with
>> the referenced
>> > flag cleared. For those objects which don't have the referenced fl=
ag
>> set, they
>> > are moved to the inactive list, with the referenced flag set. So
>> that they can be
>> > quickly promoted to the active list when necessary.
>> > >
>> > > ## Combine flush with eviction
>> > > - When evicting an object, if it's dirty, it's flushed first.
>> After flushing, it's
>> > evicted. If not dirty, it's evicted directly.
>> > > - This means that we won't have separate activities and won't se=
t
>> different
>> > ratios for flush and evict. Is there a need to do so?
>> > > - Number of objects to evict at a time. 'evict_effort' acts as t=
he
>> priority, which
>> > is used to calculate the number of objects to evict.
>> >
>> > As someone else mentioned in a follow-up, the reason we let the
>> dirty level be
>> > set lower than the full level is that it provides headroom so that
>> objects can be
>> > quickly evicted (delete, no flush) to make room for new writes or
>> new
>> > promotions.
>> >
>> > That said, we probably can/should streamline the flush so that an
>> evict can
>> > immediately follow without waiting for the agent to come around
>> again.
>> > (I don't think we do that now?)
>>
>> I was afraid of having to maintain different lists for flush/evict. =
So
>> I proposed to combine flush with evict. But seems like we don't need
>> to. When reaching the dirty ratio and selecting objects to flush, we
>> look for dirty objects from the inactive list. The objects are marke=
d
>> clean and kept in the same position in the LRU list after flushing.
>> When evicting objects, clean objects in the inactive list are
>> selected. Dirty objects are ignored. This will keep the flush/evict
>> the same as current implementation. Make sense?
>>
>> >
>> > sage
>> >
>> >
>> > > ## LRU lists Snapshotting
>> > > - The two lists are snapshotted persisted periodically.
>> > > - Only one copy needs to be saved. The old copy is removed when
>> persisting
>> > the lists. The saved lists are used to restore the LRU lists when
>> OSD reboots.
>> > >
>> > > Any comments/feedbacks are welcomed.
>> > > --
>> > > To unsubscribe from this list: send the line "unsubscribe
>> ceph-devel"
>> > > in the body of a message to majordomo@vger.kernel.org More
>> majordomo
>> > > info at  http://vger.kernel.org/majordomo-info.html
>> > >
>> > >
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe
>> ceph-devel" in the body
>> > of a message to majordomo@vger.kernel.org More majordomo info at
>> > http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
"
>> in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> --
> Matt Benjamin
> CohortFS, LLC.
> 315 West Huron Street, Suite 140A
> Ann Arbor, Michigan 48103
>
> http://cohortfs.com
>
> tel.  734-761-4689
> fax.  734-769-8938
> cel.  734-216-5309
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
