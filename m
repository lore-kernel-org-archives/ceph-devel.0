From: samlang@gmail.com
Subject: [PATCH] client: Fix for client hang caused by connection drop to MDS.
Date: Mon, 21 Nov 2011 15:51:19 -0600
Message-ID: <1321912279-15673-1-git-send-email-samlang@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:44194 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752910Ab1KUVvX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Nov 2011 16:51:23 -0500
Received: by iage36 with SMTP id e36so7850264iag.19
        for <ceph-devel@vger.kernel.org>; Mon, 21 Nov 2011 13:51:23 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sam Lang <samlang@gmail.com>

From: Sam Lang <samlang@gmail.com>

This patch will cause inprogress client operations to the MDS server to
be kicked if the connection to the MDS server is dropped.
---
 src/client/Client.cc |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/src/client/Client.cc b/src/client/Client.cc
index 78d12c8e..1f37dfc 100644
--- a/src/client/Client.cc
+++ b/src/client/Client.cc
@@ -6907,6 +6907,18 @@ bool Client::ms_handle_reset(Connection *con)
   ldout(cct, 0) << "ms_handle_reset on " << con->get_peer_addr() << dendl;
   Mutex::Locker l(client_lock);
   objecter->ms_handle_reset(con);
+
+  // look for mds that has this connection and kick associated requests
+  for(map<int, MetaSession*>::iterator it = mds_sessions.begin();
+      it != mds_sessions.end();
+      it++)
+  {
+      if((*it).second->inst.addr.probably_equals(con->get_peer_addr()))
+      {
+          kick_requests((*it).first, true);
+          break;
+      }
+  }
   return false;
 }
 
-- 
1.7.5.4

