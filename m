From: Sage Weil <sweil@redhat.com>
Subject: Re: Reducing backfilling/recovery long tail
Date: Fri, 12 Dec 2014 08:12:42 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1412120812070.23559@cobra.newdream.net>
References: <548B06D2.90609@dachary.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42566 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030483AbaLLQNs (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 12 Dec 2014 11:13:48 -0500
In-Reply-To: <548B06D2.90609@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Samuel Just <sam.just@inktank.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Fri, 12 Dec 2014, Loic Dachary wrote:
> Hi Sam & Sage,
> 
> In the context of http://tracker.ceph.com/issues/9566 I'm inclined to 
> think the best solution would be that the AsyncReserver choose a PG 
> instead of just picking the next one in the list when there is a free 
> slot. It would always choose a PG that must move to/from an OSDs for 
> which there are more PGs waiting in the AsyncRerserver than any other 
> OSD. The sort involved does not seem too expensive.
> 
> Calculating priorities before adding the PG to the AsyncReserver seems 
> wrong because the state of the system will change significantly while 
> the PG is waiting to be processed. For instance the first PGs to be 
> added have a low priority while the next have increasing priorities when 
> they accumulate. If reservations are canceled because the OSD map 
> changed again (maybe another OSD is decommissioned before recovery of 
> the first one completes), you may end up having high priorities for PGs 
> that are no longer associated with busy OSDs. That could backfire and 
> create even more frequent long tails.
> 
> What do you think ?

That makes sense.  In order to make that decision, it means that the OSDs 
need to be sharing the level of recovery work they have pending on a 
regular basis, right?

sage

