From: Alex Elder <elder@inktank.com>
Subject: [PATCH] libceph: drop pages parameter
Date: Tue, 12 Mar 2013 20:02:36 -0500
Message-ID: <513FD02C.3060207@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:46153 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932103Ab3CMBCk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Mar 2013 21:02:40 -0400
Received: by mail-ob0-f178.google.com with SMTP id wd20so485617obb.23
        for <ceph-devel@vger.kernel.org>; Tue, 12 Mar 2013 18:02:39 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The "pages" parameter in read_partial_message_pages() is
unused, so get rid of it.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/messenger.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 997dacc..0d54ca4 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -2176,10 +2176,11 @@ static int read_partial_message_section(struct
ceph_connection *con,
 static int ceph_con_in_msg_alloc(struct ceph_connection *con, int *skip);

 static int read_partial_message_pages(struct ceph_connection *con,
-				      struct page **pages,
 				      unsigned int data_len, bool do_datacrc)
 {
+	struct ceph_msg *msg = con->in_msg;
 	struct ceph_msg_pos *msg_pos = &con->in_msg_pos;
+	struct page **pages;
 	struct page *page;
 	size_t page_offset;
 	size_t length;
@@ -2187,6 +2188,7 @@ static int read_partial_message_pages(struct
ceph_connection *con,
 	int ret;

 	/* (page) data */
+	pages = msg->p.pages;
 	BUG_ON(pages == NULL);
 	page = pages[msg_pos->page];
 	page_offset = msg_pos->page_pos;
@@ -2258,8 +2260,8 @@ static int read_partial_msg_data(struct
ceph_connection *con)
 	data_len = le32_to_cpu(con->in_hdr.data_len);
 	while (msg_pos->data_pos < data_len) {
 		if (ceph_msg_has_pages(msg)) {
-			ret = read_partial_message_pages(con, msg->p.pages,
-						 data_len, do_datacrc);
+			ret = read_partial_message_pages(con, data_len,
+							do_datacrc);
 			if (ret <= 0)
 				return ret;
 #ifdef CONFIG_BLOCK
-- 
1.7.9.5

