From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] reinstate ceph cluster_snap support
Date: Tue, 27 Aug 2013 21:34:11 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1308272131500.1901@cobra.newdream.net>
References: <orob8qt7kf.fsf@livre.home> <alpine.DEB.2.00.1308231715500.28981@cobra.newdream.net> <ortxifi1cs.fsf@livre.home> <alpine.DEB.2.00.1308271515500.24783@cobra.newdream.net> <CAAM7YA=9A37Paf3+NjM3hYD5Ro2tu0hkUwLrLt_aLtzBmky-aQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57719 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752791Ab3H1EeM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Aug 2013 00:34:12 -0400
In-Reply-To: <CAAM7YA=9A37Paf3+NjM3hYD5Ro2tu0hkUwLrLt_aLtzBmky-aQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: Alexandre Oliva <oliva@gnu.org>, sam.just@inktank.com, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, 28 Aug 2013, Yan, Zheng wrote:
> On Wed, Aug 28, 2013 at 6:21 AM, Sage Weil <sage@inktank.com> wrote:
> > Hi,
> >
> > On Sat, 24 Aug 2013, Alexandre Oliva wrote:
> >> On Aug 23, 2013, Sage Weil <sage@inktank.com> wrote:
> >>
> >> > FWIW Alexandre, this feature was never really complete.  For it to work,
> >> > we also need to snapshot the monitors, and roll them back as well.
> >>
> >> That depends on what's expected from the feature, actually.
> >>
> >> One use is to roll back a single osd, and for that, the feature works
> >> just fine.  Of course, for that one doesn't need the multi-osd snapshots
> >> to be mutually consistent, but it's still convenient to be able to take
> >> a global snapshot with a single command.
> >>
> >> Another use is to roll back the entire cluster to an earlier state, and
> >> for that, you *probably* want to roll back the monitors too, although it
> >> doesn't seem like this is strictly necessary, unless some significant
> >> configuration changes occurrend in the cluster since the snapshot was
> >> taken, and you want to roll back those too.
> >>
> >> In my experience, rolling back only osds has worked just fine, with the
> >> exception of cases in which the snapshot is much too old, and the mons
> >> have already expired osdmaps after the last one the osd got when the
> >> snapshot was taken.  For this one case, I have a patch that enables the
> >> osd to rejoin the cluster in spite of the expired osdmaps, which has
> >> always worked for me, but I understand there may be exceptional cluster
> >> reconfigurations in which this wouldn't have worked.
> >>
> >>
> >> As for snapshotting monitors...  I suppose the way to go is to start a
> >> store.db dump in background, instead of taking a btrfs snapshot, since
> >> the store.db is not created as a subvolume.  That said, it would make
> >> some sense to make it so, to make it trivially snapshottable.
> >>
> >>
> >> Anyway, I found a problem in the earlier patch: when I added a new disk
> >> to my cluster this morning, it tried to iterate over osdmaps that were
> >> not available (e.g. the long-gone osdmap 1), and crashed.
> >>
> >> Here's a fixed version, that makes sure we don't start the iteration
> >> before m->get_first().
> >
> > In principle, we can add this back in.  I think it needs a few changes,
> > though.
> >
> > First, FileStore::snapshot() needs to pause and drain the workqueue before
> > taking the snapshot, similar to what is done with the sync sequence.
> > Otherwise it isn't a transactionally consistent snapshot and may tear some
> > update.  Because it is draining the work queue, it *might* also need to
> > drop some locks, but I'm hopeful that that isn't necessary.
> >
> > Second, the call in handle_osd_map() should probably go in the loop a bit
> > further down that is consuming maps.  It probably won't matter most of the
> > time, but I'm paranoid about corner conditions.  It also avoids iterating
> > over the new OSDMaps multiple times in the common case where there is no
> > cluster_snap (a minor win).
> >
> > Finally, eventually we should make this do a checkpoint on the mons too.
> > We can add the osd snapping back in first, but before this can/should
> > really be used the mons need to be snapshotted as well.  Probably that's
> > just adding in a snapshot() method to MonitorStore.h and doing either a
> > leveldb snap or making a full copy of store.db... I forget what leveldb is
> > capable of here.
> >
> 
> I think we also need to snapshot the osd journal

If the snapshot does a sync (drain op_tp before doing the snap) that puts 
the file subvol in a consistent state.  To actually use it ceph-osd rolls 
back to that point on startup.  I didn't check that code, but I think what 
it should do is ignore/reset the journal then.

This is annoying code to test, unfortunately.

sage
