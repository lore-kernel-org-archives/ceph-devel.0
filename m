From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] ceph: fix potential double free
Date: Fri, 13 Jul 2012 15:28:48 +0100
Message-ID: <20120713142839.23587.58658.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:33321 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933323Ab2GMOLy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 13 Jul 2012 10:11:54 -0400
Received: from localhost.localdomain (earthlight.etchedpixels.co.uk [81.2.110.250])
	by lxorguk.ukuu.org.uk (8.14.5/8.14.1) with ESMTP id q6DEjKDP015423
	for <ceph-devel@vger.kernel.org>; Fri, 13 Jul 2012 15:45:25 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

From: Alan Cox <alan@linux.intel.com>

We re-run the loop but we don't re-set the attrs pointer back to NULL.

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 fs/ceph/xattr.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index 785cb30..2c2ae5b 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -457,6 +457,7 @@ start:
 			for (i = 0; i < numattr; i++)
 				kfree(xattrs[i]);
 			kfree(xattrs);
+			xattrs = NULL;
 			goto start;
 		}
 		err = -EIO;

