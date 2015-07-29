From: mchristi@redhat.com
Subject: [PATCH 14/18] libceph: fix pr_fmt compile issues
Date: Wed, 29 Jul 2015 04:23:51 -0500
Message-ID: <1438161835-27960-14-git-send-email-mchristi@redhat.com>
References: <1438161835-27960-1-git-send-email-mchristi@redhat.com>
Return-path: <target-devel-owner@vger.kernel.org>
In-Reply-To: <1438161835-27960-1-git-send-email-mchristi@redhat.com>
Sender: target-devel-owner@vger.kernel.org
To: ceph-devel@vger.kernel.org, target-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

From: Mike Christie <michaelc@cs.wisc.edu>

When using ceph from other modules like the target ones, pr_fmt
might already be defined. This just ifndefs it.

Signed-off-by: Mike Christie <michaelc@cs.wisc.edu>
---
 include/linux/ceph/ceph_debug.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/ceph/ceph_debug.h b/include/linux/ceph/ceph_debug.h
index aa2e191..05711eb 100644
--- a/include/linux/ceph/ceph_debug.h
+++ b/include/linux/ceph/ceph_debug.h
@@ -1,7 +1,9 @@
 #ifndef _FS_CEPH_DEBUG_H
 #define _FS_CEPH_DEBUG_H
 
+#ifndef pr_fmt
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#endif
 
 #ifdef CONFIG_CEPH_LIB_PRETTYDEBUG
 
-- 
1.8.3.1
