From: Yanhu Cao <gmayyyha@gmail.com>
Subject: [v3] ceph: if we are blacklisted, __do_request returns directly
Date: Fri, 17 Apr 2020 19:07:23 +0800
Message-ID: <20200417110723.12235-1-gmayyyha@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jlayton@kernel.org
Cc: sage@redhat.com, idryomov@gmail.com, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, Yanhu Cao <gmayyyha@gmail.com>
List-Id: ceph-devel.vger.kernel.org

If we mount cephfs by the recover_session option,
__do_request can return directly until the client automatically reconnects.

Signed-off-by: Yanhu Cao <gmayyyha@gmail.com>
---
 fs/ceph/mds_client.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 486f91f9685b..16ac5e5f7f79 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2708,6 +2708,12 @@ static void __do_request(struct ceph_mds_client *mdsc,
 
 	put_request_session(req);
 
+	if (mdsc->fsc->blacklisted &&
+	    ceph_test_mount_opt(mdsc->fsc, CLEANRECOVER)) {
+		err = -EBLACKLISTED;
+		goto finish;
+	}
+
 	mds = __choose_mds(mdsc, req, &random);
 	if (mds < 0 ||
 	    ceph_mdsmap_get_state(mdsc->mdsmap, mds) < CEPH_MDS_STATE_ACTIVE) {
-- 
2.24.2 (Apple Git-127)
