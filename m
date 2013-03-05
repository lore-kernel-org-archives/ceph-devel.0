From: Alex Elder <elder@inktank.com>
Subject: [PATCH 1/5] libceph: isolate message page field manipulation
Date: Tue, 05 Mar 2013 07:52:41 -0600
Message-ID: <5135F8A9.2080506@inktank.com>
References: <5135F859.1090606@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:40964 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754580Ab3CENwo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Mar 2013 08:52:44 -0500
Received: by mail-ie0-f170.google.com with SMTP id c11so7808473ieb.1
        for <ceph-devel@vger.kernel.org>; Tue, 05 Mar 2013 05:52:44 -0800 (PST)
In-Reply-To: <5135F859.1090606@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Define a function ceph_msg_data_set_pages(), which more clearly
abstracts the assignment page-related fields for data in a ceph
message structure.  Use this new function in the osd client and mds
client.

Ideally, these fields would never be set more than once (with
BUG_ON() calls to guarantee that).  At the moment though the osd
client sets these every time it recieves a message, and in the event
of a communication problem this can happen more than once.  (This
will be resolved shortly, but setting up these helpers first makes
it all a bit easier to work with.)

Rearrange the field order in a ceph_msg structure to group those
that are used to define the possible data payloads.

This partially resolves:
    http://tracker.ceph.com/issues/4263

Signed-off-by: Alex Elder <elder@inktank.com>
Reviewed-by: Josh Durgin <josh.durgin@inktank.com>
---
 fs/ceph/mds_client.c           |    4 ++--
 include/linux/ceph/messenger.h |   22 +++++++++++++---------
 net/ceph/messenger.c           |   13 +++++++++++++
 net/ceph/osd_client.c          |   11 +++++------
 4 files changed, 33 insertions(+), 17 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index afb9dc9..c8f6be9 100644
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
index 6c11874..aa463b9 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -74,21 +74,22 @@ struct ceph_msg {
 	struct ceph_msg_footer footer;	/* footer */
 	struct kvec front;              /* unaligned blobs of message */
 	struct ceph_buffer *middle;
-	struct page **pages;            /* data payload.  NOT OWNER. */
-	unsigned page_count;		/* size of page array */
-	unsigned page_alignment;        /* io offset in first page */
-	struct ceph_pagelist *pagelist; /* instead of pages */
-
-	struct ceph_connection *con;
-	struct list_head list_head;

-	struct kref kref;
+	struct page **pages;		/* data payload.  NOT OWNER. */
+	unsigned int page_alignment;	/* io offset in first page */
+	unsigned int page_count;	/* # pages in array or list */
+	struct ceph_pagelist *pagelist; /* instead of pages */
 #ifdef CONFIG_BLOCK
+	unsigned int bio_seg;		/* current bio segment */
 	struct bio  *bio;		/* instead of pages/pagelist */
 	struct bio  *bio_iter;		/* bio iterator */
-	unsigned int bio_seg;		/* current bio segment */
 #endif /* CONFIG_BLOCK */
 	struct ceph_pagelist *trail;	/* the trailing part of the data */
+
+	struct ceph_connection *con;
+	struct list_head list_head;	/* links for connection lists */
+
+	struct kref kref;
 	bool front_is_vmalloc;
 	bool more_to_follow;
 	bool needs_out_seq;
@@ -218,6 +219,9 @@ extern void ceph_msg_revoke_incoming(struct ceph_msg
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
index c7d4278..a23faba 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -2674,6 +2674,19 @@ void ceph_con_keepalive(struct ceph_connection *con)
 }
 EXPORT_SYMBOL(ceph_con_keepalive);

+void ceph_msg_data_set_pages(struct ceph_msg *msg, struct page **pages,
+		unsigned int page_count, size_t alignment)
+{
+	/* BUG_ON(!pages); */
+	/* BUG_ON(!page_count); */
+	/* BUG_ON(msg->pages); */
+	/* BUG_ON(msg->page_count); */
+
+	msg->pages = pages;
+	msg->page_count = page_count;
+	msg->page_alignment = alignment & PAGE_SIZE;
+}
+EXPORT_SYMBOL(ceph_msg_data_set_pages);

 /*
  * construct a new message with given type, size
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index f9cf445..db777a4 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1753,9 +1753,8 @@ int ceph_osdc_start_request(struct ceph_osd_client
*osdc,

 	osd_data = &req->r_data_out;
 	if (osd_data->type == CEPH_OSD_DATA_TYPE_PAGES) {
-		req->r_request->pages = osd_data->pages;
-		req->r_request->page_count = osd_data->num_pages;
-		req->r_request->page_alignment = osd_data->alignment;
+		ceph_msg_data_set_pages(req->r_request, osd_data->pages,
+			osd_data->num_pages, osd_data->alignment);
 #ifdef CONFIG_BLOCK
 	} else if (osd_data->type == CEPH_OSD_DATA_TYPE_BIO) {
 		req->r_request->bio = osd_data->bio;
@@ -2127,9 +2126,9 @@ static struct ceph_msg *get_reply(struct
ceph_connection *con,
 				m = NULL;
 				goto out;
 			}
-			m->pages = osd_data->pages;
-			m->page_count = osd_data->num_pages;
-			m->page_alignment = osd_data->alignment;
+
+			ceph_msg_data_set_pages(m, osd_data->pages,
+				osd_data->num_pages, osd_data->alignment);
 #ifdef CONFIG_BLOCK
 		} else if (osd_data->type == CEPH_OSD_DATA_TYPE_BIO) {
 			m->bio = osd_data->bio;
-- 
1.7.9.5

