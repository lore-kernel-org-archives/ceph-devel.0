From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH] libceph: ceph_build_auth() doesn't need ceph_auth_build_hello()
Date: Fri, 23 Sep 2016 09:59:50 +0200
Message-ID: <1474617590-24456-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36766 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753675AbcIWIAV (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Sep 2016 04:00:21 -0400
Received: by mail-wm0-f66.google.com with SMTP id b184so1399969wma.3
        for <ceph-devel@vger.kernel.org>; Fri, 23 Sep 2016 01:00:21 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Iago Abal <iari@itu.dk>

A static bug finder (EBA) on Linux 4.7:

    Double lock in net/ceph/auth.c
    second lock at 108: mutex_lock(& ac->mutex); [ceph_auth_build_hello]
    after calling from 263: ret = ceph_auth_build_hello(ac, msg_buf, msg_len);
    if ! ac->protocol -> true at 262
    first lock at 261: mutex_lock(& ac->mutex); [ceph_build_auth]

ceph_auth_build_hello() is never called, because the protocol is always
initialized, whether we are checking existing tickets (in delayed_work())
or getting new ones after invalidation (in invalidate_authorizer()).

Reported-by: Iago Abal <iari@itu.dk>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 net/ceph/auth.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/ceph/auth.c b/net/ceph/auth.c
index 53aa2d27e36b..c822b3ae1bd3 100644
--- a/net/ceph/auth.c
+++ b/net/ceph/auth.c
@@ -262,9 +262,7 @@ int ceph_build_auth(struct ceph_auth_client *ac,
 	int ret = 0;
 
 	mutex_lock(&ac->mutex);
-	if (!ac->protocol)
-		ret = ceph_auth_build_hello(ac, msg_buf, msg_len);
-	else if (ac->ops->should_authenticate(ac))
+	if (ac->ops->should_authenticate(ac))
 		ret = ceph_build_auth_request(ac, msg_buf, msg_len);
 	mutex_unlock(&ac->mutex);
 	return ret;
-- 
2.4.3

