From: Huang Weiyi <weiyi.huang@gmail.com>
Subject: [PATCH 1/2] ceph: remove unused #include <linux/version.h>
Date: Tue,  4 May 2010 15:16:39 +0800
Message-ID: <1272957399-6032-1-git-send-email-weiyi.huang@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:40493 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751217Ab0EDHQx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 May 2010 03:16:53 -0400
Received: by pwi5 with SMTP id 5so20049pwi.19
        for <ceph-devel@vger.kernel.org>; Tue, 04 May 2010 00:16:52 -0700 (PDT)
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
index f888cf4..82b709f 100644
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

