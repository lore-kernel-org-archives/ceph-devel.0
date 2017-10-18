From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ceph: remove unused and redundant variable dropping
Date: Wed, 18 Oct 2017 12:34:25 +0100
Message-ID: <20171018113425.28658-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: zyan@redhat.com, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable dropping is set but never read and hence is redundant
and can be removed. Cleans up clang warning:

fs/ceph/caps.c:1170:2: warning: Value stored to 'dropping' is never read

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/ceph/caps.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 157fe59fbabe..14df41e3751c 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -1159,7 +1159,7 @@ static int __send_cap(struct ceph_mds_client *mdsc, struct ceph_cap *cap,
 	struct ceph_inode_info *ci = cap->ci;
 	struct inode *inode = &ci->vfs_inode;
 	struct cap_msg_args arg;
-	int held, revoking, dropping;
+	int held, revoking;
 	int wake = 0;
 	int delayed = 0;
 	int ret;
@@ -1167,7 +1167,6 @@ static int __send_cap(struct ceph_mds_client *mdsc, struct ceph_cap *cap,
 	held = cap->issued | cap->implemented;
 	revoking = cap->implemented & ~cap->issued;
 	retain &= ~revoking;
-	dropping = cap->issued & ~retain;
 
 	dout("__send_cap %p cap %p session %p %s -> %s (revoking %s)\n",
 	     inode, cap, cap->session,
-- 
2.14.1
