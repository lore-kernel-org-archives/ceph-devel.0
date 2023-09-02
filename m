Return-Path: <ceph-devel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F666CA0FE2
	for <ceph-devel@archiver.kernel.org>; Fri,  1 Sep 2023 02:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348133AbjIACTN (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Thu, 31 Aug 2023 22:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235244AbjIACTM (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Aug 2023 22:19:12 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 2E171E6E;
        Thu, 31 Aug 2023 19:19:09 -0700 (PDT)
Received: from localhost.localdomain (unknown [219.141.250.2])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 49ED46047B72E;
        Fri,  1 Sep 2023 10:19:06 +0800 (CST)
X-MD-Sfrom: kunyu@nfschina.com
X-MD-SrcIP: 219.141.250.2
From:   Li kunyu <kunyu@nfschina.com>
To:     idryomov@gmail.com, xiubli@redhat.com, jlayton@kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     ceph-devel@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Li kunyu <kunyu@nfschina.com>
Subject: [PATCH] =?UTF-8?q?ceph/ceph=5Fcommon:=20Remove=20unnecessary=20?= =?UTF-8?q?=E2=80=980=E2=80=99=20values=20from=20ret?=
Date:   Sun,  3 Sep 2023 02:50:22 +0800
Message-Id: <20230902185022.3347-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

ret is assigned first, so it does not need to initialize the assignment.

Signed-off-by: Li kunyu <kunyu@nfschina.com>
---
 net/ceph/ceph_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
index 4c6441536d55..bf8dc1c1149c 100644
--- a/net/ceph/ceph_common.c
+++ b/net/ceph/ceph_common.c
@@ -865,7 +865,7 @@ EXPORT_SYMBOL(ceph_wait_for_latest_osdmap);
 
 static int __init init_ceph_lib(void)
 {
-	int ret = 0;
+	int ret;
 
 	ceph_debugfs_init();
 
-- 
2.18.2

