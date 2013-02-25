From: Alex Elder <elder@inktank.com>
Subject: [PATCH 3/4] libceph: isolate message page field manipulation
Date: Mon, 25 Feb 2013 17:42:36 -0600
Message-ID: <512BF6EC.3040409@inktank.com>
References: <512BF683.5050905@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f170.google.com ([209.85.210.170]:61909 "EHLO
	mail-ia0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759857Ab3BYXmk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Feb 2013 18:42:40 -0500
Received: by mail-ia0-f170.google.com with SMTP id k20so2971335iak.1
        for <ceph-devel@vger.kernel.org>; Mon, 25 Feb 2013 15:42:39 -0800 (PST)
In-Reply-To: <512BF683.5050905@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Define a function ceph_msg_data_set_pages(), which more clearly
abstracts the assignment page-related fields for data in a ceph
message structure.  These fields should never be set more than once
(add BUG_ON() calls to guarantee that).  Use this new function in
the osd client and mds client.

Rearrange the field order in a ceph_msg structure to group those
that are used to define the possible data payloads.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 fs/ceph/mds_client.c           |    4 ++--
 include/linux/ceph/messenger.h |   22 +++++++++++++---------
 net/ceph/messenger.c           |   12 ++++++++++++
 net/ceph/osd_client.c          |   11 +++++------
 4 files changed, 32 insertions(+), 17 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 44435c2..d8842a1 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -1718,8 +1718,8 @@ static struct ceph_msg
*create_request_message(struct ceph_mds_client *mdsc,
 	msg->front.iov_len = p - msg->front.iov_base;
 	msg->hdr.front_len = cpu_to_le32(msg->front.iov_len);

-	msg->pages = req->r_pages;
-	msg->page_count = req->r_num_pages;
+	ceph_msg_data_set_pages(msg, req->r_pages, req->r_num_pages, 0);
+
 	msg->hdr.data_len = cpu_to_le32(req->r_data_len);
 	msg->hdr.data_off = cpu_to_le16(0);

diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index 1b08349..eeb28a0 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -74,22 +74,23 @@ struct ceph_msg {
 	struct ceph_msg_footer footer;	/* footer */
 	struct kvec front;              /* unaligned blobs of message */
 	struct ceph_buffer *middle;
-	struct page **pages;            /* data payload.  NOT OWNER. */
-	unsigned page_count;		/* size of page array */
-	unsigned page_alignment;        /* io offset in first page */
+
+	struct page **pages;		/* data payload.  NOT OWNER. */
+	unsigned int page_alignment;	/* io offset in first page */
+	unsigned int page_count;	/* # pages in array or list */
 	struct ceph_pagelist *pagelist; /* instead of pages */
 	unsigned int pagelist_count;	/* number of pages in pagelist */
-
-	struct ceph_connection *con;
-	struct list_head list_head;
-
-	struct kref kref;
 #ifdef CONFIG_BLOCK
+	unsigned int bio_seg;		/* current bio segment */
 	struct bio  *bio;		/* instead of pages/pagelist */
 	struct bio  *bio_iter;		/* bio iterator */
-	unsigned int bio_seg;		/* current bio segment */
 #endif /* CONFIG_BLOCK */
 	struct ceph_pagelist *trail;	/* the trailing part of the data */
+
+	struct ceph_connection *con;
+	struct list_head list_head;
+
+	struct kref kref;
 	bool front_is_vmalloc;
 	bool more_to_follow;
 	bool needs_out_seq;
@@ -219,6 +220,9 @@ extern void ceph_msg_revoke_incoming(struct ceph_msg
*msg);

 extern void ceph_con_keepalive(struct ceph_connection *con);

+extern void ceph_msg_data_set_pages(struct ceph_msg *msg, struct page
**pages,
+				unsigned int page_count, size_t alignment);
+
 extern struct ceph_msg *ceph_msg_new(int type, int front_len, gfp_t flags,
 				     bool can_fail);
 extern void ceph_msg_kfree(struct ceph_msg *m);
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 9d8abb0..7328e1b 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -2674,6 +2674,18 @@ void ceph_con_keepalive(struct ceph_connection *con)
 }
 EXPORT_SYMBOL(ceph_con_keepalive);

+void ceph_msg_data_set_pages(struct ceph_msg *msg, struct page **pages,
+		unsigned int page_count, size_t alignment)
+{
+	BUG_ON(msg->pages);
+	BUG_ON(msg->page_count);
+	BUG_ON(alignment >= PAGE_SIZE);
+
+	msg->pages = pages;
+	msg->page_count = page_count;
+	msg->page_alignment = alignment;
+}
+EXPORT_SYMBOL(ceph_msg_data_set_pages);

 /*
  * construct a new message with given type, size
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 1bb2b59..0f8351d 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1629,9 +1629,8 @@ int ceph_osdc_start_request(struct ceph_osd_client
*osdc,
 {
 	int rc = 0;

-	req->r_request->pages = req->r_pages;
-	req->r_request->page_count = req->r_num_pages;
-	req->r_request->page_alignment = req->r_page_alignment;
+	ceph_msg_data_set_pages(req->r_request, req->r_pages, req->r_num_pages,
+				req->r_page_alignment);
 #ifdef CONFIG_BLOCK
 	req->r_request->bio = req->r_bio;
 #endif
@@ -1981,9 +1980,9 @@ static struct ceph_msg *get_reply(struct
ceph_connection *con,
 			m = NULL;
 			goto out;
 		}
-		m->pages = req->r_pages;
-		m->page_count = req->r_num_pages;
-		m->page_alignment = req->r_page_alignment;
+
+		ceph_msg_data_set_pages(m, req->r_pages, req->r_num_pages,
+					req->r_page_alignment);
 #ifdef CONFIG_BLOCK
 		m->bio = req->r_bio;
 #endif
-- 
1.7.9.5

