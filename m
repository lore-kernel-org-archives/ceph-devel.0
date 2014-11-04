From: John Spray <john.spray@redhat.com>
Subject: [PATCH 4/7] ceph: handle full condition by cancelling ops
Date: Tue,  4 Nov 2014 14:34:26 +0000
Message-ID: <1415111669-26246-5-git-send-email-john.spray@redhat.com>
References: <1415111669-26246-1-git-send-email-john.spray@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:64713 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753312AbaKDOfP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Nov 2014 09:35:15 -0500
Received: by mail-wg0-f44.google.com with SMTP id x12so13207484wgg.31
        for <ceph-devel@vger.kernel.org>; Tue, 04 Nov 2014 06:35:14 -0800 (PST)
In-Reply-To: <1415111669-26246-1-git-send-email-john.spray@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: John Spray <john.spray@redhat.com>

While cancelling, we store the OSD epoch at time
of cancellation, this will be used later in
CAPRELEASE messages.

Signed-off-by: John Spray <john.spray@redhat.com>
---
 fs/ceph/mds_client.c | 21 +++++++++++++++++++++
 fs/ceph/mds_client.h |  1 +
 2 files changed, 22 insertions(+)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 9f00853..dce7977 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -3265,6 +3265,23 @@ static void delayed_work(struct work_struct *work)
 	schedule_delayed(mdsc);
 }
 
+/**
+ * Call this with map_sem held for read
+ */
+static void handle_osd_map(struct ceph_osd_client *osdc, void *p)
+{
+	struct ceph_mds_client *mdsc = (struct ceph_mds_client*)p;
+	u32 cancelled_epoch = 0;
+
+	if (osdc->osdmap->flags & CEPH_OSDMAP_FULL) {
+		cancelled_epoch = ceph_osdc_cancel_writes(osdc, -ENOSPC);
+		if (cancelled_epoch) {
+			mdsc->cap_epoch_barrier = max(cancelled_epoch + 1,
+						      mdsc->cap_epoch_barrier);
+		}
+	}
+}
+
 int ceph_mdsc_init(struct ceph_fs_client *fsc)
 
 {
@@ -3311,6 +3328,10 @@ int ceph_mdsc_init(struct ceph_fs_client *fsc)
 
 	ceph_caps_init(mdsc);
 	ceph_adjust_min_caps(mdsc, fsc->min_caps);
+	mdsc->cap_epoch_barrier = 0;
+
+	ceph_osdc_register_map_cb(&fsc->client->osdc,
+				  handle_osd_map, (void*)mdsc);
 
 	return 0;
 }
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 230bda7..7b40568 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -298,6 +298,7 @@ struct ceph_mds_client {
 	int               num_cap_flushing; /* # caps we are flushing */
 	spinlock_t        cap_dirty_lock;   /* protects above items */
 	wait_queue_head_t cap_flushing_wq;
+	u32               cap_epoch_barrier;
 
 	/*
 	 * Cap reservations
-- 
1.9.3

