From: Yanhu Cao <gmayyyha@gmail.com>
Subject: [v2] ceph: use frag's MDS in either mode
Date: Fri, 31 Jul 2020 16:25:13 +0800
Message-ID: <20200731082513.11806-1-gmayyyha@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jlayton@kernel.org
Cc: idryomov@gmail.com, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, Yanhu Cao <gmayyyha@gmail.com>
List-Id: ceph-devel.vger.kernel.org

When doing some tests with multiple mds, there are many
mds forwarding requests between them and then the client request
is resent.

If the request is a modification operation and the mode is set to USE_AUTH_MDS.
Auth mds should be selected to handle the request, and if auth mds for
frag is already set, it can be returned directly without the logic behind it.

But the current logic doesn't return directly because the condition
'mode == USE_AUTH_MDS', and sometimes frag's mds is not equal to
cap's session mds, which then causes the request to be resent.

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
