From: Jeff Layton <jlayton@redhat.com>
Subject: [PATCH v8 1/7] libceph: remove req->r_replay_version
Date: Mon, 17 Apr 2017 12:42:52 -0400
Message-ID: <20170417164258.31527-2-jlayton@redhat.com>
References: <20170417164258.31527-1-jlayton@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41258 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754661AbdDQQnD (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 17 Apr 2017 12:43:03 -0400
In-Reply-To: <20170417164258.31527-1-jlayton@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: idryomov@gmail.com, zyan@redhat.com, sage@redhat.com
Cc: jspray@redhat.com, ceph-devel@vger.kernel.org

Nothing uses this anymore with the removal of the ack vs. commit code.
Remove the field and just encode zeroes into place in the request
encoding.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
Reviewed-by: Ilya Dryomov <idryomov@gmail.com>
---
 include/linux/ceph/osd_client.h | 1 -
 net/ceph/debugfs.c              | 4 +---
 net/ceph/osd_client.c           | 7 ++++---
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index d6a625e75040..3fc9e7754a9b 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -192,7 +192,6 @@ struct ceph_osd_request {
 	unsigned long r_stamp;                /* jiffies, send or check time */
 	unsigned long r_start_stamp;          /* jiffies */
 	int r_attempts;
-	struct ceph_eversion r_replay_version; /* aka reassert_version */
 	u32 r_last_force_resend;
 	u32 r_map_dne_bound;
 
diff --git a/net/ceph/debugfs.c b/net/ceph/debugfs.c
index c62b2b029a6e..d7e63a4f5578 100644
--- a/net/ceph/debugfs.c
+++ b/net/ceph/debugfs.c
@@ -177,9 +177,7 @@ static void dump_request(struct seq_file *s, struct ceph_osd_request *req)
 	seq_printf(s, "%llu\t", req->r_tid);
 	dump_target(s, &req->r_t);
 
-	seq_printf(s, "\t%d\t%u'%llu", req->r_attempts,
-		   le32_to_cpu(req->r_replay_version.epoch),
-		   le64_to_cpu(req->r_replay_version.version));
+	seq_printf(s, "\t%d", req->r_attempts);
 
 	for (i = 0; i < req->r_num_ops; i++) {
 		struct ceph_osd_req_op *op = &req->r_ops[i];
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index b4500a8ab8b3..feb666c22381 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1503,9 +1503,10 @@ static void encode_request(struct ceph_osd_request *req, struct ceph_msg *msg)
 	ceph_encode_32(&p, req->r_flags);
 	ceph_encode_timespec(p, &req->r_mtime);
 	p += sizeof(struct ceph_timespec);
-	/* aka reassert_version */
-	memcpy(p, &req->r_replay_version, sizeof(req->r_replay_version));
-	p += sizeof(req->r_replay_version);
+
+	/* reassert_version */
+	memset(p, 0, sizeof(struct ceph_eversion));
+	p += sizeof(struct ceph_eversion);
 
 	/* oloc */
 	ceph_start_encoding(&p, 5, 4,
-- 
2.9.3

