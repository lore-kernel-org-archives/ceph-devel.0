From: Guanjun He <heguanbo@gmail.com>
Subject: [PATCH] fix ceph client crash when try to remove a rbd device
Date: Fri,  8 Jun 2012 15:56:56 +0800
Message-ID: <1339142216-26426-1-git-send-email-heguanbo@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:34127 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760807Ab2FHH6D (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Jun 2012 03:58:03 -0400
Received: by pbbrp8 with SMTP id rp8so2204213pbb.19
        for <ceph-devel@vger.kernel.org>; Fri, 08 Jun 2012 00:58:03 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Guanjun He <heguanbo@gmail.com>

	Create a rbd image and map it to client,then stop ceph cluster through 
'/etc/init.d/ceph -a stop', then in client side, run command 'echo id > /sys/bus/rbd/remove',
and this command can not return. Checking dmesg, seems like it enters an endless loop, 
try to re-connect osds and mons.Then press keys 'CTRL + C' to send an INT signal to 
'echo id > /sys/bus/rbd/remove',then kernel crash.

	Kernel crash because ceph_osd's o_requests list is not empty.
	This fix is to clean ceph_osd's o_requests list when it's forced to remove a rbd device(triggered
by /sys/bus/rbs/remove).

Signed-off-by: Guanjun He <heguanbo@gmail.com>
---
 net/ceph/osd_client.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 1ffebed..4dba062 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -688,11 +688,20 @@ static void __remove_osd(struct ceph_osd_client *osdc, struct ceph_osd *osd)
 
 static void remove_all_osds(struct ceph_osd_client *osdc)
 {
+	struct list_head *pos, *q;
+	struct ceph_osd_request *req;
+
 	dout("__remove_old_osds %p\n", osdc);
 	mutex_lock(&osdc->request_mutex);
 	while (!RB_EMPTY_ROOT(&osdc->osds)) {
 		struct ceph_osd *osd = rb_entry(rb_first(&osdc->osds),
 						struct ceph_osd, o_node);
+		list_for_each_safe(pos, q, &osd->o_requests) {
+			req = list_entry(pos, struct ceph_osd_request,
+							r_osd_item);
+			list_del(pos);
+			kfree(req);
+		}
 		__remove_osd(osdc, osd);
 	}
 	mutex_unlock(&osdc->request_mutex);
-- 
1.7.3.4

