From: Huang Weiyi <weiyi.huang@gmail.com>
Subject: [PATCH 02/12] ceph: remove unused #include <linux/version.h>
Date: Sun, 23 May 2010 01:11:48 +0800
Message-ID: <1274548308-552-1-git-send-email-weiyi.huang@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:60502 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753444Ab0EVRLw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 22 May 2010 13:11:52 -0400
Received: by pvg4 with SMTP id 4so234423pvg.19
        for <ceph-devel@vger.kernel.org>; Sat, 22 May 2010 10:11:52 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage@newdream.net
Cc: ceph-devel@vger.kernel.org, Huang Weiyi <weiyi.huang@gmail.com>

Remove unused #include <linux/version.h>('s) in
  fs/ceph/super.c

Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>
---
 fs/ceph/super.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 9307bbe..36a834a 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -14,7 +14,6 @@
 #include <linux/slab.h>
 #include <linux/statfs.h>
 #include <linux/string.h>
-#include <linux/version.h>
 #include <linux/vmalloc.h>
 
 #include "decode.h"
-- 
1.6.1.3

