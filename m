Return-Path: <SRS0=0t9i=B3=vger.kernel.org=ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6165C433E1
	for <ceph-devel@archiver.kernel.org>; Mon, 17 Aug 2020 01:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD3F7207FF
	for <ceph-devel@archiver.kernel.org>; Mon, 17 Aug 2020 01:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgHQBfD (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Sun, 16 Aug 2020 21:35:03 -0400
Received: from smtprelay0100.hostedemail.com ([216.40.44.100]:50468 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726221AbgHQBes (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Sun, 16 Aug 2020 21:34:48 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id AEFEB18029155;
        Mon, 17 Aug 2020 01:34:46 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: care37_35117f927012
X-Filterd-Recvd-Size: 2064
Received: from joe-laptop.perches.com (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Mon, 17 Aug 2020 01:34:45 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Ilya Dryomov <idryomov@gmail.com>, Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 6/6] ceph_debug: Remove now unused dout macro definitions
Date:   Sun, 16 Aug 2020 18:34:09 -0700
Message-Id: <fe4e9e2a544af4d00aa5c97d9288d9b4d67db1ed.1597626802.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1597626802.git.joe@perches.com>
References: <cover.1597626802.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: ceph-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

All the uses have be converted to pr_debug, so remove these.

Signed-off-by: Joe Perches <joe@perches.com>
---
 include/linux/ceph/ceph_debug.h | 30 ------------------------------
 1 file changed, 30 deletions(-)

diff --git a/include/linux/ceph/ceph_debug.h b/include/linux/ceph/ceph_debug.h
index d5a5da838caf..81c0d7195f1e 100644
--- a/include/linux/ceph/ceph_debug.h
+++ b/include/linux/ceph/ceph_debug.h
@@ -6,34 +6,4 @@
 
 #include <linux/string.h>
 
-#ifdef CONFIG_CEPH_LIB_PRETTYDEBUG
-
-/*
- * wrap pr_debug to include a filename:lineno prefix on each line.
- * this incurs some overhead (kernel size and execution time) due to
- * the extra function call at each call site.
- */
-
-# if defined(DEBUG) || defined(CONFIG_DYNAMIC_DEBUG)
-#  define dout(fmt, ...)						\
-	pr_debug("%.*s %12.12s:%-4d : " fmt,				\
-		 8 - (int)sizeof(KBUILD_MODNAME), "    ",		\
-		 kbasename(__FILE__), __LINE__, ##__VA_ARGS__)
-# else
-/* faux printk call just to see any compiler warnings. */
-#  define dout(fmt, ...)	do {				\
-		if (0)						\
-			printk(KERN_DEBUG fmt, ##__VA_ARGS__);	\
-	} while (0)
-# endif
-
-#else
-
-/*
- * or, just wrap pr_debug
- */
-# define dout(fmt, ...)	pr_debug(" " fmt, ##__VA_ARGS__)
-
-#endif
-
 #endif
-- 
2.26.0

