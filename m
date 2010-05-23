From: Andrea Gelmini <andrea.gelmini@gelma.net>
Subject: [PATCH 1/4] fs/ceph: removed duplicated #includes
Date: Sun, 23 May 2010 21:47:58 +0200
Message-ID: <1274644078-23167-1-git-send-email-andrea.gelmini@gelma.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:39503 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752938Ab0EWTsH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 23 May 2010 15:48:07 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1665760fga.1
        for <ceph-devel@vger.kernel.org>; Sun, 23 May 2010 12:48:06 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: andrea.gelmini@gelma.net
Cc: Sage Weil <sage@newdream.net>, Yehuda Sadeh <yehuda@hq.newdream.net>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux-foundation.org>, ceph-devel@vger.kernel.org

fs/ceph/auth.c: linux/slab.h is included more than once.
fs/ceph/super.h: linux/slab.h is included more than once.

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 fs/ceph/auth.c  |    1 -
 fs/ceph/super.h |    1 -
 2 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/auth.c b/fs/ceph/auth.c
index 818afe7..39208ee 100644
--- a/fs/ceph/auth.c
+++ b/fs/ceph/auth.c
@@ -1,7 +1,6 @@
 #include "ceph_debug.h"
 
 #include <linux/module.h>
-#include <linux/slab.h>
 #include <linux/err.h>
 #include <linux/slab.h>
 
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 13513b8..e30dfbb 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -10,7 +10,6 @@
 #include <linux/fs.h>
 #include <linux/mempool.h>
 #include <linux/pagemap.h>
-#include <linux/slab.h>
 #include <linux/wait.h>
 #include <linux/writeback.h>
 #include <linux/slab.h>
-- 
1.7.1.251.gf80a2

