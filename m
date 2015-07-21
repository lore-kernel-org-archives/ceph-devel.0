From: "Wang, Zhiqiang" <zhiqiang.wang@intel.com>
Subject: RE: The design of the eviction improvement
Date: Tue, 21 Jul 2015 03:55:44 +0000
Message-ID: <06E7D85B3BA36C4DB207FEDE871C53489FFEFF@SHSMSX101.ccr.corp.intel.com>
References: <06E7D85B3BA36C4DB207FEDE871C53489FFC64@SHSMSX101.ccr.corp.intel.com>
 <08fcbe8a.9Ro.9Gf.1U.hCy4iF@mailjet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:30249 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751268AbbGUDzy convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Jul 2015 23:55:54 -0400
In-Reply-To: <08fcbe8a.9Ro.9Gf.1U.hCy4iF@mailjet.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nick Fisk <nick@fisk.me.uk>
Cc: 'Sage Weil' <sweil@redhat.com>, "sjust@redhat.com" <sjust@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Nick,

> -----Original Message-----
> From: Nick Fisk [mailto:nick@fisk.me.uk]
> Sent: Monday, July 20, 2015 5:28 PM
> To: Wang, Zhiqiang; 'Sage Weil'; sjust@redhat.com;
> ceph-devel@vger.kernel.org
> Subject: RE: The design of the eviction improvement
> 
> Hi,
> 
> > -----Original Message-----
> > From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> > owner@vger.kernel.org] On Behalf Of Wang, Zhiqiang
> > Sent: 20 July 2015 09:47
> > To: Sage Weil <sweil@redhat.com>; sjust@redhat.com; ceph-
> > devel@vger.kernel.org
> > Subject: The design of the eviction improvement
> >
> > Hi all,
> >
> > This is a follow-up of one of the CDS session at
> > http://tracker.ceph.com/projects/ceph/wiki/Improvement_on_the_cache_
> > tiering_eviction. We discussed the drawbacks of the current eviction
> > algorithm and several ways to improve it. Seems like the LRU variants
> > is
> the
> > right way to go. I come up with some design points after the CDS, and
> > want to discuss it with you. It is an approximate 2Q algorithm,
> > combining some benefits of the clock algorithm, similar to what the
> > linux kernel does for
> the
> > page cache.
> >
> > # Design points:
> >
> > ## LRU lists
> > - Maintain LRU lists at the PG level.
> > The SharedLRU and SimpleLRU implementation in the current code have a
> > max_size, which limits the max number of elements in the list. This
> > mostly looks like a MRU, though its name implies they are LRUs. Since
> > the object
> size
> > may vary in a PG, it's not possible to caculate the total number of
> objects
> > which the cache tier can hold ahead of time. We need a new LRU
> > implementation with no limit on the size.
> > - Two lists for each PG: active and inactive Objects are first put
> > into
> the
> > inactive list when they are accessed, and moved between these two
> > lists based on some criteria.
> > Object flag: active, referenced, unevictable, dirty.
> > - When an object is accessed:
> > 1) If it's not in both of the lists, it's put on the top of the
> > inactive
> list
> > 2) If it's in the inactive list, and the referenced flag is not set,
> > the
> referenced
> > flag is set, and it's moved to the top of the inactive list.
> > 3) If it's in the inactive list, and the referenced flag is set, the
> referenced flag
> > is cleared, and it's removed from the inactive list, and put on top of
> > the
> active
> > list.
> > 4) If it's in the active list, and the referenced flag is not set, the
> referenced
> > flag is set, and it's moved to the top of the active list.
> > 5) If it's in the active list, and the referenced flag is set, it's
> > moved
> to the top
> > of the active list.
> > - When selecting objects to evict:
> > 1) Objects at the bottom of the inactive list are selected to evict.
> > They
> are
> > removed from the inactive list.
> > 2) If the number of the objects in the inactive list becomes low, some
> > of
> the
> > objects at the bottom of the active list are moved to the inactive list.
> For
> > those objects which have the referenced flag set, they are given one
> > more chance in the active list. They are moved to the top of the
> > active list
> with the
> > referenced flag cleared. For those objects which don't have the
> > referenced flag set, they are moved to the inactive list, with the
> > referenced flag
> set. So
> > that they can be quickly promoted to the active list when necessary.
> >
> 
> I really like this idea but just out of interest, there must be a point where the
> overhead of managing much larger lists of very cold objects starts to impact on
> the gains of having exactly the right objects in each tier. If 90% of your hot IO is
> in 10% of the total data, how much extra benefit would you get by tracking all
> objects vs just tracking the top 10,20,30%...etc and evicting randomly after
> that?  If these objects are being accessed infrequently, the impact of
> re-promoting is probably minimal and if the promotion code can get to a point
> where it is being a bit more intelligent about what objects are promoted then
> this is probably even more so?

The idea is that the lists only hold the objects in the cache tier. For those objects which are cold enough, it's evicted from the cache tier and removed from the lists. Also, the lists are maintained at the PG level. I guess the lists won't be too extremely large? In your example of the 90%/10% data access, it may be right that randomly evicting the 90% cold data is good enough. But we need a way to know what the 10% of the hot data are. Also, we can't assume the 90%/10% pattern for every workload.

> 
> > ## Combine flush with eviction
> > - When evicting an object, if it's dirty, it's flushed first. After
> flushing, it's
> > evicted. If not dirty, it's evicted directly.
> > - This means that we won't have separate activities and won't set
> different
> > ratios for flush and evict. Is there a need to do so?
> > - Number of objects to evict at a time. 'evict_effort' acts as the
> priority, which
> > is used to calculate the number of objects to evict.
> >
> 
> I think you want to flush at a lower limit because flushes can be more expensive
> that evictions. Also you want more headroom for flushes so that you don't run
> the risk of filling up the tier with dirty objects and then running out of space.
> Have you also seen the recent two speed flushing commit which provides high
> and low speeds for tier flushing?

Yes, what you said are right. My previous thought is that we may need to maintain different LRU lists for flush and evict if we separate them. But seems not. Please check my reply to Sage in another mail.

> 
> On a related note, I wonder if it would make sense to make sure a read
> promotion can't trigger a dirty object flush. You probably don't want to start
> doing flushing if you get a read storm, something like large sequential read on a
> file. I think on most other implementations of caching I can think of, the write
> cache is normally ring fenced in this sense.

Currently the flush is triggered when the dirty ratio reaches the threshold when handling op request. It's not triggered by promotion. For sequential read, maybe a better way is to proxy them. Even if we decides to do a read promotion, this doesn't increase the dirty ratio.

> 
> > ## LRU lists Snapshotting
> > - The two lists are snapshotted persisted periodically.
> > - Only one copy needs to be saved. The old copy is removed when
> > persisting the lists. The saved lists are used to restore the LRU
> > lists when OSD
> reboots.
> >
> > Any comments/feedbacks are welcomed.
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> > in
> the
> > body of a message to majordomo@vger.kernel.org More majordomo info at
> > http://vger.kernel.org/majordomo-info.html
> 
> 
> 

