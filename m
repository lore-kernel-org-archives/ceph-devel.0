From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 4/4] libceph: use sizeof_footer() more
Date: Sun, 21 Feb 2016 15:35:37 +0100
Message-ID: <1456065337-25628-1-git-send-email-idryomov@gmail.com>
References: <CAOi1vP9jV87zoR5bG7p-b3gKBt7JBVYP5iH-tjyx0Jnf-oLNsA@mail.gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:34768 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119AbcBURUR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 21 Feb 2016 12:20:17 -0500
Received: by mail-wm0-f50.google.com with SMTP id b205so127677634wmb.1
        for <ceph-devel@vger.kernel.org>; Sun, 21 Feb 2016 09:20:16 -0800 (PST)
In-Reply-To: <CAOi1vP9jV87zoR5bG7p-b3gKBt7JBVYP5iH-tjyx0Jnf-oLNsA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: ceph-devel@vger.kernel.org, Varada Kari <varada.kari@sandisk.com>

Don't open-code sizeof_footer() in read_partial_message() and
ceph_msg_revoke().  Also, after switching to sizeof_footer(), it's now
possible to use con_out_kvec_add() in prepare_write_message_footer().

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 net/ceph/messenger.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 9382619a405b..d9681bc839c7 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -1221,25 +1221,19 @@ static void prepare_message_data(struct ceph_msg *msg, u32 data_len)
 static void prepare_write_message_footer(struct ceph_connection *con)
 {
 	struct ceph_msg *m = con->out_msg;
-	int v = con->out_kvec_left;
 
 	m->footer.flags |= CEPH_MSG_FOOTER_COMPLETE;
 
 	dout("prepare_write_message_footer %p\n", con);
-	con->out_kvec[v].iov_base = &m->footer;
+	con_out_kvec_add(con, sizeof_footer(con), &m->footer);
 	if (con->peer_features & CEPH_FEATURE_MSG_AUTH) {
 		if (con->ops->sign_message)
 			con->ops->sign_message(m);
 		else
 			m->footer.sig = 0;
-		con->out_kvec[v].iov_len = sizeof(m->footer);
-		con->out_kvec_bytes += sizeof(m->footer);
 	} else {
 		m->old_footer.flags = m->footer.flags;
-		con->out_kvec[v].iov_len = sizeof(m->old_footer);
-		con->out_kvec_bytes += sizeof(m->old_footer);
 	}
-	con->out_kvec_left++;
 	con->out_more = m->more_to_follow;
 	con->out_msg_done = true;
 }
@@ -2409,11 +2403,7 @@ static int read_partial_message(struct ceph_connection *con)
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
@@ -3089,10 +3079,7 @@ void ceph_msg_revoke(struct ceph_msg *msg)
 			con->out_skip += con_out_kvec_skip(con);
 		} else {
 			BUG_ON(!msg->data_length);
-			if (con->peer_features & CEPH_FEATURE_MSG_AUTH)
-				con->out_skip += sizeof(msg->footer);
-			else
-				con->out_skip += sizeof(msg->old_footer);
+			con->out_skip += sizeof_footer(con);
 		}
 		/* data, middle, front */
 		if (msg->data_length)
-- 
2.4.3

