From: Henry C Chang <henry.cy.chang@gmail.com>
Subject: [PATCH 1/3] ceph: print debug message before put mds session
Date: Wed, 11 May 2011 10:29:52 +0000
Message-ID: <1305109794-7967-1-git-send-email-henry.cy.chang@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:47209 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754578Ab1EKQLN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 May 2011 12:11:13 -0400
Received: by pvg12 with SMTP id 12so303861pvg.19
        for <ceph-devel@vger.kernel.org>; Wed, 11 May 2011 09:11:13 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Henry C Chang <henry.cy.chang@gmail.com>

The mds session, s, could be freed during ceph_put_mds_session.
Move dout before ceph_put_mds_session.

Signed-off-by: Henry C Chang <henry.cy.chang@gmail.com>
---
 fs/ceph/mds_client.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index f60b07b..d0fae4c 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -3304,8 +3304,8 @@ static void con_put(struct ceph_connection *con)
 {
 	struct ceph_mds_session *s = con->private;
 
+	dout("mdsc con_put %p (%d)\n", s, atomic_read(&s->s_ref) - 1);
 	ceph_put_mds_session(s);
-	dout("mdsc con_put %p (%d)\n", s, atomic_read(&s->s_ref));
 }
 
 /*
-- 
1.7.2.3

