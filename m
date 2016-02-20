From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 2/4] libceph: use the right footer size when skipping a message
Date: Sat, 20 Feb 2016 17:45:27 +0100
Message-ID: <1455986729-12544-3-git-send-email-idryomov@gmail.com>
References: <1455986729-12544-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:36638 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757489AbcBTQp4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 20 Feb 2016 11:45:56 -0500
Received: by mail-wm0-f41.google.com with SMTP id g62so117116000wme.1
        for <ceph-devel@vger.kernel.org>; Sat, 20 Feb 2016 08:45:56 -0800 (PST)
In-Reply-To: <1455986729-12544-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Varada Kari <Varada.Kari@sandisk.com>

ceph_msg_footer is 21 bytes long, while ceph_msg_footer_old is only 13.
Don't skip too much when CEPH_FEATURE_MSG_AUTH isn't negotiated.

Cc: stable@vger.kernel.org # 3.19+
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 net/ceph/messenger.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index fec20819a5ea..dd7c1b7f932b 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -2284,6 +2284,13 @@ static int read_partial_msg_data(struct ceph_connection *con)
 	return 1;	/* must return > 0 to indicate success */
 }
 
+static size_t sizeof_footer(struct ceph_connection *con)
+{
+	return (con->peer_features & CEPH_FEATURE_MSG_AUTH) ?
+	    sizeof(struct ceph_msg_footer) :
+	    sizeof(struct ceph_msg_footer_old);
+}
+
 /*
  * read (part of) a message.
  */
@@ -2335,7 +2342,7 @@ static int read_partial_message(struct ceph_connection *con)
 			ceph_pr_addr(&con->peer_addr.in_addr),
 			seq, con->in_seq + 1);
 		con->in_base_pos = -front_len - middle_len - data_len -
-			sizeof(m->footer);
+			sizeof_footer(con);
 		con->in_tag = CEPH_MSGR_TAG_READY;
 		return 1;
 	} else if ((s64)seq - (s64)con->in_seq > 1) {
@@ -2360,7 +2367,7 @@ static int read_partial_message(struct ceph_connection *con)
 			/* skip this message */
 			dout("alloc_msg said skip message\n");
 			con->in_base_pos = -front_len - middle_len - data_len -
-				sizeof(m->footer);
+				sizeof_footer(con);
 			con->in_tag = CEPH_MSGR_TAG_READY;
 			con->in_seq++;
 			return 1;
@@ -2402,11 +2409,7 @@ static int read_partial_message(struct ceph_connection *con)
 	}
 
 	/* footer */
-	if (need_sign)
-		size = sizeof(m->footer);
-	else
-		size = sizeof(m->old_footer);
-
+	size = sizeof_footer(con);
 	end += size;
 	ret = read_partial(con, end, size, &m->footer);
 	if (ret <= 0)
-- 
2.4.3

