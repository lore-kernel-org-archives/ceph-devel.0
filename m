From: Sage Weil <sweil@redhat.com>
Subject: Re: newstore performance update
Date: Mon, 4 May 2015 11:08:26 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1505041106300.24939@cobra.newdream.net>
References: <554016E2.3000104@redhat.com> <6F3FA899187F0043BA1827A69DA2F7CC021E4894@shsmsx102.ccr.corp.intel.com> <alpine.DEB.2.00.1504290929400.5458@cobra.newdream.net>, <55422E0A.6010204@redhat.com> <ijupkkkyuvtsofr81j33sd7l.1430402112852@email.android.com>
 <554237F8.5070907@redhat.com> <alpine.DEB.2.00.1504301107310.5458@cobra.newdream.net> <5543923E.1020607@redhat.com> <alpine.DEB.2.00.1505011731500.5458@cobra.newdream.net> <5547B156.8060508@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37670 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751007AbbEDSIa (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 4 May 2015 14:08:30 -0400
In-Reply-To: <5547B156.8060508@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>
Cc: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, 4 May 2015, Mark Nelson wrote:
> On 05/01/2015 07:33 PM, Sage Weil wrote:
> > Ok, I think I figured out what was going on.  The db->submit_transaction()
> > call (from _txc_finish_io) was blocking when there was a
> > submit_transaction_sync() in progress.  This was making me hit a ceiling
> > of about 80 iops on my slow disk.  When I moved that into _kv_sync_thread
> > (just prior to the submit_transaction_sync() call) it jumps up to 300+
> > iops.
> > 
> > I pushed that to wip-newstore.
> > 
> > Further, if I drop the O_DSYNC, it goes up another 50% or so.  It'll take
> > a bit more coding to effectively batch the (implicit) fdatasync from the
> > O_DSYNC up, though, and capture some of that.  Next!
> > 
> > sage
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 
> Ran through a bunch of tests on 0c728ccc over the weekend:
> 
> http://nhm.ceph.com/newstore/5d96fe6f_vs_0c728ccc.pdf
> 
> The good news is that sequential writes on spinning disks are looking
> significantly better!  We went from 40x slower than filestore for small
> sequential IO to only about 30-40% slower and we become faster than filestore
> at 64kb+ IO sizes.
> 
> 128kb-2MB sequential writes with data on spinning disk and rocksdb on SSD
> regressed.  Newstore is no longer really any faster than filestore for those
> IO sizes.  We saw something similar for random IO, where spinning disk only
> results improved and spinning disk + rocksdb on SSD regressed.
> 
> With everything on SSD, we saw small sequential writes improve and nearly all
> random writes regress.  Not sure how much these regressions are due to
> 0c728ccc vs other commits yet.

That's surprising!  I pushed a commit that makes this tunable,

 newstore sync submit transaction = false (default)

Can you see if setting that to true (effectively reverting my last change) 
fixes the ssd regression?

It may also be that this is a simple locking issue that we can fix in 
rocksdb.  Again, the behavior I saw was that the db->submit_transaction() 
call would block until the sync commit (from kv_sync_thread) finished.  
I would expect rocksdb to be more careful about that, so maybe there is 
something else funny/subtle going on.

sage
