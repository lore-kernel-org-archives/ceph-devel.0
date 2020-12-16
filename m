Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66FD4C4361B
	for <ceph-devel@archiver.kernel.org>; Wed, 16 Dec 2020 13:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CF4B23371
	for <ceph-devel@archiver.kernel.org>; Wed, 16 Dec 2020 13:03:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbgLPNDD (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Wed, 16 Dec 2020 08:03:03 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9212 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgLPNDD (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Dec 2020 08:03:03 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CwwHX44v9zkqG2;
        Wed, 16 Dec 2020 21:01:28 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Wed, 16 Dec 2020 21:02:10 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <jlayton@kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
        <ceph-devel@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH net-next] ceph: Delete useless kfree code
Date:   Wed, 16 Dec 2020 21:02:39 +0800
Message-ID: <20201216130239.13759-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

The parameter of kfree function is NULL, so kfree code is useless, delete it.

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 net/ceph/osdmap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index fa08c15be0c0..6e6387c6b7bf 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -285,7 +285,6 @@ static u32 *decode_array_32_alloc(void **p, void *end, u32 *plen)
 e_inval:
 	ret = -EINVAL;
 fail:
-	kfree(a);
 	return ERR_PTR(ret);
 }
 
-- 
2.22.0

