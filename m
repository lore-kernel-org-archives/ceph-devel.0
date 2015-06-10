From: Hong Zhiguo <honkiko@gmail.com>
Subject: [PATCH] libceph: fix wrong name "Ceph filesystem for Linux"
Date: Wed, 10 Jun 2015 21:13:25 +0800
Message-ID: <1433942005-15368-1-git-send-email-zhiguohong@tencent.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35207 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751206AbbFJNNj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Jun 2015 09:13:39 -0400
Received: by pacyx8 with SMTP id yx8so34845324pac.2
        for <ceph-devel@vger.kernel.org>; Wed, 10 Jun 2015 06:13:38 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@redhat.com, Hong Zhiguo <zhiguohong@tencent.com>

modinfo libceph prints the module name "Ceph filesystem for Linux",
which is same as the real fs module ceph. It's confusing.

Signed-off-by: Hong Zhiguo <zhiguohong@tencent.com>
---
 net/ceph/ceph_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
index 925d0c8..cb7db32 100644
--- a/net/ceph/ceph_common.c
+++ b/net/ceph/ceph_common.c
@@ -741,5 +741,5 @@ module_exit(exit_ceph_lib);
 MODULE_AUTHOR("Sage Weil <sage@newdream.net>");
 MODULE_AUTHOR("Yehuda Sadeh <yehuda@hq.newdream.net>");
 MODULE_AUTHOR("Patience Warnick <patience@newdream.net>");
-MODULE_DESCRIPTION("Ceph filesystem for Linux");
+MODULE_DESCRIPTION("Ceph core library");
 MODULE_LICENSE("GPL");
-- 
1.9.1

