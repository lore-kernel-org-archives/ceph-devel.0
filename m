From: Josh Durgin <josh.durgin@inktank.com>
Subject: [PATCH v2 1/2] libceph: block I/O when PAUSE or FULL osd map flags are set
Date: Wed, 11 Dec 2013 15:02:45 -0800
Message-ID: <1386802966-15531-2-git-send-email-josh.durgin@inktank.com>
References: <1386802966-15531-1-git-send-email-josh.durgin@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:38813 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751203Ab3LKXtk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Dec 2013 18:49:40 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 7CFFC266AE
	for <ceph-devel@vger.kernel.org>; Wed, 11 Dec 2013 15:49:39 -0800 (PST)
Received: from vit.ops.newdream.net (unknown [38.122.20.226])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 6FE94266A4
	for <ceph-devel@vger.kernel.org>; Wed, 11 Dec 2013 15:49:39 -0800 (PST)
In-Reply-To: <1386802966-15531-1-git-send-email-josh.durgin@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The PAUSEWR and PAUSERD flags are meant to stop the cluster from
processing writes and reads, respectively. The FULL flag is set when
the cluster determines that it is out of space, and will no longer
process writes.  PAUSEWR and PAUSERD are purely client-side settings
already implemented in userspace clients. The osd does nothing special
with these flags.

When the FULL flag is set, however, the osd responds to all writes
with -ENOSPC. For cephfs, this makes sense, but for rbd the block
layer translates this into EIO.  If a cluster goes from full to
non-full quickly, a filesystem on top of rbd will not behave well,
since some writes succeed while others get EIO.

Fix this by blocking any writes when the FULL flag is set in the osd
client. This is the same strategy used by userspace, so apply it by
default.  A follow-on patch makes this configurable.

__map_request() is called to re-target osd requests in case the
available osds changed.  Add a paused field to a ceph_osd_request, and
set it whenever an appropriate osd map flag is set.  Avoid queueing
paused requests in __map_request(), but force them to be resent if
they become unpaused.

Also subscribe to the next osd map from the monitor if any of these
flags are set, so paused requests can be unblocked as soon as
possible.

Fixes: http://tracker.ceph.com/issues/6079

Signed-off-by: Josh Durgin <josh.durgin@inktank.com>
---
 include/linux/ceph/osd_client.h |    1 +
 net/ceph/osd_client.c           |   29 +++++++++++++++++++++++++++--
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index 8f47625..4fb6a89 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -138,6 +138,7 @@ struct ceph_osd_request {
 	__le64           *r_request_pool;
 	void             *r_request_pgid;
 	__le32           *r_request_attempts;
+	bool              r_paused;
 	struct ceph_eversion *r_request_reassert_version;
 
 	int               r_result;
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index a17eaae..1ad9866 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1232,6 +1232,22 @@ void ceph_osdc_set_request_linger(struct ceph_osd_client *osdc,
 EXPORT_SYMBOL(ceph_osdc_set_request_linger);
 
 /*
+ * Returns whether a request should be blocked from being sent
+ * based on the current osdmap and osd_client settings.
+ *
+ * Caller should hold map_sem for read.
+ */
+static bool __req_should_be_paused(struct ceph_osd_client *osdc,
+				   struct ceph_osd_request *req)
+{
+	bool pauserd = ceph_osdmap_flag(osdc->osdmap, CEPH_OSDMAP_PAUSERD);
+	bool pausewr = ceph_osdmap_flag(osdc->osdmap, CEPH_OSDMAP_PAUSEWR) ||
+		ceph_osdmap_flag(osdc->osdmap, CEPH_OSDMAP_FULL);
+	return (req->r_flags & CEPH_OSD_FLAG_READ && pauserd) ||
+		(req->r_flags & CEPH_OSD_FLAG_WRITE && pausewr);
+}
+
+/*
  * Pick an osd (the first 'up' osd in the pg), allocate the osd struct
  * (as needed), and set the request r_osd appropriately.  If there is
  * no up osd, set r_osd to NULL.  Move the request to the appropriate list
@@ -1248,6 +1264,7 @@ static int __map_request(struct ceph_osd_client *osdc,
 	int acting[CEPH_PG_MAX_SIZE];
 	int o = -1, num = 0;
 	int err;
+	bool was_paused;
 
 	dout("map_request %p tid %lld\n", req, req->r_tid);
 	err = ceph_calc_ceph_pg(&pgid, req->r_oid, osdc->osdmap,
@@ -1264,12 +1281,18 @@ static int __map_request(struct ceph_osd_client *osdc,
 		num = err;
 	}
 
+	was_paused = req->r_paused;
+	req->r_paused = __req_should_be_paused(osdc, req);
+	if (was_paused && !req->r_paused)
+		force_resend = 1;
+
 	if ((!force_resend &&
 	     req->r_osd && req->r_osd->o_osd == o &&
 	     req->r_sent >= req->r_osd->o_incarnation &&
 	     req->r_num_pg_osds == num &&
 	     memcmp(req->r_pg_osds, acting, sizeof(acting[0])*num) == 0) ||
-	    (req->r_osd == NULL && o == -1))
+	    (req->r_osd == NULL && o == -1) ||
+	    req->r_paused)
 		return 0;  /* no change */
 
 	dout("map_request tid %llu pgid %lld.%x osd%d (was osd%d)\n",
@@ -1811,7 +1834,9 @@ done:
 	 * we find out when we are no longer full and stop returning
 	 * ENOSPC.
 	 */
-	if (ceph_osdmap_flag(osdc->osdmap, CEPH_OSDMAP_FULL))
+	if (ceph_osdmap_flag(osdc->osdmap, CEPH_OSDMAP_FULL) ||
+		ceph_osdmap_flag(osdc->osdmap, CEPH_OSDMAP_PAUSERD) ||
+		ceph_osdmap_flag(osdc->osdmap, CEPH_OSDMAP_PAUSEWR))
 		ceph_monc_request_next_osdmap(&osdc->client->monc);
 
 	mutex_lock(&osdc->request_mutex);
-- 
1.7.10.4

