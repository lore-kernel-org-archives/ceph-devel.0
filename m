From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH] ceph: fix sizeof(struct tYpO *) typo
Date: Fri, 25 Jul 2014 13:26:25 +0400
Message-ID: <1406280385-30275-1-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:63268 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750818AbaGYJ0b (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 Jul 2014 05:26:31 -0400
Received: by mail-la0-f45.google.com with SMTP id ty20so2841114lab.32
        for <ceph-devel@vger.kernel.org>; Fri, 25 Jul 2014 02:26:28 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Yan Zheng <zheng.z.yan@intel.com>

struct ceph_xattr -> struct ceph_inode_xattr

Reported-by: Toralf F=C3=B6rster <toralf.foerster@gmx.de>
Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 fs/ceph/xattr.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index f89698cdbc41..12f58d22e017 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -592,7 +592,7 @@ start:
 		xattr_version =3D ci->i_xattrs.version;
 		spin_unlock(&ci->i_ceph_lock);
=20
-		xattrs =3D kcalloc(numattr, sizeof(struct ceph_xattr *),
+		xattrs =3D kcalloc(numattr, sizeof(struct ceph_inode_xattr *),
 				 GFP_NOFS);
 		err =3D -ENOMEM;
 		if (!xattrs)
--=20
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
