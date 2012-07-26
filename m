From: Paul Collins <paul.collins@canonical.com>
Subject: [PATCH] skip loading keyrings when auth supported = none
Date: Fri, 27 Jul 2012 11:38:00 +1200
Message-ID: <87wr1qnlev.fsf@agnew.wgtn.ondioline.org>
References: <871uk0pw8p.fsf@agnew.wgtn.ondioline.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:38680 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753173Ab2GZXiJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Jul 2012 19:38:09 -0400
Received: from [203.79.106.241] (helo=agnew.wgtn.ondioline.org)
	by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <paul.collins@canonical.com>)
	id 1SuXd9-00060S-KS
	for ceph-devel@vger.kernel.org; Thu, 26 Jul 2012 23:38:07 +0000
Received: from agnew (agnew [127.0.0.1])
	by agnew.wgtn.ondioline.org (Postfix) with ESMTP id 4F07C2030E
	for <ceph-devel@vger.kernel.org>; Fri, 27 Jul 2012 11:38:01 +1200 (NZST)
In-Reply-To: <871uk0pw8p.fsf@agnew.wgtn.ondioline.org>
References: <871uk0pw8p.fsf@agnew.wgtn.ondioline.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

If the cluster is not currently using authentication, then it's
possible that no keyrings were ever created.  Proceed with monitor
initialization regardless and explain what we did.

With this patch applied, my 0.48 monitor cluster starts up
correctly even when no keyring files are present in the monitors'
data directories.

Signed-off-by: Paul Collins <paul.collins@canonical.com>
---
 src/mon/Monitor.cc |   40 ++++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/src/mon/Monitor.cc b/src/mon/Monitor.cc
index c415dbf..bdd6a91 100644
--- a/src/mon/Monitor.cc
+++ b/src/mon/Monitor.cc
@@ -322,22 +322,26 @@ int Monitor::init()
     extract_save_mon_key(keyring);
   }
 
-  ostringstream os;
-  os << g_conf->mon_data << "/keyring";
-  int r = keyring.load(cct, os.str());
-  if (r < 0) {
-    EntityName mon_name;
-    mon_name.set_type(CEPH_ENTITY_TYPE_MON);
-    EntityAuth mon_key;
-    if (key_server.get_auth(mon_name, mon_key)) {
-      dout(1) << "copying mon. key from old db to external keyring" << dendl;
-      keyring.add(mon_name, mon_key);
-      bufferlist bl;
-      keyring.encode_plaintext(bl);
-      store->put_bl_ss(bl, "keyring", NULL);
-    } else {
-      derr << "unable to load initial keyring " << g_conf->keyring << dendl;
-      return r;
+  if (auth_supported.is_supported_auth(CEPH_AUTH_NONE)) {
+    dout(10) << "auth supported = none, no keys to load" << dendl;
+  } else {
+    ostringstream os;
+    os << g_conf->mon_data << "/keyring";
+    int r = keyring.load(cct, os.str());
+    if (r < 0) {
+      EntityName mon_name;
+      mon_name.set_type(CEPH_ENTITY_TYPE_MON);
+      EntityAuth mon_key;
+      if (key_server.get_auth(mon_name, mon_key)) {
+	dout(1) << "copying mon. key from old db to external keyring" << dendl;
+	keyring.add(mon_name, mon_key);
+	bufferlist bl;
+	keyring.encode_plaintext(bl);
+	store->put_bl_ss(bl, "keyring", NULL);
+      } else {
+	derr << "unable to load initial keyring " << g_conf->keyring << dendl;
+	return r;
+      }
     }
   }
 
@@ -346,8 +350,8 @@ int Monitor::init()
 
   // unlock while registering to avoid mon_lock -> admin socket lock dependency.
   lock.Unlock();
-  r = admin_socket->register_command("mon_status", admin_hook,
-				     "show current monitor status");
+  int r = admin_socket->register_command("mon_status", admin_hook,
+					 "show current monitor status");
   assert(r == 0);
   r = admin_socket->register_command("quorum_status", admin_hook,
 					 "show current quorum status");
-- 
1.7.10.4

