From: Zhang Zhen <zhenzhang.zhang@huawei.com>
Subject: [PATCH] ceph: remove useless ACL check
Date: Thu, 10 Apr 2014 13:29:17 +0800
Message-ID: <53462C2D.1030803@huawei.com>
References: <1397107160-20844-1-git-send-email-zhenzhang.zhang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:48098 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933287AbaDJF32 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Apr 2014 01:29:28 -0400
In-Reply-To: <1397107160-20844-1-git-send-email-zhenzhang.zhang@huawei.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage@inktank.com
Cc: ceph-devel@vger.kernel.org

posix_acl_xattr_set() already does the check, and it's the only
way to feed in an ACL from userspace.
So the check here is useless, remove it.

Signed-off-by: zhang zhen <zhenzhang.zhang@huawei.com>
---
 fs/ceph/acl.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/ceph/acl.c b/fs/ceph/acl.c
index 21887d6..469f2e8 100644
--- a/fs/ceph/acl.c
+++ b/fs/ceph/acl.c
@@ -104,12 +104,6 @@ int ceph_set_acl(struct inode *inode, struct posix_acl *acl, int type)
 	umode_t new_mode = inode->i_mode, old_mode = inode->i_mode;
 	struct dentry *dentry;

-	if (acl) {
-		ret = posix_acl_valid(acl);
-		if (ret < 0)
-			goto out;
-	}
-
 	switch (type) {
 	case ACL_TYPE_ACCESS:
 		name = POSIX_ACL_XATTR_ACCESS;
-- 
1.8.5.5


.




