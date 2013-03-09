From: Alex Elder <elder@inktank.com>
Subject: [PATCH 3/6] libceph: small write_partial_msg_pages() refactor
Date: Sat, 09 Mar 2013 10:43:09 -0600
Message-ID: <513B669D.8020806@inktank.com>
References: <513B661F.4050203@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:59212 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932441Ab3CIQnL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 9 Mar 2013 11:43:11 -0500
Received: by mail-ie0-f180.google.com with SMTP id bn7so3297537ieb.11
        for <ceph-devel@vger.kernel.org>; Sat, 09 Mar 2013 08:43:11 -0800 (PST)
In-Reply-To: <513B661F.4050203@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Define local variables page_offset and length to represent the range
of bytes within a page that will be sent by ceph_tcp_sendpage() in
write_partial_msg_pages().

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/messenger.c |   17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index e8fa449..813c299 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -1081,7 +1081,6 @@ static int write_partial_msg_pages(struct
ceph_connection *con)
 	struct ceph_msg *msg = con->out_msg;
 	struct ceph_msg_pos *msg_pos = &con->out_msg_pos;
 	unsigned int data_len = le32_to_cpu(msg->hdr.data_len);
-	size_t len;
 	bool do_datacrc = !con->msgr->nocrc;
 	int ret;
 	int total_max_write;
@@ -1102,6 +1101,8 @@ static int write_partial_msg_pages(struct
ceph_connection *con)
 	 */
 	while (data_len > msg_pos->data_pos) {
 		struct page *page = NULL;
+		size_t page_offset;
+		size_t length;
 		int max_write = PAGE_SIZE;
 		int bio_offset = 0;

@@ -1131,9 +1132,10 @@ static int write_partial_msg_pages(struct
ceph_connection *con)
 		} else {
 			page = zero_page;
 		}
-		len = min_t(int, max_write - msg_pos->page_pos,
+		length = min_t(int, max_write - msg_pos->page_pos,
 			    total_max_write);

+		page_offset = msg_pos->page_pos + bio_offset;
 		if (do_datacrc && !msg_pos->did_page_crc) {
 			void *base;
 			u32 crc = le32_to_cpu(msg->footer.data_crc);
@@ -1141,19 +1143,18 @@ static int write_partial_msg_pages(struct
ceph_connection *con)

 			kaddr = kmap(page);
 			BUG_ON(kaddr == NULL);
-			base = kaddr + msg_pos->page_pos + bio_offset;
-			crc = crc32c(crc, base, len);
+			base = kaddr + page_offset;
+			crc = crc32c(crc, base, length);
 			kunmap(page);
 			msg->footer.data_crc = cpu_to_le32(crc);
 			msg_pos->did_page_crc = true;
 		}
-		ret = ceph_tcp_sendpage(con->sock, page,
-				      msg_pos->page_pos + bio_offset,
-				      len, true);
+		ret = ceph_tcp_sendpage(con->sock, page, page_offset,
+				      length, true);
 		if (ret <= 0)
 			goto out;

-		out_msg_pos_next(con, page, len, (size_t) ret, in_trail);
+		out_msg_pos_next(con, page, length, (size_t) ret, in_trail);
 	}

 	dout("write_partial_msg_pages %p msg %p done\n", con, msg);
-- 
1.7.9.5

