From: Jeff Layton <jlayton@redhat.com>
Subject: [PATCH v3 4/5] ceph: register map callback to handle ENOSPC conditions
Date: Tue,  7 Feb 2017 07:28:27 -0500
Message-ID: <20170207122828.5550-5-jlayton@redhat.com>
References: <20170207122828.5550-1-jlayton@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49086 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753591AbdBGM2c (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 7 Feb 2017 07:28:32 -0500
In-Reply-To: <20170207122828.5550-1-jlayton@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: zyan@redhat.com, sage@redhat.com, idryomov@gmail.com, jspray@redhat.com

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 fs/ceph/mds_client.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 93fc893e1930..fcf1e5313c16 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -433,6 +433,18 @@ static int __verify_registered_session(struct ceph_mds_client *mdsc,
 	return 0;
 }
 
+static void handle_osd_map(struct ceph_osd_client *osdc)
+{
+	u32 cancelled_epoch;
+
+	lockdep_assert_held(&osdc->lock);
+
+	cancelled_epoch = ceph_osdc_abort_on_full(osdc);
+	if (cancelled_epoch)
+		osdc->epoch_barrier = max(cancelled_epoch + 1,
+					  osdc->epoch_barrier);
+}
+
 /*
  * create+register a new session for given mds.
  * called under mdsc->mutex.
@@ -3485,6 +3497,7 @@ int ceph_mdsc_init(struct ceph_fs_client *fsc)
 
 	ceph_caps_init(mdsc);
 	ceph_adjust_min_caps(mdsc, fsc->min_caps);
+	fsc->client->osdc.map_cb = handle_osd_map;
 
 	init_rwsem(&mdsc->pool_perm_rwsem);
 	mdsc->pool_perm_tree = RB_ROOT;
-- 
2.9.3

