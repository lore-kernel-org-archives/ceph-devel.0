From: Alexandre Oliva <oliva@gnu.org>
Subject: Re: [PATCH] reinstate ceph cluster_snap support
Date: Tue, 17 Dec 2013 12:22:55 -0200
Message-ID: <orsitr8slc.fsf@livre.home>
References: <orob8qt7kf.fsf@livre.home>
	<alpine.DEB.2.00.1308231715500.28981@cobra.newdream.net>
	<ortxifi1cs.fsf@livre.home>
	<alpine.DEB.2.00.1308271515500.24783@cobra.newdream.net>
	<or7gb3ad3w.fsf@livre.home> <orwqj38u3w.fsf@livre.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from linux-libre.fsfla.org ([208.118.235.54]:47553 "EHLO
	linux-libre.fsfla.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751274Ab3LQOXy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 Dec 2013 09:23:54 -0500
In-Reply-To: <orwqj38u3w.fsf@livre.home> (Alexandre Oliva's message of "Tue,
	17 Dec 2013 11:50:11 -0200")
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: sam.just@inktank.com, ceph-devel@vger.kernel.org

On Dec 17, 2013, Alexandre Oliva <oliva@gnu.org> wrote:

> On Dec 17, 2013, Alexandre Oliva <oliva@gnu.org> wrote:
>>> Finally, eventually we should make this do a checkpoint on the mons too.  
>>> We can add the osd snapping back in first, but before this can/should 
>>> really be used the mons need to be snapshotted as well.  Probably that's 
>>> just adding in a snapshot() method to MonitorStore.h and doing either a 
>>> leveldb snap or making a full copy of store.db... I forget what leveldb is 
>>> capable of here.

>> I haven't looked into this yet.

> None of these are particularly appealing; (1) wastes disk space and cpu
> cycles; (2) relies on leveldb internal implementation details such as
> the fact that files are never modified after they're first closed, and
> (3) requires a btrfs subvol for the store.db.  My favorite choice would
> be 3, but can we just fail mon snaps when this requirement is not met?

Another aspect that needs to be considered is whether to take a snapshot
of the leader only, or of all monitors in the quorum.  The fact that the
snapshot operation may take a while to complete (particularly (1)), and
monitors may not make progress while taking the snapshot (which might
cause the client and other monitors to assume other monitors have
failed), make the whole thing quite more complex than what I'd have
hoped for.

Another point that may affect the decision is the amount of information
in store.db that may have to be retained.  E.g., if it's just a small
amount of information, creating a separate database makes far more sense
than taking a complete copy of the entire database, and it might even
make sense for the leader to include the full snapshot data in the
snapshot-taking message shared with other monitors, so that they all
take exactly the same snapshot, even if they're not in the quorum and
receive the update at a later time.  Of course this wouldn't work if the
amount of snapshotted monitor data was more than reasonable for a
monitor message.

Anyway, this is probably more than what I'd be able to undertake myself,
at least in part because, although I can see one place to add the
snapshot-taking code to the leader (assuming it's ok to take the
snapshot just before or right after all monitors agree on it), I have no
idea of where to plug the snapshot-taking behavior into peon and
recovering monitors.  Absent a two-phase protocol, it seems to me that
all monitors ought to take snapshots tentatively when they issue or
acknowledge the snapshot-taking proposal, so as to make sure that if it
succeeds we'll have a quorum of snapshots, but if the proposal doesn't
succeed at first, I don't know how to deal with retries (overwrite
existing snapshots?  discard the snapshot when its proposal fails?) or
cancellation (say, the client doesn't get confirmation from the leader,
the leader changes, it retries that some times, and eventually it gives
up, but some monitors have already tentatively taken the snapshot in the
mean time).

-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist      Red Hat Brazil Compiler Engineer
