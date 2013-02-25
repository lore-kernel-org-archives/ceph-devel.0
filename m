From: Alex Elder <elder@inktank.com>
Subject: [PATCH 4/4] libceph: isolate other message data fields
Date: Mon, 25 Feb 2013 17:42:53 -0600
Message-ID: <512BF6FD.6010708@inktank.com>
References: <512BF683.5050905@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f169.google.com ([209.85.210.169]:57827 "EHLO
	mail-ia0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759861Ab3BYXm4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Feb 2013 18:42:56 -0500
Received: by mail-ia0-f169.google.com with SMTP id j5so3024259iaf.0
        for <ceph-devel@vger.kernel.org>; Mon, 25 Feb 2013 15:42:56 -0800 (PST)
In-Reply-To: <512BF683.5050905@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Define ceph_msg_data_set_pagelist(), ceph_msg_data_set_bio(), and
ceph_msg_data_set_trail() to clearly abstract the assignment the
remaining data-related fields in a ceph message structure.  These
fields should never be used more than once; add BUG_ON() calls to
guarantee this.  Use the new functions in the osd client and mds
client.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 fs/ceph/mds_client.c           |    4 ++--
 include/linux/ceph/messenger.h |    6 ++++++
 net/ceph/messenger.c           |   28 ++++++++++++++++++++++++++++
 net/ceph/osd_client.c          |    6 +++---
 4 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index d8842a1..c0eb44d 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2599,8 +2599,8 @@ static void send_mds_reconnect(struct
ceph_mds_client *mdsc,
 			goto fail;
 	}

-	reply->pagelist = pagelist;
-	reply->pagelist_count = calc_pages_for(0, pagelist->length);
+	ceph_msg_data_set_pagelist(reply, pagelist,
+				calc_pages_for(0, pagelist->length));
 	if (recon_state.flock)
 		reply->hdr.version = cpu_to_le16(2);
 	reply->hdr.data_len = cpu_to_le32(pagelist->length);
diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index eeb28a0..3cb3e8c 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -222,6 +222,12 @@ extern void ceph_con_keepalive(struct
ceph_connection *con);

 extern void ceph_msg_data_set_pages(struct ceph_msg *msg, struct page
**pages,
 				unsigned int page_count, size_t alignment);
+extern void ceph_msg_data_set_pagelist(struct ceph_msg *msg,
+				struct ceph_pagelist *pagelist,
+				unsigned int page_count);
+extern void ceph_msg_data_set_bio(struct ceph_msg *msg, struct bio *bio);
+extern void ceph_msg_data_set_trail(struct ceph_msg *msg,
+				struct ceph_pagelist *trail);

 extern struct ceph_msg *ceph_msg_new(int type, int front_len, gfp_t flags,
 				     bool can_fail);
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 7328e1b..82e3212 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -2687,6 +2687,34 @@ void ceph_msg_data_set_pages(struct ceph_msg
*msg, struct page **pages,
 }
 EXPORT_SYMBOL(ceph_msg_data_set_pages);

+void ceph_msg_data_set_pagelist(struct ceph_msg *msg,
+				struct ceph_pagelist *pagelist,
+				unsigned int pagelist_count)
+{
+	BUG_ON(msg->pagelist);
+	BUG_ON(msg->pagelist_count);
+
+	msg->pagelist = pagelist;
+	msg->pagelist_count = pagelist_count;
+}
+EXPORT_SYMBOL(ceph_msg_data_set_pagelist);
+
+void ceph_msg_data_set_bio(struct ceph_msg *msg, struct bio *bio)
+{
+	BUG_ON(msg->bio);
+
+	msg->bio = bio;
+}
+EXPORT_SYMBOL(ceph_msg_data_set_bio);
+
+void ceph_msg_data_set_trail(struct ceph_msg *msg, struct ceph_pagelist
*trail)
+{
+	BUG_ON(msg->trail);
+
+	msg->trail = trail;
+}
+EXPORT_SYMBOL(ceph_msg_data_set_trail);
+
 /*
  * construct a new message with given type, size
  * the new msg has a ref count of 1.
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 0f8351d..f984500 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1632,9 +1632,9 @@ int ceph_osdc_start_request(struct ceph_osd_client
*osdc,
 	ceph_msg_data_set_pages(req->r_request, req->r_pages, req->r_num_pages,
 				req->r_page_alignment);
 #ifdef CONFIG_BLOCK
-	req->r_request->bio = req->r_bio;
+	ceph_msg_data_set_bio(req->r_request, req->r_bio);
 #endif
-	req->r_request->trail = &req->r_trail;
+	ceph_msg_data_set_trail(req->r_request, &req->r_trail);

 	register_request(osdc, req);

@@ -1984,7 +1984,7 @@ static struct ceph_msg *get_reply(struct
ceph_connection *con,
 		ceph_msg_data_set_pages(m, req->r_pages, req->r_num_pages,
 					req->r_page_alignment);
 #ifdef CONFIG_BLOCK
-		m->bio = req->r_bio;
+		ceph_msg_data_set_bio(m, req->r_bio);
 #endif
 	}
 	*skip = 0;
-- 
1.7.9.5

