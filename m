From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH] ceph: avoid panic with mismatched symlink sizes in fill_inode()
Date: Tue, 28 Feb 2012 19:59:58 -0800
Message-ID: <4F4DA2BE.3040305@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:40176 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964833Ab2B2D76 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 22:59:58 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id B4C7B24318
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:59:58 -0800 (PST)
Received: from [192.168.107.136] (aon.hq.newdream.net [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id A789F24314
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:59:58 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Return -EINVAL rather than panic if iinfo->symlink_len and inode->i_size
do not match.

Also use kstrndup rather than kmalloc/memcpy.

Signed-off-by: Xi Wang <xi.wang@gmail.com>
Reviewed-by: Alex Elder <elder@dreamhost.com>
---
  fs/ceph/inode.c |   11 ++++++-----
  1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 87fb132..73e0f87 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -678,18 +678,19 @@ static int fill_inode(struct inode *inode,
  	case S_IFLNK:
  		inode->i_op = &ceph_symlink_iops;
  		if (!ci->i_symlink) {
-			int symlen = iinfo->symlink_len;
+			u32 symlen = iinfo->symlink_len;
  			char *sym;

-			BUG_ON(symlen != inode->i_size);
  			spin_unlock(&ci->i_ceph_lock);

+			err = -EINVAL;
+			if (WARN_ON(symlen != inode->i_size))
+				goto out;
+
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

