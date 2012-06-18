From: Alex Elder <elder@inktank.com>
Subject: [PATCH 1/6] libceph: encapsulate out message data setup
Date: Mon, 18 Jun 2012 10:33:08 -0500
Message-ID: <4FDF4A34.3000303@inktank.com>
References: <4FDF4948.10306@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:64225 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752607Ab2FRPdJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Jun 2012 11:33:09 -0400
Received: by yenl2 with SMTP id l2so3328546yen.19
        for <ceph-devel@vger.kernel.org>; Mon, 18 Jun 2012 08:33:08 -0700 (PDT)
In-Reply-To: <4FDF4948.10306@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Move the code that prepares to write the data portion of a message
into its own function.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/messenger.c |   36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

Index: b/net/ceph/messenger.c
===================================================================
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -590,6 +590,23 @@ static void con_out_kvec_add(struct ceph
 	con->out_kvec_bytes += size;
 }

+static void prepare_write_message_data(struct ceph_connection *con)
+{
+	struct ceph_msg *msg = con->out_msg;
+
+	BUG_ON(!msg);
+	BUG_ON(!msg->hdr.data_len);
+
+	/* initialize page iterator */
+	if (msg->pages)
+		con->out_msg_pos.page_pos = msg->page_alignment;
+	else
+		con->out_msg_pos.page_pos = 0;
+	con->out_msg_pos.data_pos = 0;
+	con->out_msg_pos.did_page_crc = false;
+	con->out_more = 1;  /* data + footer will follow */
+}
+
 /*
  * Prepare footer for currently outgoing message, and finish things
  * off.  Assumes out_kvec* are already valid.. we just add on to the end.
@@ -682,26 +699,17 @@ static void prepare_write_message(struct
 		con->out_msg->footer.middle_crc = cpu_to_le32(crc);
 	} else
 		con->out_msg->footer.middle_crc = 0;
-	con->out_msg->footer.data_crc = 0;
-	dout("prepare_write_message front_crc %u data_crc %u\n",
+	dout("%s front_crc %u middle_crc %u\n", __func__,
 	     le32_to_cpu(con->out_msg->footer.front_crc),
 	     le32_to_cpu(con->out_msg->footer.middle_crc));

 	/* is there a data payload? */
-	if (le32_to_cpu(m->hdr.data_len) > 0) {
-		/* initialize page iterator */
-		con->out_msg_pos.page = 0;
-		if (m->pages)
-			con->out_msg_pos.page_pos = m->page_alignment;
-		else
-			con->out_msg_pos.page_pos = 0;
-		con->out_msg_pos.data_pos = 0;
-		con->out_msg_pos.did_page_crc = false;
-		con->out_more = 1;  /* data + footer will follow */
-	} else {
+	con->out_msg->footer.data_crc = 0;
+	if (m->hdr.data_len)
+		prepare_write_message_data(con);
+	else
 		/* no, queue up footer too and be done */
 		prepare_write_message_footer(con);
-	}

 	set_bit(WRITE_PENDING, &con->flags);
 }

