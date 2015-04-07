From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH] Revert "libceph: use memalloc flags for net IO"
Date: Tue,  7 Apr 2015 16:40:24 +0300
Message-ID: <1428414024-47769-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:34649 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753986AbbDGNkf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Apr 2015 09:40:35 -0400
Received: by lboc7 with SMTP id c7so42720909lbo.1
        for <ceph-devel@vger.kernel.org>; Tue, 07 Apr 2015 06:40:34 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Mike Christie <michaelc@cs.wisc.edu>, Mel Gorman <mgorman@suse.de>, Sage Weil <sage@redhat.com>

This reverts commit 89baaa570ab0b476db09408d209578cfed700e9f.

Dirty page throttling should be sufficient for us in the general case
so there is no need to use __GFP_MEMALLOC - it would be needed only in
the swap-over-rbd case, which we currently don't support.  (It would
probably take approximately the commit that is being reverted to add
that support, but we would also need the "swap" option to distinguish
from the general case and make sure swap ceph_client-s aren't shared
with anything else.)  See ceph-devel threads [1] and [2] for the
details of why enabling pfmemalloc reserves for all cases is a bad
thing.

On top of potential system lockups related to drained emergency
reserves, this turned out to cause ceph lockups in case peers are on
the same host and communicating via loopback due to sk_filter()
dropping pfmemalloc skbs on the receiving side because the receiving
loopback socket is not tagged with SOCK_MEMALLOC.

[1] "SOCK_MEMALLOC vs loopback"
    http://www.spinics.net/lists/ceph-devel/msg22998.html
[2] "[PATCH] libceph: don't set memalloc flags in loopback case"
    http://www.spinics.net/lists/ceph-devel/msg23392.html

Conflicts:
	net/ceph/messenger.c [ context: tcp_nodelay option ]

Cc: Mike Christie <michaelc@cs.wisc.edu>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Sage Weil <sage@redhat.com>
Cc: stable@vger.kernel.org # 3.18+, needs backporting
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 net/ceph/messenger.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 6b3f54ed65ba..a9f4ae45b7fb 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -484,7 +484,7 @@ static int ceph_tcp_connect(struct ceph_connection *con)
 			       IPPROTO_TCP, &sock);
 	if (ret)
 		return ret;
-	sock->sk->sk_allocation = GFP_NOFS | __GFP_MEMALLOC;
+	sock->sk->sk_allocation = GFP_NOFS;
 
 #ifdef CONFIG_LOCKDEP
 	lockdep_set_class(&sock->sk->sk_lock, &socket_class);
@@ -520,8 +520,6 @@ static int ceph_tcp_connect(struct ceph_connection *con)
 			       ret);
 	}
 
-	sk_set_memalloc(sock->sk);
-
 	con->sock = sock;
 	return 0;
 }
@@ -2808,11 +2806,8 @@ static void con_work(struct work_struct *work)
 {
 	struct ceph_connection *con = container_of(work, struct ceph_connection,
 						   work.work);
-	unsigned long pflags = current->flags;
 	bool fault;
 
-	current->flags |= PF_MEMALLOC;
-
 	mutex_lock(&con->mutex);
 	while (true) {
 		int ret;
@@ -2866,8 +2861,6 @@ static void con_work(struct work_struct *work)
 		con_fault_finish(con);
 
 	con->ops->put(con);
-
-	tsk_restore_flags(current, pflags, PF_MEMALLOC);
 }
 
 /*
-- 
1.9.3

