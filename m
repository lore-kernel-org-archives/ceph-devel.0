From: Chengguang Xu <cgxu519@icloud.com>
Subject: [PATCH] ceph: keep consistent semantic in fscache related option
 combination
Date: Wed, 07 Feb 2018 10:27:06 +0800
Message-ID: <1517970426-39663-1-git-send-email-cgxu519@icloud.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mr11p00im-asmtp004.me.com ([17.110.69.135]:34075 "EHLO
        mr11p00im-asmtp004.me.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752537AbeBGC1k (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Feb 2018 21:27:40 -0500
Received: from process-dkim-sign-daemon.mr11p00im-asmtp004.me.com by
 mr11p00im-asmtp004.me.com
 (Oracle Communications Messaging Server 8.0.1.2.20170607 64bit (built Jun  7
 2017)) id <0P3R00100BY2TG00@mr11p00im-asmtp004.me.com> for
 ceph-devel@vger.kernel.org; Wed, 07 Feb 2018 02:27:33 +0000 (GMT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: zyan@redhat.com, idryomov@gmail.com, Chengguang Xu <cgxu519@icloud.com>

When specifying multiple fscache related options, the result isn't always
the same as option order, this fix will keep strict consistent meaning
by order.

Signed-off-by: Chengguang Xu <cgxu519@icloud.com>
---
 fs/ceph/super.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 7f1e212..e654005 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -314,9 +314,13 @@ static int parse_fsopt_token(char *c, void *private)
 		break;
 	case Opt_fscache:
 		fsopt->flags |= CEPH_MOUNT_OPT_FSCACHE;
+		kfree(fsopt->fscache_uniq);
+		fsopt->fscache_uniq = NULL;
 		break;
 	case Opt_nofscache:
 		fsopt->flags &= ~CEPH_MOUNT_OPT_FSCACHE;
+		kfree(fsopt->fscache_uniq);
+		fsopt->fscache_uniq = NULL;
 		break;
 	case Opt_poolperm:
 		fsopt->flags &= ~CEPH_MOUNT_OPT_NOPOOLPERM;
-- 
1.8.3.1

