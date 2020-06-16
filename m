From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 1/3] libceph: don't omit recovery_deletes in target_copy()
Date: Tue, 16 Jun 2020 09:44:13 +0200
Message-ID: <20200616074415.9989-2-idryomov@gmail.com>
References: <20200616074415.9989-1-idryomov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbgFPHop (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Jun 2020 03:44:45 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE11FC03E96A
        for <ceph-devel@vger.kernel.org>; Tue, 16 Jun 2020 00:44:44 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id q19so20424023eja.7
        for <ceph-devel@vger.kernel.org>; Tue, 16 Jun 2020 00:44:44 -0700 (PDT)
In-Reply-To: <20200616074415.9989-1-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>

Currently target_copy() is used only for sending linger pings, so
this doesn't come up, but generally omitting recovery_deletes can
result in unneeded resends (force_resend in calc_target()).

Fixes: ae78dd8139ce ("libceph: make RECOVERY_DELETES feature create a new interval")
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 net/ceph/osd_client.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index a37d159019a0..8f7fbe861dff 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -445,6 +445,7 @@ static void target_copy(struct ceph_osd_request_target *dest,
 	dest->size = src->size;
 	dest->min_size = src->min_size;
 	dest->sort_bitwise = src->sort_bitwise;
+	dest->recovery_deletes = src->recovery_deletes;
 
 	dest->flags = src->flags;
 	dest->paused = src->paused;
-- 
2.19.2
