From: Milosz Tanski <milosz@adfin.com>
Subject: [PATCH 8/8] ceph: Do not do invalidate if the
 filesystem is mounted nofsc
Date: Thu, 5 Sep 2013 18:23:19 -0400
Message-ID: <ed0af89bd01410f38f017ad4de6e1bd94c79e738.1378418255.git.milosz@adfin.com>
References: <cover.1378418255.git.milosz@adfin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-cachefs-bounces@redhat.com>
Content-Disposition: inline
In-Reply-To: <cover.1378418255.git.milosz@adfin.com>
List-Unsubscribe: <https://www.redhat.com/mailman/options/linux-cachefs>,
	<mailto:linux-cachefs-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/archives/linux-cachefs>
List-Post: <mailto:linux-cachefs@redhat.com>
List-Help: <mailto:linux-cachefs-request@redhat.com?subject=help>
List-Subscribe: <https://www.redhat.com/mailman/listinfo/linux-cachefs>,
	<mailto:linux-cachefs-request@redhat.com?subject=subscribe>
Sender: linux-cachefs-bounces@redhat.com
Errors-To: linux-cachefs-bounces@redhat.com
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com, zheng.z.yan@intel.com
List-Id: ceph-devel.vger.kernel.org

Previously we would always try to enqueue work even if the filesystem is not
mounted with fscache enabled (or the file has no cookie). In the case of the
filesystem mouned nofsc (but with fscache compiled in) this would lead to a
crash.

Signed-off-by: Milosz Tanski <milosz@adfin.com>
---
 fs/ceph/cache.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ceph/cache.c b/fs/ceph/cache.c
index c737ae9..d3b88c7 100644
--- a/fs/ceph/cache.c
+++ b/fs/ceph/cache.c
@@ -374,8 +374,12 @@ out:
 
 void ceph_queue_revalidate(struct inode *inode)
 {
+	struct ceph_fs_client *fsc = ceph_sb_to_client(inode->i_sb);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 
+	if (fsc->revalidate_wq == NULL || ci->fscache == NULL)
+		return;
+
 	ihold(inode);
 
 	if (queue_work(ceph_sb_to_client(inode->i_sb)->revalidate_wq,
-- 
1.7.9.5
