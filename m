From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ceph: do_sync is never initialized
Date: Fri, 28 Nov 2014 11:33:34 +0300
Message-ID: <20141128083334.GB10252@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:27476 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751291AbaK1IcF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 28 Nov 2014 03:32:05 -0500
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>, majianpeng@gmail.com
Cc: ceph-devel@vger.kernel.org, kernel-janitors@vger.kernel.org

Probably this code was syncing a lot more often then intended because
the do_sync variable wasn't set to zero.

Fixes: c62988ec0910 ('ceph: avoid meaningless calling ceph_caps_revoking if sync_mode == WB_SYNC_ALL.')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Static checker stuff.  Not tested.  It's surprising that GCC doesn't
catch this.

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 18c06bb..481529b 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -673,7 +673,7 @@ static int ceph_writepages_start(struct address_space *mapping,
 	int rc = 0;
 	unsigned wsize = 1 << inode->i_blkbits;
 	struct ceph_osd_request *req = NULL;
-	int do_sync;
+	int do_sync = 0;
 	u64 truncate_size, snap_size;
 	u32 truncate_seq;
 
