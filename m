From: Roald van Loon <roaldvanloon@gmail.com>
Subject: [PATCH] cleanup: removed last references to g_conf from auth
Date: Tue, 27 Aug 2013 11:20:48 +0200
Message-ID: <CAN04cT65Dd0q-VcKgmr56JrZkt9dKv3Qkv-1aKHtgUydrV10ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f47.google.com ([209.85.219.47]:64733 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752716Ab3H0JUt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Aug 2013 05:20:49 -0400
Received: by mail-oa0-f47.google.com with SMTP id g12so4948778oah.20
        for <ceph-devel@vger.kernel.org>; Tue, 27 Aug 2013 02:20:48 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Trivial cleanup. There were still 3 references to g_conf in CephxKeyServer.
Replaced them in favor of cct->_conf.

Signed-off-by: Roald J. van Loon <roaldvanloon@gmail.com>
---
diff --git a/src/auth/cephx/CephxKeyServer.cc b/src/auth/cephx/CephxKeyServer.cc
index e0c8174..e57b557 100644
--- a/src/auth/cephx/CephxKeyServer.cc
+++ b/src/auth/cephx/CephxKeyServer.cc
@@ -163,7 +163,7 @@ bool KeyServer::_check_rotating_secrets()
     ldout(cct, 10) << __func__ << " added " << added << dendl;
     data.rotating_ver++;
     //data.next_rotating_time = ceph_clock_now(cct);
-    //data.next_rotating_time += MIN(g_conf->auth_mon_ticket_ttl,
g_conf->auth_service_ticket_ttl);
+    //data.next_rotating_time += MIN(cct->_conf->auth_mon_ticket_ttl,
cct->_conf->auth_service_ticket_ttl);
     _dump_rotating_secrets();
     return true;
   }
@@ -191,7 +191,7 @@ int KeyServer::_rotate_secret(uint32_t service_id)
   RotatingSecrets& r = data.rotating_secrets[service_id];
   int added = 0;
   utime_t now = ceph_clock_now(cct);
-  double ttl = service_id == CEPH_ENTITY_TYPE_AUTH ?
g_conf->auth_mon_ticket_ttl : g_conf->auth_service_ticket_ttl;
+  double ttl = service_id == CEPH_ENTITY_TYPE_AUTH ?
cct->_conf->auth_mon_ticket_ttl : cct->_conf->auth_service_ticket_ttl;

   while (r.need_new_secrets(now)) {
     ExpiringCryptoKey ek;
@@ -424,7 +424,7 @@ int KeyServer::_build_session_auth_info(uint32_t
service_id, CephXServiceTicketI
 {
   info.service_id = service_id;
   info.ticket = auth_ticket_info.ticket;
-  info.ticket.init_timestamps(ceph_clock_now(cct),
g_conf->auth_service_ticket_ttl);
+  info.ticket.init_timestamps(ceph_clock_now(cct),
cct->_conf->auth_service_ticket_ttl);

   generate_secret(info.session_key);
