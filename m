From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH] libceph: fix double __remove_osd() problem
Date: Wed, 18 Feb 2015 16:25:40 +0300
Message-ID: <1424265940-40771-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:40955 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772AbbBRNZs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Feb 2015 08:25:48 -0500
Received: by lbdu10 with SMTP id u10so1024785lbd.7
        for <ceph-devel@vger.kernel.org>; Wed, 18 Feb 2015 05:25:46 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sweil@redhat.com>

It turns out it's possible to get __remove_osd() called twice on the
same OSD.  That doesn't sit well with rb_erase() - depending on the
shape of the tree we can get a NULL dereference, a soft lockup or
a random crash at some point in the future as we end up touching freed
memory.  One scenario that I was able to reproduce is as follows:

            <osd3 is idle, on the osd lru list>
<con reset - osd3>
con_fault_finish()
  osd_reset()
                              <osdmap - osd3 down>
                              ceph_osdc_handle_map()
                                <takes map_sem>
                                kick_requests()
                                  <takes request_mutex>
                                  reset_changed_osds()
                                    __reset_osd()
                                      __remove_osd()
                                  <releases request_mutex>
                                <releases map_sem>
    <takes map_sem>
    <takes request_mutex>
    __kick_osd_requests()
      __reset_osd()
        __remove_osd() <-- !!!

A case can be made that osd refcounting is imperfect and reworking it
would be a proper resolution, but for now Sage and I decided to fix
this by adding a safe guard around __remove_osd().

Fixes: http://tracker.ceph.com/issues/8087

Cc: Sage Weil <sweil@redhat.com>
Cc: stable@vger.kernel.org # 3.9+: 7c6e6fc53e73: libceph: assert both regular and lingering lists in __remove_osd()
Cc: stable@vger.kernel.org # 3.9+: cc9f1f518cec: libceph: change from BUG to WARN for __remove_osd() asserts
Cc: stable@vger.kernel.org # 3.9+
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 net/ceph/osd_client.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 53299c7b0ca4..f693a2f8ac86 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1048,14 +1048,24 @@ static void put_osd(struct ceph_osd *osd)
  */
 static void __remove_osd(struct ceph_osd_client *osdc, struct ceph_osd *osd)
 {
-	dout("__remove_osd %p\n", osd);
+	dout("%s %p osd%d\n", __func__, osd, osd->o_osd);
 	WARN_ON(!list_empty(&osd->o_requests));
 	WARN_ON(!list_empty(&osd->o_linger_requests));
 
-	rb_erase(&osd->o_node, &osdc->osds);
 	list_del_init(&osd->o_osd_lru);
-	ceph_con_close(&osd->o_con);
-	put_osd(osd);
+	rb_erase(&osd->o_node, &osdc->osds);
+	RB_CLEAR_NODE(&osd->o_node);
+}
+
+static void remove_osd(struct ceph_osd_client *osdc, struct ceph_osd *osd)
+{
+	dout("%s %p osd%d\n", __func__, osd, osd->o_osd);
+
+	if (!RB_EMPTY_NODE(&osd->o_node)) {
+		ceph_con_close(&osd->o_con);
+		__remove_osd(osdc, osd);
+		put_osd(osd);
+	}
 }
 
 static void remove_all_osds(struct ceph_osd_client *osdc)
@@ -1065,7 +1075,7 @@ static void remove_all_osds(struct ceph_osd_client *osdc)
 	while (!RB_EMPTY_ROOT(&osdc->osds)) {
 		struct ceph_osd *osd = rb_entry(rb_first(&osdc->osds),
 						struct ceph_osd, o_node);
-		__remove_osd(osdc, osd);
+		remove_osd(osdc, osd);
 	}
 	mutex_unlock(&osdc->request_mutex);
 }
@@ -1106,7 +1116,7 @@ static void remove_old_osds(struct ceph_osd_client *osdc)
 	list_for_each_entry_safe(osd, nosd, &osdc->osd_lru, o_osd_lru) {
 		if (time_before(jiffies, osd->lru_ttl))
 			break;
-		__remove_osd(osdc, osd);
+		remove_osd(osdc, osd);
 	}
 	mutex_unlock(&osdc->request_mutex);
 }
@@ -1121,8 +1131,7 @@ static int __reset_osd(struct ceph_osd_client *osdc, struct ceph_osd *osd)
 	dout("__reset_osd %p osd%d\n", osd, osd->o_osd);
 	if (list_empty(&osd->o_requests) &&
 	    list_empty(&osd->o_linger_requests)) {
-		__remove_osd(osdc, osd);
-
+		remove_osd(osdc, osd);
 		return -ENODEV;
 	}
 
@@ -1926,6 +1935,7 @@ static void reset_changed_osds(struct ceph_osd_client *osdc)
 {
 	struct rb_node *p, *n;
 
+	dout("%s %p\n", __func__, osdc);
 	for (p = rb_first(&osdc->osds); p; p = n) {
 		struct ceph_osd *osd = rb_entry(p, struct ceph_osd, o_node);
 
-- 
1.9.3

