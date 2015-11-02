From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 2/4] libceph: drop authorizer check from cephx msg signing routines
Date: Mon,  2 Nov 2015 23:44:08 +0100
Message-ID: <1446504250-25647-3-git-send-email-idryomov@gmail.com>
References: <1446504250-25647-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:36259 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753840AbbKBVEc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Nov 2015 16:04:32 -0500
Received: by wmec75 with SMTP id c75so71130367wme.1
        for <ceph-devel@vger.kernel.org>; Mon, 02 Nov 2015 13:04:31 -0800 (PST)
In-Reply-To: <1446504250-25647-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Zheng Yan <zyan@redhat.com>

I don't see a way for auth->authorizer to be NULL in
ceph_x_sign_message() or ceph_x_check_message_signature().

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 net/ceph/auth_x.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/ceph/auth_x.c b/net/ceph/auth_x.c
index 65054fd31b97..3a544ca6b5ce 100644
--- a/net/ceph/auth_x.c
+++ b/net/ceph/auth_x.c
@@ -697,8 +697,7 @@ static int ceph_x_sign_message(struct ceph_auth_handshake *auth,
 			       struct ceph_msg *msg)
 {
 	int ret;
-	if (!auth->authorizer)
-		return 0;
+
 	ret = calcu_signature((struct ceph_x_authorizer *)auth->authorizer,
 			      msg, &msg->footer.sig);
 	if (ret < 0)
@@ -713,8 +712,6 @@ static int ceph_x_check_message_signature(struct ceph_auth_handshake *auth,
 	__le64 sig_check;
 	int ret;
 
-	if (!auth->authorizer)
-		return 0;
 	ret = calcu_signature((struct ceph_x_authorizer *)auth->authorizer,
 			      msg, &sig_check);
 	if (ret < 0)
-- 
2.4.3

