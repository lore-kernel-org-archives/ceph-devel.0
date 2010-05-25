From: Huang Weiyi <weiyi.huang@gmail.com>
Subject: [PATCH 3/5] ceph: remove duplicated #include
Date: Tue, 25 May 2010 22:07:45 +0800
Message-ID: <1274796465-3812-1-git-send-email-weiyi.huang@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:43790 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756411Ab0EYOHt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 May 2010 10:07:49 -0400
Received: by pvg3 with SMTP id 3so563660pvg.19
        for <ceph-devel@vger.kernel.org>; Tue, 25 May 2010 07:07:48 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage@newdream.net
Cc: ceph-devel@vger.kernel.org, Huang Weiyi <weiyi.huang@gmail.com>

Remove duplicated #include('s) in
  fs/ceph/auth.c
  fs/ceph/super.h

Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>
---
 fs/ceph/auth.c  |    1 -
 fs/ceph/super.h |    1 -
 2 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/auth.c b/fs/ceph/auth.c
index 9f46de2..5f3f0be 100644
--- a/fs/ceph/auth.c
+++ b/fs/ceph/auth.c
@@ -3,7 +3,6 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/err.h>
-#include <linux/slab.h>
 
 #include "types.h"
 #include "auth_none.h"
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 3725c9e..e23a4d3 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -13,7 +13,6 @@
 #include <linux/slab.h>
 #include <linux/wait.h>
 #include <linux/writeback.h>
-#include <linux/slab.h>
 
 #include "types.h"
 #include "messenger.h"
-- 
1.6.1.3

