From: Jeff Layton <jlayton@redhat.com>
Subject: [PATCH v2 4/6] ceph: register map callback to handle ENOSPC conditions
Date: Mon,  6 Feb 2017 08:29:25 -0500
Message-ID: <20170206132927.9219-5-jlayton@redhat.com>
References: <20170206132927.9219-1-jlayton@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34322 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751414AbdBFN3c (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 6 Feb 2017 08:29:32 -0500
In-Reply-To: <20170206132927.9219-1-jlayton@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: zyan@redhat.com, sage@redhat.com, idryomov@gmail.com, jspray@redhat.com

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 fs/ceph/mds_client.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 93fc893e1930..43297c6b5a8b 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -433,6 +433,21 @@ static int __verify_registered_session(struct ceph_mds_client *mdsc,
 	return 0;
 }
 
+static void handle_osd_map(struct ceph_osd_client *osdc, void *p)
+{
+	u32 cancelled_epoch = 0;
+
+	lockdep_assert_held(&osdc->lock);
+
+	if ((osdc->osdmap->flags & CEPH_OSDMAP_FULL) ||
+	    ceph_osdc_have_pool_full(osdc))
+		cancelled_epoch = ceph_osdc_complete_writes(osdc, -ENOSPC);
+
+	if (cancelled_epoch)
+		osdc->epoch_barrier = max(cancelled_epoch + 1,
+					  osdc->epoch_barrier);
+}
+
 /*
  * create+register a new session for given mds.
  * called under mdsc->mutex.
@@ -3486,6 +3501,9 @@ int ceph_mdsc_init(struct ceph_fs_client *fsc)
 	ceph_caps_init(mdsc);
 	ceph_adjust_min_caps(mdsc, fsc->min_caps);
 
+	ceph_osdc_register_map_cb(&fsc->client->osdc,
+				  handle_osd_map, (void*)mdsc);
+
 	init_rwsem(&mdsc->pool_perm_rwsem);
 	mdsc->pool_perm_tree = RB_ROOT;
 
-- 
2.9.3

