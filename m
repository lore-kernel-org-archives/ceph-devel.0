From: Sage Weil <sage@inktank.com>
Subject: Re: [RFC PATCH 0/2] Distribute re-replicated objects evenly after
 OSD failure
Date: Sat, 12 May 2012 16:51:16 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1205121646040.21796@cobra.newdream.net>
References: <1336689506-15029-1-git-send-email-jaschut@sandia.gov>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47038 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755265Ab2ELXvS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 12 May 2012 19:51:18 -0400
In-Reply-To: <1336689506-15029-1-git-send-email-jaschut@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: sam.just@dreamhost.com, ceph-devel@vger.kernel.org

Hey Jim,

These both look like reasonable changes.  And it's great to see they fix 
behavior for you.

I'm not going to merge them yet, though.  We're just kicking off a CRUSH 
refresh project next week that will include some testing framework to more 
thoroughly validate the quality of the output, and also take a more 
holistic look at all what the algorithm is doing and see what we can 
improve.  Most likely these changes will be included, but revving the 
mapping algorithm is going to be tricky for forward/backward 
compatibility, and we'd like to get it all in at once.  (And/or come up 
with a better way to deal with mismatched versions...)

Thanks!
sage


On Thu, 10 May 2012, Jim Schutt wrote:

> Hi Sage,
> 
> I've been trying to solve the issue mentioned in tracker #2047, which I 
> think is the same as I described in
>   http://www.spinics.net/lists/ceph-devel/msg05824.html
> 
> The attached patches seem to fix it for me.  I also attempted to 
> address the local search issue you mentioned in #2047.
> 
> I'm testing this using a cluster with 3 rows, 2 racks/row, 2 hosts/rack,
> 4 osds/host. I tested against a CRUSH map with the rules:
> 	step take root
> 	step chooseleaf firstn 0 type rack
> 	step emit
> 
> I'm in the processes of testing this as follows:
> 
> I wrote some data to the cluster, then started shutting down OSDs using
> "init-ceph stop osd.n". For the first rack's worth, I shut OSDs down
> sequentially.  I waited for recovery to complete each time before
> stopping the next OSD.  For the next rack I shut down the first 3 OSDs
> on a host at the same time, waited for recovery to complete, then shut
> down the last OSD on that host.  For the next racks, I shut down all
> the OSDs on the hosts in the rack at the same time.
> 
> Right now I'm waiting for recovery to complete after shutting down
> the third rack.  Once recovery completed after each phase so far,
> there were no degraded objects.
> 
> So, this is looking fairly solid to me so far.  What do you think?
> 
> Thanks -- Jim
> 
> Jim Schutt (2):
>   ceph: retry CRUSH map descent before retrying bucket
>   ceph: retry CRUSH map descent from root if leaf is failed
> 
>  src/crush/mapper.c |   30 ++++++++++++++++++++++--------
>  1 files changed, 22 insertions(+), 8 deletions(-)
> 
> -- 
> 1.7.8.2
> 
> 
> 
