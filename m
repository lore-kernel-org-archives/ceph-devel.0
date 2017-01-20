From: Jeff Layton <jlayton@redhat.com>
Subject: [PATCH v1 2/7] libceph: rename and export have_pool_full
Date: Fri, 20 Jan 2017 10:17:33 -0500
Message-ID: <20170120151738.9584-3-jlayton@redhat.com>
References: <20170120151738.9584-1-jlayton@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43302 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751276AbdATPRk (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 20 Jan 2017 10:17:40 -0500
In-Reply-To: <20170120151738.9584-1-jlayton@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: jspray@redhat.com, idryomov@gmail.com, zyan@redhat.com, sage@redhat.com

Rename have_pool_full to ceph_osdc_have_pool_full, and export it.

Cephfs needs to be able to call this as well.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 include/linux/ceph/osd_client.h | 1 +
 net/ceph/osd_client.c           | 7 ++++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index a5298c02bde4..35f74c86533e 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -311,6 +311,7 @@ extern void ceph_osdc_handle_reply(struct ceph_osd_client *osdc,
 				   struct ceph_msg *msg);
 extern void ceph_osdc_handle_map(struct ceph_osd_client *osdc,
 				 struct ceph_msg *msg);
+extern bool ceph_osdc_have_pool_full(struct ceph_osd_client *osdc);
 
 extern void osd_req_op_init(struct ceph_osd_request *osd_req,
 			    unsigned int which, u16 opcode, u32 flags);
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 0562ea76c772..290968865a41 100644
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
@@ -3260,7 +3261,7 @@ void ceph_osdc_handle_map(struct ceph_osd_client *osdc, struct ceph_msg *msg)
 	was_pauserd = ceph_osdmap_flag(osdc, CEPH_OSDMAP_PAUSERD);
 	was_pausewr = ceph_osdmap_flag(osdc, CEPH_OSDMAP_PAUSEWR) ||
 		      ceph_osdmap_flag(osdc, CEPH_OSDMAP_FULL) ||
-		      have_pool_full(osdc);
+		      ceph_osdc_have_pool_full(osdc);
 
 	/* incremental maps */
 	ceph_decode_32_safe(&p, end, nr_maps, bad);
@@ -3324,7 +3325,7 @@ void ceph_osdc_handle_map(struct ceph_osd_client *osdc, struct ceph_msg *msg)
 	pauserd = ceph_osdmap_flag(osdc, CEPH_OSDMAP_PAUSERD);
 	pausewr = ceph_osdmap_flag(osdc, CEPH_OSDMAP_PAUSEWR) ||
 		  ceph_osdmap_flag(osdc, CEPH_OSDMAP_FULL) ||
-		  have_pool_full(osdc);
+		  ceph_osdc_have_pool_full(osdc);
 	if (was_pauserd || was_pausewr || pauserd || pausewr)
 		maybe_request_map(osdc);
 
-- 
2.9.3

