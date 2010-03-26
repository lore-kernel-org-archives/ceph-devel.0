From: Cheng Renquan <crquan@gmail.com>
Subject: [PATCH] ceph: handle kzalloc() failure
Date: Fri, 26 Mar 2010 18:04:40 +0800
Message-ID: <1269597880-6125-1-git-send-email-crquan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@lists.sourceforge.net
List-Id: ceph-devel.vger.kernel.org

Signed-off-by: Cheng Renquan <crquan@gmail.com>
---
 fs/ceph/mds_client.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 5268d40..5a209d9 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2614,6 +2614,9 @@ int ceph_mdsc_init(struct ceph_mds_client *mdsc, struct ceph_client *client)
 	mdsc->client = client;
 	mutex_init(&mdsc->mutex);
 	mdsc->mdsmap = kzalloc(sizeof(*mdsc->mdsmap), GFP_NOFS);
+	if (mdsc->mdsmap == NULL)
+		return -ENOMEM;
+
 	init_completion(&mdsc->safe_umount_waiters);
 	init_completion(&mdsc->session_close_waiters);
 	INIT_LIST_HEAD(&mdsc->waiting_for_map);
@@ -2639,6 +2642,7 @@ int ceph_mdsc_init(struct ceph_mds_client *mdsc, struct ceph_client *client)
 	init_waitqueue_head(&mdsc->cap_flushing_wq);
 	spin_lock_init(&mdsc->dentry_lru_lock);
 	INIT_LIST_HEAD(&mdsc->dentry_lru);
+
 	return 0;
 }
 
-- 
1.7.0.2


------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
