From: Li Wang <liwang@ubuntukylin.com>
Subject: [PATCH 2/2] ceph fscache: Uncaching no data page from fscache in readpage()
Date: Thu, 19 Dec 2013 06:03:49 -0800
Message-ID: <fe9e6fbe07dfdd26c16aa577758a9f4f799c5dfe.1387461299.git.liwang@ubuntukylin.com>
References: <cover.1387461299.git.liwang@ubuntukylin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1387461299.git.liwang@ubuntukylin.com>
In-Reply-To: <cover.1387461299.git.liwang@ubuntukylin.com>
References: <cover.1387461299.git.liwang@ubuntukylin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, Milosz Tanski <milosz@adfin.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Li Wang <liwang@ubuntukylin.com>
List-Id: ceph-devel.vger.kernel.org

Currently, if one new page allocated into fscache in readpage(), however, 
with no data read into due to error encountered during reading from OSDs, 
the slot in fscache is not uncached. This patch fixes this.

Signed-off-by: Li Wang <liwang@ubuntukylin.com>
---
 fs/ceph/addr.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index ec3ba43..0cc9749 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -209,6 +209,7 @@ static int readpage_nounlock(struct file *filp, struct page *page)
 		err = 0;
 	if (err < 0) {
 		SetPageError(page);
+		ceph_fscache_readpage_cancel(inode, page);
 		goto out;
 	} else {
 		if (err < PAGE_CACHE_SIZE) {
-- 
1.7.9.5
