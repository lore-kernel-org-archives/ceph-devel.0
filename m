From: Christian Brunner <chb@muc.de>
Subject: [PATCH] qemu/rbd bugfix for create_tmap_op
Date: Thu, 3 Jun 2010 23:08:31 +0200
Message-ID: <20100603210831.GA17094@chb-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:26462 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752752Ab0FCVIh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Jun 2010 17:08:37 -0400
Received: by fg-out-1718.google.com with SMTP id l26so2322412fgb.1
        for <ceph-devel@vger.kernel.org>; Thu, 03 Jun 2010 14:08:36 -0700 (PDT)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: kwolf@redhat.com

The patch I sent in response to kevins comments contains a bug in 
create_tmap_op. (I've deleted to much here). Please include the 
following fix.

Regards,
Christian
---
 block/rbd.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index e4c4deb..74589cb 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -124,7 +124,7 @@ static int create_tmap_op(uint8_t op, const char *name, char **tmap_desc)
     uint32_t total_len = 1 + (sizeof(uint32_t) + len) + sizeof(uint32_t);
     char *desc = NULL;
 
-    qemu_malloc(total_len);
+    desc = qemu_malloc(total_len);
 
     *tmap_desc = desc;
 
-- 
1.7.0.4

