From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/3] libceph: kill ceph_msg->pagelist_count
Date: Mon, 04 Mar 2013 12:09:28 -0600
Message-ID: <5134E358.50309@inktank.com>
References: <5134E25E.4030701@inktank.com> <5134E30E.2090400@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f172.google.com ([209.85.210.172]:37329 "EHLO
	mail-ia0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757985Ab3CDSJ2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Mar 2013 13:09:28 -0500
Received: by mail-ia0-f172.google.com with SMTP id l29so5124476iag.3
        for <ceph-devel@vger.kernel.org>; Mon, 04 Mar 2013 10:09:28 -0800 (PST)
In-Reply-To: <5134E30E.2090400@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The pagelist_count field is never actually used, so get rid of it.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 fs/ceph/mds_client.c           |    1 -
 include/linux/ceph/messenger.h |    1 -
 net/ceph/messenger.c           |    2 --
 3 files changed, 4 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 44435c2..76b7344 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2600,7 +2600,6 @@ static void send_mds_reconnect(struct
ceph_mds_client *mdsc,
 	}

 	reply->pagelist = pagelist;
-	reply->pagelist_count = calc_pages_for(0, pagelist->length);
 	if (recon_state.flock)
 		reply->hdr.version = cpu_to_le16(2);
 	reply->hdr.data_len = cpu_to_le32(pagelist->length);
diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index 1b08349..6c11874 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -78,7 +78,6 @@ struct ceph_msg {
 	unsigned page_count;		/* size of page array */
 	unsigned page_alignment;        /* io offset in first page */
 	struct ceph_pagelist *pagelist; /* instead of pages */
-	unsigned int pagelist_count;	/* number of pages in pagelist */

 	struct ceph_connection *con;
 	struct list_head list_head;
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 9d8abb0..0f9933a 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -2718,7 +2718,6 @@ struct ceph_msg *ceph_msg_new(int type, int
front_len, gfp_t flags,
 	m->page_count = 0;
 	m->page_alignment = 0;
 	m->pages = NULL;
-	m->pagelist_count = 0;
 	m->pagelist = NULL;
 #ifdef	CONFIG_BLOCK
 	m->bio = NULL;
@@ -2898,7 +2897,6 @@ void ceph_msg_last_put(struct kref *kref)
 		ceph_pagelist_release(m->pagelist);
 		kfree(m->pagelist);
 		m->pagelist = NULL;
-		m->pagelist_count = 0;
 	}

 	m->trail = NULL;
-- 
1.7.9.5

