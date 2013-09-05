From: Milosz Tanski <milosz@adfin.com>
Subject: [PATCH 6/8] ceph: ceph_readpage_to_fscache didn't
	check if marked
Date: Thu, 5 Sep 2013 18:22:49 -0400
Message-ID: <0df1c53e0a04f0358496d31c54d691651d04a1e1.1378418255.git.milosz@adfin.com>
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

Previously ceph_readpage_to_fscache did not call if page was marked as cached
before calling fscache_write_page resulting in a BUG inside of fscache.

FS-Cache: Assertion failed
------------[ cut here ]------------
kernel BUG at fs/fscache/page.c:874!
invalid opcode: 0000 [#1] SMP
Call Trace:
 [<ffffffffa02e6566>] __ceph_readpage_to_fscache+0x66/0x80 [ceph]
 [<ffffffffa02caf84>] readpage_nounlock+0x124/0x210 [ceph]
 [<ffffffffa02cb08d>] ceph_readpage+0x1d/0x40 [ceph]
 [<ffffffff81126db6>] generic_file_aio_read+0x1f6/0x700
 [<ffffffffa02c6fcc>] ceph_aio_read+0x5fc/0xab0 [ceph]

Signed-off-by: Milosz Tanski <milosz@adfin.com>
Signed-off-by: Sage Weil <sage@inktank.com>
---
 fs/ceph/cache.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ceph/cache.c b/fs/ceph/cache.c
index 5c413ec..c737ae9 100644
--- a/fs/ceph/cache.c
+++ b/fs/ceph/cache.c
@@ -311,6 +311,9 @@ void ceph_readpage_to_fscache(struct inode *inode, struct page *page)
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	int ret;
 
+	if (!PageFsCache(page))
+		return;
+
 	if (!cache_valid(ci))
 		return;
 
-- 
1.7.9.5
