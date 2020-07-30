From: Yanhu Cao <gmayyyha@gmail.com>
Subject: [PATCH] ceph: use frag's MDS in either mode
Date: Thu, 30 Jul 2020 19:22:42 +0800
Message-ID: <20200730112242.31648-1-gmayyyha@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jlayton@kernel.org
Cc: idryomov@gmail.com, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, Yanhu Cao <gmayyyha@gmail.com>
List-Id: ceph-devel.vger.kernel.org

if frag.mds != cap->session->s_mds, the client's req will be resent.

e.g.

file: mnt/cephfs/dir03/dir003 (0x10000000003)
ceph.dir.pin="1"

echo 'aaa' > /mnt/cephfs/dir03/dir003/file29

kernel: ceph:  __choose_mds 00000000ca362c7a is_hash=1 (0x7c768b89) mode 2
kernel: ceph:  __choose_mds 00000000ca362c7a 10000000003.fffffffffffffffe frag 0 mds1 (auth)
kernel: ceph:  __choose_mds 00000000ca362c7a 10000000003.fffffffffffffffe mds0 (auth cap 00000000679c38e2)
kernel: ceph:  __choose_mds using resend_mds mds1

Signed-off-by: Yanhu Cao <gmayyyha@gmail.com>
---
 fs/ceph/mds_client.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index a50497142e59..b2255a9be7c0 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -1103,8 +1103,7 @@ static int __choose_mds(struct ceph_mds_client *mdsc,
 				     frag.frag, mds);
 				if (ceph_mdsmap_get_state(mdsc->mdsmap, mds) >=
 				    CEPH_MDS_STATE_ACTIVE) {
-					if (mode == USE_ANY_MDS &&
-					    !ceph_mdsmap_is_laggy(mdsc->mdsmap,
+					if (!ceph_mdsmap_is_laggy(mdsc->mdsmap,
 								  mds))
 						goto out;
 				}
-- 
2.24.3 (Apple Git-128)
