From: Christos Gkekas <chris.gekas@gmail.com>
Subject: [PATCH] ceph: Delete unused variables in mds_client
Date: Thu, 12 Oct 2017 22:55:11 +0100
Message-ID: <1507845311-28087-1-git-send-email-chris.gekas@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Christos Gkekas <chris.gekas@gmail.com>
List-Id: ceph-devel.vger.kernel.org

Remove variables in mds_client that are set but never used.

Signed-off-by: Christos Gkekas <chris.gekas@gmail.com>
---
 fs/ceph/mds_client.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index f23c820..cadf9b6 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -3797,11 +3797,8 @@ void ceph_mdsc_handle_fsmap(struct ceph_mds_client *mdsc, struct ceph_msg *msg)
 	void *p = msg->front.iov_base;
 	void *end = p + msg->front.iov_len;
 	u32 epoch;
-	u32 map_len;
 	u32 num_fs;
 	u32 mount_fscid = (u32)-1;
-	u8 struct_v, struct_cv;
-	int err = -EINVAL;
 
 	ceph_decode_need(&p, end, sizeof(u32), bad);
 	epoch = ceph_decode_32(&p);
@@ -3809,10 +3806,6 @@ void ceph_mdsc_handle_fsmap(struct ceph_mds_client *mdsc, struct ceph_msg *msg)
 	dout("handle_fsmap epoch %u\n", epoch);
 
 	ceph_decode_need(&p, end, 2 + sizeof(u32), bad);
-	struct_v = ceph_decode_8(&p);
-	struct_cv = ceph_decode_8(&p);
-	map_len = ceph_decode_32(&p);
-
 	ceph_decode_need(&p, end, sizeof(u32) * 3, bad);
 	p += sizeof(u32) * 2; /* skip epoch and legacy_client_fscid */
 
@@ -3820,12 +3813,9 @@ void ceph_mdsc_handle_fsmap(struct ceph_mds_client *mdsc, struct ceph_msg *msg)
 	while (num_fs-- > 0) {
 		void *info_p, *info_end;
 		u32 info_len;
-		u8 info_v, info_cv;
 		u32 fscid, namelen;
 
 		ceph_decode_need(&p, end, 2 + sizeof(u32), bad);
-		info_v = ceph_decode_8(&p);
-		info_cv = ceph_decode_8(&p);
 		info_len = ceph_decode_32(&p);
 		ceph_decode_need(&p, end, info_len, bad);
 		info_p = p;
@@ -3852,7 +3842,6 @@ void ceph_mdsc_handle_fsmap(struct ceph_mds_client *mdsc, struct ceph_msg *msg)
 				   0, true);
 		ceph_monc_renew_subs(&fsc->client->monc);
 	} else {
-		err = -ENOENT;
 		goto err_out;
 	}
 	return;
-- 
2.7.4
