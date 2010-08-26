From: Dan Carpenter <error27@gmail.com>
Subject: [patch] ceph: fix get_ticket_handler() error handling
Date: Thu, 26 Aug 2010 11:12:38 +0200
Message-ID: <20100826091238.GB20072@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:65119 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753441Ab0HZJNH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Aug 2010 05:13:07 -0400
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Yehuda Sadeh <yehuda@hq.newdream.net>, ceph-devel@vger.kernel.org, kernel-janitors@vger.kernel.org

get_ticket_handler() returns a valid pointer or it returns
ERR_PTR(-ENOMEM) if kzalloc() fails.

Signed-off-by: Dan Carpenter <error27@gmail.com>

diff --git a/fs/ceph/auth_x.c b/fs/ceph/auth_x.c
index 582e0b2..a2d002c 100644
--- a/fs/ceph/auth_x.c
+++ b/fs/ceph/auth_x.c
@@ -376,7 +376,7 @@ static void ceph_x_validate_tickets(struct ceph_auth_client *ac, int *pneed)
 
 		th = get_ticket_handler(ac, service);
 
-		if (!th) {
+		if (IS_ERR(th)) {
 			*pneed |= service;
 			continue;
 		}
@@ -399,6 +399,9 @@ static int ceph_x_build_request(struct ceph_auth_client *ac,
 	struct ceph_x_ticket_handler *th =
 		get_ticket_handler(ac, CEPH_ENTITY_TYPE_AUTH);
 
+	if (IS_ERR(th))
+		return PTR_ERR(th);
+
 	ceph_x_validate_tickets(ac, &need);
 
 	dout("build_request want %x have %x need %x\n",
@@ -450,7 +453,6 @@ static int ceph_x_build_request(struct ceph_auth_client *ac,
 			return -ERANGE;
 		head->op = cpu_to_le16(CEPHX_GET_PRINCIPAL_SESSION_KEY);
 
-		BUG_ON(!th);
 		ret = ceph_x_build_authorizer(ac, th, &xi->auth_authorizer);
 		if (ret)
 			return ret;
@@ -505,7 +507,8 @@ static int ceph_x_handle_reply(struct ceph_auth_client *ac, int result,
 
 	case CEPHX_GET_PRINCIPAL_SESSION_KEY:
 		th = get_ticket_handler(ac, CEPH_ENTITY_TYPE_AUTH);
-		BUG_ON(!th);
+		if (IS_ERR(th))
+			return PTR_ERR(th);
 		ret = ceph_x_proc_ticket_reply(ac, &th->session_key,
 					       buf + sizeof(*head), end);
 		break;
@@ -563,8 +566,8 @@ static int ceph_x_verify_authorizer_reply(struct ceph_auth_client *ac,
 	void *end = p + sizeof(au->reply_buf);
 
 	th = get_ticket_handler(ac, au->service);
-	if (!th)
-		return -EIO;  /* hrm! */
+	if (IS_ERR(th))
+		return PTR_ERR(th);
 	ret = ceph_x_decrypt(&th->session_key, &p, end, &reply, sizeof(reply));
 	if (ret < 0)
 		return ret;
@@ -626,7 +629,7 @@ static void ceph_x_invalidate_authorizer(struct ceph_auth_client *ac,
 	struct ceph_x_ticket_handler *th;
 
 	th = get_ticket_handler(ac, peer_type);
-	if (th && !IS_ERR(th))
+	if (!IS_ERR(th))
 		remove_ticket_handler(ac, th);
 }
 
