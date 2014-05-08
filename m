From: Wido den Hollander <wido@widodh.nl>
Subject: [PATCH] Write correct 'mon_host' with IPv6 addresses
Date: Thu,  8 May 2014 13:44:43 +0200
Message-ID: <1399549483-14813-1-git-send-email-wido@widodh.nl>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:47189 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753437AbaEHLvH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 May 2014 07:51:07 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Wido den Hollander <wido@widodh.nl>

When the IP-address from a monitor is a IPv6 address, encapsulate
it with [ and ]

Fixes: #8309

Signed-off-by: Wido den Hollander <wido@widodh.nl>
---
 ceph_deploy/new.py |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/ceph_deploy/new.py b/ceph_deploy/new.py
index 3680821..fc4c5f4 100644
--- a/ceph_deploy/new.py
+++ b/ceph_deploy/new.py
@@ -5,6 +5,7 @@ import uuid
 import struct
 import time
 import base64
+import socket
 
 from ceph_deploy.cliutil import priority
 from ceph_deploy import conf, hosts, exc
@@ -90,7 +91,12 @@ def new(args):
         ip = net.get_nonlocal_ip(host)
         LOG.debug('Monitor %s at %s', name, ip)
         mon_initial_members.append(name)
-        mon_host.append(ip)
+        try:
+            socket.inet_pton(socket.AF_INET6, ip)
+            mon_host.append("[" + ip + "]")
+        except socket.error:
+            mon_host.append(ip)
+
         if args.ssh_copykey:
             ssh_copy_keys(host, args.username)
 
-- 
1.7.9.5

