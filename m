From: Sage Weil <sage@inktank.com>
Subject: Re: master <=> next
Date: Thu, 15 Nov 2012 11:32:32 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1211151131150.26514@cobra.newdream.net>
References: <50A53FAF.3020306@profihost.ag>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46253 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1768775Ab2KOTcd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Nov 2012 14:32:33 -0500
In-Reply-To: <50A53FAF.3020306@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, 15 Nov 2012, Stefan Priebe wrote:
> Hello list,
> 
> maybe i do not understand the difference between master and next but is it
> correct that the following commits are in next but NOT in master?
> 
> b40387d msg/Pipe: fix leak of Authorizer
> 0fb23cf Merge remote-tracking branch 'gh/wip-3477' into next
> 12c2b7f msg/DispatchQueue: release throttle on messages when dropping an id
> 5f214b2 PrioritizedQueue: allow remove_by_class to return removed items
> 98b93b5 librbd: use delete[] properly
> 4a7a81b objecter: fix leak of out_handlers
> ef4e4c8 mon: calculate failed_since relative to message receive time
> 9267d8a rgw: update post policy parser
> f6cb078 mon: set default port when binding to random local ip
> dfeb8de Merge remote-tracking branch 'gh/wip-asok' into next
> ce28455 rgw: relax date format check
> 4a34965 client: register admin socket commands without lock held
> 4db9442 objecter: separate locked and unlocked init/shutdown
> 9c31d09 mon: kick failures when we lose leadership
> e43f9d7 mon: process failures when osds go down
> 763d348 mon: ignore failure messages if already pending a failure

Temporarily, yes.  Normally fixes go into next and are then merged back 
into master.  Since we're in the 'frozen but stabilizing' phase that's 
less work than cherry-picking every fix from master->next.

We then regularly merge next back into master so that master gets 
everything, but that hasn't happened in a day or so; I'll do it now.

sage
