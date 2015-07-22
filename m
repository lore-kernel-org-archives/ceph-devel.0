From: Sage Weil <sweil@redhat.com>
Subject: RE: The design of the eviction improvement
Date: Wed, 22 Jul 2015 11:51:28 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1507221145530.18181@cobra.newdream.net>
References: <06E7D85B3BA36C4DB207FEDE871C53489FFC64@SHSMSX101.ccr.corp.intel.com> <alpine.DEB.2.00.1507201530200.8878@cobra.newdream.net> <06E7D85B3BA36C4DB207FEDE871C53489FFF18@SHSMSX101.ccr.corp.intel.com> <alpine.DEB.2.00.1507210620270.8878@cobra.newdream.net>
 <06E7D85B3BA36C4DB207FEDE871C5348A001B4@SHSMSX101.ccr.corp.intel.com> <alpine.DEB.2.00.1507220551290.8878@cobra.newdream.net> <7334B4281E425749B85E08CF7EC6F853437A9AB3@SACMBXIP03.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49428 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751600AbbGVSvb (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 22 Jul 2015 14:51:31 -0400
In-Reply-To: <7334B4281E425749B85E08CF7EC6F853437A9AB3@SACMBXIP03.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Allen Samuels <Allen.Samuels@sandisk.com>
Cc: "Wang, Zhiqiang" <zhiqiang.wang@intel.com>, "sjust@redhat.com" <sjust@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 22 Jul 2015, Allen Samuels wrote:
> I'm very concerned about designing around the assumption that objects 
> are ~1MB in size. That's probably a good assumption for block and HDFS 
> dominated systems, but likely a very poor assumption about many object 
> and file dominated systems.
> 
> If I understand the proposals that have been discussed, each of them 
> assumes in in-memory data structure with an entry per object (the exact 
> size of the entry varies with the different proposals).
> 
> Under that assumption, I have another concern which is the lack of 
> graceful degradation as the object counts grow and the in-memory data 
> structures get larger. Everything seems fine until just a few objects 
> get added then the system starts to page and performance drops 
> dramatically (likely) to the point where Linux will start killing OSDs.
> 
> What's really needed is some kind of way to extend the lists into 
> storage in way that's doesn't cause a zillion I/O operations.
> 
> I have some vague idea that some data structure like the LSM mechanism 
> ought to be able to accomplish what we want. Some amount of the data 
> structure (the most likely to be used) is held in DRAM [and backed to 
> storage for restart] and the least likely to be used is flushed to 
> storage with some mechanism that allows batched updates.

How about this:

The basic mapping we want is object -> atime.

We keep a simple LRU of the top N objects in memory with the object->atime 
values.  When an object is accessed, it is moved or added to the top 
of the list.

Periodically, or when the LRU size reaches N * (1.x), we flush:

 - write the top N items to a compact object that can be quickly loaded
 - write our records for the oldest items (N .. N*1.x) to leveldb/rocksdb 
in a simple object -> atime fashion

When the agent runs, we just walk across that key range of the db the same 
way we currently enumerate objects.  For each record we use either the 
stored atime or the value in the in-memory LRU (it'll need to be 
dual-indexed by both a list and a hash map), whichever is newer.  We can 
use the same histogram estimation approach we do now to determine if the 
object in question is below the flush/evict threshold.

The LSM does the work of sorting/compacting the atime info, while we avoid 
touching it at all for the hottest objects to keep the amount of work it 
has to do in check.

sage

> 
> Allen Samuels
> Software Architect, Systems and Software Solutions
> 
> 2880 Junction Avenue, San Jose, CA 95134
> T: +1 408 801 7030| M: +1 408 780 6416
> allen.samuels@SanDisk.com
> 
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Sage Weil
> Sent: Wednesday, July 22, 2015 5:57 AM
> To: Wang, Zhiqiang
> Cc: sjust@redhat.com; ceph-devel@vger.kernel.org
> Subject: RE: The design of the eviction improvement
> 
> On Wed, 22 Jul 2015, Wang, Zhiqiang wrote:
> > > The part that worries me now is the speed with which we can load and
> > > manage such a list.  Assuming it is several hundred MB, it'll take a
> > > while to load that into memory and set up all the pointers (assuming
> > > a conventional linked list structure).  Maybe tens of seconds...
> >
> > I'm thinking of maintaining the lists at the PG level. That's to say,
> > we have an active/inactive list for every PG. We can load the lists in
> > parallel during rebooting. Also, the ~100 MB lists are split among
> > different OSD nodes. Perhaps it does not need such long time to load
> > them?
> >
> > >
> > > I wonder if instead we should construct some sort of flat model
> > > where we load slabs of contiguous memory, 10's of MB each, and have
> > > the next/previous pointers be a (slab,position) pair.  That way we
> > > can load it into memory in big chunks, quickly, and be able to
> > > operate on it (adjust links) immediately.
> > >
> > > Another thought: currently we use the hobject_t hash only instead of
> > > the full object name.  We could continue to do the same, or we could
> > > do a hash pair (hobject_t hash + a different hash of the rest of the
> > > object) to keep the representation compact.  With a model lke the
> > > above, that could get the object representation down to 2 u32's.  A
> > > link could be a slab + position (2 more u32's), and if we have prev
> > > + next that'd be just 6x4=24 bytes per object.
> >
> > Looks like for an object, the head and the snapshot version have the
> > same hobject hash. Thus we have to use the hash pair instead of just
> > the hobject hash. But I still have two questions if we use the hash
> > pair to represent an object.
> >
> > 1) Does the hash pair uniquely identify an object? That's to say, is
> > it possible for two objects to have the same hash pair?
> 
> With two hashes collisions would be rare but could happen
> 
> > 2) We need a way to get the full object name from the hash pair, so
> > that we know what objects to evict. But seems like we don't have a
> > good way to do this?
> 
> Ah, yeah--I'm a little stuck in the current hitset view of things.  I think we can either embed the full ghobject_t (which means we lose the fixed-size property, and the per-object overhead goes way up.. probably from ~24 bytes to more like 80 or 100).  Or, we can enumerate objects starting at the (hobject_t) hash position to find the object.  That's somewhat inefficient for FileStore (it'll list a directory of a hundred or so objects, probably, and iterate over them to find the right one), but for NewStore it will be quite fast (NewStore has all objects sorted into keys in rocksdb, so we just start listing at the right offset).  Usually we'll get the object right off, unless there are hobject_t hash collisions (already reasonably rare since it's a 2^32 space for the pool).
> 
> Given that, I would lean toward the 2-hash fixed-sized records (of these 2 options)...
> 
> sage
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> ________________________________
> 
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
