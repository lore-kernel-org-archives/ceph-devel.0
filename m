Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADEBCCA48A
	for <ceph-devel@archiver.kernel.org>; Sun, 24 Jul 2022 12:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbiGXMUE (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Sun, 24 Jul 2022 08:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGXMUD (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 24 Jul 2022 08:20:03 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCE012ABB;
        Sun, 24 Jul 2022 05:19:55 -0700 (PDT)
X-QQ-mid: bizesmtp84t1658665190thxciqmk
Received: from localhost.localdomain ( [171.223.97.251])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 24 Jul 2022 20:19:48 +0800 (CST)
X-QQ-SSF: 01000000002000F0U000B00A0000020
X-QQ-FEAT: cbck7jzG4wbbtuthirBaXPVLfg+gpwTLWy1jH/yCDaAkqZ0ZMegFdCCJ1VCBi
        fgNoElUAWi2M/T9xWYrilrApykYb6OIsP+uiZc/XWe5fEqYqymPGWbuvjbXG8Ye2D05Z+dK
        syuVtFwBGcieqUQ3rNQdVnvxWMIbWvNl4ZFMQaVNRYH7sBU76CJb35t27JRBQqa6AymiqHC
        uw++O1DnTSZ8PSUOPMfPWQnrcXhGGlqnuUevwnLI982SFpl6/kz0y+zDLtpv+oda2Id/2NA
        64cd0MH4W36sM4UnhR3RiEm3ZTpP/jwV4eErQoS5ydOyVFeZCWaCflcsveptP3pnWLGPIqx
        2ksE4UYTugAkK4c1z63WucbVlPUUXUby7QNmsyC/9m8QPbYyPsNrpQrSS/9+w==
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     edumazet@google.com
Cc:     idryomov@gmail.com, xiubli@redhat.com, jlayton@kernel.org,
        davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        ceph-devel@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] libceph: Fix comment typo
Date:   Mon, 25 Jul 2022 04:11:31 +0800
Message-Id: <20220724201131.3381-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

The double `without' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 net/ceph/pagelist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ceph/pagelist.c b/net/ceph/pagelist.c
index 65e34f78b05d..74622b278d57 100644
--- a/net/ceph/pagelist.c
+++ b/net/ceph/pagelist.c
@@ -96,7 +96,7 @@ int ceph_pagelist_append(struct ceph_pagelist *pl, const void *buf, size_t len)
 EXPORT_SYMBOL(ceph_pagelist_append);
 
 /* Allocate enough pages for a pagelist to append the given amount
- * of data without without allocating.
+ * of data without allocating.
  * Returns: 0 on success, -ENOMEM on error.
  */
 int ceph_pagelist_reserve(struct ceph_pagelist *pl, size_t space)
-- 
2.35.1

