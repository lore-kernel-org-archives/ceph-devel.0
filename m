From: Li Wang <liwang@ubuntukylin.com>
Subject: [PATCH 4/7] Ceph: Uncaching no-data page in readpage()
Date: Mon, 11 Nov 2013 23:27:26 +0800
Message-ID: <1328cc859d1b2d40786fc3aa634a36764b286e70.1384183054.git.liwang@ubuntukylin.com>
References: <cover.1384183054.git.liwang@ubuntukylin.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m53-178.qiye.163.com ([123.58.178.53]:52857 "EHLO
	m53-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754444Ab3KKPl1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Nov 2013 10:41:27 -0500
In-Reply-To: <cover.1384183054.git.liwang@ubuntukylin.com>
In-Reply-To: <cover.1384183054.git.liwang@ubuntukylin.com>
References: <cover.1384183054.git.liwang@ubuntukylin.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: ceph-devel@vger.kernel.org, Sage Weil <sage@inktank.com>, linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org, Milosz Tanski <milosz@adfin.com>, Li Wang <liwang@ubuntukylin.com>

Currently, if one page allocated into fscache in readpage(), however, with
no-data read, it is not uncached. This patch fixes this.

Signed-off-by: Li Wang <liwang@ubuntukylin.com>
---
 fs/ceph/addr.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 6df8bd4..be5f4b6 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -209,6 +209,7 @@ static int readpage_nounlock(struct file *filp, struct page *page)
 		err = 0;
 	if (err < 0) {
 		SetPageError(page);
+		ceph_fscache_readpage_cancel(inode, page);
 		goto out;
 	} else if (err < PAGE_CACHE_SIZE) {
 		/* zero fill remainder of page */
-- 
1.7.9.5

