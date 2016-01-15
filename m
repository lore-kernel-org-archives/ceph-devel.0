From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 1/4] libceph: clear messenger auth_retry flag if we fault
Date: Fri, 15 Jan 2016 15:50:42 +0100
Message-ID: <1452869445-10228-2-git-send-email-idryomov@gmail.com>
References: <1452869445-10228-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33933 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754031AbcAOOvL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Jan 2016 09:51:11 -0500
Received: by mail-wm0-f68.google.com with SMTP id b14so3233944wmb.1
        for <ceph-devel@vger.kernel.org>; Fri, 15 Jan 2016 06:51:10 -0800 (PST)
In-Reply-To: <1452869445-10228-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sweil@redhat.com>

Commit 20e55c4cc758 ("libceph: clear messenger auth_retry flag when we
authenticate") got us only half way there.  We clear the flag if the
second attempt succeeds, but it also needs to be cleared if that
attempt fails, to allow for the exponential backoff to kick in.
Otherwise, if ->should_authenticate() thinks our keys are valid, we
will busy loop, incrementing auth_retry to no avail:

    process_connect ffff880079a63830 got BADAUTHORIZER attempt 1
    process_connect ffff880079a63830 got BADAUTHORIZER attempt 2
    process_connect ffff880079a63830 got BADAUTHORIZER attempt 3
    process_connect ffff880079a63830 got BADAUTHORIZER attempt 4
    process_connect ffff880079a63830 got BADAUTHORIZER attempt 5
    ...

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 net/ceph/messenger.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 3850d1a5bd7c..9cfedf565f5b 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -2827,13 +2827,17 @@ static bool con_backoff(struct ceph_connection *con)
 
 static void con_fault_finish(struct ceph_connection *con)
 {
+	dout("%s %p\n", __func__, con);
+
 	/*
 	 * in case we faulted due to authentication, invalidate our
 	 * current tickets so that we can get new ones.
 	 */
-	if (con->auth_retry && con->ops->invalidate_authorizer) {
-		dout("calling invalidate_authorizer()\n");
-		con->ops->invalidate_authorizer(con);
+	if (con->auth_retry) {
+		dout("auth_retry %d, invalidating\n", con->auth_retry);
+		if (con->ops->invalidate_authorizer)
+			con->ops->invalidate_authorizer(con);
+		con->auth_retry = 0;
 	}
 
 	if (con->ops->fault)
-- 
2.4.3

