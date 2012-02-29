From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH] ceph: don't reset s_cap_ttl to zero
Date: Tue, 28 Feb 2012 19:06:07 -0800
Message-ID: <4F4D961F.2030404@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:42665 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755406Ab2B2DGH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 22:06:07 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 7FCA02431D
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:06:07 -0800 (PST)
Received: from [192.168.107.136] (aon.hq.newdream.net [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 770FD24318
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:06:07 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Avoid the need to check for a special zero s_cap_ttl value by just
using (jiffies - 1) as the value assigned to indicate "sometime in
the past."

Signed-off-by: Alex Elder <elder@dreamhost.com>
Reviewed-by: Sage Weil <sage@newdream.net>
---
  fs/ceph/mds_client.c |    7 +++----
  1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index a4fdf93..9f86a80 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -402,7 +402,7 @@ static struct ceph_mds_session 
*register_session(struct ceph_mds_client *mdsc,

  	spin_lock_init(&s->s_gen_ttl_lock);
  	s->s_cap_gen = 0;
-	s->s_cap_ttl = 0;
+	s->s_cap_ttl = jiffies - 1;

  	spin_lock_init(&s->s_cap_lock);
  	s->s_renew_requested = 0;
@@ -1083,8 +1083,7 @@ static void renewed_caps(struct ceph_mds_client *mdsc,
  	int wake = 0;

  	spin_lock(&session->s_cap_lock);
-	was_stale = is_renew && (session->s_cap_ttl == 0 ||
-				 time_after_eq(jiffies, session->s_cap_ttl));
+	was_stale = is_renew && time_after_eq(jiffies, session->s_cap_ttl);

  	session->s_cap_ttl = session->s_renew_requested +
  		mdsc->mdsmap->m_session_timeout*HZ;
@@ -2332,7 +2331,7 @@ static void handle_session(struct ceph_mds_session 
*session,
  			session->s_mds);
  		spin_lock(&session->s_gen_ttl_lock);
  		session->s_cap_gen++;
-		session->s_cap_ttl = 0;
+		session->s_cap_ttl = jiffies - 1;
  		spin_unlock(&session->s_gen_ttl_lock);
  		send_renew_caps(mdsc, session);
  		break;
