From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: [PATCH 1/1] Use a common xml type for ceph secret usage.
Date: Fri, 28 Oct 2011 14:19:34 -0700
Message-ID: <ce9e6885af6aa76edcebca9103a5690447e8dc47.1319835863.git.josh.durgin@dreamhost.com>
References: <fc9aba44da7d8be72fabeba1caf07901aaef202d.1319836201.git.josh.durgin@dreamhost.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:46225 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933393Ab1J1VTw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 28 Oct 2011 17:19:52 -0400
In-Reply-To: <fc9aba44da7d8be72fabeba1caf07901aaef202d.1319836201.git.josh.durgin@dreamhost.com>
In-Reply-To: <4EAAFF3E.6070703@dreamhost.com>
References: <4EAAFF3E.6070703@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: libvir-list@redhat.com
Cc: ceph-devel@vger.kernel.org, eblake@redhat.com

The types used in domaincommon.rng and secret.rng should be the same.

Signed-off-by: Josh Durgin <josh.durgin@dreamhost.com>
---
 docs/schemas/domaincommon.rng |   11 ++++++++---
 docs/schemas/secret.rng       |    4 +++-
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/docs/schemas/domaincommon.rng b/docs/schemas/domaincommon.rng
index 3477351..d053489 100644
--- a/docs/schemas/domaincommon.rng
+++ b/docs/schemas/domaincommon.rng
@@ -2558,13 +2558,13 @@
         <attribute name='uuid'>
           <ref name="UUID"/>
         </attribute>
-        <attribute name="usage">
-          <ref name="genericName"/>
+        <attribute name='usage'>
+          <ref name='usageName'/>
         </attribute>
       </choice>
     </element>
   </define>
-
+  
   <!--
        Optional hypervisor extensions in their own namespace:
          QEmu
@@ -2675,6 +2675,11 @@
       <param name="pattern">(([0-2]?[0-9]?[0-9]\.){3}[0-2]?[0-9]?[0-9])|(([0-9a-fA-F]+|:)+[0-9a-fA-F]+)|([a-zA-Z0-9_\.\+\-]*)</param>
     </data>
   </define>
+  <define name="usageName">
+    <data type="string">
+      <param name="pattern">[a-zA-Z0-9_\.\+\-]+</param>
+    </data>
+  </define>
   <define name="usbId">
     <data type="string">
       <param name="pattern">(0x)?[0-9a-fA-F]{1,4}</param>
diff --git a/docs/schemas/secret.rng b/docs/schemas/secret.rng
index 8e7714b..3abd3c7 100644
--- a/docs/schemas/secret.rng
+++ b/docs/schemas/secret.rng
@@ -4,6 +4,8 @@
     <ref name='secret'/>
   </start>
 
+  <include href='domaincommon.rng'/>
+
   <define name='secret'>
     <element name='secret'>
       <optional>
@@ -60,7 +62,7 @@
       <value>ceph</value>
     </attribute>
     <element name='name'>
-      <text/>
+      <ref name='usageName'/>
     </element>
   </define>
 
-- 
1.7.1

