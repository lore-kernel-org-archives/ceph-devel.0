From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH] reinstate ceph cluster_snap support
Date: Mon, 27 Oct 2014 14:00:57 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1410271357160.15740@cobra.newdream.net>
References: <orob8qt7kf.fsf@livre.home> <alpine.DEB.2.00.1308231715500.28981@cobra.newdream.net> <ortxifi1cs.fsf@livre.home> <alpine.DEB.2.00.1308271515500.24783@cobra.newdream.net> <orbnp6uofj.fsf@free.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48901 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752158AbaJ0VA6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Oct 2014 17:00:58 -0400
In-Reply-To: <orbnp6uofj.fsf@free.home>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre Oliva <oliva@gnu.org>
Cc: sam.just@inktank.com, ceph-devel@vger.kernel.org

On Tue, 21 Oct 2014, Alexandre Oliva wrote:
> On Aug 27, 2013, Sage Weil <sage@inktank.com> wrote:
> 
> > Finally, eventually we should make this do a checkpoint on the mons too.  
> > We can add the osd snapping back in first, but before this can/should 
> > really be used the mons need to be snapshotted as well.  Probably that's 
> > just adding in a snapshot() method to MonitorStore.h and doing either a 
> > leveldb snap or making a full copy of store.db... I forget what leveldb is 
> > capable of here.
> 
> I suppose it might be a bit too late for Giant, but I finally got 'round
> to implementing this.  I attach the patch that implements it, to be
> applied on top of the updated version of the patch I posted before, also
> attached.
> 
> I have a backport to Firefly too, if there's interest.
> 
> I have tested both methods: btrfs snapshotting of store.db (I've
> manually turned store.db into a btrfs subvolume), and creating a new db
> with all (prefix,key,value) triples.  I'm undecided about inserting
> multiple transaction commits for the latter case; the mon mem use grew
> up a lot as it was, and in a few tests the snapshotting ran twice, but
> in the end a dump of all the data in the database created by btrfs
> snapshotting was identical to that created by explicit copying.  So, the
> former is preferred, since it's so incredibly more efficient.  I also
> considered hardlinking all files in store.db into a separate tree, but I
> didn't like the idea of coding that in C+-, :-) and I figured it might
> not work with other db backends, and maybe even not be guaranteed to
> work with leveldb.  It's probably not worth much more effort.

This looks pretty reasonable!

I think we definitely need to limit the size of the transaction when doing 
the snap.  The attached patch seems to try to do it all in one go, which 
is not going to work for large clusters.  Either re-use an existing 
tunable like the sync chunk size or add a new one?

Thanks!
sage

