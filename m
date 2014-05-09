From: Wido den Hollander <wido@widodh.nl>
Subject: [PATCH 2/2] Set ms_bind_ipv6 to true when IPv6 is used
Date: Fri,  9 May 2014 10:36:15 +0200
Message-ID: <1399624575-4772-1-git-send-email-wido@widodh.nl>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:38220 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756063AbaEIIgV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 May 2014 04:36:21 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Wido den Hollander <wido@widodh.nl>


Signed-off-by: Wido den Hollander <wido@widodh.nl>
---
 ceph_deploy/new.py |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/ceph_deploy/new.py b/ceph_deploy/new.py
index fc4c5f4..e573128 100644
--- a/ceph_deploy/new.py
+++ b/ceph_deploy/new.py
@@ -91,9 +91,11 @@ def new(args):
         ip = net.get_nonlocal_ip(host)
         LOG.debug('Monitor %s at %s', name, ip)
         mon_initial_members.append(name)
+        ms_ipv6 = False
         try:
             socket.inet_pton(socket.AF_INET6, ip)
             mon_host.append("[" + ip + "]")
+            ms_ipv6 = True
         except socket.error:
             mon_host.append(ip)
 
@@ -106,6 +108,10 @@ def new(args):
     cfg.set('global', 'mon initial members', ', '.join(mon_initial_members))
     # no spaces here, see http://tracker.newdream.net/issues/3145
     cfg.set('global', 'mon host', ','.join(mon_host))
+    
+    if ms_ipv6 == True:
+        LOG.debug('Monitors are IPv6, binding Messenger traffic on IPv6')
+        cfg.set('global', 'ms bind ipv6', 'true')
 
     # override undesirable defaults, needed until bobtail
 
-- 
1.7.9.5

