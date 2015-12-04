From: Sage Weil <sweil@redhat.com>
Subject: ack vs commit
Date: Thu, 3 Dec 2015 16:54:37 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1512031641060.20799@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56961 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750849AbbLDAyj (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 3 Dec 2015 19:54:39 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (Postfix) with ESMTPS id D7F3EC0B0239
	for <ceph-devel@vger.kernel.org>; Fri,  4 Dec 2015 00:54:38 +0000 (UTC)
Received: from redhat.com ([10.3.112.19])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id tB40sbTk006739
	for <ceph-devel@vger.kernel.org>; Thu, 3 Dec 2015 19:54:38 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

From the beginning Ceph has had two kinds of acks for rados write/update 
operations: ack (indicating the operation is accepted, serialized, and 
staged in the osd's buffer cache) and commit (indicating the write is 
durable).  The client, if it saw a failure on the OSD before getting the 
commit, would have to resend the write to the new or recovered OSD, 
attaching the version it got with the original ack so that the 
new/recovered OSD could preserve the order.  (This is what the 
replay_window pool property is for.)

The only user for this functionality is CephFS, and only when a file is 
opened for write or read/write by multiple clients.  When that happens, 
the clients do all read/write operations synchronously with the OSDs, and 
effectively things are ordered there, at the object.  The idea is/was to 
avoid penalizing this sort of IO by waiting for commits when the clients 
aren't actually asking for that--at least until they call f[data]sync, at 
which point the client will block and wait for the second commit replies 
to arrive.

In practice, this doesn't actually help: everybody runs the OSDs on XFS, 
and FileStore has to do write-ahead journaling, which means that these 
operations are committed and durable before they are readable, and the 
clients only ever see 'commit' (and not 'ack' followed by 'commit') 
(commit implies ack too).   If you run the OSD on btrfs, you might see 
some acks (journaling and writes to the file system/page cache are done in 
parallel).

With newstore/bluestore, the current implementation doesn't make any 
attempt to make a write readable before it is durable.  This could be 
changed, but.. I'm not sure it's worth it.  For most workloads (RBD, RGW) 
we only care about making writes durable as quickly as possible, and all 
of the OSD optimization efforts are focusing on making this as fast as 
possible.  Is there much marginal benefit to the initial ack?  It's only 
the CephFS clients with the same file open from multiple hosts that might 
see a small benefit.

On the other hand, there is a bunch of code in the OSD and on the 
client side to deal with the dual-ack behavior we could potentially drop.  
Also, we are generating lots of extra messages on the backend network for 
both ack and commit, even though the librados users don't usually care 
(the clients don't get the dual acks unless they request them).

Also, it is arguably Wrong and a Bad Thing that you could have client A 
write to file F, client B reads from file F and sees that data, the OSD 
and client A both fail, and when things recover client B re-reads the same 
portion of the file and sees the file content from before client A's 
change.  The MDS is extremely careful about this on the metadata side: no 
side-effects of one client are visible to any other client until they are 
durable, so that a combination MDS and client failure will never make 
things appear to go back in time.

Any opinions here?  My inclination is to remove the functionality (less 
code, less complexity, more sane semantics), but we'd be closing the door 
on what might have been a half-decent idea (separating serialization from 
durability when multiple clients have the same file open for 
read/write)...

sage
