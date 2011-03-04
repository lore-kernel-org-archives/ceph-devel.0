From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: monitor dispatch queue seems backed up?
Date: Fri, 4 Mar 2011 15:47:47 -0700
Message-ID: <1299278867.4750.209.camel@sale659.sandia.gov>
References: <1299258853.4750.191.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1103041137050.25280@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:52122 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932603Ab1CDWrx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Mar 2011 17:47:53 -0500
In-Reply-To: <Pine.LNX.4.64.1103041137050.25280@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


On Fri, 2011-03-04 at 12:48 -0700, Sage Weil wrote:
> > Hi,
> > 
> > I'm continuing my testing of the master branch
> > (commit 1ed2d8c587) against 96 osds.
> > 
> > I'm having trouble getting a new filesystem to
> > start up.  FWIW this size filesystem starts up
> > in a minute or two at most under the stable branch.
> 
> The main thing that's changed since then is the default number of PGs has 
> gone up.  Can you try changing the osd_pg_bits to 6 in common/config.cc, 
> rebuild, and re-mkcephfs, and see if that gives you behavior similar to 
> stable?  (mkcephfs isn't currently letting you adjust that yet.)

OK, I tried osd_pg_bits = 6 as you suggested.

The startup behavior is much like stable, except my "ceph -w"
seems to have some trouble connecting - it often needs to 
try multiple times before it is successful.

Unfortunately, the behavior under my 64-client write
test is also much like stable - I'm still getting
osds wrongly marked down.

I didn't dig into it enough yet to see if this is due to 
the same type of mysterious delays as I was finding
on stable.

-- Jim

> 
> I suspect this is just a problem with the size of the various pg map<>s on 
> the monitor (they're O(log n) for most operations).
> 
> Thanks!
> sage
> 
> 


