From: David Disseldorp <ddiss@suse.de>
Subject: [PATCH] mds: remove waiting lock before merging with neighbours
Date: Mon, 29 Jul 2013 17:05:44 +0200
Message-ID: <1375110344-26133-1-git-send-email-ddiss@suse.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:43711 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750820Ab3G2PFK (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 29 Jul 2013 11:05:10 -0400
Received: from relay1.suse.de (unknown [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 16E72A535C
	for <ceph-devel@vger.kernel.org>; Mon, 29 Jul 2013 17:05:09 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: David Disseldorp <ddiss@suse.de>

CephFS currently deadlocks under CTDB's ping_pong POSIX locking test
when run concurrently on multiple nodes.
The deadlock is caused by failed removal of a waiting_locks entry when
the waiting lock is merged with an existing lock, e.g:

Initial MDS state (two clients, same file):
held_locks -- start: 0, length: 1, client: 4116, pid: 7899, type: 2
	      start: 2, length: 1, client: 4110, pid: 40767, type: 2
waiting_locks -- start: 1, length: 1, client: 4116, pid: 7899, type: 2

Waiting lock entry 4116@1:1 fires:
handle_client_file_setlock: start: 1, length: 1,
			    client: 4116, pid: 7899, type: 2

MDS state after lock is obtained:
held_locks -- start: 0, length: 2, client: 4116, pid: 7899, type: 2
	      start: 2, length: 1, client: 4110, pid: 40767, type: 2
waiting_locks -- start: 1, length: 1, client: 4116, pid: 7899, type: 2

Note that the waiting 4116@1:1 lock entry is merged with the existing
4116@0:1 held lock to become a 4116@0:2 held lock. However, the now
handled 4116@1:1 waiting_locks entry remains.

When handling a lock request, the MDS calls adjust_locks() to merge
the new lock with available neighbours. If the new lock is merged,
then the waiting_locks entry is not located in the subsequent
remove_waiting() call.
This fix ensures that the waiting_locks entry is removed prior to
modification during merge.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 src/mds/flock.cc | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/mds/flock.cc b/src/mds/flock.cc
index e83c5ee..5e329af 100644
--- a/src/mds/flock.cc
+++ b/src/mds/flock.cc
@@ -75,12 +75,14 @@ bool ceph_lock_state_t::add_lock(ceph_filelock& new_lock,
       } else {
         //yay, we can insert a shared lock
         dout(15) << "inserting shared lock" << dendl;
+        remove_waiting(new_lock);
         adjust_locks(self_overlapping_locks, new_lock, neighbor_locks);
         held_locks.insert(pair<uint64_t, ceph_filelock>(new_lock.start, new_lock));
         ret = true;
       }
     }
   } else { //no overlapping locks except our own
+    remove_waiting(new_lock);
     adjust_locks(self_overlapping_locks, new_lock, neighbor_locks);
     dout(15) << "no conflicts, inserting " << new_lock << dendl;
     held_locks.insert(pair<uint64_t, ceph_filelock>
@@ -89,7 +91,6 @@ bool ceph_lock_state_t::add_lock(ceph_filelock& new_lock,
   }
   if (ret) {
     ++client_held_lock_counts[(client_t)new_lock.client];
-    remove_waiting(new_lock);
   }
   else if (wait_on_fail && !replay)
     ++client_waiting_lock_counts[(client_t)new_lock.client];
@@ -306,7 +307,7 @@ void ceph_lock_state_t::adjust_locks(list<multimap<uint64_t, ceph_filelock>::ite
     old_lock = &(*iter)->second;
     old_lock_client = old_lock->client;
     dout(15) << "lock to coalesce: " << *old_lock << dendl;
-    /* because if it's a neibhoring lock there can't be any self-overlapping
+    /* because if it's a neighboring lock there can't be any self-overlapping
        locks that covered it */
     if (old_lock->type == new_lock.type) { //merge them
       if (0 == new_lock.length) {
-- 
1.8.1.4

