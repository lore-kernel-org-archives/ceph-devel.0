From: Sage Weil <sweil@redhat.com>
Subject: Re: newstore performance update
Date: Fri, 1 May 2015 17:33:58 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1505011731500.5458@cobra.newdream.net>
References: <554016E2.3000104@redhat.com> <6F3FA899187F0043BA1827A69DA2F7CC021E4894@shsmsx102.ccr.corp.intel.com> <alpine.DEB.2.00.1504290929400.5458@cobra.newdream.net>, <55422E0A.6010204@redhat.com> <ijupkkkyuvtsofr81j33sd7l.1430402112852@email.android.com>
 <554237F8.5070907@redhat.com> <alpine.DEB.2.00.1504301107310.5458@cobra.newdream.net> <5543923E.1020607@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45376 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750778AbbEBAeD (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 1 May 2015 20:34:03 -0400
In-Reply-To: <5543923E.1020607@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>
Cc: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Ok, I think I figured out what was going on.  The db->submit_transaction() 
call (from _txc_finish_io) was blocking when there was a 
submit_transaction_sync() in progress.  This was making me hit a ceiling 
of about 80 iops on my slow disk.  When I moved that into _kv_sync_thread 
(just prior to the submit_transaction_sync() call) it jumps up to 300+ 
iops.

I pushed that to wip-newstore.

Further, if I drop the O_DSYNC, it goes up another 50% or so.  It'll take 
a bit more coding to effectively batch the (implicit) fdatasync from the 
O_DSYNC up, though, and capture some of that.  Next!

sage
