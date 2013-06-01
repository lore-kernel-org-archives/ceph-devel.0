From: Sage Weil <sage@inktank.com>
Subject: Re: leveldb compaction overhead
Date: Fri, 31 May 2013 17:00:57 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1305311659200.16097@cobra.newdream.net>
References: <alpine.DEB.2.00.1305291406080.16097@cobra.newdream.net> <51A916AE.9010700@sandia.gov>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35295 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755037Ab3FAAA6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 31 May 2013 20:00:58 -0400
In-Reply-To: <51A916AE.9010700@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: ceph-devel@vger.kernel.org

On Fri, 31 May 2013, Jim Schutt wrote:
> Hi Sage,
> 
> On 05/29/2013 03:07 PM, Sage Weil wrote:
> > Hi all-
> > 
> > I have a couple of branches (wip-5176 and wip-5176-cuttlefish) that try to 
> > make the leveldb compaction on the monitor less expensive by doing it in 
> > an async thread and compaction only the trimmed range.  If anyone who is 
> > experience high monitor io on cuttlefish would like to test it out, 
> > feedback on whether/how much it improves things would be much appreciated!
> 
> I've been flogging wip-5176-cuttlefish merged into recent cuttlefish
> branch (commit 02ef6e918e), and the result has been very stable for
> me.  I've been testing OSD reweights, and so have been getting lots
> of pgmap updates, and lots of data movement.
> 
> I'm no longer seeing stalls, and I see much less data movement
> on the monitor hosts.  I haven't seen any monitors drop out
> and rejoin, which had been a regular occurrence for me.
> I stopped a mon and reinitialized it, and it resync'ed in 
> just a few minutes, which is also a big improvement.
> 
> This is all with 128K PGs - next week I'll try much higher
> PG counts.
> 
> Thanks a bunch for these fixes - they are working great
> for me!

This is great news!

I pushed a few more patches to wip-5176-cuttlefish that should make it 
even better (smarter about ranges to compact, and perfcounters so we can 
tell what leveldb compactions are taking place).  Do you mind trying it 
out as well?

In the meantime, I'm going to pull it into the cuttlefish branch and test 
over the weekend.  If that looks good we'll cut a point release with all 
of these fixes.

Thank you to everyone who has helped with the debugging and testing on 
these issues!

sage


> 
> Thanks -- Jim
> 
> > 
> > Thanks-
> > sage
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> > 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
