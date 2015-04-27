From: Alex Elder <elder@linaro.org>
Subject: [PATCH 3/7] messenger: rename "out_kvec_left" field
Date: Mon, 27 Apr 2015 12:13:11 -0500
Message-ID: <1430154795-17123-4-git-send-email-elder@linaro.org>
References: <1430154795-17123-1-git-send-email-elder@linaro.org>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:34040 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753197AbbD0RNX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Apr 2015 13:13:23 -0400
Received: by pdbqa5 with SMTP id qa5so134828658pdb.1
        for <ceph-devel@vger.kernel.org>; Mon, 27 Apr 2015 10:13:22 -0700 (PDT)
Received: from shibby.corp.google.com ([104.135.1.105])
        by mx.google.com with ESMTPSA id ff10sm12124675pab.13.2015.04.27.10.13.21
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Apr 2015 10:13:21 -0700 (PDT)
In-Reply-To: <1430154795-17123-1-git-send-email-elder@linaro.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The name "out_kvec_left" in the ceph_connection structure is sort of
ambiguous.  It represents the number of the entries of the out_kvec[]
array that are filled with data to send.  The name can easily be
misinterpreted to mean the number of such entries that are available.

Change the name to "out_kvec_used" to avoid misunderstanding.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 include/linux/ceph/messenger.h |  2 +-
 net/ceph/messenger.c           | 22 +++++++++++-----------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index e154994..c457f13 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -230,7 +230,7 @@ struct ceph_connection {
 
 	struct kvec out_kvec[8],         /* sending header/footer data */
 		*out_kvec_cur;
-	int out_kvec_left;   /* kvec's left in out_kvec */
+	int out_kvec_used;   /* kvec's used in out_kvec */
 	int out_skip;        /* skip this many bytes */
 	int out_kvec_bytes;  /* total bytes left */
 	bool out_kvec_is_msg; /* kvec refers to out_msg */
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 37b0fa7..a0d2673 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -773,7 +773,7 @@ static u32 get_global_seq(struct ceph_messenger *msgr, u32 gt)
 
 static void con_out_kvec_reset(struct ceph_connection *con)
 {
-	con->out_kvec_left = 0;
+	con->out_kvec_used = 0;
 	con->out_kvec_bytes = 0;
 	con->out_kvec_cur = &con->out_kvec[0];
 }
@@ -783,12 +783,12 @@ static void con_out_kvec_add(struct ceph_connection *con,
 {
 	int index;
 
-	index = con->out_kvec_left;
+	index = con->out_kvec_used;
 	BUG_ON(index >= ARRAY_SIZE(con->out_kvec));
 
 	con->out_kvec[index].iov_len = size;
 	con->out_kvec[index].iov_base = data;
-	con->out_kvec_left++;
+	con->out_kvec_used++;
 	con->out_kvec_bytes += size;
 }
 
@@ -1194,7 +1194,7 @@ static void prepare_message_data(struct ceph_msg *msg, u32 data_len)
 static void prepare_write_message_footer(struct ceph_connection *con)
 {
 	struct ceph_msg *m = con->out_msg;
-	int v = con->out_kvec_left;
+	int v = con->out_kvec_used;
 
 	m->footer.flags |= CEPH_MSG_FOOTER_COMPLETE;
 
@@ -1213,7 +1213,7 @@ static void prepare_write_message_footer(struct ceph_connection *con)
 		con->out_kvec[v].iov_len = sizeof(m->old_footer);
 		con->out_kvec_bytes += sizeof(m->old_footer);
 	}
-	con->out_kvec_left++;
+	con->out_kvec_used++;
 	con->out_more = m->more_to_follow;
 	con->out_msg_done = true;
 }
@@ -1462,7 +1462,7 @@ static int write_partial_kvec(struct ceph_connection *con)
 	dout("write_partial_kvec %p %d left\n", con, con->out_kvec_bytes);
 	while (con->out_kvec_bytes > 0) {
 		ret = ceph_tcp_sendmsg(con->sock, con->out_kvec_cur,
-				       con->out_kvec_left, con->out_kvec_bytes,
+				       con->out_kvec_used, con->out_kvec_bytes,
 				       con->out_more);
 		if (ret <= 0)
 			goto out;
@@ -1472,10 +1472,10 @@ static int write_partial_kvec(struct ceph_connection *con)
 
 		/* account for full iov entries consumed */
 		while (ret >= con->out_kvec_cur->iov_len) {
-			BUG_ON(!con->out_kvec_left);
+			BUG_ON(!con->out_kvec_used);
 			ret -= con->out_kvec_cur->iov_len;
 			con->out_kvec_cur++;
-			con->out_kvec_left--;
+			con->out_kvec_used--;
 		}
 		/* and for a partially-consumed entry */
 		if (ret) {
@@ -1483,12 +1483,12 @@ static int write_partial_kvec(struct ceph_connection *con)
 			con->out_kvec_cur->iov_base += ret;
 		}
 	}
-	con->out_kvec_left = 0;
+	con->out_kvec_used = 0;
 	con->out_kvec_is_msg = false;
 	ret = 1;
 out:
 	dout("write_partial_kvec %p %d left in %d kvecs ret = %d\n", con,
-	     con->out_kvec_bytes, con->out_kvec_left, ret);
+	     con->out_kvec_bytes, con->out_kvec_used, ret);
 	return ret;  /* done! */
 }
 
@@ -2497,7 +2497,7 @@ more_kvec:
 		if (ret <= 0)
 			goto out;
 	}
-	if (con->out_kvec_left) {
+	if (con->out_kvec_used) {
 		ret = write_partial_kvec(con);
 		if (ret <= 0)
 			goto out;
-- 
2.1.0

