From: Jeff Layton <jlayton@redhat.com>
Subject: [PATCH v2 3/6] libceph: rename and export have_pool_full
Date: Mon,  6 Feb 2017 08:29:24 -0500
Message-ID: <20170206132927.9219-4-jlayton@redhat.com>
References: <20170206132927.9219-1-jlayton@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44686 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752105AbdBFN3b (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 6 Feb 2017 08:29:31 -0500
In-Reply-To: <20170206132927.9219-1-jlayton@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: zyan@redhat.com, sage@redhat.com, idryomov@gmail.com, jspray@redhat.com

Cephfs needs to be able to call this as well. Rename have_pool_full to
ceph_osdc_have_pool_full, and export it.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 include/linux/ceph/osd_client.h | 1 +
 net/ceph/osd_client.c           | 7 ++++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index 34010c86b307..17bf1873bb01 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -313,6 +313,7 @@ extern void ceph_osdc_handle_reply(struct ceph_osd_client *osdc,
 extern void ceph_osdc_handle_map(struct ceph_osd_client *osdc,
 				 struct ceph_msg *msg);
 void ceph_osdc_update_epoch_barrier(struct ceph_osd_client *osdc, u32 eb);
+extern bool ceph_osdc_have_pool_full(struct ceph_osd_client *osdc);
 
 extern void osd_req_op_init(struct ceph_osd_request *osd_req,
 			    unsigned int which, u16 opcode, u32 flags);
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index aeee87a0e0da..d61d7a79fdb3 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1259,7 +1259,7 @@ static bool __pool_full(struct ceph_pg_pool_info *pi)
 	return pi->flags & CEPH_POOL_FLAG_FULL;
 }
 
-static bool have_pool_full(struct ceph_osd_client *osdc)
+bool ceph_osdc_have_pool_full(struct ceph_osd_client *osdc)
 {
 	struct rb_node *n;
 
@@ -1273,6 +1273,7 @@ static bool have_pool_full(struct ceph_osd_client *osdc)
 
 	return false;
 }
+EXPORT_SYMBOL(ceph_osdc_have_pool_full);
 
 static bool pool_full(struct ceph_osd_client *osdc, s64 pool_id)
 {
@@ -3271,7 +3272,7 @@ void ceph_osdc_handle_map(struct ceph_osd_client *osdc, struct ceph_msg *msg)
 	was_pauserd = ceph_osdmap_flag(osdc, CEPH_OSDMAP_PAUSERD);
 	was_pausewr = ceph_osdmap_flag(osdc, CEPH_OSDMAP_PAUSEWR) ||
 		      ceph_osdmap_flag(osdc, CEPH_OSDMAP_FULL) ||
-		      have_pool_full(osdc);
+		      ceph_osdc_have_pool_full(osdc);
 
 	/* incremental maps */
 	ceph_decode_32_safe(&p, end, nr_maps, bad);
@@ -3335,7 +3336,7 @@ void ceph_osdc_handle_map(struct ceph_osd_client *osdc, struct ceph_msg *msg)
 	pauserd = ceph_osdmap_flag(osdc, CEPH_OSDMAP_PAUSERD);
 	pausewr = ceph_osdmap_flag(osdc, CEPH_OSDMAP_PAUSEWR) ||
 		  ceph_osdmap_flag(osdc, CEPH_OSDMAP_FULL) ||
-		  have_pool_full(osdc);
+		  ceph_osdc_have_pool_full(osdc);
 	if (was_pauserd || was_pausewr || pauserd || pausewr ||
 	    (osdc->epoch_barrier && osdc->osdmap->epoch < osdc->epoch_barrier))
 		maybe_request_map(osdc);
-- 
2.9.3

