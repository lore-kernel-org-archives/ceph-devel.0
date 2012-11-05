From: Sage Weil <sage@inktank.com>
Subject: Re: explicitly specifying pgnum on pool creation
Date: Mon, 5 Nov 2012 11:35:48 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1211051134540.30301@cobra.newdream.net>
References: <alpine.DEB.2.00.1211040338400.30792@cobra.newdream.net> <50980BA3.20709@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54402 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750776Ab2KETft (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Nov 2012 14:35:49 -0500
In-Reply-To: <50980BA3.20709@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Mon, 5 Nov 2012, Josh Durgin wrote:
> On 11/04/2012 03:42 AM, Sage Weil wrote:
> > The wip-explicit-pgnum changes the 'ceph osd pool create <name> <pgnum>'
> > command to require the pg_num value instead of defaulting to 8.  This
> > would make it harder for users to get this wrong.
> 
> I like this. It'd be great if we could add a pgnum argument to
> 'rados mkpool' and the corresponding librados pool_create* functions
> too.

I'm tempted to remove those commands from teh rados tool.  I think we need 
to keep them in the librados api, tho, so maybe that's not helpful.

Anyway, yeah, definitely!

> > On the other hand, it probably also breaks some scripts for deploying
> > OpenStack that create volume and image pools.  :/
> 
> If those scripts are creating pools with 8 pgs, they're going to
> create problems anyway. I don't mind breaking them as long as it's well
> documented (i.e. release notes and docs on 'ceph osd pool create'
> should mention the change).

Ok.  Let's try to do this this week for bobtail!

sage

> 
> > Ideas?
> > 
> > The original idea was that the monitor would automagically notice when a
> > small pgnum pool gets lots of objects and trigger a split.  Even if we
> > don't do that, pretty soon now you'll be able to explicitly increase
> > pg_num.  I still think it might be a good idea to require it up-front,
> > though.
> 
> Until split is implemented and well-tested, I think it makes sense to
> require it up-front. It's easy to relax that requirement later if we
> want to make it more automatic.
> 
> > An alternative would be to default to a larger number (say, num_osds <<
> > 2).  My concern there is that it makes it easy to create lots of pgs for
> > pools that may be small, and it's still not large enough to get good
> > performance for the "create pool, run rados bench" crowd.
> 
> It would also be easy to create too few pgs, and then add a bunch of
> osds later.
> 
> Josh
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
