From: Xi Wang <xi.wang@gmail.com>
Subject: [PATCH 3/3] ceph: avoid panic with mismatched symbolic link sizes in fill_inode()
Date: Wed, 14 Dec 2011 15:24:33 -0500
Message-ID: <1323894273-13904-4-git-send-email-xi.wang@gmail.com>
References: <1323894273-13904-1-git-send-email-xi.wang@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qw0-f53.google.com ([209.85.216.53]:62492 "EHLO
	mail-qw0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755179Ab1LNU0L (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Dec 2011 15:26:11 -0500
Received: by qadb15 with SMTP id b15so829796qad.19
        for <ceph-devel@vger.kernel.org>; Wed, 14 Dec 2011 12:26:10 -0800 (PST)
In-Reply-To: <1323894273-13904-1-git-send-email-xi.wang@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org, Xi Wang <xi.wang@gmail.com>

Return -EINVAL with mismatched iinfo->symlink_len and inode->i_size.

Also use kstrndup rather than kmalloc/memcpy.

Signed-off-by: Xi Wang <xi.wang@gmail.com>
---
 fs/ceph/inode.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 87fb132..d100cd6 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -678,18 +678,18 @@ static int fill_inode(struct inode *inode,
 	case S_IFLNK:
 		inode->i_op = &ceph_symlink_iops;
 		if (!ci->i_symlink) {
-			int symlen = iinfo->symlink_len;
+			u32 symlen = iinfo->symlink_len;
 			char *sym;
 
-			BUG_ON(symlen != inode->i_size);
 			spin_unlock(&ci->i_ceph_lock);
+			err = -EINVAL;
+			if (symlen != inode->i_size)
+				goto out;
 
 			err = -ENOMEM;
-			sym = kmalloc(symlen+1, GFP_NOFS);
+			sym = kstrndup(iinfo->symlink, symlen, GFP_NOFS);
 			if (!sym)
 				goto out;
-			memcpy(sym, iinfo->symlink, symlen);
-			sym[symlen] = 0;
 
 			spin_lock(&ci->i_ceph_lock);
 			if (!ci->i_symlink)
-- 
1.7.5.4

