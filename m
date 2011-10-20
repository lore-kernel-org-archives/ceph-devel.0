From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: [RFC PATCH v3 1/4] secret: add Ceph secret type
Date: Thu, 20 Oct 2011 11:01:24 -0700
Message-ID: <539f3129dfd5d3f80a06837b63dfc5d355f1acc8.1319072460.git.josh.durgin@dreamhost.com>
References: <cover.1319072460.git.josh.durgin@dreamhost.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:38042 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752501Ab1JTSBy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 20 Oct 2011 14:01:54 -0400
In-Reply-To: <cover.1319072460.git.josh.durgin@dreamhost.com>
In-Reply-To: <cover.1319072460.git.josh.durgin@dreamhost.com>
References: <cover.1319072460.git.josh.durgin@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: libvir-list@redhat.com
Cc: ceph-devel@vger.kernel.org, berrange@redhat.com

From: Sage Weil <sage@newdream.net>

Add a new secret type to store a Ceph authentication key. The name
is simply an identifier for easy human reference.

The xml looks like this:

<secret ephemeral='no' private='no'>
  <uuid>0a81f5b2-8403-7b23-c8d6-21ccc2f80d6f</uuid>
  <usage type='ceph'>
    <name>mycluster_admin</name>
  </usage>
</secret>

Signed-off-by: Sage Weil <sage@newdream.net>
Signed-off-by: Josh Durgin <josh.durgin@dreamhost.com>
---
 docs/schemas/secret.rng      |   10 ++++++++++
 include/libvirt/libvirt.h.in |    3 +++
 src/conf/secret_conf.c       |   23 ++++++++++++++++++++++-
 src/conf/secret_conf.h       |    1 +
 src/secret/secret_driver.c   |    8 ++++++++
 5 files changed, 44 insertions(+), 1 deletions(-)

diff --git a/docs/schemas/secret.rng b/docs/schemas/secret.rng
index 80270ae..8e7714b 100644
--- a/docs/schemas/secret.rng
+++ b/docs/schemas/secret.rng
@@ -37,6 +37,7 @@
           <element name='usage'>
             <choice>
               <ref name='usagevolume'/>
+              <ref name='usageceph'/>
               <!-- More choices later -->
             </choice>
           </element>
@@ -54,6 +55,15 @@
     </element>
   </define>
 
+  <define name='usageceph'>
+    <attribute name='type'>
+      <value>ceph</value>
+    </attribute>
+    <element name='name'>
+      <text/>
+    </element>
+  </define>
+
   <define name="UUID">
     <choice>
       <data type="string">
diff --git a/include/libvirt/libvirt.h.in b/include/libvirt/libvirt.h.in
index 361881a..2ef1c9c 100644
--- a/include/libvirt/libvirt.h.in
+++ b/include/libvirt/libvirt.h.in
@@ -2381,7 +2381,10 @@ typedef virSecret *virSecretPtr;
 typedef enum {
     VIR_SECRET_USAGE_TYPE_NONE = 0,
     VIR_SECRET_USAGE_TYPE_VOLUME = 1,
+    VIR_SECRET_USAGE_TYPE_CEPH = 2,
     /* Expect more owner types later... */
+
+    VIR_SECRET_USAGE_TYPE_LAST
 } virSecretUsageType;
 
 virConnectPtr           virSecretGetConnect     (virSecretPtr secret);
diff --git a/src/conf/secret_conf.c b/src/conf/secret_conf.c
index b33ce98..a51fc69 100644
--- a/src/conf/secret_conf.c
+++ b/src/conf/secret_conf.c
@@ -35,7 +35,8 @@
 
 #define VIR_FROM_THIS VIR_FROM_SECRET
 
-VIR_ENUM_IMPL(virSecretUsageType, VIR_SECRET_USAGE_TYPE_VOLUME + 1, "none", "volume")
+VIR_ENUM_IMPL(virSecretUsageType, VIR_SECRET_USAGE_TYPE_LAST,
+              "none", "volume", "ceph")
 
 void
 virSecretDefFree(virSecretDefPtr def)
@@ -52,6 +53,10 @@ virSecretDefFree(virSecretDefPtr def)
         VIR_FREE(def->usage.volume);
         break;
 
+    case VIR_SECRET_USAGE_TYPE_CEPH:
+        VIR_FREE(def->usage.ceph);
+        break;
+
     default:
         VIR_ERROR(_("unexpected secret usage type %d"), def->usage_type);
         break;
@@ -94,6 +99,15 @@ virSecretDefParseUsage(xmlXPathContextPtr ctxt,
         }
         break;
 
+    case VIR_SECRET_USAGE_TYPE_CEPH:
+        def->usage.ceph = virXPathString("string(./usage/name)", ctxt);
+        if (!def->usage.ceph) {
+            virSecretReportError(VIR_ERR_INTERNAL_ERROR, "%s",
+                                 _("Ceph usage specified, but name is missing"));
+            return -1;
+        }
+        break;
+
     default:
         virSecretReportError(VIR_ERR_INTERNAL_ERROR,
                              _("unexpected secret usage type %d"),
@@ -239,6 +253,13 @@ virSecretDefFormatUsage(virBufferPtr buf,
                                   def->usage.volume);
         break;
 
+    case VIR_SECRET_USAGE_TYPE_CEPH:
+        if (def->usage.ceph != NULL) {
+            virBufferEscapeString(buf, "    <name>%s</name>\n",
+                                  def->usage.ceph);
+        }
+        break;
+
     default:
         virSecretReportError(VIR_ERR_INTERNAL_ERROR,
                              _("unexpected secret usage type %d"),
diff --git a/src/conf/secret_conf.h b/src/conf/secret_conf.h
index 4b47c52..b5d72d4 100644
--- a/src/conf/secret_conf.h
+++ b/src/conf/secret_conf.h
@@ -42,6 +42,7 @@ struct _virSecretDef {
     int usage_type;
     union {
         char *volume;               /* May be NULL */
+        char *ceph;
     } usage;
 };
 
diff --git a/src/secret/secret_driver.c b/src/secret/secret_driver.c
index 59dc687..088a243 100644
--- a/src/secret/secret_driver.c
+++ b/src/secret/secret_driver.c
@@ -144,6 +144,11 @@ secretFindByUsage(virSecretDriverStatePtr driver, int usageType, const char *usa
             if (STREQ(s->def->usage.volume, usageID))
                 return s;
             break;
+
+        case VIR_SECRET_USAGE_TYPE_CEPH:
+            if (STREQ(s->def->usage.ceph, usageID))
+                return s;
+            break;
         }
     }
     return NULL;
@@ -607,6 +612,9 @@ secretUsageIDForDef(virSecretDefPtr def)
     case VIR_SECRET_USAGE_TYPE_VOLUME:
         return def->usage.volume;
 
+    case VIR_SECRET_USAGE_TYPE_CEPH:
+        return def->usage.ceph;
+
     default:
         return NULL;
     }
-- 
1.7.1

