From: Alex Elder <elder@inktank.com>
Subject: [PATCH 3/4] libceph: use cursor for inbound data pages
Date: Tue, 12 Mar 2013 20:05:47 -0500
Message-ID: <513FD0EB.60800@inktank.com>
References: <513FD092.2030106@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f41.google.com ([209.85.219.41]:65394 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932103Ab3CMBFv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Mar 2013 21:05:51 -0400
Received: by mail-oa0-f41.google.com with SMTP id i10so538797oag.14
        for <ceph-devel@vger.kernel.org>; Tue, 12 Mar 2013 18:05:50 -0700 (PDT)
In-Reply-To: <513FD092.2030106@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The cursor code for a page array selects the right page, page
offset, and length to use for a ceph_tcp_recvpage() call, so
we can use it to replace a block in read_partial_message_pages().

This partially resolves:
    http://tracker.ceph.com/issues/4428

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/messenger.c |   17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 835447c..5507a12 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -1423,8 +1423,10 @@ static void in_msg_pos_next(struct
ceph_connection *con, size_t len,

 	msg_pos->data_pos += received;
 	msg_pos->page_pos += received;
+	if (ceph_msg_has_pages(msg))
+		(void) ceph_msg_data_advance(&msg->p, received);
 #ifdef CONFIG_BLOCK
-	if (ceph_msg_has_bio(msg))
+	else if (ceph_msg_has_bio(msg))
 		(void) ceph_msg_data_advance(&msg->b, received);
 #endif /* CONFIG_BLOCK */
 	if (received < len)
@@ -2162,23 +2164,12 @@ static int read_partial_message_pages(struct
ceph_connection *con,
 				      unsigned int data_len, bool do_datacrc)
 {
 	struct ceph_msg *msg = con->in_msg;
-	struct ceph_msg_pos *msg_pos = &con->in_msg_pos;
-	struct page **pages;
 	struct page *page;
 	size_t page_offset;
 	size_t length;
-	unsigned int left;
 	int ret;

-	/* (page) data */
-	pages = msg->p.pages;
-	BUG_ON(pages == NULL);
-	page = pages[msg_pos->page];
-	page_offset = msg_pos->page_pos;
-	BUG_ON(msg_pos->data_pos >= data_len);
-	left = data_len - msg_pos->data_pos;
-	BUG_ON(page_offset >= PAGE_SIZE);
-	length = min_t(unsigned int, PAGE_SIZE - page_offset, left);
+	page = ceph_msg_data_next(&msg->p, &page_offset, &length, NULL);

 	ret = ceph_tcp_recvpage(con->sock, page, page_offset, length);
 	if (ret <= 0)
-- 
1.7.9.5

