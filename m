From: mchristi@redhat.com
Subject: [PATCH 03/18] rbd: add lio specific data area
Date: Wed, 29 Jul 2015 04:23:40 -0500
Message-ID: <1438161835-27960-3-git-send-email-mchristi@redhat.com>
References: <1438161835-27960-1-git-send-email-mchristi@redhat.com>
Return-path: <target-devel-owner@vger.kernel.org>
In-Reply-To: <1438161835-27960-1-git-send-email-mchristi@redhat.com>
Sender: target-devel-owner@vger.kernel.org
To: ceph-devel@vger.kernel.org, target-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

From: Mike Christie <michaelc@cs.wisc.edu>

The LIO RBD backend is going to make img_request calls, so this patch
adds a pointer so it can store its cmd for completions.

Signed-off-by: Mike Christie <michaelc@cs.wisc.edu>
---
 drivers/block/rbd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index bc0466c..1df7bdd 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -303,6 +303,7 @@ struct rbd_img_request {
 
 	struct request		*rq;		/* block request */
 	struct rbd_obj_request	*obj_request;	/* obj req initiator */
+	void			*lio_cmd_data;	/* lio specific data */
 
 	struct page		**copyup_pages;
 	u32			copyup_page_count;
-- 
1.8.3.1
