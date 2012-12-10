From: Alex Elder <elder@inktank.com>
Subject: [PATCH] libceph: reformat __reset_osd()
Date: Sun, 09 Dec 2012 18:37:47 -0600
Message-ID: <50C52EDB.9010905@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:65480 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752668Ab2LJAhu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 9 Dec 2012 19:37:50 -0500
Received: by mail-ie0-f179.google.com with SMTP id k14so6614263iea.10
        for <ceph-devel@vger.kernel.org>; Sun, 09 Dec 2012 16:37:50 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Reformat __reset_osd() into three distinct blocks of code
handling the three return cases.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/osd_client.c |   33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 218a97f..fb5a0bd 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -665,31 +665,36 @@ static void remove_old_osds(struct ceph_osd_client
*osdc)
  */
 static int __reset_osd(struct ceph_osd_client *osdc, struct ceph_osd *osd)
 {
-	struct ceph_osd_request *req;
-	int ret = 0;
+	struct ceph_entity_addr *peer_addr;

 	dout("__reset_osd %p osd%d\n", osd, osd->o_osd);
 	if (list_empty(&osd->o_requests) &&
 	    list_empty(&osd->o_linger_requests)) {
 		__remove_osd(osdc, osd);
-		ret = -ENODEV;
-	} else if (memcmp(&osdc->osdmap->osd_addr[osd->o_osd],
-			  &osd->o_con.peer_addr,
-			  sizeof(osd->o_con.peer_addr)) == 0 &&
-		   !ceph_con_opened(&osd->o_con)) {
+
+		return -ENODEV;
+	}
+
+	peer_addr = &osdc->osdmap->osd_addr[osd->o_osd];
+	if (!memcmp(peer_addr, &osd->o_con.peer_addr, sizeof (*peer_addr)) &&
+			!ceph_con_opened(&osd->o_con)) {
+		struct ceph_osd_request *req;
+
 		dout(" osd addr hasn't changed and connection never opened,"
 		     " letting msgr retry");
 		/* touch each r_stamp for handle_timeout()'s benfit */
 		list_for_each_entry(req, &osd->o_requests, r_osd_item)
 			req->r_stamp = jiffies;
-		ret = -EAGAIN;
-	} else {
-		ceph_con_close(&osd->o_con);
-		ceph_con_open(&osd->o_con, CEPH_ENTITY_TYPE_OSD, osd->o_osd,
-			      &osdc->osdmap->osd_addr[osd->o_osd]);
-		osd->o_incarnation++;
+
+		return -EAGAIN;
 	}
-	return ret;
+
+	ceph_con_close(&osd->o_con);
+	ceph_con_open(&osd->o_con, CEPH_ENTITY_TYPE_OSD, osd->o_osd,
+		      &osdc->osdmap->osd_addr[osd->o_osd]);
+	osd->o_incarnation++;
+
+	return 0;
 }

 static void __insert_osd(struct ceph_osd_client *osdc, struct ceph_osd
*new)
-- 
1.7.9.5

