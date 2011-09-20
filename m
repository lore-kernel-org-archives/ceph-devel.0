From: Sage Weil <sage@newdream.net>
Subject: [PATCH 1/5] secret: add Ceph secret type
Date: Mon, 19 Sep 2011 21:13:39 -0700
Message-ID: <1316492023-17749-2-git-send-email-sage@newdream.net>
References: <1316492023-17749-1-git-send-email-sage@newdream.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36843 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750986Ab1ITENv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Sep 2011 00:13:51 -0400
In-Reply-To: <1316492023-17749-1-git-send-email-sage@newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: libvir-list@redhat.com
Cc: ceph-devel@vger.kernel.org, veillard@redhat.com, Sage Weil <sage@newdream.net>

Add a new secret type to store a Ceph authentication key.  The ceph_id
field contains the name of the key (e.g. 'admin' for the ceph superuser).

Signed-off-by: Sage Weil <sage@newdream.net>
---
 docs/schemas/secret.rng      |   17 +++++++++++++++
 include/libvirt/libvirt.h.in |    3 ++
 src/conf/secret_conf.c       |   45 +++++++++++++++++++++++++++++++++++++++++-
 src/conf/secret_conf.h       |    1 +
 src/secret/secret_driver.c   |    8 +++++++
 5 files changed, 73 insertions(+), 1 deletions(-)

diff --git a/docs/schemas/secret.rng b/docs/schemas/secret.rng
index 80270ae..c3da8b3 100644
--- a/docs/schemas/secret.rng
+++ b/docs/schemas/secret.rng
@@ -37,6 +37,7 @@
           <element name='usage'>
             <choice>
               <ref name='usagevolume'/>
+              <ref name='cephauth'/>
               <!-- More choices later -->
             </choice>
           </element>
@@ -54,6 +55,22 @@
     </element>
   </define>
 
+  <define name='cephauth'>
+    <attribute name='type'>
+      <value>ceph</value>
+    </attribute>
+    <element name='auth'>
+      <attribute name='id'>
+	<text/>
+      </attribute>
+      <optional>
+        <attribute name='domain'>
+	  <text/>
+	</attribute>
+      </optional>
+    </element>
+  </define>
+
   <define name="UUID">
     <choice>
       <data type="string">
diff --git a/include/libvirt/libvirt.h.in b/include/libvirt/libvirt.h.in
index b1bda31..51fd044 100644
--- a/include/libvirt/libvirt.h.in
+++ b/include/libvirt/libvirt.h.in
@@ -2257,7 +2257,10 @@ typedef virSecret *virSecretPtr;
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
index 105afbe..8f11a51 100644
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
+        VIR_FREE(def->usage.authIdDomain);
+        break;
+
     default:
         VIR_ERROR(_("unexpected secret usage type %d"), def->usage_type);
         break;
@@ -65,6 +70,8 @@ virSecretDefParseUsage(xmlXPathContextPtr ctxt,
 {
     char *type_str;
     int type;
+    char *authId, *authDomain;
+    int ret;
 
     type_str = virXPathString("string(./usage/@type)", ctxt);
     if (type_str == NULL) {
@@ -94,6 +101,27 @@ virSecretDefParseUsage(xmlXPathContextPtr ctxt,
         }
         break;
 
+    case VIR_SECRET_USAGE_TYPE_CEPH:
+        authId = virXPathString("string(./usage/auth/@id)", ctxt);
+        if (!authId) {
+            virSecretReportError(VIR_ERR_INTERNAL_ERROR, "%s",
+                                 _("ceph usage specified, but auth id is missing"));
+            return -1;
+        }
+        authDomain = virXPathString("string(./usage/auth/@domain)", ctxt);
+        if (!authDomain) {
+            VIR_FREE(authId);
+            virSecretReportError(VIR_ERR_INTERNAL_ERROR, "%s",
+                                 _("ceph usage specified, but auth domain is missing"));
+            return -1;
+        }
+        ret = virAlloc(&def->usage.authIdDomain, strlen(authId) +
+                       strlen(authDomain) + 2);
+        sprintf(def->usage.authIdDomain, "%s/%s", authId, authDomain);
+        VIR_FREE(authId);
+        VIR_FREE(authDomain);
+        break;
+
     default:
         virSecretReportError(VIR_ERR_INTERNAL_ERROR,
                              _("unexpected secret usage type %d"),
@@ -220,6 +248,9 @@ virSecretDefFormatUsage(virBufferPtr buf,
                         const virSecretDefPtr def)
 {
     const char *type;
+    char *p;
+    char idAuth[80];
+    int len;
 
     type = virSecretUsageTypeTypeToString(def->usage_type);
     if (type == NULL) {
@@ -239,6 +270,18 @@ virSecretDefFormatUsage(virBufferPtr buf,
                                   def->usage.volume);
         break;
 
+    case VIR_SECRET_USAGE_TYPE_CEPH:
+        if (def->usage.authIdDomain != NULL) {
+            p = strchr(def->usage.authIdDomain, '/');
+            len = p - def->usage.authIdDomain;
+            strncpy(idAuth, def->usage.authIdDomain, len);
+            idAuth[len] = '\0';
+            p++;
+            virBufferEscapeString(buf, "    <auth id='%s'", idAuth);
+            virBufferEscapeString(buf, " domain='%s'/>\n", p);
+        }
+        break;
+
     default:
         virSecretReportError(VIR_ERR_INTERNAL_ERROR,
                              _("unexpected secret usage type %d"),
diff --git a/src/conf/secret_conf.h b/src/conf/secret_conf.h
index 4b47c52..294e7ab 100644
--- a/src/conf/secret_conf.h
+++ b/src/conf/secret_conf.h
@@ -42,6 +42,7 @@ struct _virSecretDef {
     int usage_type;
     union {
         char *volume;               /* May be NULL */
+        char *authIdDomain;
     } usage;
 };
 
diff --git a/src/secret/secret_driver.c b/src/secret/secret_driver.c
index 59dc687..7ea8a49 100644
--- a/src/secret/secret_driver.c
+++ b/src/secret/secret_driver.c
@@ -144,6 +144,11 @@ secretFindByUsage(virSecretDriverStatePtr driver, int usageType, const char *usa
             if (STREQ(s->def->usage.volume, usageID))
                 return s;
             break;
+
+        case VIR_SECRET_USAGE_TYPE_CEPH:
+            if (STREQ(s->def->usage.authIdDomain, usageID))
+                return s;
+            break;
         }
     }
     return NULL;
@@ -607,6 +612,9 @@ secretUsageIDForDef(virSecretDefPtr def)
     case VIR_SECRET_USAGE_TYPE_VOLUME:
         return def->usage.volume;
 
+    case VIR_SECRET_USAGE_TYPE_CEPH:
+        return def->usage.authIdDomain;
+
     default:
         return NULL;
     }
-- 
1.7.4.1

