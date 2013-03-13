From: Alex Elder <elder@inktank.com>
Subject: [PATCH 4/4] libceph: use only ceph_msg_data_advance()
Date: Tue, 12 Mar 2013 20:09:58 -0500
Message-ID: <513FD1E6.2090104@inktank.com>
References: <513FD178.60207@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:44143 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932394Ab3CMBKB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Mar 2013 21:10:01 -0400
Received: by mail-ob0-f180.google.com with SMTP id ef5so508036obb.11
        for <ceph-devel@vger.kernel.org>; Tue, 12 Mar 2013 18:10:01 -0700 (PDT)
In-Reply-To: <513FD178.60207@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The *_msg_pos_next() functions do little more than call
ceph_msg_data_advance().  Replace those wrapper functions with
a simple call to ceph_msg_data_advance().

This cleanup is related to:
    http://tracker.ceph.com/issues/4428

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/messenger.c |   39 +++------------------------------------
 1 file changed, 3 insertions(+), 36 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 3180f82..8e07ac4 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -1365,40 +1365,6 @@ out:
 	return ret;  /* done! */
 }

-static void out_msg_pos_next(struct ceph_connection *con, struct page
*page,
-			size_t len, size_t sent)
-{
-	struct ceph_msg *msg = con->out_msg;
-	bool need_crc = false;
-
-	BUG_ON(!msg);
-	BUG_ON(!sent);
-
-	need_crc = ceph_msg_data_advance(&msg->data, sent);
-	BUG_ON(need_crc && sent != len);
-
-	if (sent < len)
-		return;
-
-	BUG_ON(sent != len);
-}
-
-static void in_msg_pos_next(struct ceph_connection *con, size_t len,
-				size_t received)
-{
-	struct ceph_msg *msg = con->in_msg;
-
-	BUG_ON(!msg);
-	BUG_ON(!received);
-
-	(void) ceph_msg_data_advance(&msg->data, received);
-
-	if (received < len)
-		return;
-
-	BUG_ON(received != len);
-}
-
 static u32 ceph_crc32c_page(u32 crc, struct page *page,
 				unsigned int page_offset,
 				unsigned int length)
@@ -1445,6 +1411,7 @@ static int write_partial_message_data(struct
ceph_connection *con)
 		size_t page_offset;
 		size_t length;
 		bool last_piece;
+		bool need_crc;
 		int ret;

 		page = ceph_msg_data_next(&msg->data, &page_offset, &length,
@@ -1458,7 +1425,7 @@ static int write_partial_message_data(struct
ceph_connection *con)

 			return ret;
 		}
-		out_msg_pos_next(con, page, length, (size_t) ret);
+		need_crc = ceph_msg_data_advance(&msg->data, (size_t) ret);
 	}
 	msg->footer.data_crc = cpu_to_le32(crc);

@@ -2133,7 +2100,7 @@ static int read_partial_msg_data(struct
ceph_connection *con)

 		if (do_datacrc)
 			crc = ceph_crc32c_page(crc, page, page_offset, ret);
-		in_msg_pos_next(con, length, ret);
+		(void) ceph_msg_data_advance(&msg->data, (size_t) ret);
 	}
 	con->in_data_crc = crc;

-- 
1.7.9.5

