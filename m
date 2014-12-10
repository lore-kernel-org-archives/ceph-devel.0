From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH] ceph: fix mksnap crash
Date: Wed, 10 Dec 2014 19:54:39 +0800
Message-ID: <1418212479-17714-1-git-send-email-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42646 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750911AbaLJLyu (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 10 Dec 2014 06:54:50 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id sBABsoo8006642
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <ceph-devel@vger.kernel.org>; Wed, 10 Dec 2014 06:54:50 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zyan@redhat.com>

mksnap reply only contain 'target', does not contain 'dentry'. So
it's wrong to use req->r_reply_info.head->is_dentry to detect traceless
reply.

Signed-off-by: Yan, Zheng <zyan@redhat.com>
---
 fs/ceph/dir.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 6526199..fcfd0ab 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -812,7 +812,9 @@ static int ceph_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 		acls.pagelist = NULL;
 	}
 	err = ceph_mdsc_do_request(mdsc, dir, req);
-	if (!err && !req->r_reply_info.head->is_dentry)
+	if (!err &&
+	    !req->r_reply_info.head->is_target &&
+	    !req->r_reply_info.head->is_dentry)
 		err = ceph_handle_notrace_create(dir, dentry);
 	ceph_mdsc_put_request(req);
 out:
-- 
1.9.3

