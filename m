From: Huang Weiyi <weiyi.huang@gmail.com>
Subject: [PATCH 2/2] ceph: remove duplicated #include
Date: Tue,  4 May 2010 15:16:54 +0800
Message-ID: <1272957414-2816-1-git-send-email-weiyi.huang@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:40493 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751923Ab0EDHRG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 May 2010 03:17:06 -0400
Received: by mail-pw0-f46.google.com with SMTP id 5so20049pwi.19
        for <ceph-devel@vger.kernel.org>; Tue, 04 May 2010 00:17:05 -0700 (PDT)
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
index 818afe7..f6394b9 100644
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
index 13513b8..dbf474e 100644
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

