From: Alex Elder <elder@inktank.com>
Subject: [PATCH 3/7] libceph: isolate other message data fields
Date: Sat, 09 Mar 2013 10:02:56 -0600
Message-ID: <513B5D30.9070901@inktank.com>
References: <513B5CAF.4010702@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:64963 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932735Ab3CIQC7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 9 Mar 2013 11:02:59 -0500
Received: by mail-ia0-f174.google.com with SMTP id k38so704132iah.5
        for <ceph-devel@vger.kernel.org>; Sat, 09 Mar 2013 08:02:59 -0800 (PST)
In-Reply-To: <513B5CAF.4010702@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Define ceph_msg_data_set_pagelist(), ceph_msg_data_set_bio(), and
ceph_msg_data_set_trail() to clearly abstract the assignment the
remaining data-related fields in a ceph message structure.  Use the
new functions in the osd client and mds client.

This partially resolves:
    http://tracker.ceph.com/issues/4263

Signed-off-by: Alex Elder <elder@inktank.com>
Reviewed-by: Josh Durgin <josh.durgin@inktank.com>
---
 fs/ceph/mds_client.c           |    2 +-
 include/linux/ceph/messenger.h |    5 +++++
 net/ceph/messenger.c           |   28 ++++++++++++++++++++++++++++
 net/ceph/osd_client.c          |    6 +++---
 4 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index bfc28ee..ae9438f 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2603,7 +2603,7 @@ static void send_mds_reconnect(struct
ceph_mds_client *mdsc,
 			goto fail;
 	}

-	reply->pagelist = pagelist;
+	ceph_msg_data_set_pagelist(reply, pagelist);
 	if (recon_state.flock)
 		reply->hdr.version = cpu_to_le16(2);
 	reply->hdr.data_len = cpu_to_le32(pagelist->length);
diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index e6d20e8..9d9be46 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -221,6 +221,11 @@ extern void ceph_con_keepalive(struct
ceph_connection *con);

 extern void ceph_msg_data_set_pages(struct ceph_msg *msg, struct page
**pages,
 				size_t length, size_t alignment);
+extern void ceph_msg_data_set_pagelist(struct ceph_msg *msg,
+				struct ceph_pagelist *pagelist);
+extern void ceph_msg_data_set_bio(struct ceph_msg *msg, struct bio *bio);
+extern void ceph_msg_data_set_trail(struct ceph_msg *msg,
+				struct ceph_pagelist *trail);

 extern struct ceph_msg *ceph_msg_new(int type, int front_len, gfp_t flags,
 				     bool can_fail);
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index fc59fcc..d118353 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -2701,6 +2701,34 @@ void ceph_msg_data_set_pages(struct ceph_msg
*msg, struct page **pages,
 }
 EXPORT_SYMBOL(ceph_msg_data_set_pages);

+void ceph_msg_data_set_pagelist(struct ceph_msg *msg,
+				struct ceph_pagelist *pagelist)
+{
+	/* BUG_ON(!pagelist); */
+	/* BUG_ON(msg->pagelist); */
+
+	msg->pagelist = pagelist;
+}
+EXPORT_SYMBOL(ceph_msg_data_set_pagelist);
+
+void ceph_msg_data_set_bio(struct ceph_msg *msg, struct bio *bio)
+{
+	/* BUG_ON(!bio); */
+	/* BUG_ON(msg->bio); */
+
+	msg->bio = bio;
+}
+EXPORT_SYMBOL(ceph_msg_data_set_bio);
+
+void ceph_msg_data_set_trail(struct ceph_msg *msg, struct ceph_pagelist
*trail)
+{
+	/* BUG_ON(!trail); */
+	/* BUG_ON(msg->trail); */
+
+	msg->trail = trail;
+}
+EXPORT_SYMBOL(ceph_msg_data_set_trail);
+
 /*
  * construct a new message with given type, size
  * the new msg has a ref count of 1.
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index f29beda..387e312 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1763,12 +1763,12 @@ int ceph_osdc_start_request(struct
ceph_osd_client *osdc,
 			osd_data->length, osd_data->alignment);
 #ifdef CONFIG_BLOCK
 	} else if (osd_data->type == CEPH_OSD_DATA_TYPE_BIO) {
-		req->r_request->bio = osd_data->bio;
+		ceph_msg_data_set_bio(req->r_request, osd_data->bio);
 #endif
 	} else {
 		BUG_ON(osd_data->type != CEPH_OSD_DATA_TYPE_NONE);
 	}
-	req->r_request->trail = &req->r_trail;
+	ceph_msg_data_set_trail(req->r_request, &req->r_trail);

 	register_request(osdc, req);

@@ -2132,7 +2132,7 @@ static struct ceph_msg *get_reply(struct
ceph_connection *con,
 				osd_data->length, osd_data->alignment);
 #ifdef CONFIG_BLOCK
 		} else if (osd_data->type == CEPH_OSD_DATA_TYPE_BIO) {
-			m->bio = osd_data->bio;
+			ceph_msg_data_set_bio(m, osd_data->bio);
 #endif
 		}
 	}
-- 
1.7.9.5

