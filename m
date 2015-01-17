From: Sage Weil <sage@newdream.net>
Subject: Re: 'Immutable bit' on pools to prevent deletion
Date: Sat, 17 Jan 2015 08:24:52 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1501170822460.26676@cobra.newdream.net>
References: <54B7D2D6.4020503@42on.com> <m9chio$3lp$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33644 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751435AbbAQQYw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 17 Jan 2015 11:24:52 -0500
In-Reply-To: <m9chio$3lp$1@ger.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elsayed <eternaleye@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Fri, 16 Jan 2015, Alex Elsayed wrote:
> Wido den Hollander wrote:
> 
> <snip>
> > Is it a sane thing to look at 'features' which pools could have? Other
> > features which might be set on a pool:
> > 
> > - Read Only (all write operations return -EPERM)
> > - Delete Protected
> 
> There's another pool feature I'd find very useful: a WORM flag, that permits 
> only create & append (at the RADOS level, not the RBD level as was an 
> Emperor blueprint).
> 
> In particular, I'd _love_ being able to make something that takes Postgres 
> WAL logs and puts them in such a pool, providing real guarantees re: 
> consistency. Similarly, audit logs and such for compliance.

How would you want this to work?

- If the bit is set, object creates are allowed, but not deletes?  What 
about append?

- Are you allowed to clear the bit with something like 'ceph osd pool set 
<pool> worm false' ?

sage
