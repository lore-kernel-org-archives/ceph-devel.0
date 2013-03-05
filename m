From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/5] libceph: isolate other message data fields
Date: Tue, 05 Mar 2013 07:52:59 -0600
Message-ID: <5135F8BB.5020108@inktank.com>
References: <5135F859.1090606@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f180.google.com ([209.85.210.180]:63122 "EHLO
	mail-ia0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754580Ab3CENxE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Mar 2013 08:53:04 -0500
Received: by mail-ia0-f180.google.com with SMTP id f27so5970321iae.39
        for <ceph-devel@vger.kernel.org>; Tue, 05 Mar 2013 05:53:03 -0800 (PST)
In-Reply-To: <5135F859.1090606@inktank.com>
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
index c8f6be9..42400ce 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2599,7 +2599,7 @@ static void send_mds_reconnect(struct
ceph_mds_client *mdsc,
 			goto fail;
 	}

-	reply->pagelist = pagelist;
+	ceph_msg_data_set_pagelist(reply, pagelist);
 	if (recon_state.flock)
 		reply->hdr.version = cpu_to_le16(2);
 	reply->hdr.data_len = cpu_to_le32(pagelist->length);
diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index aa463b9..8e55d86 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -221,6 +221,11 @@ extern void ceph_con_keepalive(struct
ceph_connection *con);

 extern void ceph_msg_data_set_pages(struct ceph_msg *msg, struct page
**pages,
 				unsigned int page_count, size_t alignment);
+extern void ceph_msg_data_set_pagelist(struct ceph_msg *msg,
+				struct ceph_pagelist *pagelist);
+extern void ceph_msg_data_set_bio(struct ceph_msg *msg, struct bio *bio);
+extern void ceph_msg_data_set_trail(struct ceph_msg *msg,
+				struct ceph_pagelist *trail);

 extern struct ceph_msg *ceph_msg_new(int type, int front_len, gfp_t flags,
 				     bool can_fail);
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index a23faba..97506ac 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -2688,6 +2688,34 @@ void ceph_msg_data_set_pages(struct ceph_msg
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
index db777a4..c19188a 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1757,12 +1757,12 @@ int ceph_osdc_start_request(struct
ceph_osd_client *osdc,
 			osd_data->num_pages, osd_data->alignment);
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

@@ -2131,7 +2131,7 @@ static struct ceph_msg *get_reply(struct
ceph_connection *con,
 				osd_data->num_pages, osd_data->alignment);
 #ifdef CONFIG_BLOCK
 		} else if (osd_data->type == CEPH_OSD_DATA_TYPE_BIO) {
-			m->bio = osd_data->bio;
+			ceph_msg_data_set_bio(m, osd_data->bio);
 #endif
 		}
 	}
-- 
1.7.9.5

