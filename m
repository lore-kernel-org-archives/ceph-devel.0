Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B7CC433EF
	for <ceph-devel@archiver.kernel.org>; Tue, 22 Mar 2022 23:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbiCVXym (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Tue, 22 Mar 2022 19:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbiCVXyl (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Mar 2022 19:54:41 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719FB5D182;
        Tue, 22 Mar 2022 16:53:12 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R331e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V7yMQzf_1647993189;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V7yMQzf_1647993189)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 23 Mar 2022 07:53:10 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     jlayton@kernel.org
Cc:     xiubli@redhat.com, idryomov@gmail.com, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] ceph: replace DEFINE_SIMPLE_ATTRIBUTE with DEFINE_DEBUGFS_ATTRIBUTE
Date:   Wed, 23 Mar 2022 07:53:08 +0800
Message-Id: <20220322235308.9770-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

Fix the following coccicheck warning:
./fs/ceph/debugfs.c:389:0-23: WARNING: congestion_kb_fops should be
defined with DEFINE_DEBUGFS_ATTRIBUTE

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 fs/ceph/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
index bec3c4549c07..05d15a0bbd9b 100644
--- a/fs/ceph/debugfs.c
+++ b/fs/ceph/debugfs.c
@@ -386,7 +386,7 @@ static int congestion_kb_get(void *data, u64 *val)
 	return 0;
 }
 
-DEFINE_SIMPLE_ATTRIBUTE(congestion_kb_fops, congestion_kb_get,
+DEFINE_DEBUGFS_ATTRIBUTE(congestion_kb_fops, congestion_kb_get,
 			congestion_kb_set, "%llu\n");
 
 
-- 
2.20.1.7.g153144c

