From: Alex Elder <elder@inktank.com>
Subject: [PATCH 1/4] libceph: distinguish page array and pagelist count
Date: Mon, 25 Feb 2013 17:42:03 -0600
Message-ID: <512BF6CB.7040600@inktank.com>
References: <512BF683.5050905@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:52970 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759817Ab3BYXmH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Feb 2013 18:42:07 -0500
Received: by mail-ie0-f174.google.com with SMTP id k10so3745422iea.5
        for <ceph-devel@vger.kernel.org>; Mon, 25 Feb 2013 15:42:06 -0800 (PST)
In-Reply-To: <512BF683.5050905@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Use distinct fields for tracking the number of pages in a message's
page array and in a message's page list.  Currently only one or the
other is used at a time, but that will be changing soon.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 fs/ceph/mds_client.c           |    4 ++--
 include/linux/ceph/messenger.h |    3 ++-
 net/ceph/messenger.c           |   14 ++++++++------
 net/ceph/osd_client.c          |    4 ++--
 4 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index d958420..44435c2 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -1719,7 +1719,7 @@ static struct ceph_msg
*create_request_message(struct ceph_mds_client *mdsc,
 	msg->hdr.front_len = cpu_to_le32(msg->front.iov_len);

 	msg->pages = req->r_pages;
-	msg->nr_pages = req->r_num_pages;
+	msg->page_count = req->r_num_pages;
 	msg->hdr.data_len = cpu_to_le32(req->r_data_len);
 	msg->hdr.data_off = cpu_to_le16(0);

@@ -2600,10 +2600,10 @@ static void send_mds_reconnect(struct
ceph_mds_client *mdsc,
 	}

 	reply->pagelist = pagelist;
+	reply->pagelist_count = calc_pages_for(0, pagelist->length);
 	if (recon_state.flock)
 		reply->hdr.version = cpu_to_le16(2);
 	reply->hdr.data_len = cpu_to_le32(pagelist->length);
-	reply->nr_pages = calc_pages_for(0, pagelist->length);
 	ceph_con_send(&session->s_con, reply);

 	mutex_unlock(&session->s_mutex);
diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index 8297288..1b08349 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -75,9 +75,10 @@ struct ceph_msg {
 	struct kvec front;              /* unaligned blobs of message */
 	struct ceph_buffer *middle;
 	struct page **pages;            /* data payload.  NOT OWNER. */
-	unsigned nr_pages;              /* size of page array */
+	unsigned page_count;		/* size of page array */
 	unsigned page_alignment;        /* io offset in first page */
 	struct ceph_pagelist *pagelist; /* instead of pages */
+	unsigned int pagelist_count;	/* number of pages in pagelist */

 	struct ceph_connection *con;
 	struct list_head list_head;
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index c06f940..9d8abb0 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -813,7 +813,7 @@ static void prepare_write_message(struct
ceph_connection *con)
 	     m, con->out_seq, le16_to_cpu(m->hdr.type),
 	     le32_to_cpu(m->hdr.front_len), le32_to_cpu(m->hdr.middle_len),
 	     le32_to_cpu(m->hdr.data_len),
-	     m->nr_pages);
+	     m->page_count);
 	BUG_ON(le32_to_cpu(m->hdr.front_len) != m->front.iov_len);

 	/* tag + hdr + front + middle */
@@ -1072,7 +1072,7 @@ static int write_partial_msg_pages(struct
ceph_connection *con)
 	const size_t trail_off = data_len - trail_len;

 	dout("write_partial_msg_pages %p msg %p page %d/%d offset %d\n",
-	     con, msg, con->out_msg_pos.page, msg->nr_pages,
+	     con, msg, con->out_msg_pos.page, msg->page_count,
 	     con->out_msg_pos.page_pos);

 	/*
@@ -2715,9 +2715,10 @@ struct ceph_msg *ceph_msg_new(int type, int
front_len, gfp_t flags,
 	m->middle = NULL;

 	/* data */
-	m->nr_pages = 0;
+	m->page_count = 0;
 	m->page_alignment = 0;
 	m->pages = NULL;
+	m->pagelist_count = 0;
 	m->pagelist = NULL;
 #ifdef	CONFIG_BLOCK
 	m->bio = NULL;
@@ -2890,13 +2891,14 @@ void ceph_msg_last_put(struct kref *kref)
 		ceph_buffer_put(m->middle);
 		m->middle = NULL;
 	}
-	m->nr_pages = 0;
+	m->page_count = 0;
 	m->pages = NULL;

 	if (m->pagelist) {
 		ceph_pagelist_release(m->pagelist);
 		kfree(m->pagelist);
 		m->pagelist = NULL;
+		m->pagelist_count = 0;
 	}

 	m->trail = NULL;
@@ -2910,8 +2912,8 @@ EXPORT_SYMBOL(ceph_msg_last_put);

 void ceph_msg_dump(struct ceph_msg *msg)
 {
-	pr_debug("msg_dump %p (front_max %d nr_pages %d)\n", msg,
-		 msg->front_max, msg->nr_pages);
+	pr_debug("msg_dump %p (front_max %d page_count %d)\n", msg,
+		 msg->front_max, msg->page_count);
 	print_hex_dump(KERN_DEBUG, "header: ",
 		       DUMP_PREFIX_OFFSET, 16, 1,
 		       &msg->hdr, sizeof(msg->hdr), true);
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 980911e..0a4d4a0 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1631,7 +1631,7 @@ int ceph_osdc_start_request(struct ceph_osd_client
*osdc,
 	int rc = 0;

 	req->r_request->pages = req->r_pages;
-	req->r_request->nr_pages = req->r_num_pages;
+	req->r_request->page_count = req->r_num_pages;
 #ifdef CONFIG_BLOCK
 	req->r_request->bio = req->r_bio;
 #endif
@@ -1982,7 +1982,7 @@ static struct ceph_msg *get_reply(struct
ceph_connection *con,
 			goto out;
 		}
 		m->pages = req->r_pages;
-		m->nr_pages = req->r_num_pages;
+		m->page_count = req->r_num_pages;
 		m->page_alignment = req->r_page_alignment;
 #ifdef CONFIG_BLOCK
 		m->bio = req->r_bio;
-- 
1.7.9.5

