From: Sage Weil <sage@inktank.com>
Subject: [PATCH 4/4] ceph: avoid divide by zero in __validate_layout()
Date: Tue, 21 Aug 2012 12:19:32 -0700
Message-ID: <1345576772-3284-5-git-send-email-sage@inktank.com>
References: <1345576772-3284-1-git-send-email-sage@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42596 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756641Ab2HUTHT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Aug 2012 15:07:19 -0400
In-Reply-To: <1345576772-3284-1-git-send-email-sage@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>

If "l->stripe_unit" is zero the the mod on the next line will cause a
divide by zero bug.  This comes from the copy_from_user() in
ceph_ioctl_set_layout_policy().  Passing 0 is valid, though (it means
"do not change") so avoid the % check in that case.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Sage Weil <sage@inktank.com>
Reviewed-by: Alex Elder <elder@inktank.com>
---
 fs/ceph/ioctl.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/fs/ceph/ioctl.c b/fs/ceph/ioctl.c
index 8e3fb69..1396ceb 100644
--- a/fs/ceph/ioctl.c
+++ b/fs/ceph/ioctl.c
@@ -42,7 +42,8 @@ static long __validate_layout(struct ceph_mds_client *mdsc,
 	/* validate striping parameters */
 	if ((l->object_size & ~PAGE_MASK) ||
 	    (l->stripe_unit & ~PAGE_MASK) ||
-	    ((unsigned)l->object_size % (unsigned)l->stripe_unit))
+	    (l->stripe_unit != 0 &&
+	     ((unsigned)l->object_size % (unsigned)l->stripe_unit)))
 		return -EINVAL;
 
 	/* make sure it's a valid data pool */
-- 
1.7.9

