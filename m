From: Zhang Zhen <zhenzhang.zhang@huawei.com>
Subject: [PATCH] ceph: delete unnecessary condition judgment
Date: Mon, 28 Apr 2014 14:27:59 +0800
Message-ID: <535DF4EF.8060703@huawei.com>
References: <1398666300-28368-1-git-send-email-zhenzhang.zhang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:39604 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751655AbaD1G2n (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Apr 2014 02:28:43 -0400
In-Reply-To: <1398666300-28368-1-git-send-email-zhenzhang.zhang@huawei.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage@inktank.com, ukernel@gmail.com
Cc: ceph-devel@vger.kernel.org

If the return number of ceph_osdc_readpages() is not
less than zero, it is certainly greater than or
equal to zero.

So the condition judgment is unnecessary.

Signed-off-by: Zhang Zhen <zhenzhang.zhang@huawei.com>
---
 fs/ceph/addr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index b53278c..8f579d2 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -221,8 +221,7 @@ static int readpage_nounlock(struct file *filp, struct page *page)
 	}
 	SetPageUptodate(page);

-	if (err >= 0)
-		ceph_readpage_to_fscache(inode, page);
+	ceph_readpage_to_fscache(inode, page);

 out:
 	return err < 0 ? err : 0;
-- 
1.8.1.2


.




