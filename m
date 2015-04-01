From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH] libceph: don't set memalloc flags in loopback case
Date: Wed,  1 Apr 2015 20:19:20 +0300
Message-ID: <1427908760-7083-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:35658 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751113AbbDARTa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Apr 2015 13:19:30 -0400
Received: by lahf3 with SMTP id f3so41387481lah.2
        for <ceph-devel@vger.kernel.org>; Wed, 01 Apr 2015 10:19:29 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Mike Christie <michaelc@cs.wisc.edu>, Mel Gorman <mgorman@suse.de>, Sage Weil <sage@redhat.com>

Following nbd and iscsi, commit 89baaa570ab0 ("libceph: use memalloc
flags for net IO") set SOCK_MEMALLOC and PF_MEMALLOC flags for rbd and
cephfs.  However it turned out to not play nice with loopback scenario,
leading to lockups with a full socket send-q and empty recv-q.

While we always advised against colocating kernel client and ceph
servers on the same box, a few people are doing it and it's also useful
for light development testing, so rather than reverting make sure to
not set those flags in the loopback case.

Cc: Mike Christie <michaelc@cs.wisc.edu>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Sage Weil <sage@redhat.com>
Cc: stable@vger.kernel.org # 3.18+, needs backporting
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 net/ceph/messenger.c | 40 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 6b3f54ed65ba..9fa2cce71164 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -101,6 +101,7 @@
 #define CON_FLAG_WRITE_PENDING	   2  /* we have data ready to send */
 #define CON_FLAG_SOCK_CLOSED	   3  /* socket state changed to closed */
 #define CON_FLAG_BACKOFF           4  /* need to retry queuing delayed work */
+#define CON_FLAG_LOCAL             5  /* using loopback interface */
 
 static bool con_flag_valid(unsigned long con_flag)
 {
@@ -110,6 +111,7 @@ static bool con_flag_valid(unsigned long con_flag)
 	case CON_FLAG_WRITE_PENDING:
 	case CON_FLAG_SOCK_CLOSED:
 	case CON_FLAG_BACKOFF:
+	case CON_FLAG_LOCAL:
 		return true;
 	default:
 		return false;
@@ -470,6 +472,18 @@ static void set_sock_callbacks(struct socket *sock,
  * socket helpers
  */
 
+static bool sk_is_loopback(struct sock *sk)
+{
+	struct dst_entry *dst = sk_dst_get(sk);
+	bool ret = false;
+
+	if (dst) {
+		ret = dst->dev && (dst->dev->flags & IFF_LOOPBACK);
+		dst_release(dst);
+	}
+	return ret;
+}
+
 /*
  * initiate connection to a remote socket.
  */
@@ -484,7 +498,7 @@ static int ceph_tcp_connect(struct ceph_connection *con)
 			       IPPROTO_TCP, &sock);
 	if (ret)
 		return ret;
-	sock->sk->sk_allocation = GFP_NOFS | __GFP_MEMALLOC;
+	sock->sk->sk_allocation = GFP_NOFS;
 
 #ifdef CONFIG_LOCKDEP
 	lockdep_set_class(&sock->sk->sk_lock, &socket_class);
@@ -510,6 +524,11 @@ static int ceph_tcp_connect(struct ceph_connection *con)
 		return ret;
 	}
 
+	if (sk_is_loopback(sock->sk))
+		con_flag_set(con, CON_FLAG_LOCAL);
+	else
+		con_flag_clear(con, CON_FLAG_LOCAL);
+
 	if (con->msgr->tcp_nodelay) {
 		int optval = 1;
 
@@ -520,7 +539,18 @@ static int ceph_tcp_connect(struct ceph_connection *con)
 			       ret);
 	}
 
-	sk_set_memalloc(sock->sk);
+	/*
+	 * Tagging with SOCK_MEMALLOC / setting PF_MEMALLOC may lead to
+	 * lockups if our peer is on the same host (communicating via
+	 * loopback) due to sk_filter() mercilessly dropping pfmemalloc
+	 * skbs on the receiving side - receiving loopback socket is
+	 * not going to be tagged with SOCK_MEMALLOC.  See:
+	 *
+	 * - http://article.gmane.org/gmane.linux.kernel/1418791
+	 * - http://article.gmane.org/gmane.linux.kernel.stable/46128
+	 */
+	if (!con_flag_test(con, CON_FLAG_LOCAL))
+		sk_set_memalloc(sock->sk);
 
 	con->sock = sock;
 	return 0;
@@ -2811,7 +2841,11 @@ static void con_work(struct work_struct *work)
 	unsigned long pflags = current->flags;
 	bool fault;
 
-	current->flags |= PF_MEMALLOC;
+	/*
+	 * See SOCK_MEMALLOC comment in ceph_tcp_connect().
+	 */
+	if (!con_flag_test(con, CON_FLAG_LOCAL))
+		current->flags |= PF_MEMALLOC;
 
 	mutex_lock(&con->mutex);
 	while (true) {
-- 
1.9.3

