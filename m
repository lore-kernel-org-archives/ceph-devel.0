From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 3/4] libceph: invalidate AUTH in addition to a service ticket
Date: Fri, 15 Jan 2016 15:50:44 +0100
Message-ID: <1452869445-10228-4-git-send-email-idryomov@gmail.com>
References: <1452869445-10228-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33955 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754031AbcAOOvN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Jan 2016 09:51:13 -0500
Received: by mail-wm0-f68.google.com with SMTP id b14so3234122wmb.1
        for <ceph-devel@vger.kernel.org>; Fri, 15 Jan 2016 06:51:12 -0800 (PST)
In-Reply-To: <1452869445-10228-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sweil@redhat.com>

If we fault due to authentication, we invalidate the service ticket we
have and request a new one - the idea being that if a service rejected
our authorizer, it must have expired, despite mon_client's attempts at
periodic renewal.  (The other possibility is that our ticket is too new
and the service hasn't gotten it yet, in which case invalidating isn't
necessary but doesn't hurt.)

Invalidating just the service ticket is not enough, though.  If we
assume a failure on mon_client's part to renew a service ticket, we
have to assume the same for the AUTH ticket.  If our AUTH ticket is
bad, we won't get any service tickets no matter how hard we try, so
invalidate AUTH ticket along with the service ticket.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 net/ceph/auth_x.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/net/ceph/auth_x.c b/net/ceph/auth_x.c
index ab080bb18254..05e9fc21d460 100644
--- a/net/ceph/auth_x.c
+++ b/net/ceph/auth_x.c
@@ -684,8 +684,7 @@ static void ceph_x_destroy(struct ceph_auth_client *ac)
 	ac->private = NULL;
 }
 
-static void ceph_x_invalidate_authorizer(struct ceph_auth_client *ac,
-				   int peer_type)
+static void invalidate_ticket(struct ceph_auth_client *ac, int peer_type)
 {
 	struct ceph_x_ticket_handler *th;
 
@@ -694,6 +693,19 @@ static void ceph_x_invalidate_authorizer(struct ceph_auth_client *ac,
 		th->have_key = false;
 }
 
+static void ceph_x_invalidate_authorizer(struct ceph_auth_client *ac,
+					 int peer_type)
+{
+	/*
+	 * We are to invalidate a service ticket in the hopes of
+	 * getting a new, hopefully more valid, one.  But, we won't get
+	 * it unless our AUTH ticket is good, so invalidate AUTH ticket
+	 * as well, just in case.
+	 */
+	invalidate_ticket(ac, peer_type);
+	invalidate_ticket(ac, CEPH_ENTITY_TYPE_AUTH);
+}
+
 static int calcu_signature(struct ceph_x_authorizer *au,
 			   struct ceph_msg *msg, __le64 *sig)
 {
-- 
2.4.3

