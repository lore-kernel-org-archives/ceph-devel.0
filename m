From: Alex Elder <elder@inktank.com>
Subject: [PATCH 1/4] libceph: use cursor resid for loop condition
Date: Tue, 12 Mar 2013 20:09:16 -0500
Message-ID: <513FD1BC.4060001@inktank.com>
References: <513FD178.60207@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f41.google.com ([209.85.219.41]:34855 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932394Ab3CMBJW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Mar 2013 21:09:22 -0400
Received: by mail-oa0-f41.google.com with SMTP id i10so528908oag.28
        for <ceph-devel@vger.kernel.org>; Tue, 12 Mar 2013 18:09:22 -0700 (PDT)
In-Reply-To: <513FD178.60207@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Use the "resid" field of a cursor rather than finding when the
message data position has moved up to meet the data length to
determine when all data has been sent or received in
write_partial_message_data() and read_partial_msg_data().

This is cleanup of old code related to:
    http://tracker.ceph.com/issues/4428

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/messenger.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 30943c1..389dc62 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -1442,8 +1442,8 @@ static u32 ceph_crc32c_page(u32 crc, struct page
*page,
 static int write_partial_message_data(struct ceph_connection *con)
 {
 	struct ceph_msg *msg = con->out_msg;
+	struct ceph_msg_data_cursor *cursor = &msg->data.cursor;
 	struct ceph_msg_pos *msg_pos = &con->out_msg_pos;
-	unsigned int data_len = le32_to_cpu(msg->hdr.data_len);
 	bool do_datacrc = !con->msgr->nocrc;
 	int ret;

@@ -1461,7 +1461,7 @@ static int write_partial_message_data(struct
ceph_connection *con)
 	 * need to map the page.  If we have no pages, they have
 	 * been revoked, so use the zero page.
 	 */
-	while (data_len > msg_pos->data_pos) {
+	while (cursor->resid) {
 		struct page *page;
 		size_t page_offset;
 		size_t length;
@@ -1471,7 +1471,6 @@ static int write_partial_message_data(struct
ceph_connection *con)
 							&last_piece);
 		if (do_datacrc && !msg_pos->did_page_crc) {
 			u32 crc = le32_to_cpu(msg->footer.data_crc);
-
 			crc = ceph_crc32c_page(crc, page, page_offset, length);
 			msg->footer.data_crc = cpu_to_le32(crc);
 			msg_pos->did_page_crc = true;
@@ -2131,7 +2130,7 @@ static int read_partial_message_section(struct
ceph_connection *con,
 static int read_partial_msg_data(struct ceph_connection *con)
 {
 	struct ceph_msg *msg = con->in_msg;
-	struct ceph_msg_pos *msg_pos = &con->in_msg_pos;
+	struct ceph_msg_data_cursor *cursor = &msg->data.cursor;
 	const bool do_datacrc = !con->msgr->nocrc;
 	unsigned int data_len;
 	struct page *page;
@@ -2144,7 +2143,7 @@ static int read_partial_msg_data(struct
ceph_connection *con)
 		return -EIO;

 	data_len = le32_to_cpu(con->in_hdr.data_len);
-	while (msg_pos->data_pos < data_len) {
+	while (cursor->resid) {
 		page = ceph_msg_data_next(&msg->data, &page_offset, &length,
 							NULL);
 		ret = ceph_tcp_recvpage(con->sock, page, page_offset, length);
-- 
1.7.9.5

