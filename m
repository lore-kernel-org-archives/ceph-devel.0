From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 2/3] libceph: don't omit used_replica in target_copy()
Date: Tue, 16 Jun 2020 09:44:14 +0200
Message-ID: <20200616074415.9989-3-idryomov@gmail.com>
References: <20200616074415.9989-1-idryomov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbgFPHos (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Jun 2020 03:44:48 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51498C05BD43
        for <ceph-devel@vger.kernel.org>; Tue, 16 Jun 2020 00:44:45 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id p20so20379817ejd.13
        for <ceph-devel@vger.kernel.org>; Tue, 16 Jun 2020 00:44:45 -0700 (PDT)
In-Reply-To: <20200616074415.9989-1-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>

Currently target_copy() is used only for sending linger pings, so
this doesn't come up, but generally omitting used_replica can hang
the client as we wouldn't notice the acting set change (legacy_change
in calc_target()) or trigger a warning in handle_reply().

Fixes: 117d96a04f00 ("libceph: support for balanced and localized reads")
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 net/ceph/osd_client.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 8f7fbe861dff..2db8b44e70c2 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -448,6 +448,7 @@ static void target_copy(struct ceph_osd_request_target *dest,
 	dest->recovery_deletes = src->recovery_deletes;
 
 	dest->flags = src->flags;
+	dest->used_replica = src->used_replica;
 	dest->paused = src->paused;
 
 	dest->epoch = src->epoch;
-- 
2.19.2
