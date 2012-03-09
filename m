From: Sage Weil <sage@newdream.net>
Subject: Re: Is ceph cluster time sensitive
Date: Fri, 9 Mar 2012 08:24:18 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1203090821470.11669@cobra.newdream.net>
References: <loom.20120309T160103-320@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46874 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754555Ab2CIQYT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Mar 2012 11:24:19 -0500
In-Reply-To: <loom.20120309T160103-320@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Madhusudhan <madhusudhana.u.acharya@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Fri, 9 Mar 2012, Madhusudhan wrote:
> Hi all,
> Just wanted to know if ceph cluster is time sensitive. will there
> be any issue if the date and time differs between client machine
> and ceph cluster? do their time has to be in sync to work 
> properly? if time differs, will there be any performance issue ?

It is time sensitive.  You currently need to have (reasonably well) 
synchronized clocks.  At the very minimum, the ceph-mon daemons need to 
run on machines with good time.  There are also some oddities that can 
occur if the fs client doesn't match the metadata server... At some point 
we'll take a closer look at what we can do to make that less of a problem, 
but for now things will be a bit wonky.

> Any plans to include exports/quotas in ceph file system ?
> it will be a beauty if we have above to options, so that the space
> in ceph cluster can be effectively allocated to client system.

I'm not sure what you mean by exports, but quotas will be added 
eventually.  Again, it's a ways out.

sage

