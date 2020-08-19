Return-Path: <SRS0=w0HK=B5=vger.kernel.org=ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375A1C433E1
	for <ceph-devel@archiver.kernel.org>; Wed, 19 Aug 2020 08:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20DBC207BB
	for <ceph-devel@archiver.kernel.org>; Wed, 19 Aug 2020 08:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgHSIyj (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Wed, 19 Aug 2020 04:54:39 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:54978 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727111AbgHSIw5 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 19 Aug 2020 04:52:57 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5CA694435E0D016789D8;
        Wed, 19 Aug 2020 16:52:53 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Wed, 19 Aug 2020
 16:52:47 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <jlayton@kernel.org>, <idryomov@gmail.com>
CC:     <ceph-devel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] ceph: Convert to use the preferred fallthrough macro
Date:   Wed, 19 Aug 2020 04:51:42 -0400
Message-ID: <20200819085142.42652-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Sender: ceph-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

Convert the uses of fallthrough comments to fallthrough macro.

Signed-off-by: Hongxiang Lou <louhongxiang@huawei.com>
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 fs/ceph/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index d51c3f2fdca0..30cd00265181 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -252,7 +252,7 @@ static int ceph_init_file(struct inode *inode, struct file *file, int fmode)
 	case S_IFREG:
 		ceph_fscache_register_inode_cookie(inode);
 		ceph_fscache_file_set_cookie(inode, file);
-		/* fall through */
+		fallthrough;
 	case S_IFDIR:
 		ret = ceph_init_file_info(inode, file, fmode,
 						S_ISDIR(inode->i_mode));
-- 
2.19.1

