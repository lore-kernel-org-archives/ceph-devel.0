From: Christos Gkekas <chris.gekas@gmail.com>
Subject: [PATCH] ceph: Delete unused variable in mds_client
Date: Sat, 14 Oct 2017 11:01:12 +0100
Message-ID: <1507975272-8264-1-git-send-email-chris.gekas@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Gregory Farnum <gfarnum@redhat.com>, Yan Zheng <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>, linux-kernel@vger.kernel.org
Cc: Christos Gkekas <chris.gekas@gmail.com>
List-Id: ceph-devel.vger.kernel.org

Variable 'err' is set but never used, so should be removed.

Signed-off-by: Christos Gkekas <chris.gekas@gmail.com>
---
 fs/ceph/mds_client.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index f23c820..7cd4fd9 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -3801,7 +3801,6 @@ void ceph_mdsc_handle_fsmap(struct ceph_mds_client *mdsc, struct ceph_msg *msg)
 	u32 num_fs;
 	u32 mount_fscid = (u32)-1;
 	u8 struct_v, struct_cv;
-	int err = -EINVAL;
 
 	ceph_decode_need(&p, end, sizeof(u32), bad);
 	epoch = ceph_decode_32(&p);
@@ -3852,7 +3851,6 @@ void ceph_mdsc_handle_fsmap(struct ceph_mds_client *mdsc, struct ceph_msg *msg)
 				   0, true);
 		ceph_monc_renew_subs(&fsc->client->monc);
 	} else {
-		err = -ENOENT;
 		goto err_out;
 	}
 	return;
-- 
2.7.4
