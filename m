From: Alex Elder <elder@inktank.com>
Subject: [PATCH 5/7] libceph: record message data byte length
Date: Sat, 09 Mar 2013 10:03:24 -0600
Message-ID: <513B5D4C.1000001@inktank.com>
References: <513B5CAF.4010702@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f179.google.com ([209.85.210.179]:56323 "EHLO
	mail-ia0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932429Ab3CIQD1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 9 Mar 2013 11:03:27 -0500
Received: by mail-ia0-f179.google.com with SMTP id x24so2365653iak.24
        for <ceph-devel@vger.kernel.org>; Sat, 09 Mar 2013 08:03:27 -0800 (PST)
In-Reply-To: <513B5CAF.4010702@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Record the number of bytes of data in a page array rather than the
number of pages in the array.  It can be assumed that the page array
is of sufficient size to hold the number of bytes indicated (and
offset by the indicated alignment).

Signed-off-by: Alex Elder <elder@inktank.com>
---
 include/linux/ceph/messenger.h |    2 +-
 net/ceph/messenger.c           |   20 +++++++++-----------
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index 9d9be46..1991a6f 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -77,7 +77,7 @@ struct ceph_msg {

 	struct page **pages;		/* data payload.  NOT OWNER. */
 	unsigned int page_alignment;	/* io offset in first page */
-	unsigned int page_count;	/* # pages in array or list */
+	size_t length;			/* # data bytes in array or list */
 	struct ceph_pagelist *pagelist; /* instead of pages */
 #ifdef CONFIG_BLOCK
 	unsigned int bio_seg;		/* current bio segment */
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 1965d78..f48e2af 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -809,11 +809,10 @@ static void prepare_write_message(struct
ceph_connection *con)
 		m->bio_iter = NULL;
 #endif

-	dout("prepare_write_message %p seq %lld type %d len %d+%d+%d %d pgs\n",
+	dout("prepare_write_message %p seq %lld type %d len %d+%d+%d (%zd)\n",
 	     m, con->out_seq, le16_to_cpu(m->hdr.type),
 	     le32_to_cpu(m->hdr.front_len), le32_to_cpu(m->hdr.middle_len),
-	     le32_to_cpu(m->hdr.data_len),
-	     m->page_count);
+	     le32_to_cpu(m->hdr.data_len), m->length);
 	BUG_ON(le32_to_cpu(m->hdr.front_len) != m->front.iov_len);

 	/* tag + hdr + front + middle */
@@ -1091,9 +1090,8 @@ static int write_partial_msg_pages(struct
ceph_connection *con)
 	const size_t trail_len = (msg->trail ? msg->trail->length : 0);
 	const size_t trail_off = data_len - trail_len;

-	dout("write_partial_msg_pages %p msg %p page %d/%d offset %d\n",
-	     con, msg, con->out_msg_pos.page, msg->page_count,
-	     con->out_msg_pos.page_pos);
+	dout("write_partial_msg_pages %p msg %p page %d offset %d\n",
+	     con, msg, con->out_msg_pos.page, con->out_msg_pos.page_pos);

 	/*
 	 * Iterate through each page that contains data to be
@@ -2695,10 +2693,10 @@ void ceph_msg_data_set_pages(struct ceph_msg
*msg, struct page **pages,
 	/* BUG_ON(!pages); */
 	/* BUG_ON(!length); */
 	/* BUG_ON(msg->pages); */
-	/* BUG_ON(msg->page_count); */
+	/* BUG_ON(msg->length); */

 	msg->pages = pages;
-	msg->page_count = calc_pages_for((u64)alignment, (u64)length);
+	msg->length = length;
 	msg->page_alignment = alignment & ~PAGE_MASK;
 }
 EXPORT_SYMBOL(ceph_msg_data_set_pages);
@@ -2906,7 +2904,7 @@ void ceph_msg_last_put(struct kref *kref)
 		ceph_buffer_put(m->middle);
 		m->middle = NULL;
 	}
-	m->page_count = 0;
+	m->length = 0;
 	m->pages = NULL;

 	if (m->pagelist) {
@@ -2926,8 +2924,8 @@ EXPORT_SYMBOL(ceph_msg_last_put);

 void ceph_msg_dump(struct ceph_msg *msg)
 {
-	pr_debug("msg_dump %p (front_max %d page_count %d)\n", msg,
-		 msg->front_max, msg->page_count);
+	pr_debug("msg_dump %p (front_max %d length %zd)\n", msg,
+		 msg->front_max, msg->length);
 	print_hex_dump(KERN_DEBUG, "header: ",
 		       DUMP_PREFIX_OFFSET, 16, 1,
 		       &msg->hdr, sizeof(msg->hdr), true);
-- 
1.7.9.5

