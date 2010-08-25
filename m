From: Dan Carpenter <error27@gmail.com>
Subject: [patch] ceph: ceph_get_inode() returns an ERR_PTR
Date: Wed, 25 Aug 2010 09:11:35 +0200
Message-ID: <20100825071135.GO29330@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:48514 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751631Ab0HYHL7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Aug 2010 03:11:59 -0400
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Yehuda Sadeh <yehuda@hq.newdream.net>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

ceph_get_inode() returns an ERR_PTR and it doesn't return a NULL.

Signed-off-by: Dan Carpenter <error27@gmail.com>

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 5d893d3..1e623ec 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1229,11 +1229,11 @@ retry_lookup:
 			in = dn->d_inode;
 		} else {
 			in = ceph_get_inode(parent->d_sb, vino);
-			if (in == NULL) {
+			if (IS_ERR(in)) {
 				dout("new_inode badness\n");
 				d_delete(dn);
 				dput(dn);
-				err = -ENOMEM;
+				err = PTR_ERR(in);
 				goto out;
 			}
 			dn = splice_dentry(dn, in, NULL);
