From: Sage Weil <sage@newdream.net>
Subject: Re: Is ceph cluster time sensitive
Date: Fri, 9 Mar 2012 08:52:32 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1203090849230.11669@cobra.newdream.net>
References: <loom.20120309T160103-320@post.gmane.org>
 <Pine.LNX.4.64.1203090821470.11669@cobra.newdream.net>
 <loom.20120309T174045-17@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34550 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754555Ab2CIQwe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Mar 2012 11:52:34 -0500
In-Reply-To: <loom.20120309T174045-17@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Madhusudhan <madhusudhana.u.acharya@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Fri, 9 Mar 2012, Madhusudhan wrote:
> Sage Weil <sage <at> newdream.net> writes:
> 
> > 
> > On Fri, 9 Mar 2012, Madhusudhan wrote:
> > > Hi all,
> > > Just wanted to know if ceph cluster is time sensitive. will there
> > > be any issue if the date and time differs between client machine
> > > and ceph cluster? do their time has to be in sync to work 
> > > properly? if time differs, will there be any performance issue ?
> > 
> > It is time sensitive.  You currently need to have (reasonably well) 
> > synchronized clocks.  At the very minimum, the ceph-mon daemons need to 
> > run on machines with good time.  There are also some oddities that can 
> > occur if the fs client doesn't match the metadata server... At some point 
> > we'll take a closer look at what we can do to make that less of a problem, 
> > but for now things will be a bit wonky.
> 
> 
> Thank you Sage.
> Currenlty all nodes in ceph cluster are having a set of time set on them and 
> client is having a different time. Below is example
> 
> Date in one of ceph node :
> [root@ceph-node-5 ~]# date
> Fri Mar  9 08:41:39 PST 2012
> 
> Date in the client machine :
> [root@my_client_10 ~]# date
> Fri Mar  9 22:12:02 IST 2012
> 
> Will this difference cause performance issue ?

I can't think how right now, but I may be missing something.  It's hard to 
tell why things are slow without knowing more about the cluster, load, 
workoad, etc.

A good sanity check is to run rados bench from a client node to see the 
raw write throughput you can get.  Something like 'rados -p rbd bench 60 
write'.

> > 
> > > Any plans to include exports/quotas in ceph file system ?
> > > it will be a beauty if we have above to options, so that the space
> > > in ceph cluster can be effectively allocated to client system.
> > 
> > I'm not sure what you mean by exports, but quotas will be added 
> > eventually.  Again, it's a ways out.
> > 
> > sage
> > 
> 
> when i said exports, i mean to say about unix exports, where i can 
> export individual directories/sub-directories to different hosts in
> different subnets. 
> 
> As a NAS admin, i make use exports a lot. Some time we have to export
> a directory to certain subnet and some time to a different subnet.

Oh.  Yeah, that's also on the roadmap, although again all the fs stuff is 
a ways out.

sage


> 
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo <at> vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> > 
> 
> 
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
