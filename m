From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 1/6] libceph: make ceph_osdc_put_request() accept NULL
Date: Thu, 19 May 2016 16:06:37 +0200
Message-ID: <1463666802-25140-2-git-send-email-idryomov@gmail.com>
References: <1463666802-25140-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35839 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754776AbcESOHI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 May 2016 10:07:08 -0400
Received: by mail-wm0-f66.google.com with SMTP id s63so6789865wme.2
        for <ceph-devel@vger.kernel.org>; Thu, 19 May 2016 07:07:07 -0700 (PDT)
Received: from localhost.localdomain (ip-94-112-165-81.net.upcbroadband.cz. [94.112.165.81])
        by smtp.gmail.com with ESMTPSA id b124sm3586833wmb.1.2016.05.19.07.07.06
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 May 2016 07:07:06 -0700 (PDT)
In-Reply-To: <1463666802-25140-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 fs/ceph/addr.c        | 9 +++------
 net/ceph/osd_client.c | 8 +++++---
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 4801571f51cb..3e61fc8bb371 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1099,8 +1099,7 @@ release_pvec_pages:
 		mapping->writeback_index = index;
 
 out:
-	if (req)
-		ceph_osdc_put_request(req);
+	ceph_osdc_put_request(req);
 	ceph_put_snap_context(snapc);
 	dout("writepages done, rc = %d\n", rc);
 	return rc;
@@ -1824,10 +1823,8 @@ static int __ceph_pool_perm_get(struct ceph_inode_info *ci, u32 pool)
 out_unlock:
 	up_write(&mdsc->pool_perm_rwsem);
 
-	if (rd_req)
-		ceph_osdc_put_request(rd_req);
-	if (wr_req)
-		ceph_osdc_put_request(wr_req);
+	ceph_osdc_put_request(rd_req);
+	ceph_osdc_put_request(wr_req);
 out:
 	if (!err)
 		err = have;
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 40a53a70efdf..cacce9e35f08 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -354,9 +354,11 @@ EXPORT_SYMBOL(ceph_osdc_get_request);
 
 void ceph_osdc_put_request(struct ceph_osd_request *req)
 {
-	dout("%s %p (was %d)\n", __func__, req,
-	     atomic_read(&req->r_kref.refcount));
-	kref_put(&req->r_kref, ceph_osdc_release_request);
+	if (req) {
+		dout("%s %p (was %d)\n", __func__, req,
+		     atomic_read(&req->r_kref.refcount));
+		kref_put(&req->r_kref, ceph_osdc_release_request);
+	}
 }
 EXPORT_SYMBOL(ceph_osdc_put_request);
 
-- 
2.4.3

