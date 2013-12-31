From: Sage Weil <sage@inktank.com>
Subject: [PATCH 4/4] ceph: allocate non-zero page to fscache in readpage()
Date: Mon, 30 Dec 2013 16:13:51 -0800
Message-ID: <1388448831-10324-5-git-send-email-sage@inktank.com>
References: <1388448831-10324-1-git-send-email-sage@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34246 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932405Ab3LaAOA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Dec 2013 19:14:00 -0500
In-Reply-To: <1388448831-10324-1-git-send-email-sage@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: stable@vger.kernel.org
Cc: ceph-devel@vger.kernel.org, Li Wang <liwang@ubuntukylin.com>

From: Li Wang <liwang@ubuntukylin.com>

ceph_osdc_readpages() returns number of bytes read, currently,
the code only allocate full-zero page into fscache, this patch
fixes this.

Signed-off-by: Li Wang <liwang@ubuntukylin.com>
Reviewed-by: Milosz Tanski <milosz@adfin.com>
Reviewed-by: Sage Weil <sage@inktank.com>
(cherry picked from commit ff638b7df5a9264024a6448bdfde2b2bf5d1994a)
---
 fs/ceph/addr.c | 2 +-
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
1.8.5.1

