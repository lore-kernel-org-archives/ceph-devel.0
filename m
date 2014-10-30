From: Sage Weil <sage@newdream.net>
Subject: Re: About the blueprint monitor: reweight near full osd
 autonomicly
Date: Thu, 30 Oct 2014 09:22:39 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1410300912270.13322@cobra.newdream.net>
References: <54524648.9010504@ubuntukylin.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45950 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758415AbaJ3QWj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Oct 2014 12:22:39 -0400
In-Reply-To: <54524648.9010504@ubuntukylin.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Li Wang <liwang@ubuntukylin.com>
Cc: Yunchuan Wen <yunchuanwen@ubuntukylin.com>, minchen <minchen@ubuntukylin.com>, ceph-devel@vger.kernel.org

Hi Li!

[adding ceph-devel]

On Thu, 30 Oct 2014, Li Wang wrote:
> Hi Sage,
>   It seems this blueprint is not scheduled for the CDS. So far, it seems 
> the write operation will hang if one of the OSDs being written into is 
> near full, and current solution is to manually adjust the weight of the 
> OSD to force some of the data migrated. This complicates the 
> maintaining, and the administrator needs to track the disk usage of each 
> OSD. So we think we need a mechanism to automatize the process, what is 
> your opinion?

Yes.  The trick here is deciding when it is safe for the mon to reweight 
things on its own.  There are some users that won't want this sort of 
automatic rebalance to happen.

I think there are a couple of steps we should make in this direction:

1) Make the reweight-by-pg or -utiliization have an option to either 
adjust the CRUSH weight or the osd reweight.  I can't convince myself that 
one is always better than the other.

2) Make a new mon config option that sets the amount an osd has to be 
above the mean to trigger the reweight-by-utilization.  This is probably a 
bit tricky, though, since it's possible that we'll fail to bring it below 
that threshold and we want to avoid getting stuck in a loop or some sort 
or throwing the weights all out of whack.  Maybe we only do this at most 
once per day?  Or we confirm that it appreciably changes the PG mappings 
before going forward with the change?  The latter might be a good thing 
anyway, since we have this general problem already with the command where 
you can't see what the effect is going to be before you do it...

Thoughts?
sage

