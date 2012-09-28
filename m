From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] ceph: convert to use le32_add_cpu()
Date: Fri, 28 Sep 2012 12:59:16 +0800
Message-ID: <CAPgLHd8VSUZnVac+QT5Uvu2STd9KsMCy-G5C5LX6ZpcwO7Lzgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:46915 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751259Ab2I1E7R (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 28 Sep 2012 00:59:17 -0400
Received: by qchd3 with SMTP id d3so1651805qch.19
        for <ceph-devel@vger.kernel.org>; Thu, 27 Sep 2012 21:59:16 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage@inktank.com
Cc: yongjun_wei@trendmicro.com.cn, ceph-devel@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Convert cpu_to_le32(le32_to_cpu(E1) + E2) to use le32_add_cpu().

dpatch engine is used to auto generate this patch.
(https://github.com/weiyj/dpatch)

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 fs/ceph/caps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 620daad..3251e9c 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -1005,7 +1005,7 @@ static void __queue_cap_release(struct ceph_mds_session *session,
 
 	BUG_ON(msg->front.iov_len + sizeof(*item) > PAGE_CACHE_SIZE);
 	head = msg->front.iov_base;
-	head->num = cpu_to_le32(le32_to_cpu(head->num) + 1);
+	le32_add_cpu(&head->num, 1);
 	item = msg->front.iov_base + msg->front.iov_len;
 	item->ino = cpu_to_le64(ino);
 	item->cap_id = cpu_to_le64(cap_id);


