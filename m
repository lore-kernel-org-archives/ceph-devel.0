From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH 4/4] libceph: a few small changes
Date: Tue, 28 Feb 2012 20:46:44 -0800
Message-ID: <4F4DADB4.4040909@dreamhost.com>
References: <4F4DAD34.2030202@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:48684 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965676Ab2B2Eqo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 23:46:44 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 9B42024318
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 20:46:44 -0800 (PST)
Received: from [192.168.107.136] (aon.hq.newdream.net [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 90B2024314
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 20:46:44 -0800 (PST)
In-Reply-To: <4F4DAD34.2030202@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This gathers a number of very minor changes:
     - use %hu when formatting the a socket address's address family
     - null out the ceph_msgr_wq pointer after the queue has been
       destroyed
     - drop a needless cast in ceph_write_space()
     - add a WARN() call in ceph_state_change() in the event an
       unrecognized socket state is encountered
     - rearrange the logic in ceph_con_get() and ceph_con_put() so
       that:
         - the reference counts are only atomically read once
	- the values displayed via dout() calls are known to
	  be meaningful at the time they are formatted

Signed-off-by: Alex Elder <elder@dreamhost.com>
---
  net/ceph/messenger.c |   33 +++++++++++++++++++--------------
  1 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 9a8a479..d793b9f 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -80,8 +80,8 @@ const char *ceph_pr_addr(const struct sockaddr_storage 
*ss)
  		break;

  	default:
-		snprintf(s, MAX_ADDR_STR_LEN, "(unknown sockaddr family %d)",
-			 (int)ss->ss_family);
+		snprintf(s, MAX_ADDR_STR_LEN, "(unknown sockaddr family %hu)",
+			 ss->ss_family);
  	}

  	return s;
@@ -101,8 +101,10 @@ static struct workqueue_struct *ceph_msgr_wq;

  void _ceph_msgr_exit(void)
  {
-	if (ceph_msgr_wq)
+	if (ceph_msgr_wq) {
  		destroy_workqueue(ceph_msgr_wq);
+		ceph_msgr_wq = NULL;
+	}

  	BUG_ON(zero_page_address == NULL);
  	zero_page_address = NULL;
@@ -169,8 +171,7 @@ static void ceph_data_ready(struct sock *sk, int 
count_unused)
  /* socket has buffer space for writing */
  static void ceph_write_space(struct sock *sk)
  {
-	struct ceph_connection *con =
-		(struct ceph_connection *)sk->sk_user_data;
+	struct ceph_connection *con = sk->sk_user_data;

  	/* only queue to workqueue if there is data we want to write. */
  	if (test_bit(WRITE_PENDING, &con->state)) {
@@ -212,6 +213,9 @@ static void ceph_state_change(struct sock *sk)
  		dout("ceph_state_change TCP_ESTABLISHED\n");
  		queue_con(con);
  		break;
+	default:
+		WARN(1, "unexpected socket state (%d)", sk->sk_state);
+		break;
  	}
  }

@@ -416,22 +420,23 @@ bool ceph_con_opened(struct ceph_connection *con)
   */
  struct ceph_connection *ceph_con_get(struct ceph_connection *con)
  {
-	dout("con_get %p nref = %d -> %d\n", con,
-	     atomic_read(&con->nref), atomic_read(&con->nref) + 1);
-	if (atomic_inc_not_zero(&con->nref))
-		return con;
-	return NULL;
+	int nref = __atomic_add_unless(&con->nref, 1, 0);
+
+	dout("con_get %p nref = %d -> %d\n", con, nref, nref + 1);
+
+	return nref ? con : NULL;
  }

  void ceph_con_put(struct ceph_connection *con)
  {
-	dout("con_put %p nref = %d -> %d\n", con,
-	     atomic_read(&con->nref), atomic_read(&con->nref) - 1);
-	BUG_ON(atomic_read(&con->nref) == 0);
-	if (atomic_dec_and_test(&con->nref)) {
+	int nref = atomic_dec_return(&con->nref);
+
+	BUG_ON(nref < 0);
+	if (nref == 0) {
  		BUG_ON(con->sock);
  		kfree(con);
  	}
+	dout("con_put %p nref = %d -> %d\n", con, nref + 1, nref);
  }

  /*
-- 
1.7.5.4

