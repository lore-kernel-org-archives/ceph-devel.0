From: Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH] ceph: include linux/crush/mapper.h in crush/mapper.c
Date: Fri, 28 Oct 2016 13:23:24 +0200
Message-ID: <20161028112324.14850-1-tklauser@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.zhinst.com ([212.126.164.98]:37718 "EHLO mail.zhinst.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754436AbcJ1LX1 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 28 Oct 2016 07:23:27 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>
Cc: ceph-devel@vger.kernel.org

Include linux/crush/mapper.h in crush/mapper.c to get the prototypes of
crush_find_rule and crush_do_rule which are defined there. This fixes
the following GCC warnings when building with 'W=1':

  net/ceph/crush/mapper.c:40:5: warning: no previous prototype for ‘crush_find_rule’ [-Wmissing-prototypes]
  net/ceph/crush/mapper.c:793:5: warning: no previous prototype for ‘crush_do_rule’ [-Wmissing-prototypes]

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 net/ceph/crush/mapper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ceph/crush/mapper.c b/net/ceph/crush/mapper.c
index a421e905331a..407bd146ba9e 100644
--- a/net/ceph/crush/mapper.c
+++ b/net/ceph/crush/mapper.c
@@ -17,6 +17,7 @@
 # include <linux/kernel.h>
 # include <linux/crush/crush.h>
 # include <linux/crush/hash.h>
+# include <linux/crush/mapper.h>
 #else
 # include "crush_compat.h"
 # include "crush.h"
-- 
2.9.0


