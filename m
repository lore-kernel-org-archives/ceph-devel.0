From: Jan Kara <jack@suse.cz>
Subject: [PATCH 5/5] fs: Avoid premature clearing of capabilities
Date: Mon, 19 Sep 2016 17:30:59 +0200
Message-ID: <1474299059-14806-6-git-send-email-jack@suse.cz>
References: <1474299059-14806-1-git-send-email-jack@suse.cz>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:34529 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751207AbcISPbQ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 19 Sep 2016 11:31:16 -0400
In-Reply-To: <1474299059-14806-1-git-send-email-jack@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org, xfs@oss.sgi.org, Dave Chinner <david@fromorbit.com>, Ilya Dryomov <idryomov@gmail.com>, Sage Weil <sage@redhat.com>, "Yan, Zheng" <zyan@redhat.com>, ceph-devel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>

Currently, notify_change() clears capabilities or IMA attributes by
calling security_inode_killpriv() before calling into ->setattr. Thus it
happens before any other permission checks in inode_change_ok() and user
is thus allowed to trigger clearing of capabilities or IMA attributes
for any file he can look up e.g. by calling chown for that file. This is
unexpected and can lead to user DoSing a system.

Fix the problem by calling security_inode_killpriv() at the end of
inode_change_ok() instead of from notify_change(). At that moment we are
sure user has permissions to do the requested change.

References: CVE-2015-1350
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/attr.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index 5c45909ea204..83c8430d908f 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -47,7 +47,7 @@ int setattr_prepare(struct dentry *dentry, struct iattr *attr)
 
 	/* If force is set do it anyway. */
 	if (ia_valid & ATTR_FORCE)
-		return 0;
+		goto kill_priv;
 
 	/* Make sure a caller can chown. */
 	if ((ia_valid & ATTR_UID) &&
@@ -80,6 +80,16 @@ int setattr_prepare(struct dentry *dentry, struct iattr *attr)
 			return -EPERM;
 	}
 
+kill_priv:
+	/* User has permission for the change */
+	if (ia_valid & ATTR_KILL_PRIV) {
+		int error;
+
+		error = security_inode_killpriv(dentry);
+		if (error)
+			return error;
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL(setattr_prepare);
@@ -220,13 +230,11 @@ int notify_change(struct dentry * dentry, struct iattr * attr, struct inode **de
 	if (!(ia_valid & ATTR_MTIME_SET))
 		attr->ia_mtime = now;
 	if (ia_valid & ATTR_KILL_PRIV) {
-		attr->ia_valid &= ~ATTR_KILL_PRIV;
-		ia_valid &= ~ATTR_KILL_PRIV;
 		error = security_inode_need_killpriv(dentry);
-		if (error > 0)
-			error = security_inode_killpriv(dentry);
-		if (error)
+		if (error < 0)
 			return error;
+		if (error == 0)
+			ia_valid = attr->ia_valid &= ~ATTR_KILL_PRIV;
 	}
 
 	/*
-- 
2.6.6

