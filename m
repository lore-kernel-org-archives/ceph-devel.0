From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH] reinstate ceph cluster_snap support
Date: Thu, 13 Nov 2014 10:02:09 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1411130955210.24475@cobra.newdream.net>
References: <orob8qt7kf.fsf@livre.home> <alpine.DEB.2.00.1308231715500.28981@cobra.newdream.net> <ortxifi1cs.fsf@livre.home> <alpine.DEB.2.00.1308271515500.24783@cobra.newdream.net> <orbnp6uofj.fsf@free.home> <alpine.DEB.2.00.1410271357160.15740@cobra.newdream.net>
 <or4mug12i5.fsf@free.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41316 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933296AbaKMSCM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Nov 2014 13:02:12 -0500
In-Reply-To: <or4mug12i5.fsf@free.home>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre Oliva <oliva@gnu.org>
Cc: sam.just@inktank.com, ceph-devel@vger.kernel.org

On Mon, 3 Nov 2014, Alexandre Oliva wrote:
> On Oct 27, 2014, Sage Weil <sage@newdream.net> wrote:
> 
> > On Tue, 21 Oct 2014, Alexandre Oliva wrote:
> 
> >> I have tested both methods: btrfs snapshotting of store.db (I've
> >> manually turned store.db into a btrfs subvolume), and creating a new db
> >> with all (prefix,key,value) triples.  I'm undecided about inserting
> >> multiple transaction commits for the latter case; the mon mem use grew
> >> up a lot as it was, and in a few tests the snapshotting ran twice, but
> >> in the end a dump of all the data in the database created by btrfs
> >> snapshotting was identical to that created by explicit copying.  So, the
> >> former is preferred, since it's so incredibly more efficient.  I also
> >> considered hardlinking all files in store.db into a separate tree, but I
> >> didn't like the idea of coding that in C+-, :-) and I figured it might
> >> not work with other db backends, and maybe even not be guaranteed to
> >> work with leveldb.  It's probably not worth much more effort.
> 
> > This looks pretty reasonable!
> 
> > I think we definitely need to limit the size of the transaction when doing 
> > the snap.  The attached patch seems to try to do it all in one go, which 
> > is not going to work for large clusters.  Either re-use an existing 
> > tunable like the sync chunk size or add a new one?
> 
> Ok, I changed it so that it reuses the same tunable used for mon sync
> transaction sizes.  Tested on top of 0.87 (flawless upgrade, whee!),
> with both btrfs snapshots and leveldb copying.  I noticed slight
> differences between the databases at each mon with the leveldb copying,
> presumably having to do with at least one round of monitor-internal
> retrying as the first copy in each mon took too long, but each copy
> appeared to be consistent, and their aggregate is presumably usable to
> get the cluster rolled back to an earlier consistent state.

Yeah, I don't think it matters that the mons are in sync when the snapshot 
happens since they're well-prepared to handle that.  As long as the 
snapshot happens at the same logical time (triggered by a broadcast from 
the leader).

> I wish there was a better way to avoid the retry; though.  I'm thinking
> maybe not performing the copy when the snapshot dir already exists (like
> we do for osd snapshots), but I'm not sure this would guarantee a
> consistent monitor quorum snapshot.  But then, I'm not sure the current
> approach does either.  Plus, if we were to fail because the dir already
> existed, we'd need to somehow collect the success/fail status of the
> first try so that we don't misreport a failure just because the internal
> retry failed, and then, we'd need to distinguish an internal retry that
> ought to pass if the first attempt passed from a user-commanded attempt
> to created a new snapshot with the same name, which should ideally fail
> if any cluster component fails to take the snapshot.  Not that we
> currently send any success/failure status back...

A failure would be ideal and not overwriting I would think.  Barring the 
error handling, I'd just send something to the cluster log that it failed 
so that the operator has a clue it didn't work.

> If we stick with re-copying (rather than dropping the request on the
> floor if the dir exists), I might improve the overwriting from ?remove
> all entries, then add them all back? to ?compare entries in source and
> destination, and copy only those that changed?.  I have code to do just
> that, that I could borrow from a leveldbcmp programlet I wrote, but it
> would take some significant rewriting to refit it into the KeyValueDB
> interface, so I didn't jump through this hoop.  Let me know if it is
> desirable, and I'll try to schedule some time to work on it.

Meh, simpler to avoid dup names in the first place, I think?

> Another issue I'm somewhat unhappy about is that, while we perform the
> copying (which can take a few tens of seconds), the cluster comes to a
> halt because the mons won't make progress.  I wish we could do this
> copying in background, but I have no clue as to how to go about making
> the operation proceed asynchronously while returning a success at the
> end, rather than, say, because we successfully *started* the copying.  I
> could use a clue or two to do better than that ;-)

Technically leveldb can do it but other backends we plug in later may not.  
I'm fine with this stalling for now since this is really about disaster 
recovery and isn't something we're ready to have everyone use.

> Another nit I'm slightly unhappy about is that the command is still
> ?ceph osd cluster_snap <tag>?, whereas it now snapshots mons too, and it
> creates directories named clustersnap_<tag>, without the underscore
> separating cluster and snap as in the command.  I'd like to spell them
> out the same.  Any preferences?

I'm all for picking new names.  No need to preserve any sort of 
compatibility here.  Maybe just 'ceph cluster_snap <name>'?

Anyway, if you're going to be using this and will be giving it some 
testing, happy to pull these into the tree.  Not ready to advertise the 
feature until it has more robust testing in the test suite, though.  We 
should make the usage/help text for the cluster_snap command indicate it 
is experimental.

sage



> Here's the patch I've tested, that currently builds upon the other patch
> upthread, that reinstates osd snapshotting.
> 
> 
> 
