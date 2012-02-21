From: Sage Weil <sage@newdream.net>
Subject: Re: v0.42 released
Date: Mon, 20 Feb 2012 21:33:17 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1202202121250.26279@cobra.newdream.net>
References: <Pine.LNX.4.64.1202201001200.30602@cobra.newdream.net>
 <CAA7Uhck1u8CJjtwjqUvRYyMFS8EKeQi-0f1FMSwGXYpvzus21g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51390 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750765Ab2BUFdS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Feb 2012 00:33:18 -0500
In-Reply-To: <CAA7Uhck1u8CJjtwjqUvRYyMFS8EKeQi-0f1FMSwGXYpvzus21g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Diego Woitasen <diego@woitasen.com.ar>
Cc: ceph-devel@vger.kernel.org

On Mon, 20 Feb 2012, Diego Woitasen wrote:
> Production ready, right?

We are very close, at least with RADOS and RBD.

This is what we are focused on:

 - improving qa coverage.  it's grown by leaps and bounds over the last 
   several months, and is getting better.
 - osd stability.  we are cleaning up a few bits of problematic code, and 
   ensuring that the core functionality is well tested.  that includes 
   api coverage, load/stress testing, and failure testing.  most of the 
   recent work is in the 'thrashing' tests, which continously mark osds 
   in/out and/or restart daemons.  these tests are all passing.
 - administrator tools.  we've identified the top 10 most likely failure 
   scenarios that people are likely to see, and are going down the list to 
   ensure that they are detected, reported, diagnosable, and ideally 
   fixable.
 - key/value objects.  this is on of the few recent bits of new 
   functionality, but it's needed to make radosgw perform well for large 
   bucket sizes.

And very soon (next sprint?) we will be returning some attention to RBD
caching and layering.

sage
