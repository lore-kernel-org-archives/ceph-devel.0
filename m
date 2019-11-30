From: Deepa Dinamani <deepa.kernel@gmail.com>
Subject: [PATCH 4/7] fs: ceph: Delete timespec64_trunc() usage
Date: Fri, 29 Nov 2019 21:30:27 -0800
Message-ID: <20191130053030.7868-5-deepa.kernel@gmail.com>
References: <20191130053030.7868-1-deepa.kernel@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191130053030.7868-1-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, arnd@arndb.de, jlayton@kernel.org, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Since ceph always uses ns granularity, skip the
truncation which is a no-op.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: jlayton@kernel.org
Cc: ceph-devel@vger.kernel.org
---
 fs/ceph/mds_client.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 068b029cf073..c2aa290f6c3e 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2088,8 +2088,7 @@ ceph_mdsc_create_request(struct ceph_mds_client *mdsc, int op, int mode)
 	init_completion(&req->r_safe_completion);
 	INIT_LIST_HEAD(&req->r_unsafe_item);
 
-	ktime_get_coarse_real_ts64(&ts);
-	req->r_stamp = timespec64_trunc(ts, mdsc->fsc->sb->s_time_gran);
+	ktime_get_coarse_real_ts64(&req->r_stamp);
 
 	req->r_op = op;
 	req->r_direct_mode = mode;
-- 
2.17.1
