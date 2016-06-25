From: Deepa Dinamani <deepa.kernel@gmail.com>
Subject: [PATCH v3 21/24] libceph: Replace CURRENT_TIME with ktime_get_real_ts
Date: Sat, 25 Jun 2016 14:37:45 -0700
Message-ID: <1466890668-23400-22-git-send-email-deepa.kernel@gmail.com>
References: <1466890668-23400-1-git-send-email-deepa.kernel@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466890668-23400-1-git-send-email-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, tglx@linutronix.de, torvalds@linux-foundation.org, tytso@mit.edu, viro@zeniv.linux.org.uk, y2038@lists.linaro.org, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

CURRENT_TIME is not y2038 safe.
The macro will be deleted and all the references to it
will be replaced by ktime_get_* apis.

struct timespec is also not y2038 safe.
Retain timespec for timestamp representation here as ceph
uses it internally everywhere.
These references will be changed to use struct timespec64
in a separate patch.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: "Yan, Zheng" <zyan@redhat.com>
Cc: Sage Weil <sage@redhat.com>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org
---
 net/ceph/messenger.c  | 6 ++++--
 net/ceph/osd_client.c | 4 ++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index a550289..1825eed 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -1366,8 +1366,9 @@ static void prepare_write_keepalive(struct ceph_connection *con)
 	dout("prepare_write_keepalive %p\n", con);
 	con_out_kvec_reset(con);
 	if (con->peer_features & CEPH_FEATURE_MSGR_KEEPALIVE2) {
-		struct timespec now = CURRENT_TIME;
+		struct timespec now;
 
+		ktime_get_real_ts(&now);
 		con_out_kvec_add(con, sizeof(tag_keepalive2), &tag_keepalive2);
 		ceph_encode_timespec(&con->out_temp_keepalive2, &now);
 		con_out_kvec_add(con, sizeof(con->out_temp_keepalive2),
@@ -3149,8 +3150,9 @@ bool ceph_con_keepalive_expired(struct ceph_connection *con,
 {
 	if (interval > 0 &&
 	    (con->peer_features & CEPH_FEATURE_MSGR_KEEPALIVE2)) {
-		struct timespec now = CURRENT_TIME;
+		struct timespec now;
 		struct timespec ts;
+		ktime_get_real_ts(&now);
 		jiffies_to_timespec(interval, &ts);
 		ts = timespec_add(con->last_keepalive_ack, ts);
 		return timespec_compare(&now, &ts) >= 0;
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 8946959..44eb2d0 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -3567,7 +3567,7 @@ ceph_osdc_watch(struct ceph_osd_client *osdc,
 	ceph_oid_copy(&lreq->t.base_oid, oid);
 	ceph_oloc_copy(&lreq->t.base_oloc, oloc);
 	lreq->t.flags = CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ONDISK;
-	lreq->mtime = CURRENT_TIME;
+	ktime_get_real_ts(&lreq->mtime);
 
 	lreq->reg_req = alloc_linger_request(lreq);
 	if (!lreq->reg_req) {
@@ -3625,7 +3625,7 @@ int ceph_osdc_unwatch(struct ceph_osd_client *osdc,
 	ceph_oid_copy(&req->r_base_oid, &lreq->t.base_oid);
 	ceph_oloc_copy(&req->r_base_oloc, &lreq->t.base_oloc);
 	req->r_flags = CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ONDISK;
-	req->r_mtime = CURRENT_TIME;
+	ktime_get_real_ts(&req->r_mtime);
 	osd_req_op_watch_init(req, 0, lreq->linger_id,
 			      CEPH_OSD_WATCH_OP_UNWATCH);
 
-- 
1.9.1
