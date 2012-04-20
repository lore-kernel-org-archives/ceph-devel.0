From: Sage Weil <sage@newdream.net>
Subject: Re: OSD weighting
Date: Fri, 20 Apr 2012 10:34:16 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1204201032440.27669@cobra.newdream.net>
References: <4F910F03.6070604@bashkirtsev.com> <Pine.LNX.4.64.1204201012360.27669@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57619 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757276Ab2DTReS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Apr 2012 13:34:18 -0400
In-Reply-To: <Pine.LNX.4.64.1204201012360.27669@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Vladimir Bashkirtsev <vladimir@bashkirtsev.com>
Cc: ceph-devel@vger.kernel.org

On Fri, 20 Apr 2012, Sage Weil wrote:
> On Fri, 20 Apr 2012, Vladimir Bashkirtsev wrote:
> > Dear devs,
> > 
> > Playing around with ceph and gradually moving it from a toy thing into
> > production I wanted ceph to actually make its run for the money (so to speak).
> > I have assembled number of OSDs which are really built on different hardware:
> > starting from old P4 with 512MB of RAM and ending up with high end Dell
> > server, including mixture of 100 and 1000 mbit networks. I will not really
> > speak about performance of MONs and MDSes as they do fairly well does not
> > matter what I throw to them. But with OSDs it is different story. Even one
> > full OSD will stall whole ceph - I've read that it is normal and good way of
> > fighting it is to have periodic health check to see that no OSD is approaching
> > full status. However I believe it would be better if ceph will reduce
> > weighting for OSDs approaching full status so it will effectively prevent OSD
> > getting full. Should be reasonably simple to implement and will not cause
> > major grief if some OSD will go past near full status to full status quickly
> > and unnoticed. I guess reweight-by-utilization is an attempt to address the
> > issue based on CPU performance.
> 
> The intention is to reweight based on disk utilization.  Actually, it 
> assumes that the CRUSH weights are "correct", but it will make minor 
> corrections in the osdmap (post-crush) to prevent statistical outliers 
> from filling up.  CPU performance isn't considered at all...
> 
> > In the mean time I have reverted back to manual weighting of OSDs and I found
> > that there no clear explanation on how weights actually applied. I've seen
> > suggestion to keep weight equivalent to number of TBs on OSD. Doing so in
> > single rack has achieved expected result: data has spread itself
> > proportionally to OSDs sizes. But when I started to move OSDs from toy rack
> > into production rack I also have changed weights for racks in pool. So I had 6

Greg just pointed this out to me: are you explicitly setting the rack 
weights, so that they are no longer the sum of the items inside the rack?  
That might explain what you are seeing as well.  Strictly speaking that's 
okay.. every decision when descending the tree looks at the relative 
weights of children for each node/bucket.. but then the end result won't 
necessarily be proportional to the leaf weights.

> > OSDs and I moved 2 of them. I have changed toyrack weight to 4.000 and
> > productionrack to 2.000. Waited for data to settle just to find out that disk
> > use is no longer proportional. Then I have changed rack weights to total
> > amount of TBs in the rack, data reshuffled and settled but again did not
> > achieved expected result. So I guess function of weights: racks, hosts and
> > devices is not straight forward as I thought originally. This begs clear
> > explanation of how weights are used in case of straw algo.
> 
> Can you share the output of 'ceph osd tree' and the last bit of 'ceph pg 
> dump' (which shows actual utilizations) in that case?  There are some 
> problems with CRUSH when buckets are small that we will be addressing 
> soon.  I'd like to confirm that is what is going on.
> 
> Thanks!
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
