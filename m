From: Sage Weil <sweil@redhat.com>
Subject: RE: newstore performance update
Date: Wed, 29 Apr 2015 09:38:30 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1504290929400.5458@cobra.newdream.net>
References: <554016E2.3000104@redhat.com> <6F3FA899187F0043BA1827A69DA2F7CC021E4894@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41866 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966209AbbD2Qid (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 29 Apr 2015 12:38:33 -0400
In-Reply-To: <6F3FA899187F0043BA1827A69DA2F7CC021E4894@shsmsx102.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>
Cc: Mark Nelson <mnelson@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 29 Apr 2015, Chen, Xiaoxi wrote:
> Hi Mark,
> 	Really good test:) I only played a bit on SSD, the parallel WAL 
> threads really helps but we still have a long way to go especially on 
> all-ssd case. I tried this 
> https://github.com/facebook/rocksdb/blob/master/util/env_posix.cc#L1515 
> by hacking the rocksdb, but the performance difference is negligible.

It gave me a 25% bump when rocksdb is on a spinning disk, so I went ahead 
and committed the change to the branch.  Probably not noticeable on the 
SSD, though it can't hurt.

> The rocksdb digest speed should be the problem, I believe, I was planned 
> to prove this by skip all db transaction, but failed since hitting other 
> deadlock bug in newstore.

Will look at that next!

> 
> Below are a bit more comments.
> > Sage has been furiously working away at fixing bugs in newstore and
> > improving performance.  Specifically we've been focused on write
> > performance as newstore was lagging filestore but quite a bit previously.  A
> > lot of work has gone into implementing libaio behind the scenes and as a
> > result performance on spinning disks with SSD WAL (and SSD backed rocksdb)
> > has improved pretty dramatically. It's now often beating filestore:
> > 
> 
> SSD DB is still better than SSD WAL with request size > 128KB, this indicate some WALs are actually written to Level0...Hmm, could we add newstore_wal_max_ops/bytes to capping the total WAL size(how much data is in WAL but not yet apply to backend FS) ?  I suspect this would improve performance by prevent some IO with high WA cost and latency?
> 
> > http://nhm.ceph.com/newstore/newstore-5d96fe6-no_overlay.pdf
> > 
> > On the other hand, sequential writes are slower than random writes when
> > the OSD, DB, and WAL are all on the same device be it a spinning disk or SSD.
> 
> I think sequential writes slower than random is by design in Newstore, 
> because for every object we can only have one WAL , that means no 
> concurrent IO if the req_size* QD < 4MB. Not sure how many #QD do you 
> have in the test? I suspect 64 since there is a boost in seq write 
> performance with req size > 64 ( 64KB*64=4MB).
> 
> In this case, IO pattern will be : 1 write to DB WAL->Sync-> 1 Write to 
> FS -> Sync, we do everything in synchronize way ,which is essentially 
> expensive.

The number of syncs is the same for appends vs wal... in both cases we 
fdatasync the file and the db commit, but with WAL the fs sync comes after 
the commit point instead of before (and we don't double-write the data).  
Appends should still be pipelined (many in flight for the same object)... 
and the db syncs will be batched in both cases (submit_transaction for 
each io, and a single thread doing the submit_transaction_sync in a loop).

If that's not the case then it's an accident?

sage


> 
> 													Xiaoxi.
> > -----Original Message-----
> > From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> > owner@vger.kernel.org] On Behalf Of Mark Nelson
> > Sent: Wednesday, April 29, 2015 7:25 AM
> > To: ceph-devel
> > Subject: newstore performance update
> > 
> > Hi Guys,
> > 
> > Sage has been furiously working away at fixing bugs in newstore and
> > improving performance.  Specifically we've been focused on write
> > performance as newstore was lagging filestore but quite a bit previously.  A
> > lot of work has gone into implementing libaio behind the scenes and as a
> > result performance on spinning disks with SSD WAL (and SSD backed rocksdb)
> > has improved pretty dramatically. It's now often beating filestore:
> > 
> 
> > http://nhm.ceph.com/newstore/newstore-5d96fe6-no_overlay.pdf
> > 
> > On the other hand, sequential writes are slower than random writes when
> > the OSD, DB, and WAL are all on the same device be it a spinning disk or SSD.
> 
> > In this situation newstore does better with random writes and sometimes
> > beats filestore (such as in the everything-on-spinning disk tests, and when IO
> > sizes are small in the everything-on-ssd tests).
> > 
> > Newstore is changing daily so keep in mind that these results are almost
> > assuredly going to change.  An interesting area of investigation will be why
> > sequential writes are slower than random writes, and whether or not we are
> > being limited by rocksdb ingest speed and how.
> 
> > 
> > I've also uploaded a quick perf call-graph I grabbed during the "all-SSD" 32KB
> > sequential write test to see if rocksdb was starving one of the cores, but
> > found something that looks quite a bit different:
> > 
> > http://nhm.ceph.com/newstore/newstore-5d96fe6-no_overlay.pdf
> > 
> > Mark
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the
> > body of a message to majordomo@vger.kernel.org More majordomo info at
> > http://vger.kernel.org/majordomo-info.html
> N?????r??y??????X???v???)?{.n?????z?]z????ay?????j??f???h??????w??????j:+v???w????????????zZ+???????j"????i
