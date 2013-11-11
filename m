From: Li Wang <liwang@ubuntukylin.com>
Subject: [PATCH 6/7] Cifs: Implement uncaching single no-data page
Date: Mon, 11 Nov 2013 23:27:28 +0800
Message-ID: <08bbf81e5da33b1a4a6ce8af119acfd2fb8a2760.1384183054.git.liwang@ubuntukylin.com>
References: <cover.1384183054.git.liwang@ubuntukylin.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m53-178.qiye.163.com ([123.58.178.53]:52877 "EHLO
	m53-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754480Ab3KKPla (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Nov 2013 10:41:30 -0500
In-Reply-To: <cover.1384183054.git.liwang@ubuntukylin.com>
In-Reply-To: <cover.1384183054.git.liwang@ubuntukylin.com>
References: <cover.1384183054.git.liwang@ubuntukylin.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: ceph-devel@vger.kernel.org, Sage Weil <sage@inktank.com>, linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org, Milosz Tanski <milosz@adfin.com>, Li Wang <liwang@ubuntukylin.com>

Implement the routine for uncaching single no-data page, typically
in readpage().

Signed-off-by: Li Wang <liwang@ubuntukylin.com>
---
 fs/cifs/fscache.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/cifs/fscache.c b/fs/cifs/fscache.c
index 8d4b7bc..168f184 100644
--- a/fs/cifs/fscache.c
+++ b/fs/cifs/fscache.c
@@ -223,6 +223,13 @@ void __cifs_readpage_to_fscache(struct inode *inode, struct page *page)
 		fscache_uncache_page(CIFS_I(inode)->fscache, page);
 }
 
+void __cifs_fscache_readpage_cancel(struct inode *inode, struct page *page)
+{
+        cifs_dbg(FYI, "%s: (fsc: %p, i: %p)\n",
+                 __func__, CIFS_I(inode)->fscache, inode);
+        fscache_readpage_cancel(CIFS_I(inode)->fscache, page);
+}
+
 void __cifs_fscache_readpages_cancel(struct inode *inode, struct list_head *pages)
 {
 	cifs_dbg(FYI, "%s: (fsc: %p, i: %p)\n",
-- 
1.7.9.5

