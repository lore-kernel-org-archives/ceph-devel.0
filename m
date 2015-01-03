From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Subject: [PATCH] ceph: acl:  Remove unused function
Date: Sun,  4 Jan 2015 00:44:54 +0100
Message-ID: <1420328694-4609-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:39765 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750929AbbACXlz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 3 Jan 2015 18:41:55 -0500
Received: by mail-wi0-f181.google.com with SMTP id r20so1282817wiv.14
        for <ceph-devel@vger.kernel.org>; Sat, 03 Jan 2015 15:41:53 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org
Cc: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, linux-kernel@vger.kernel.org

Remove the function ceph_get_cached_acl() that is not used anywhere.

This was partially found by using a static code analysis program called cppcheck.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 fs/ceph/acl.c |   14 --------------
 1 file changed, 14 deletions(-)

diff --git a/fs/ceph/acl.c b/fs/ceph/acl.c
index 5bd853b..64fa248 100644
--- a/fs/ceph/acl.c
+++ b/fs/ceph/acl.c
@@ -40,20 +40,6 @@ static inline void ceph_set_cached_acl(struct inode *inode,
 	spin_unlock(&ci->i_ceph_lock);
 }
 
-static inline struct posix_acl *ceph_get_cached_acl(struct inode *inode,
-							int type)
-{
-	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct posix_acl *acl = ACL_NOT_CACHED;
-
-	spin_lock(&ci->i_ceph_lock);
-	if (__ceph_caps_issued_mask(ci, CEPH_CAP_XATTR_SHARED, 0))
-		acl = get_cached_acl(inode, type);
-	spin_unlock(&ci->i_ceph_lock);
-
-	return acl;
-}
-
 struct posix_acl *ceph_get_acl(struct inode *inode, int type)
 {
 	int size;
-- 
1.7.10.4

