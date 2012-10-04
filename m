From: Sage Weil <sage@inktank.com>
Subject: Re: Slow ceph fs performance
Date: Thu, 4 Oct 2012 08:24:32 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1210040823250.23556@cobra.newdream.net>
References: <201210041314.q94DEbF9014551@ayesha.phys.virginia.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42871 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422663Ab2JDPYd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 4 Oct 2012 11:24:33 -0400
In-Reply-To: <201210041314.q94DEbF9014551@ayesha.phys.virginia.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: bryan@Virginia.EDU
Cc: ceph-devel@vger.kernel.org

On Thu, 4 Oct 2012, Bryan K. Wright wrote:
> Hi Greg,
> 
> greg@inktank.com said:
> > I think I'm with Mark now ? this does indeed look like too much random IO for
> > the disks to handle. In particular, Ceph requires that each write be synced to
> > disk before it's considered complete, which rsync definitely doesn't. In the
> > filesystem this is generally disguised fairly well by all the caches and such
> > in the way, but this use case is unfriendly to that arrangement.
> 
> > However, I am particularly struck by seeing one of your OSDs at 96% disk
> > utilization while the others remain <50%, and I've just realized we never saw
> > output from ceph -s. Can you provide that, please? 
> 
> 	Here's the ceph -s output:
> 
>    health HEALTH_OK
>    monmap e1: 3 mons at {0=192.168.1.31:6789/0,1=192.168.1.32:6789/0,2=192.168.1
> .33:6789/0}, election epoch 2, quorum 0,1,2 0,1,2
>    osdmap e24: 4 osds: 4 up, 4 in
>     pgmap v8363: 960 pgs: 960 active+clean; 15099 MB data, 38095 MB used, 74354 
> GB / 74391 GB avail
>    mdsmap e25: 1/1/1 up {0=2=up:active}, 2 up:standby
> 
> 	The OSD disk utilization seems to vary a lot during these
> benchmarks.  My recollection is that each of the OSD hosts sometimes
> sees near-100% utilization.

Can you also include 'ceph osd tree', 'ceph osd dump', and 'ceph pg dump' 
output?  So we can make sure CRUSH is distributing things well?

Thanks!
sage


> 
> 						Bryan
> 
> 
> -- 
> ========================================================================
> Bryan Wright              |"If you take cranberries and stew them like 
> Physics Department        | applesauce, they taste much more like prunes
> University of Virginia    | than rhubarb does."  --  Groucho 
> Charlottesville, VA  22901|			
> (434) 924-7218            |         bryan@virginia.edu
> ========================================================================
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
