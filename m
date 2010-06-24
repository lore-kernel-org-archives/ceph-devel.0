From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: crushmap rule issue: choose vs. chooseleaf
Date: Thu, 24 Jun 2010 15:17:58 -0600
Message-ID: <1277414278.29400.56.camel@sale659.sandia.gov>
References: <1277320801.29400.26.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1006231327140.21486@cobra.newdream.net>
 <1277330264.29400.34.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1006241059570.30180@cobra.newdream.net>
 <1277408660.29400.54.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1006241306330.30180@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:43587 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752338Ab0FXVSJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Jun 2010 17:18:09 -0400
In-Reply-To: <Pine.LNX.4.64.1006241306330.30180@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


On Thu, 2010-06-24 at 14:18 -0600, Sage Weil wrote:
> On Thu, 24 Jun 2010, Jim Schutt wrote:
> > On Thu, 2010-06-24 at 12:20 -0600, Sage Weil wrote:
> > > Hi Jim,
> > > 
> > > Okay, I fixed another bug and am now able to use your map without 
> > > problems.  The fix is pushed to the unstable branch in ceph.git.
> > 
> > Great, thanks!  I really appreciate you being able to take a look so 
> > quickly.
> 
> No problem!
> 
> > > I'm surprised we didn't run into this before.. it looks like it's been 
> > > broken for a while.  I'm adding a tracker item to set up some unit tests 
> > > for this stuff so we can avoid this sort of regression.. the crush code 
> > > should be really easy to check.
> > 
> > That sounds great.
> > 
> > I'm still having a little trouble, though.
> > 
> > My map works for me now, in the sense that I can mount
> > the file system from a client.
> > 
> > But when I try to write to it, vmstat on the server shows
> > I get a little burst of I/O on the servers, and then nothing.
> 
> Oh, the same fix needs to be applied to the kernel code as well.  I've 
> just pushed that out (ceph-client.git master and 
> ceph-client-standalone.git master+master-backport branches).  Hopefully 
> that will clear it up?

Yes, indeed.

Thanks again!

-- Jim

> 
> sage
> 


