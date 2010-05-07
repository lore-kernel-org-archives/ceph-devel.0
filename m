From: Dan Carpenter <error27@gmail.com>
Subject: [patch] ceph: cleanup: remove unused assignement
Date: Fri, 7 May 2010 10:27:14 +0200
Message-ID: <20100507082713.GQ27064@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45421 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753915Ab0EGI1S (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 May 2010 04:27:18 -0400
Received: by wyg36 with SMTP id 36so610579wyg.19
        for <ceph-devel@vger.kernel.org>; Fri, 07 May 2010 01:27:16 -0700 (PDT)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Yehuda Sadeh <yehuda@hq.newdream.net>, ceph-devel@vger.kernel.org

We don't ever use "dirty" so we can remove it.

Signed-off-by: Dan Carpenter <error27@gmail.com>

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 0c16818..a8db1a6 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -1711,10 +1711,9 @@ out_unlocked:
 static int caps_are_flushed(struct inode *inode, unsigned tid)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	int dirty, i, ret = 1;
+	int i, ret = 1;
 
 	spin_lock(&inode->i_lock);
-	dirty = __ceph_caps_dirty(ci);
 	for (i = 0; i < CEPH_CAP_BITS; i++)
 		if ((ci->i_flushing_caps & (1 << i)) &&
 		    ci->i_cap_flush_tid[i] <= tid) {
