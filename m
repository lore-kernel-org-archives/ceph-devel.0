From: Sage Weil <sage@inktank.com>
Subject: Re: PG recovery reservation state chart
Date: Tue, 2 Oct 2012 14:36:11 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1210021434450.27524@cobra.newdream.net>
References: <20121002194858.GC8206@splice>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56396 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756172Ab2JBVgM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Oct 2012 17:36:12 -0400
In-Reply-To: <20121002194858.GC8206@splice>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mike Ryan <mike.ryan@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Tue, 2 Oct 2012, Mike Ryan wrote:
> Tried sending this earlier but it seems the list doesn't like PNGs.
> dotty or dot -Tpng will make short work of the .dot file I've attached.
> 
> 
> These are the changes to the Active state of the PG state chart in order
> to support recovery reservations. This is Important Stuff, so please
> criticize mercilessly.
> 
> Here's a prose version:
> 
> When the PG activates, it determines whether it needs to do recovery. If
> it does, it grabs its local reservation, then grabs a remote reservation
> from each replica in order of OSD ID (to prevent deadlock). Once all
> remotes are reserved, it starts recovering.
> 
> After recovery, all remote reservations are dropped. If no backfill is
> necessary, the local reservation is dropped and we jump to Clean.
> 
> If we need to backfill, we request a remote backfill reservation from
> the replica. If this reservation is rejected (due to the OSD being too
> full) we drop our local reservation and wait for a while in
> NotBackfilling. We then grab our local reservation and try again on the
> remote reservation. Once we have the remote reservation, we backfill.
> After Backfilling we drop the local and remote backfill reservation and
> jump to Clean.

This all looks right to me.  I only have one concern: if, at some future 
point, we decide it's necessary or worthwhile to avoid non-backfill 
recovery due to targets begin full, does this approach preclude an elegant 
solution?

sage
