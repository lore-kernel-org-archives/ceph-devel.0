From: Li Wang <liwang@ubuntukylin.com>
Subject: [PATCH] Ceph: allocate non-zero page to fscache in readpage()
Date: Sat,  9 Nov 2013 10:26:06 +0800
Message-ID: <1383963966-10888-1-git-send-email-liwang@ubuntukylin.com>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: ceph-devel@vger.kernel.org
Cc: linux-cachefs@redhat.com, Sage Weil <sage@inktank.com>, Milosz Tanski <milosz@adfin.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Li Wang <liwang@ubuntukylin.com>
List-Id: ceph-devel.vger.kernel.org

ceph_osdc_readpages() returns number of bytes read, currently,
the code only allocate full-zero page into fscache, this patch
fixes this.

Signed-off-by: Li Wang <liwang@ubuntukylin.com>
---
 fs/ceph/addr.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 6df8bd4..1e561c0 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -216,7 +216,7 @@ static int readpage_nounlock(struct file *filp, struct page *page)
 	}
 	SetPageUptodate(page);
 
-	if (err == 0)
+	if (err >= 0)
 		ceph_readpage_to_fscache(inode, page);
 
 out:
-- 
1.7.9.5

