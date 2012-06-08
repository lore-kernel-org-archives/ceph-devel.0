From: Sage Weil <sage@inktank.com>
Subject: Re: mds dump
Date: Fri, 8 Jun 2012 12:36:11 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1206081229290.13353@cobra.newdream.net>
References: <cacaf6c2-6adf-456e-85b3-b33a4f477cf7@mail.linserv.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47636 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757756Ab2FHTgQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Jun 2012 15:36:16 -0400
In-Reply-To: <cacaf6c2-6adf-456e-85b3-b33a4f477cf7@mail.linserv.se>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Wilderoth <martin.wilderoth@linserv.se>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, 8 Jun 2012, Martin Wilderoth wrote:
> Hello and thanks,
> 
> I have removed the data and metadata pool. Do I need to create them again, or 
> will they be created automaticly.
> Maybe I need the undocumented way of creating the mds map ?. I would like to
> get an empty cephfs to play with again.

Kids, don't try this at home.

1- Recreate the pools with something like

 ceph osd pool create data PGNUM
 ceph osd pool create metadata PGNUM

where PGNUM is something like 50*num_osds, maybe rounded to a power of 
two.

2- get the numeric pool ids for data and metadata (the number after 
"pool")

 ceph osd dump | grep ^pool

3- create a new mdsmap with those pools

 ceph mds newfs METADATAPOOLID DATAPOOLID

WARNING: This will clobber any fs data that is in those two pools.  And 
make any data in the previous mdsmap's pool inaccessible.  In fact, I'm 
going to add a --yes-i-really-mean-it argument to this command now.

That should do it!
sage


> 
>  /Best Regards Martin
> 
> > On Fri, 8 Jun 2012, Tommi Virtanen wrote: 
> > > On Fri, Jun 8, 2012 at 12:35 AM, Martin Wilderoth 
> > > <martin.wilderoth@linserv.se> wrote: 
> > > > And if i just want to mkfs or similar in mds is that possible. Or or my rbd will 
> > > > also be removed ? Or how should I recover if I don't care of the data in 
> > > > the POSIX file system ? 
> > > 
> > > By default, the Ceph Distributed File System puts file metadata in the 
> > > pool "metadata", and file contents in the pool "data". RBD images, by 
> > > default, are stored in the pool "rbd". This means you can empty/remove 
> > > the pools "metadata" and "data" without affecting RBD. 
> > 
> > There is also an undocumented way to recreate a new mdsmap (mds cluster) 
> > without affecting the rest of cluster. Is that what you're after? 
> > 
> > sage 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
