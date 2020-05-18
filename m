From: Jerry Lee <leisurelysw24@gmail.com>
Subject: [PATCH] libceph: add ignore cache/overlay flag if got redirect reply
Date: Mon, 18 May 2020 16:03:09 +0800
Message-ID: <CAKQB+fug_Y4y8wYe-vG=itf+0BmYFPfDm-ch7DTobtkipQz-yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbgERIDV (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 18 May 2020 04:03:21 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CE4C061A0C
        for <ceph-devel@vger.kernel.org>; Mon, 18 May 2020 01:03:21 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id g25so1579695otp.13
        for <ceph-devel@vger.kernel.org>; Mon, 18 May 2020 01:03:21 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, Ilya Dryomov <idryomov@gmail.com>, Jeff Layton <jlayton@kernel.org>

osd client should ignore cache/overlay flag if got redirect reply.
Otherwise, the client hangs when the cache tier is in forward mode.

Similar issues:
   https://tracker.ceph.com/issues/23296
   https://tracker.ceph.com/issues/36406

Signed-off-by: Jerry Lee <leisurelysw24@gmail.com>
---
 net/ceph/osd_client.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 998e26b..1d4973f 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -3649,7 +3649,9 @@ static void handle_reply(struct ceph_osd *osd,
struct ceph_msg *msg)
                 * supported.
                 */
                req->r_t.target_oloc.pool = m.redirect.oloc.pool;
-               req->r_flags |= CEPH_OSD_FLAG_REDIRECTED;
+               req->r_flags |= CEPH_OSD_FLAG_REDIRECTED |
+                               CEPH_OSD_FLAG_IGNORE_OVERLAY |
+                               CEPH_OSD_FLAG_IGNORE_CACHE;
                req->r_tid = 0;
                __submit_request(req, false);
                goto out_unlock_osdc;
