From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH] ceph: initialize pathbase in the !dentry case in encode_caps_cb()
Date: Tue,  9 Aug 2016 16:43:35 +0200
Message-ID: <1470753815-5848-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:35044 "EHLO
	mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752748AbcHIOoA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Aug 2016 10:44:00 -0400
Received: by mail-yw0-f195.google.com with SMTP id r9so597010ywg.2
        for <ceph-devel@vger.kernel.org>; Tue, 09 Aug 2016 07:44:00 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Zheng Yan <zyan@redhat.com>

pathbase is the base inode; set it to 0 if we've got no path.

Coverity-id: 146348
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 fs/ceph/mds_client.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index fa59a85226b2..f72d4ae303b2 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2759,6 +2759,7 @@ static int encode_caps_cb(struct inode *inode, struct ceph_cap *cap,
 	} else {
 		path = NULL;
 		pathlen = 0;
+		pathbase = 0;
 	}
 
 	spin_lock(&ci->i_ceph_lock);
-- 
2.4.3

