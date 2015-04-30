From: Sage Weil <sweil@redhat.com>
Subject: Re: newstore performance update
Date: Thu, 30 Apr 2015 09:20:35 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1504300908290.5458@cobra.newdream.net>
References: <554016E2.3000104@redhat.com> <6F3FA899187F0043BA1827A69DA2F7CC021E4894@shsmsx102.ccr.corp.intel.com> <alpine.DEB.2.00.1504290929400.5458@cobra.newdream.net> <CACJqLyaJhkWM5C_QZ1zwk4ps5bwRqk0Ctd=4oSTzB0+2m2s-2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35938 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750705AbbD3QUj (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 30 Apr 2015 12:20:39 -0400
In-Reply-To: <CACJqLyaJhkWM5C_QZ1zwk4ps5bwRqk0Ctd=4oSTzB0+2m2s-2g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomaiwang@gmail.com>
Cc: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>, Mark Nelson <mnelson@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, 30 Apr 2015, Haomai Wang wrote:
> On Thu, Apr 30, 2015 at 12:38 AM, Sage Weil <sweil@redhat.com> wrote:
> > On Wed, 29 Apr 2015, Chen, Xiaoxi wrote:
> >> Hi Mark,
> >>       Really good test:) I only played a bit on SSD, the parallel WAL
> >> threads really helps but we still have a long way to go especially on
> >> all-ssd case. I tried this
> >> https://github.com/facebook/rocksdb/blob/master/util/env_posix.cc#L1515
> >> by hacking the rocksdb, but the performance difference is negligible.
> >
> > It gave me a 25% bump when rocksdb is on a spinning disk, so I went ahead
> > and committed the change to the branch.  Probably not noticeable on the
> > SSD, though it can't hurt.
> >
> >> The rocksdb digest speed should be the problem, I believe, I was planned
> >> to prove this by skip all db transaction, but failed since hitting other
> >> deadlock bug in newstore.
> >
> > Will look at that next!
> >
> >>
> >> Below are a bit more comments.
> >> > Sage has been furiously working away at fixing bugs in newstore and
> >> > improving performance.  Specifically we've been focused on write
> >> > performance as newstore was lagging filestore but quite a bit previously.  A
> >> > lot of work has gone into implementing libaio behind the scenes and as a
> >> > result performance on spinning disks with SSD WAL (and SSD backed rocksdb)
> >> > has improved pretty dramatically. It's now often beating filestore:
> >> >
> >>
> >> SSD DB is still better than SSD WAL with request size > 128KB, this indicate some WALs are actually written to Level0...Hmm, could we add newstore_wal_max_ops/bytes to capping the total WAL size(how much data is in WAL but not yet apply to backend FS) ?  I suspect this would improve performance by prevent some IO with high WA cost and latency?
> >>
> >> > http://nhm.ceph.com/newstore/newstore-5d96fe6-no_overlay.pdf
> >> >
> >> > On the other hand, sequential writes are slower than random writes when
> >> > the OSD, DB, and WAL are all on the same device be it a spinning disk or SSD.
> >>
> >> I think sequential writes slower than random is by design in Newstore,
> >> because for every object we can only have one WAL , that means no
> >> concurrent IO if the req_size* QD < 4MB. Not sure how many #QD do you
> >> have in the test? I suspect 64 since there is a boost in seq write
> >> performance with req size > 64 ( 64KB*64=4MB).
> >>
> >> In this case, IO pattern will be : 1 write to DB WAL->Sync-> 1 Write to
> >> FS -> Sync, we do everything in synchronize way ,which is essentially
> >> expensive.
> >
> > The number of syncs is the same for appends vs wal... in both cases we
> > fdatasync the file and the db commit, but with WAL the fs sync comes after
> > the commit point instead of before (and we don't double-write the data).
> > Appends should still be pipelined (many in flight for the same object)...
> > and the db syncs will be batched in both cases (submit_transaction for
> > each io, and a single thread doing the submit_transaction_sync in a loop).
> >
> > If that's not the case then it's an accident?
> 
> I hope I could clarify the current impl(For rbd 4k write, warm object,
> aio, no overlay) from my view compared to FileStore:
> 
> 1. because buffer should be page aligned, we only need to consider aio
> here. Prepare aio write(why we need to call ftruncate when doing
> append?), a must "open" call(may increase hugely if directory has lots
> of files?)

We do not do write-ahed journaling for append.. we just append, 
then fsync, then update the kv db.  Which means that after a crash 
it is possible to have extra data at teh end of a fragment.

That said, I found yesterday that the ftruncate was contending with 
a kernel lock (i_mutex or something) and slowing things down; now it 
does an fstat and only does the truncate if needed.

> 2. setxattr will encode the whole onode and omapsetkeys is the same as
> FileStore, but maybe a larger onode buffer compared to local fs xattr
> set in FileStore?

It's a bit bigger, yeah, but fewer key/value updates overall.

> 3. submit aio: because we do aio+dio for data file, so the "i_size"
> will be update inline AFAR for lots of cases?

XFS will journal an inode update, yeah.  This means 1 fsync per append, 
which does suck.. they don't get coalesced.  Perhaps a better strategy 
would be to not do O_DSYNC and queue the fsyncs independently?  Then 
there is some chance we'd have multiple fsyncs on the same file queued, 
the first would clean the inode, and the later ones would be no-ops, 
reducing the # of xfs journal writes...

> 4. aio completed and do aio fsync(comes from #2?, this will increase a
> thread wake/signal cost): we need a finisher thread here to do
> _txc_state_proc to avoid aio thread not waiting for new aio, so we
> need a thread switch cost again?

Sorry, I'm not following.  :/

> 5. keyvaluedb submit transaction(I think we won't do sync submit
> because we can't block in _txc_state_proc, so another thread
> wake/signal cost)

We want to batch things as much as possible, and the fsync for 
the rocksdb log is somewhat expensive (data write + 2 ios for the xfs 
journal commit).

> 6. complete caller's context(Response to client now!)
> 
> Am I missing or wrong for this flow?
> 
> @sage, could you share your current insight about the next thing? From
> my current intuition, it looks a much higher latency and bandwidth
> optimization for newstore.

I think the main difference is that in the FileStore case we journal 
everything (data included) and as a result can delay the syncs, which (in 
some cases) leads to better batching.  For random IO it doesn't help much 
(all objects must still get synced), but for sequential IO it helps a lot 
because we do lots of ios to the same file and then a single fsync to 
update the inode.

I put in a patch to do WAL for small appends that should give us something 
more like what FileStore was doing, but the async wal apply code isn't 
being smart about coalescing all of the updates to the same file and 
syncing them at once.  I think that change would make the biggest 
difference here.

The other thing we're fighting against is that the rocksdb log is simply 
not as efficient as the raw device ring buffer that FileJournal does.  If 
we implement something similar in rocksdb we'll cut the rocksdb 
commit IOs by up to 2/3 (a small commit = 1 write to end of file, 2 
ios from fdatasync to commit the xfs journal).

sage


> 
> >
> > sage
> >
> >
> >>
> >>                                                                                                       Xiaoxi.
> >> > -----Original Message-----
> >> > From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> >> > owner@vger.kernel.org] On Behalf Of Mark Nelson
> >> > Sent: Wednesday, April 29, 2015 7:25 AM
> >> > To: ceph-devel
> >> > Subject: newstore performance update
> >> >
> >> > Hi Guys,
> >> >
> >> > Sage has been furiously working away at fixing bugs in newstore and
> >> > improving performance.  Specifically we've been focused on write
> >> > performance as newstore was lagging filestore but quite a bit previously.  A
> >> > lot of work has gone into implementing libaio behind the scenes and as a
> >> > result performance on spinning disks with SSD WAL (and SSD backed rocksdb)
> >> > has improved pretty dramatically. It's now often beating filestore:
> >> >
> >>
> >> > http://nhm.ceph.com/newstore/newstore-5d96fe6-no_overlay.pdf
> >> >
> >> > On the other hand, sequential writes are slower than random writes when
> >> > the OSD, DB, and WAL are all on the same device be it a spinning disk or SSD.
> >>
> >> > In this situation newstore does better with random writes and sometimes
> >> > beats filestore (such as in the everything-on-spinning disk tests, and when IO
> >> > sizes are small in the everything-on-ssd tests).
> >> >
> >> > Newstore is changing daily so keep in mind that these results are almost
> >> > assuredly going to change.  An interesting area of investigation will be why
> >> > sequential writes are slower than random writes, and whether or not we are
> >> > being limited by rocksdb ingest speed and how.
> >>
> >> >
> >> > I've also uploaded a quick perf call-graph I grabbed during the "all-SSD" 32KB
> >> > sequential write test to see if rocksdb was starving one of the cores, but
> >> > found something that looks quite a bit different:
> >> >
> >> > http://nhm.ceph.com/newstore/newstore-5d96fe6-no_overlay.pdf
> >> >
> >> > Mark
> >> > --
> >> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the
> >> > body of a message to majordomo@vger.kernel.org More majordomo info at
> >> > http://vger.kernel.org/majordomo-info.html
> >> N?????r??y??????X???v???)?{.n?????z?]z????ay? ????j ??f???h????? ?w??? ???j:+v???w???????? ????zZ+???????j"????i
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 
> -- 
> Best Regards,
> 
> Wheat
> 
> 
