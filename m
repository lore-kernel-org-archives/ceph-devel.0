From: Alex Elder <elder@inktank.com>
Subject: [PATCH 4/5] libceph: use a do..while loop in con_work()
Date: Tue, 19 Feb 2013 18:56:48 -0600
Message-ID: <51241F50.6010708@inktank.com>
References: <51241E15.80903@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f50.google.com ([209.85.216.50]:34893 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759039Ab3BTA4v (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Feb 2013 19:56:51 -0500
Received: by mail-qa0-f50.google.com with SMTP id dx4so2162389qab.2
        for <ceph-devel@vger.kernel.org>; Tue, 19 Feb 2013 16:56:50 -0800 (PST)
In-Reply-To: <51241E15.80903@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

This just converts a manually-implemented loop into a do..while loop
in con_work().  It also moves handling of EAGAIN inside the blocks
where it's already been determined an error code was returned.

NOTE:
    This was done in two steps in order to facilitate review.  The
    This patch will be squashed into the next one before commit.
    next patch simply indents the loop properly.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/messenger.c |   32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 1cf0e53..609f2eb 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -2338,28 +2338,28 @@ static void con_work(struct work_struct *work)
 {
 	struct ceph_connection *con = container_of(work, struct ceph_connection,
 						   work.work);
-	bool fault = false;
-	int ret;
+	bool fault;

 	mutex_lock(&con->mutex);
-restart:
-	if (con_sock_closed(con)) {
+while (true) {
+	int ret;
+
+	if ((fault = con_sock_closed(con))) {
 		dout("con_work %p SOCK_CLOSED\n", con);
-		fault = true;
-		goto done;
+		break;
 	}
 	if (con_backoff(con)) {
 		dout("con_work %p BACKOFF\n", con);
-		goto done;
+		break;
 	}
 	if (con->state == CON_STATE_STANDBY) {
 		dout("con_work %p STANDBY\n", con);
-		goto done;
+		break;
 	}
 	if (con->state == CON_STATE_CLOSED) {
 		dout("con_work %p CLOSED\n", con);
 		BUG_ON(con->sock);
-		goto done;
+		break;
 	}
 	if (con->state == CON_STATE_PREOPEN) {
 		dout("con_work %p OPENING\n", con);
@@ -2367,22 +2367,24 @@ restart:
 	}

 	ret = try_read(con);
-	if (ret == -EAGAIN)
-		goto restart;
 	if (ret < 0) {
+		if (ret == -EAGAIN)
+			continue;
 		con->error_msg = "socket error on read";
 		fault = true;
-		goto done;
+		break;
 	}

 	ret = try_write(con);
-	if (ret == -EAGAIN)
-		goto restart;
 	if (ret < 0) {
+		if (ret == -EAGAIN)
+			continue;
 		con->error_msg = "socket error on write";
 		fault = true;
 	}
-done:
+
+	break;	/* If we make it to here, we're done */
+}
 	if (fault)
 		con_fault(con);
 	mutex_unlock(&con->mutex);
-- 
1.7.9.5

