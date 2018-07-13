From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 5/5] ceph: use 64-bit timespec for r_stamp
Date: Fri, 13 Jul 2018 22:18:38 +0200
Message-ID: <20180713201923.3200799-5-arnd@arndb.de>
References: <20180713201923.3200799-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180713201923.3200799-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Ilya Dryomov <idryomov@gmail.com>, Yan Zheng <zyan@redhat.com>, Sage Weil <sage@redhat.com>
Cc: y2038@lists.linaro.org, linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Jeff Layton <jlayton@redhat.com>, Luis Henriques <lhenriques@suse.com>, Deepa Dinamani <deepa.kernel@gmail.com>, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

The ceph_mds_request stamp still uses the deprecated timespec structure,
this converts it over as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/ceph/inode.c      | 2 +-
 fs/ceph/mds_client.c | 7 +++----
 fs/ceph/mds_client.h | 2 +-
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 715a6f2a4613..d62f65f2875d 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -2136,7 +2136,7 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr)
 		req->r_inode_drop = release;
 		req->r_args.setattr.mask = cpu_to_le32(mask);
 		req->r_num_caps = 1;
-		req->r_stamp = timespec64_to_timespec(attr->ia_ctime);
+		req->r_stamp = attr->ia_ctime;
 		err = ceph_mdsc_do_request(mdsc, NULL, req);
 	}
 	dout("setattr %p result=%d (%s locally, %d remote)\n", inode, err,
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 580644b04737..09142d309912 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -1799,8 +1799,7 @@ ceph_mdsc_create_request(struct ceph_mds_client *mdsc, int op, int mode)
 	INIT_LIST_HEAD(&req->r_unsafe_item);
 
 	ktime_get_coarse_real_ts64(&ts);
-	req->r_stamp = timespec64_to_timespec(timespec64_trunc(ts,
-						mdsc->fsc->sb->s_time_gran));
+	req->r_stamp = timespec64_trunc(ts, mdsc->fsc->sb->s_time_gran);
 
 	req->r_op = op;
 	req->r_direct_mode = mode;
@@ -2097,7 +2096,7 @@ static struct ceph_msg *create_request_message(struct ceph_mds_client *mdsc,
 	/* time stamp */
 	{
 		struct ceph_timespec ts;
-		ceph_encode_timespec(&ts, &req->r_stamp);
+		ceph_encode_timespec64(&ts, &req->r_stamp);
 		ceph_encode_copy(&p, &ts, sizeof(ts));
 	}
 
@@ -2190,7 +2189,7 @@ static int __prepare_send_request(struct ceph_mds_client *mdsc,
 		p = msg->front.iov_base + req->r_request_release_offset;
 		{
 			struct ceph_timespec ts;
-			ceph_encode_timespec(&ts, &req->r_stamp);
+			ceph_encode_timespec64(&ts, &req->r_stamp);
 			ceph_encode_copy(&p, &ts, sizeof(ts));
 		}
 
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 2ec3b5b35067..80a7523e1523 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -229,7 +229,7 @@ struct ceph_mds_request {
 	int r_fmode;        /* file mode, if expecting cap */
 	kuid_t r_uid;
 	kgid_t r_gid;
-	struct timespec r_stamp;
+	struct timespec64 r_stamp;
 
 	/* for choosing which mds to send this request to */
 	int r_direct_mode;
-- 
2.9.0
