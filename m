From: "Jim Schutt" <jaschut@sandia.gov>
Subject: [PATCH 1/2] libceph: add debugging to understand how bad msg
 tag is getting sent
Date: Thu, 12 May 2011 15:32:33 -0600
Message-ID: <1305235954-9860-1-git-send-email-jaschut@sandia.gov>
References: <Pine.LNX.4.64.1105051215050.26811@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:50855 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932821Ab1ELVdX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 May 2011 17:33:23 -0400
In-Reply-To: <Pine.LNX.4.64.1105051215050.26811@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage@newdream.net
Cc: ceph-devel@vger.kernel.org, Jim Schutt <jaschut@sandia.gov>

---
 net/ceph/messenger.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index e15a82c..db12abc 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -502,8 +502,8 @@ static void prepare_write_message(struct ceph_connection *con)
 		m->needs_out_seq = false;
 	}
 
-	dout("prepare_write_message %p seq %lld type %d len %d+%d+%d %d pgs\n",
-	     m, con->out_seq, le16_to_cpu(m->hdr.type),
+	dout("prepare_write_message %p msg %p seq %lld type %d len %d+%d+%d %d pgs\n",
+	     con, m, con->out_seq, le16_to_cpu(m->hdr.type),
 	     le32_to_cpu(m->hdr.front_len), le32_to_cpu(m->hdr.middle_len),
 	     le32_to_cpu(m->hdr.data_len),
 	     m->nr_pages);
@@ -1708,7 +1708,8 @@ static int try_write(struct ceph_connection *con)
 	     atomic_read(&con->nref));
 
 more:
-	dout("try_write out_kvec_bytes %d\n", con->out_kvec_bytes);
+	dout("try_write %p out_msg %p out_kvec_bytes %d\n",
+	     con, con->out_msg, con->out_kvec_bytes);
 
 	/* open the socket first? */
 	if (con->sock == NULL) {
@@ -1783,7 +1784,7 @@ do_next:
 
 	/* Nothing to do! */
 	clear_bit(WRITE_PENDING, &con->state);
-	dout("try_write nothing else to write.\n");
+	dout("try_write nothing else to write on %p.\n", con);
 	ret = 0;
 out:
 	dout("try_write done on %p ret %d\n", con, ret);
@@ -1959,13 +1960,13 @@ static void con_work(struct work_struct *work)
 		goto done;
 	}
 	if (test_bit(CLOSED, &con->state)) { /* e.g. if we are replaced */
-		dout("con_work CLOSED\n");
+		dout("con_work %p CLOSED\n", con);
 		con_close_socket(con);
 		goto done;
 	}
 	if (test_and_clear_bit(OPENING, &con->state)) {
 		/* reopen w/ new peer */
-		dout("con_work OPENING\n");
+		dout("con_work %p OPENING\n", con);
 		con_close_socket(con);
 	}
 
-- 
1.6.6


