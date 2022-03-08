Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E056C433EF
	for <ceph-devel@archiver.kernel.org>; Tue,  8 Mar 2022 13:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241950AbiCHNYd (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Tue, 8 Mar 2022 08:24:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232457AbiCHNYc (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Mar 2022 08:24:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 393D13BF87
        for <ceph-devel@vger.kernel.org>; Tue,  8 Mar 2022 05:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646745815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=NDxp7H+GcL8hqxYR74DTjafU/P8xgyd3PyijGy7ze3k=;
        b=RNppp9qL9X12U+m3gzPJUzcdRyom90lpMCbTYBqjW4u1TvY/IdcvJtEo6XXUHXertUBiO9
        ACsPh0+8LuE74/kxZQBjcD3SQWntJMaAki7oAibfUAvx1m1bnI+R0FGJIXMIAXGE854Xnr
        JLczRYxgjtH5fcLPtCiHg0SJsUWGbWQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-19-9S7CYMkOM9CdQ1sbB4yGZA-1; Tue, 08 Mar 2022 08:23:32 -0500
X-MC-Unique: 9S7CYMkOM9CdQ1sbB4yGZA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE1251006AA5;
        Tue,  8 Mar 2022 13:23:30 +0000 (UTC)
Received: from lxbceph1.gsslab.pek2.redhat.com (unknown [10.72.47.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1043976C2B;
        Tue,  8 Mar 2022 13:23:28 +0000 (UTC)
From:   xiubli@redhat.com
To:     jlayton@kernel.org, idryomov@gmail.com
Cc:     vshankar@redhat.com, ceph-devel@vger.kernel.org,
        Xiubo Li <xiubli@redhat.com>
Subject: [PATCH v2] libceph: wait for con->work to finish when cancelling con
Date:   Tue,  8 Mar 2022 21:23:22 +0800
Message-Id: <20220308132322.1309992-1-xiubli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

When reconnecting MDS it will reopen the con with new ip address,
but the when opening the con with new address it couldn't be sure
that the stale work has finished. So it's possible that the stale
work queued will use the new data.

This will use cancel_delayed_work_sync() instead.

Signed-off-by: Xiubo Li <xiubli@redhat.com>
---

V2:
- Call cancel_con() after dropping the mutex


 net/ceph/messenger.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index d3bb656308b4..62e39f63f94c 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -581,8 +581,8 @@ void ceph_con_close(struct ceph_connection *con)
 
 	ceph_con_reset_protocol(con);
 	ceph_con_reset_session(con);
-	cancel_con(con);
 	mutex_unlock(&con->mutex);
+	cancel_con(con);
 }
 EXPORT_SYMBOL(ceph_con_close);
 
@@ -1416,7 +1416,7 @@ static void queue_con(struct ceph_connection *con)
 
 static void cancel_con(struct ceph_connection *con)
 {
-	if (cancel_delayed_work(&con->work)) {
+	if (cancel_delayed_work_sync(&con->work)) {
 		dout("%s %p\n", __func__, con);
 		con->ops->put(con);
 	}
-- 
2.27.0

