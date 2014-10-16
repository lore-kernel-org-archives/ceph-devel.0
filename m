From: michaelc@cs.wisc.edu
Subject: [PATCH 1/1] libceph: use memalloc flags for net IO
Date: Thu, 16 Oct 2014 01:50:19 -0500
Message-ID: <1413442219-28024-1-git-send-email-michaelc@cs.wisc.edu>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sabe.cs.wisc.edu ([128.105.6.20]:39814 "EHLO sabe.cs.wisc.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750765AbaJPGu3 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 16 Oct 2014 02:50:29 -0400
Received: from localhost.localdomain (c-24-245-27-162.hsd1.mn.comcast.net [24.245.27.162])
	(authenticated bits=0)
	by sabe.cs.wisc.edu (8.14.1/8.14.1) with ESMTP id s9G6oOED013624
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ceph-devel@vger.kernel.org>; Thu, 16 Oct 2014 01:50:27 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

From: Mike Christie <michaelc@cs.wisc.edu>

This patch has ceph's lib code use the memalloc flags.

If the VM layer needs to write data out to free up memory to handle new
allocation requests, the block layer must be able to make forward progress.
To handle that requirement we use structs like mempools to reserve memory for
objects like bios and requests.

The problem is when we send/receive block layer requests over the network
layer, net skb allocations can fail and the system can lock up.
To solve this, the memalloc related flags were added. NBD, iSCSI
and NFS uses these flags to tell the network/vm layer that it should
use memory reserves to fullfill allcation requests for structs like
skbs.

I am running ceph in a bunch of VMs in my laptop, so this patch was
not tested very harshly. The patch was made over Linus's tree. I tried
to make it over the ceph-client tree but noticed it was very old (3.3
kernel or something).

Signed-off-by: Mike Christie <michaelc@cs.wisc.edu>
---
 net/ceph/messenger.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 559c9f6..a2d9c97 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -484,7 +484,7 @@ static int ceph_tcp_connect(struct ceph_connection *con)
 			       IPPROTO_TCP, &sock);
 	if (ret)
 		return ret;
-	sock->sk->sk_allocation = GFP_NOFS;
+	sock->sk->sk_allocation = GFP_NOFS | __GFP_MEMALLOC;
 
 #ifdef CONFIG_LOCKDEP
 	lockdep_set_class(&sock->sk->sk_lock, &socket_class);
@@ -510,6 +510,7 @@ static int ceph_tcp_connect(struct ceph_connection *con)
 		return ret;
 	}
 	con->sock = sock;
+	sk_set_memalloc(sock->sk);
 	return 0;
 }
 
@@ -2769,8 +2770,11 @@ static void con_work(struct work_struct *work)
 {
 	struct ceph_connection *con = container_of(work, struct ceph_connection,
 						   work.work);
+	unsigned long pflags = current->flags;
 	bool fault;
 
+	current->flags |= PF_MEMALLOC;
+
 	mutex_lock(&con->mutex);
 	while (true) {
 		int ret;
@@ -2824,6 +2828,7 @@ static void con_work(struct work_struct *work)
 		con_fault_finish(con);
 
 	con->ops->put(con);
+	tsk_restore_flags(current, pflags, PF_MEMALLOC);
 }
 
 /*
-- 
1.7.1

