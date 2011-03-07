From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: monitor dispatch queue seems backed up?
Date: Mon, 7 Mar 2011 08:26:05 -0700
Message-ID: <1299511565.4750.227.camel@sale659.sandia.gov>
References: <1299258853.4750.191.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1103041137050.25280@cobra.newdream.net>
 <1299278867.4750.209.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1103041552040.25280@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:56902 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802Ab1CGP0U (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Mar 2011 10:26:20 -0500
In-Reply-To: <Pine.LNX.4.64.1103041552040.25280@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


On Fri, 2011-03-04 at 16:56 -0700, Sage Weil wrote:
> On Fri, 4 Mar 2011, Jim Schutt wrote:
> > On Fri, 2011-03-04 at 12:48 -0700, Sage Weil wrote:
> > > > Hi,
> > > > 
> > > > I'm continuing my testing of the master branch
> > > > (commit 1ed2d8c587) against 96 osds.
> > > > 
> > > > I'm having trouble getting a new filesystem to
> > > > start up.  FWIW this size filesystem starts up
> > > > in a minute or two at most under the stable branch.
> > > 
> > > The main thing that's changed since then is the default number of PGs has 
> > > gone up.  Can you try changing the osd_pg_bits to 6 in common/config.cc, 
> > > rebuild, and re-mkcephfs, and see if that gives you behavior similar to 
> > > stable?  (mkcephfs isn't currently letting you adjust that yet.)
> > 
> > OK, I tried osd_pg_bits = 6 as you suggested.
> > 
> > The startup behavior is much like stable, except my "ceph -w"
> > seems to have some trouble connecting - it often needs to 
> > try multiple times before it is successful.
> 
> Okay.  We'll have more nodes up next week so hopefully I'll be able to 
> reproduce this behavior.
> 
> > Unfortunately, the behavior under my 64-client write
> > test is also much like stable - I'm still getting
> > osds wrongly marked down.
> > 
> > I didn't dig into it enough yet to see if this is due to 
> > the same type of mysterious delays as I was finding
> > on stable.
> 
> I just pushed something to master that sprinkles debug prints all through 
> the heartbeat thread.  Let's try to figure out where it is blocking.
> 
> My worry is that this is all the VM's fault: we're writing data, hit the 
> dirty page limit, and thereafter any memory allocations or writes block.  
> I've been assuming that only the thread that does the write gets blocked, 
> but it may be that the VM blocks all threads in the process, or that it is 
> a memory allocation (in the heartbeat thread) that is hitting the limit 
> (balance_dirty_pages() IIRC).  We may need to make sure the heartbeat 
> thread uses preallocated/locked memory or something.. :(
> 
> Anyway, getting more detailed logs will tell us which thread(s) are 
> blocking when.  

OK.  FWIW, when I was digging into this on stable, one
thing I noticed is that when processing of a heatbeat
message stalled, the time between when it was dequeued
from the dispatch queue and when processing finished
was full of Reader/Writer thread processing, with the
occasional journal commit.

I'll recreate with your debugging, and see if I get
a similar behavior.  In any event, I'll have the logs
available.


-- Jim

> 
> Thanks!
> sage
> 


