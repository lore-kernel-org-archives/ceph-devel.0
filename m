From: Alexandre Oliva <oliva@gnu.org>
Subject: Re: [PATCH] reinstate ceph cluster_snap support
Date: Tue, 17 Dec 2013 11:50:11 -0200
Message-ID: <orwqj38u3w.fsf@livre.home>
References: <orob8qt7kf.fsf@livre.home>
	<alpine.DEB.2.00.1308231715500.28981@cobra.newdream.net>
	<ortxifi1cs.fsf@livre.home>
	<alpine.DEB.2.00.1308271515500.24783@cobra.newdream.net>
	<or7gb3ad3w.fsf@livre.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from linux-libre.fsfla.org ([208.118.235.54]:47486 "EHLO
	linux-libre.fsfla.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753006Ab3LQNuk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 Dec 2013 08:50:40 -0500
In-Reply-To: <or7gb3ad3w.fsf@livre.home> (Alexandre Oliva's message of "Tue,
	17 Dec 2013 10:14:27 -0200")
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: sam.just@inktank.com, ceph-devel@vger.kernel.org

On Dec 17, 2013, Alexandre Oliva <oliva@gnu.org> wrote:

>> Finally, eventually we should make this do a checkpoint on the mons too.  
>> We can add the osd snapping back in first, but before this can/should 
>> really be used the mons need to be snapshotted as well.  Probably that's 
>> just adding in a snapshot() method to MonitorStore.h and doing either a 
>> leveldb snap or making a full copy of store.db... I forget what leveldb is 
>> capable of here.

> I haven't looked into this yet.

I looked a bit at the leveldb interface.  It offers a facility to create
Snapshots, but they only last for the duration of one session of the
database.  It can be used to create multiple iterators at once state of
the db, or to read multiple values from the same state of the db, but
not to roll back to a state you had at an earlier session, e.g., after a
monitor restart.  So they won't help us.

I thus see a few possibilities (all of them to be done between taking
note of the request for the new snapshot and returning a response to the
requestor that the request was satisfied):

1. take a snapshot, create an iterator out of the snapshot, create a new
database named after the cluster_snap key, and go over all key/value
pairs tha the iterator can see, adding each one to this new database.

2. close the database, create a dir named after the cluster_snap key,
create hardlinks to all files in the database tree in the cluster_snap
dir, and then reopen the database

3. flush the leveldb (how?  will a write with sync=true do?  must we
close it?) and take a btrfs snapshot of the store.db tree, named after
the cluster_snap key, and then reopen the database

None of these are particularly appealing; (1) wastes disk space and cpu
cycles; (2) relies on leveldb internal implementation details such as
the fact that files are never modified after they're first closed, and
(3) requires a btrfs subvol for the store.db.  My favorite choice would
be 3, but can we just fail mon snaps when this requirement is not met?

-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist      Red Hat Brazil Compiler Engineer
