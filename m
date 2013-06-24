From: Sage Weil <sage@inktank.com>
Subject: Re: ceph-mon vs leveldb status
Date: Mon, 24 Jun 2013 09:56:40 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1306240955180.29802@cobra.newdream.net>
References: <alpine.DEB.2.00.1306191304230.7089@cobra.newdream.net> <pan.2013.06.24.10.51.37.437785@googlemail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59286 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752433Ab3FXQ4k (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Jun 2013 12:56:40 -0400
In-Reply-To: <pan.2013.06.24.10.51.37.437785@googlemail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Holger Hoffstaette <holger.hoffstaette@googlemail.com>
Cc: ceph-devel@vger.kernel.org

On Mon, 24 Jun 2013, Holger Hoffstaette wrote:
> On Wed, 19 Jun 2013 13:09:42 -0700, Sage Weil wrote:
> 
> [snip]
> 
> > Meanwhile, the next development release will be changing the way all the
> > pg metadata in the monitor is stored to be much more efficient and to take
> > advantage of leveldb's capabilities; this will be present in 0.66
> > (dumpling - 1).
> 
> Have you considered using one of the recently annoucned LevelDB forks? The
> HyperDex folks recently published their HyperLevelDB fork (still
> compatible though) and it has significantly improved behaviour, less
> performance variance etc.
> See http://hyperdex.org/performance/leveldb/ or github.

The two issues are packaging and QA.  Ideally we (or someone) would build 
packages that provide libleveldb so that users can drop in whichever 
leveldb variant they want on their machines.  The other issue here, 
though, is that these are new variants that haven't seen as much usage, so 
we have no idea how stable they are with Ceph workloads.

sage
