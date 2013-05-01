From: Alex Elder <elder@inktank.com>
Subject: [PATCH 3/3] libceph: use slab cache for osd client requests
Date: Wed, 01 May 2013 16:38:29 -0500
Message-ID: <51818B55.2010403@inktank.com>
References: <51818B12.4010307@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:40768 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932993Ab3EAVic (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 May 2013 17:38:32 -0400
Received: by mail-ie0-f171.google.com with SMTP id e11so2462250iej.30
        for <ceph-devel@vger.kernel.org>; Wed, 01 May 2013 14:38:32 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id ve9sm5789985igb.3.2013.05.01.14.38.30
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 01 May 2013 14:38:31 -0700 (PDT)
In-Reply-To: <51818B12.4010307@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Create a slab cache to manage allocation of ceph_osdc_request
structures.

This resolves:
    http://tracker.ceph.com/issues/3926

Signed-off-by: Alex Elder <elder@inktank.com>
---
 include/linux/ceph/osd_client.h |    3 +++
 net/ceph/ceph_common.c          |    7 +++++++
 net/ceph/osd_client.c           |   27 +++++++++++++++++++++++++--
 3 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/include/linux/ceph/osd_client.h
b/include/linux/ceph/osd_client.h
index 4191cd2..186db0b 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -224,6 +224,9 @@ struct ceph_osd_client {
 	struct workqueue_struct	*notify_wq;
 };

+extern int ceph_osdc_setup(void);
+extern void ceph_osdc_cleanup(void);
+
 extern int ceph_osdc_init(struct ceph_osd_client *osdc,
 			  struct ceph_client *client);
 extern void ceph_osdc_stop(struct ceph_osd_client *osdc);
diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
index c5605ae..b746cd7 100644
--- a/net/ceph/ceph_common.c
+++ b/net/ceph/ceph_common.c
@@ -601,11 +601,17 @@ static int __init init_ceph_lib(void)
 	if (ret < 0)
 		goto out_crypto;

+	ret = ceph_osdc_setup();
+	if (ret < 0)
+		goto out_msgr;
+
 	pr_info("loaded (mon/osd proto %d/%d)\n",
 		CEPH_MONC_PROTOCOL, CEPH_OSDC_PROTOCOL);

 	return 0;

+out_msgr:
+	ceph_msgr_exit();
 out_crypto:
 	ceph_crypto_shutdown();
 out_debugfs:
@@ -617,6 +623,7 @@ out:
 static void __exit exit_ceph_lib(void)
 {
 	dout("exit_ceph_lib\n");
+	ceph_osdc_cleanup();
 	ceph_msgr_exit();
 	ceph_crypto_shutdown();
 	ceph_debugfs_cleanup();
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 57d8db5..a3395fd 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -22,6 +22,8 @@
 #define OSD_OP_FRONT_LEN	4096
 #define OSD_OPREPLY_FRONT_LEN	512

+static struct kmem_cache	*ceph_osd_request_cache;
+
 static const struct ceph_connection_operations osd_con_ops;

 static void __send_queued(struct ceph_osd_client *osdc);
@@ -315,7 +317,8 @@ void ceph_osdc_release_request(struct kref *kref)
 	if (req->r_mempool)
 		mempool_free(req, req->r_osdc->req_mempool);
 	else
-		kfree(req);
+		kmem_cache_free(ceph_osd_request_cache, req);
+
 }
 EXPORT_SYMBOL(ceph_osdc_release_request);

@@ -346,7 +349,7 @@ struct ceph_osd_request
*ceph_osdc_alloc_request(struct ceph_osd_client *osdc,
 		req = mempool_alloc(osdc->req_mempool, gfp_flags);
 		memset(req, 0, sizeof(*req));
 	} else {
-		req = kzalloc(sizeof(*req), gfp_flags);
+		req = kmem_cache_zalloc(ceph_osd_request_cache, gfp_flags);
 	}
 	if (req == NULL)
 		return NULL;
@@ -2365,6 +2368,26 @@ int ceph_osdc_writepages(struct ceph_osd_client
*osdc, struct ceph_vino vino,
 }
 EXPORT_SYMBOL(ceph_osdc_writepages);

+int ceph_osdc_setup(void)
+{
+	BUG_ON(ceph_osd_request_cache);
+	ceph_osd_request_cache = kmem_cache_create("ceph_osd_request",
+					sizeof (struct ceph_osd_request),
+					__alignof__(struct ceph_osd_request),
+					0, NULL);
+
+	return ceph_osd_request_cache ? 0 : -ENOMEM;
+}
+EXPORT_SYMBOL(ceph_osdc_setup);
+
+void ceph_osdc_cleanup(void)
+{
+	BUG_ON(!ceph_osd_request_cache);
+	kmem_cache_destroy(ceph_osd_request_cache);
+	ceph_osd_request_cache = NULL;
+}
+EXPORT_SYMBOL(ceph_osdc_cleanup);
+
 /*
  * handle incoming message
  */
-- 
1.7.9.5

