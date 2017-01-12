From: Jeff Layton <jlayton@redhat.com>
Subject: [PATCH 3/4] ceph: fix bogus endianness change in ceph_ioctl_set_layout
Date: Thu, 12 Jan 2017 11:12:44 -0500
Message-ID: <1484237565-27423-4-git-send-email-jlayton@redhat.com>
References: <1484237565-27423-1-git-send-email-jlayton@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34000 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751201AbdALQMu (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 12 Jan 2017 11:12:50 -0500
In-Reply-To: <1484237565-27423-1-git-send-email-jlayton@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>
Cc: Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org

sparse says:

    fs/ceph/ioctl.c:100:28: warning: cast to restricted __le64

preferred_osd is a __s64 so we don't need to do any conversion. Also,
just remove the cast in ceph_ioctl_get_layout as it's not needed.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 fs/ceph/ioctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/ioctl.c b/fs/ceph/ioctl.c
index 7d752d53353a..4c9c72f26eb9 100644
--- a/fs/ceph/ioctl.c
+++ b/fs/ceph/ioctl.c
@@ -25,7 +25,7 @@ static long ceph_ioctl_get_layout(struct file *file, void __user *arg)
 		l.stripe_count = ci->i_layout.stripe_count;
 		l.object_size = ci->i_layout.object_size;
 		l.data_pool = ci->i_layout.pool_id;
-		l.preferred_osd = (s32)-1;
+		l.preferred_osd = -1;
 		if (copy_to_user(arg, &l, sizeof(l)))
 			return -EFAULT;
 	}
@@ -97,7 +97,7 @@ static long ceph_ioctl_set_layout(struct file *file, void __user *arg)
 		nl.data_pool = ci->i_layout.pool_id;
 
 	/* this is obsolete, and always -1 */
-	nl.preferred_osd = le64_to_cpu(-1);
+	nl.preferred_osd = -1;
 
 	err = __validate_layout(mdsc, &nl);
 	if (err)
-- 
2.7.4

