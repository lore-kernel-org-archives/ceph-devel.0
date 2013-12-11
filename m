From: Josh Durgin <josh.durgin@inktank.com>
Subject: [PATCH v2 2/2] libceph: resend all writes after the osdmap loses the full flag
Date: Wed, 11 Dec 2013 15:02:46 -0800
Message-ID: <1386802966-15531-3-git-send-email-josh.durgin@inktank.com>
References: <1386802966-15531-1-git-send-email-josh.durgin@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:38814 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000Ab3LKXtk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Dec 2013 18:49:40 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 85CB3266AF
	for <ceph-devel@vger.kernel.org>; Wed, 11 Dec 2013 15:49:39 -0800 (PST)
Received: from vit.ops.newdream.net (unknown [38.122.20.226])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 7AED8266AC
	for <ceph-devel@vger.kernel.org>; Wed, 11 Dec 2013 15:49:39 -0800 (PST)
In-Reply-To: <1386802966-15531-1-git-send-email-josh.durgin@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

With the current full handling, there is a race between osds and
clients getting the first map marked full. If the osd wins, it will
return -ENOSPC to any writes, but the client may already have writes
in flight. This results in the client getting the error and
propagating it up the stack. For rbd, the block layer turns this into
EIO, which can cause corruption in filesystems above it.

To avoid this race, osds are being changed to drop writes that came
from clients with an osdmap older than the last osdmap marked full.
In order for this to work, clients must resend all writes after they
encounter a full -> not full transition in the osdmap. osds will wait
for an updated map instead of processing a request from a client with
a newer map, so resent writes will not be dropped by the osd unless
there is another not full -> full transition.

This approach requires both osds and clients to be fixed to avoid the
race. Old clients talking to osds with this fix may hang instead of
returning EIO and potentially corrupting an fs. New clients talking to
old osds have the same behavior as before if they encounter this race.

Fixes: http://tracker.ceph.com/issues/6938

Signed-off-by: Josh Durgin <josh.durgin@inktank.com>
---
 net/ceph/osd_client.c |   28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 1ad9866..9ad0f2a 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1643,14 +1643,17 @@ static void reset_changed_osds(struct ceph_osd_client *osdc)
  *
  * Caller should hold map_sem for read.
  */
-static void kick_requests(struct ceph_osd_client *osdc, int force_resend)
+static void kick_requests(struct ceph_osd_client *osdc, bool force_resend,
+			  bool force_resend_writes)
 {
 	struct ceph_osd_request *req, *nreq;
 	struct rb_node *p;
 	int needmap = 0;
 	int err;
+	bool force_resend_req;
 
-	dout("kick_requests %s\n", force_resend ? " (force resend)" : "");
+	dout("kick_requests %s %s\n", force_resend ? " (force resend)" : "",
+		force_resend_writes ? " (force resend writes)" : "");
 	mutex_lock(&osdc->request_mutex);
 	for (p = rb_first(&osdc->requests); p; ) {
 		req = rb_entry(p, struct ceph_osd_request, r_node);
@@ -1675,7 +1678,10 @@ static void kick_requests(struct ceph_osd_client *osdc, int force_resend)
 			continue;
 		}
 
-		err = __map_request(osdc, req, force_resend);
+		force_resend_req = force_resend ||
+			(force_resend_writes &&
+				req->r_flags & CEPH_OSD_FLAG_WRITE)
+		err = __map_request(osdc, req, force_resend_req);
 		if (err < 0)
 			continue;  /* error */
 		if (req->r_osd == NULL) {
@@ -1695,7 +1701,8 @@ static void kick_requests(struct ceph_osd_client *osdc, int force_resend)
 				 r_linger_item) {
 		dout("linger req=%p req->r_osd=%p\n", req, req->r_osd);
 
-		err = __map_request(osdc, req, force_resend);
+		err = __map_request(osdc, req,
+				    force_resend || force_resend_write);
 		dout("__map_request returned %d\n", err);
 		if (err == 0)
 			continue;  /* no change and no osd was specified */
@@ -1737,6 +1744,7 @@ void ceph_osdc_handle_map(struct ceph_osd_client *osdc, struct ceph_msg *msg)
 	struct ceph_osdmap *newmap = NULL, *oldmap;
 	int err;
 	struct ceph_fsid fsid;
+	bool was_full;
 
 	dout("handle_map have %u\n", osdc->osdmap ? osdc->osdmap->epoch : 0);
 	p = msg->front.iov_base;
@@ -1750,6 +1758,8 @@ void ceph_osdc_handle_map(struct ceph_osd_client *osdc, struct ceph_msg *msg)
 
 	down_write(&osdc->map_sem);
 
+	was_full = ceph_osdmap_flag(osdc->osdmap, CEPH_OSDMAP_FULL);
+
 	/* incremental maps */
 	ceph_decode_32_safe(&p, end, nr_maps, bad);
 	dout(" %d inc maps\n", nr_maps);
@@ -1774,7 +1784,10 @@ void ceph_osdc_handle_map(struct ceph_osd_client *osdc, struct ceph_msg *msg)
 				ceph_osdmap_destroy(osdc->osdmap);
 				osdc->osdmap = newmap;
 			}
-			kick_requests(osdc, 0);
+			was_full = was_full ||
+				ceph_osdmap_flag(osdc->osdmap,
+						 CEPH_OSDMAP_FULL);
+			kick_requests(osdc, 0, was_full);
 		} else {
 			dout("ignoring incremental map %u len %d\n",
 			     epoch, maplen);
@@ -1817,7 +1830,10 @@ void ceph_osdc_handle_map(struct ceph_osd_client *osdc, struct ceph_msg *msg)
 					skipped_map = 1;
 				ceph_osdmap_destroy(oldmap);
 			}
-			kick_requests(osdc, skipped_map);
+			was_full = was_full ||
+				ceph_osdmap_flag(osdc->osdmap,
+						 CEPH_OSDMAP_FULL);
+			kick_requests(osdc, skipped_map, was_full);
 		}
 		p += maplen;
 		nr_maps--;
-- 
1.7.10.4

