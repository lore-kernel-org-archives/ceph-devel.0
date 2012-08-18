From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ceph: divide by zero bug in __validate_layout()
Date: Sat, 18 Aug 2012 18:56:38 +0300
Message-ID: <20120818155638.GC22424@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:46470 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751669Ab2HRP4p (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 18 Aug 2012 11:56:45 -0400
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org, kernel-janitors@vger.kernel.org

If "l->stripe_unit" is zero the the mod on the next line will cause a
divide by zero bug.  This comes from the copy_from_user() in
ceph_ioctl_set_layout_policy()

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/fs/ceph/ioctl.c b/fs/ceph/ioctl.c
index 8e3fb69..81ec22b 100644
--- a/fs/ceph/ioctl.c
+++ b/fs/ceph/ioctl.c
@@ -42,6 +42,7 @@ static long __validate_layout(struct ceph_mds_client *mdsc,
 	/* validate striping parameters */
 	if ((l->object_size & ~PAGE_MASK) ||
 	    (l->stripe_unit & ~PAGE_MASK) ||
+	    (l->stripe_unit == 0) ||
 	    ((unsigned)l->object_size % (unsigned)l->stripe_unit))
 		return -EINVAL;
 
