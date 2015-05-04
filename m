From: Mark Nelson <mnelson@redhat.com>
Subject: Re: newstore performance update
Date: Mon, 04 May 2015 12:50:14 -0500
Message-ID: <5547B156.8060508@redhat.com>
References: <554016E2.3000104@redhat.com> <6F3FA899187F0043BA1827A69DA2F7CC021E4894@shsmsx102.ccr.corp.intel.com> <alpine.DEB.2.00.1504290929400.5458@cobra.newdream.net>, <55422E0A.6010204@redhat.com> <ijupkkkyuvtsofr81j33sd7l.1430402112852@email.android.com> <554237F8.5070907@redhat.com> <alpine.DEB.2.00.1504301107310.5458@cobra.newdream.net> <5543923E.1020607@redhat.com> <alpine.DEB.2.00.1505011731500.5458@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47087 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751444AbbEDRuR (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 4 May 2015 13:50:17 -0400
In-Reply-To: <alpine.DEB.2.00.1505011731500.5458@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 05/01/2015 07:33 PM, Sage Weil wrote:
> Ok, I think I figured out what was going on.  The db->submit_transaction()
> call (from _txc_finish_io) was blocking when there was a
> submit_transaction_sync() in progress.  This was making me hit a ceiling
> of about 80 iops on my slow disk.  When I moved that into _kv_sync_thread
> (just prior to the submit_transaction_sync() call) it jumps up to 300+
> iops.
>
> I pushed that to wip-newstore.
>
> Further, if I drop the O_DSYNC, it goes up another 50% or so.  It'll take
> a bit more coding to effectively batch the (implicit) fdatasync from the
> O_DSYNC up, though, and capture some of that.  Next!
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

Ran through a bunch of tests on 0c728ccc over the weekend:

http://nhm.ceph.com/newstore/5d96fe6f_vs_0c728ccc.pdf

The good news is that sequential writes on spinning disks are looking 
significantly better!  We went from 40x slower than filestore for small 
sequential IO to only about 30-40% slower and we become faster than 
filestore at 64kb+ IO sizes.

128kb-2MB sequential writes with data on spinning disk and rocksdb on 
SSD regressed.  Newstore is no longer really any faster than filestore 
for those IO sizes.  We saw something similar for random IO, where 
spinning disk only results improved and spinning disk + rocksdb on SSD 
regressed.

With everything on SSD, we saw small sequential writes improve and 
nearly all random writes regress.  Not sure how much these regressions 
are due to 0c728ccc vs other commits yet.

Mark
