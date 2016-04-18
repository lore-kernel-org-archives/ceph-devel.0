From: Sage Weil <sage@newdream.net>
Subject: Re: Flexible placement
Date: Mon, 18 Apr 2016 14:57:39 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1604181454160.4797@cpach.fuggernut.com>
References: <alpine.DEB.2.11.1604172057000.4797@cpach.fuggernut.com> <20160418170836.GB20078@ultraspiritum.redhat.com> <alpine.DEB.2.11.1604181355330.4797@cpach.fuggernut.com> <20160418184755.GB22875@ultraspiritum.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57271 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751047AbcDRS5i (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Apr 2016 14:57:38 -0400
In-Reply-To: <20160418184755.GB22875@ultraspiritum.redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Adam C. Emerson" <aemerson@redhat.com>
Cc: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On Mon, 18 Apr 2016, Adam C. Emerson wrote:
> > I think that in those cases, we let them use a wacky object -> PG
> > mapping, and then have a linear/flat PG -> device mapping so they
> > can still get some uniformity.
> >
> > This isn't completely general, but I'd want to see an example of
> > something it can't express.  Maybe those entanglement erasure codes
> > that Veronica was talking about at FAST?
> >
> > Or maybe the key step is to not assume the PG is a hash range, but
> > instead consider it an arbitrary bucket in the pool.
> 
> Would the idea basically be in that case that we go from OID =>
> WHATEVER => DEVICE LIST without putting too many constraints on what
> 'WHATEVER' is?

Yeah, probably with the additional/implicit restriction that the OSD -> 
WHATEVER mapping is fixed.  That way when a policy or topology change 
happens, we do O(num WHATEVERs) remapping work.  It's the O(num objects) 
part that is really problematic.

(I would say fundamental, but you *could* imagine something where you know 
the old and new mapping, and try both, or incrementall walk through them.. 
but, man, it would be ugly.  At that point you're probably better of just 
migrating objects from pool A to pool B.)

sage
