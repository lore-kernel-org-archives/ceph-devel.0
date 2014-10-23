From: Sage Weil <sage@newdream.net>
Subject: RE: 10/14/2014 Weekly Ceph Performance Meeting
Date: Thu, 23 Oct 2014 14:53:57 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1410231452250.29946@cobra.newdream.net>
References: <6F3FA899187F0043BA1827A69DA2F7CC020C8323@shsmsx102.ccr.corp.intel.com> <811a14ba-31af-49d2-bd37-841ebadbca23@mailpro> <6F3FA899187F0043BA1827A69DA2F7CC020C8403@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50264 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750928AbaJWVx6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Oct 2014 17:53:58 -0400
In-Reply-To: <6F3FA899187F0043BA1827A69DA2F7CC020C8403@shsmsx102.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>
Cc: Alexandre DERUMIER <aderumier@odiso.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Mark Nelson <mark.nelson@inktank.com>

On Thu, 16 Oct 2014, Chen, Xiaoxi wrote:
> >Hi, indeed qemu use a single thread per queue.
> >I think it's not a problem with common storage (nfs,scsi,..) because they use less cpu ressource than librbd, so you can reach 
> >easily > 100000iops with 1thread.
> 
> I think it's a common problem shared by all storage backend(nfs,scsi), 
> but Ceph take longer time to sent out an IO(30us), while NFS and scsi is 
> really simple(no crush, no stripping, etc) that may only take 3us to 
> send out an IO, so the upper bound is 10X than ceph.

I would be very interested in seeing where the CPU time is actually spent.  
I know there are is some locking contention in librbd, but with the 
librados changes that layer at least should have have a much lower 
overhead.  We also should be preserving mappings for PGs in most cases to 
avoid much time spent in CRUSH.  It would be very interesting to be 
proven wrong, though!

sage
