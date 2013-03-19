From: Sage Weil <sage@inktank.com>
Subject: [PATCH 2/6] libceph: fix authorizer invalidation
Date: Tue, 19 Mar 2013 16:08:02 -0700
Message-ID: <1363734486-26879-2-git-send-email-sage@inktank.com>
References: <1363734486-26879-1-git-send-email-sage@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54521 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754146Ab3CSXIK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Mar 2013 19:08:10 -0400
In-Reply-To: <1363734486-26879-1-git-send-email-sage@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>

We were invalidating the authorizer by removing the ticket handler
entirely.  This was effective in inducing us to request a new authorizer,
but in the meantime it mean that any authorizer we generated would get a
new and initialized handler with secret_id=0, which would always be
rejected by the server side with a confusing error message:

 auth: could not find secret_id=0
 cephx: verify_authorizer could not get service secret for service osd secret_id=0

Instead, simply clear the validity field.  This will still induce the auth
code to request a new secret, but will let us continue to use the old
ticket in the meantime.  The messenger code will probably continue to fail,
but the exponential backoff will kick in, and eventually the we will get a
new (hopefully more valid) ticket from the mon and be able to continue.

Signed-off-by: Sage Weil <sage@inktank.com>
---
 net/ceph/auth_x.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ceph/auth_x.c b/net/ceph/auth_x.c
index a16bf14..bd8758d 100644
--- a/net/ceph/auth_x.c
+++ b/net/ceph/auth_x.c
@@ -630,7 +630,7 @@ static void ceph_x_invalidate_authorizer(struct ceph_auth_client *ac,
 
 	th = get_ticket_handler(ac, peer_type);
 	if (!IS_ERR(th))
-		remove_ticket_handler(ac, th);
+		memset(&th->validity, 0, sizeof(th->validity));
 }
 
 
-- 
1.7.9.5

