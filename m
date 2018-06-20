From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 2/5] ceph: stop using current_kernel_time()
Date: Wed, 20 Jun 2018 17:50:34 +0200
Message-ID: <20180620155101.57685-2-arnd@arndb.de>
References: <20180620155101.57685-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180620155101.57685-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Yan Zheng <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc: y2038@lists.linaro.org, ceph-devel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Jeff Layton <jlayton@redhat.com>, Chengguang Xu <cgxu519@gmx.com>, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

ceph_mdsc_create_request() is one of the last callers of the
deprecated current_kernel_time() as well as timespec_trunc().

This changes it to use the timespec64 based interfaces instead,
though we still need to convert the result until we are ready to
change over req->r_stamp.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/ceph/mds_client.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index dc8bc664a871..69c839316a7a 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -1779,6 +1779,7 @@ struct ceph_mds_request *
 ceph_mdsc_create_request(struct ceph_mds_client *mdsc, int op, int mode)
 {
 	struct ceph_mds_request *req = kzalloc(sizeof(*req), GFP_NOFS);
+	struct timespec64 ts;
 
 	if (!req)
 		return ERR_PTR(-ENOMEM);
@@ -1797,7 +1798,9 @@ ceph_mdsc_create_request(struct ceph_mds_client *mdsc, int op, int mode)
 	init_completion(&req->r_safe_completion);
 	INIT_LIST_HEAD(&req->r_unsafe_item);
 
-	req->r_stamp = timespec_trunc(current_kernel_time(), mdsc->fsc->sb->s_time_gran);
+	ktime_get_coarse_real_ts64(&ts);
+	req->r_stamp = timespec64_to_timespec(timespec64_trunc(ts,
+						mdsc->fsc->sb->s_time_gran));
 
 	req->r_op = op;
 	req->r_direct_mode = mode;
-- 
2.9.0
