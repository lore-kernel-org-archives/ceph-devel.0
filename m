From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH] ceph: fix setting empty extended attribute
Date: Wed, 17 Dec 2014 21:42:35 +0800
Message-ID: <1418823755-25690-1-git-send-email-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41852 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752005AbaLQNn2 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 17 Dec 2014 08:43:28 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id sBHDhSUi017686
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <ceph-devel@vger.kernel.org>; Wed, 17 Dec 2014 08:43:28 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zyan@redhat.com>

make sure 'value' is not null. otherwise __ceph_setxattr will remove
the extended attribute.

Signed-off-by: Yan, Zheng <zyan@redhat.com>
---
 fs/ceph/xattr.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index 678b0d2..5a492ca 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -854,7 +854,7 @@ static int ceph_sync_setxattr(struct dentry *dentry, const char *name,
 	struct ceph_pagelist *pagelist = NULL;
 	int err;
 
-	if (value) {
+	if (size > 0) {
 		/* copy value into pagelist */
 		pagelist = kmalloc(sizeof(*pagelist), GFP_NOFS);
 		if (!pagelist)
@@ -864,7 +864,7 @@ static int ceph_sync_setxattr(struct dentry *dentry, const char *name,
 		err = ceph_pagelist_append(pagelist, value, size);
 		if (err)
 			goto out;
-	} else {
+	} else if (!value) {
 		flags |= CEPH_XATTR_REMOVE;
 	}
 
@@ -1001,6 +1001,9 @@ int ceph_setxattr(struct dentry *dentry, const char *name,
 	if (!strncmp(name, XATTR_SYSTEM_PREFIX, XATTR_SYSTEM_PREFIX_LEN))
 		return generic_setxattr(dentry, name, value, size, flags);
 
+	if (size == 0)
+		value = "";  /* empty EA, do not remove */
+
 	return __ceph_setxattr(dentry, name, value, size, flags);
 }
 
-- 
1.9.3

