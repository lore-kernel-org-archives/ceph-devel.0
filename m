From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/5] libceph: separate non-locked fault handling
Date: Fri, 22 Feb 2013 11:26:04 -0600
Message-ID: <5127AA2C.7090709@inktank.com>
References: <5127A85D.1070000@inktank.com> <5127A935.8020605@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:40971 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758035Ab3BVR0H (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Feb 2013 12:26:07 -0500
Received: by mail-ie0-f170.google.com with SMTP id c11so1003845ieb.1
        for <ceph-devel@vger.kernel.org>; Fri, 22 Feb 2013 09:26:06 -0800 (PST)
In-Reply-To: <5127A935.8020605@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org >> ceph-devel" <ceph-devel@vger.kernel.org>

An error occurring on a ceph connection is treated as a fault,
causing the connection to be reset.  The initial part of this fault
handling has to be done while holding the connection mutex, but
it must then be dropped for the last part.

Separate the part of this fault handling that executes without the
lock into its own function, con_fault_finish().  Move the call to
this new function, as well as call that drops the connection mutex,
into ceph_fault().  Rename that function con_fault() to reflect that
it's only handling the connection part of the fault handling.

The motivation for this was a warning from sparse about the locking
being done here.  Rearranging things this way keeps all the mutex
manipulation within ceph_fault(), and this stops sparse from
complaining.

This partially resolves:
    http://tracker.ceph.com/issues/4184

Reported-by: Fengguang Wu <fengguang.wu@intel.com>
Signed-off-by: Alex Elder <elder@inktank.com>
---
v2: rebased

 net/ceph/messenger.c |   42 +++++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 9a29d8a..c3b9060 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -166,7 +166,7 @@ static struct lock_class_key socket_class;

 static void queue_con(struct ceph_connection *con);
 static void con_work(struct work_struct *);
-static void ceph_fault(struct ceph_connection *con);
+static void con_fault(struct ceph_connection *con);

 /*
  * Nicely render a sockaddr as a string.  An array of formatted
@@ -2363,6 +2363,23 @@ static bool con_backoff(struct ceph_connection *con)
 	return true;
 }

+/* Finish fault handling; con->mutex must *not* be held here */
+
+static void con_fault_finish(struct ceph_connection *con)
+{
+	/*
+	 * in case we faulted due to authentication, invalidate our
+	 * current tickets so that we can get new ones.
+	 */
+	if (con->auth_retry && con->ops->invalidate_authorizer) {
+		dout("calling invalidate_authorizer()\n");
+		con->ops->invalidate_authorizer(con);
+	}
+
+	if (con->ops->fault)
+		con->ops->fault(con);
+}
+
 /*
  * Do some work on a connection.  Drop a connection ref when we're done.
  */
@@ -2419,7 +2436,9 @@ done_unlocked:
 	return;

 fault:
-	ceph_fault(con);     /* error/fault path */
+	con_fault(con);
+	mutex_unlock(&con->mutex);
+	con_fault_finish(con);
 	goto done_unlocked;
 }

@@ -2428,8 +2447,7 @@ fault:
  * Generic error/fault handler.  A retry mechanism is used with
  * exponential backoff
  */
-static void ceph_fault(struct ceph_connection *con)
-	__releases(con->mutex)
+static void con_fault(struct ceph_connection *con)
 {
 	pr_warning("%s%lld %s %s\n", ENTITY_NAME(con->peer_name),
 	       ceph_pr_addr(&con->peer_addr.in_addr), con->error_msg);
@@ -2445,7 +2463,7 @@ static void ceph_fault(struct ceph_connection *con)
 	if (con_flag_test(con, CON_FLAG_LOSSYTX)) {
 		dout("fault on LOSSYTX channel, marking CLOSED\n");
 		con->state = CON_STATE_CLOSED;
-		goto out_unlock;
+		return;
 	}

 	if (con->in_msg) {
@@ -2476,20 +2494,6 @@ static void ceph_fault(struct ceph_connection *con)
 		con_flag_set(con, CON_FLAG_BACKOFF);
 		queue_con(con);
 	}
-
-out_unlock:
-	mutex_unlock(&con->mutex);
-	/*
-	 * in case we faulted due to authentication, invalidate our
-	 * current tickets so that we can get new ones.
-	 */
-	if (con->auth_retry && con->ops->invalidate_authorizer) {
-		dout("calling invalidate_authorizer()\n");
-		con->ops->invalidate_authorizer(con);
-	}
-
-	if (con->ops->fault)
-		con->ops->fault(con);
 }


-- 
1.7.9.5

