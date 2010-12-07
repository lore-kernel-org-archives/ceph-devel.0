From: Josh Durgin <joshd-L5o5AL9CYN0tUFlbccrkMA@public.gmane.org>
Subject: [PATCH 1/2] qemu: Add RBD support and some network disk
	fixes
Date: Tue, 07 Dec 2010 11:56:34 -0800
Message-ID: <4CFE9172.6030302@hq.newdream.net>
References: <20101202131928.GV2502@redhat.com>
	<1291620249-19645-1-git-send-email-morita.kazutaka@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <sheepdog-bounces-CJ+3F33aHDCwRfvgX43A7Q@public.gmane.org>
In-Reply-To: <1291620249-19645-1-git-send-email-morita.kazutaka-Zyj7fXuS5i5L9jVzuh4AOg@public.gmane.org>
List-Unsubscribe: <http://lists.wpkg.org/mailman/options/sheepdog>,
	<mailto:sheepdog-request-CJ+3F33aHDCwRfvgX43A7Q@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.wpkg.org/pipermail/sheepdog>
List-Post: <mailto:sheepdog-CJ+3F33aHDCwRfvgX43A7Q@public.gmane.org>
List-Help: <mailto:sheepdog-request-CJ+3F33aHDCwRfvgX43A7Q@public.gmane.org?subject=help>
List-Subscribe: <http://lists.wpkg.org/mailman/listinfo/sheepdog>,
	<mailto:sheepdog-request-CJ+3F33aHDCwRfvgX43A7Q@public.gmane.org?subject=subscribe>
Sender: sheepdog-bounces-CJ+3F33aHDCwRfvgX43A7Q@public.gmane.org
Errors-To: sheepdog-bounces-CJ+3F33aHDCwRfvgX43A7Q@public.gmane.org
To: libvir-list-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sheepdog-CJ+3F33aHDCwRfvgX43A7Q@public.gmane.org
List-Id: ceph-devel.vger.kernel.org


Changes common to all network disks:
-Make source name optional in the domain schema, since NBD doesn't use it
-Add a hostName type to the domain schema, and use it instead of genericName, which doesn't include .
-Don't leak host names or ports
-Set the source protocol in qemuParseCommandline

Signed-off-by: Josh Durgin <joshd-L5o5AL9CYN0tUFlbccrkMA@public.gmane.org>
---
 docs/schemas/domain.rng |   11 +++-
 src/conf/domain_conf.c  |   25 +++++++-
 src/conf/domain_conf.h  |    1 +
 src/qemu/qemu_conf.c    |  143 ++++++++++++++++++++++++++++++++++++++++++++---
 4 files changed, 165 insertions(+), 15 deletions(-)

diff --git a/docs/schemas/domain.rng b/docs/schemas/domain.rng
index 4463884..51aae14 100644
--- a/docs/schemas/domain.rng
+++ b/docs/schemas/domain.rng
@@ -626,11 +626,13 @@
                     <value>sheepdog</value>
                   </choice>
                 </attribute>
-                <attribute name="name"/>
+                <optional>
+                  <attribute name="name"/>
+                </optional>
                 <zeroOrMore>
                   <element name="host">
                     <attribute name="name">
-                      <ref name="genericName"/>
+                      <ref name="hostName"/>
                     </attribute>
                     <attribute name="port">
                       <ref name="unsignedInt"/>
@@ -2024,6 +2026,11 @@
       <param name="minInclusive">1</param>
     </data>
   </define>
+  <define name="hostName">
+    <data type="string">
+      <param name="pattern">[a-zA-Z0-9\.\-]+</param>
+    </data>
+  </define>
   <define name="PortNumber">
     <data type="short">
       <param name="minInclusive">-1</param>
diff --git a/src/conf/domain_conf.c b/src/conf/domain_conf.c
index 5e2422b..6b4320a 100644
--- a/src/conf/domain_conf.c
+++ b/src/conf/domain_conf.c
@@ -508,21 +508,34 @@ void virDomainInputDefFree(virDomainInputDefPtr def)

 void virDomainDiskDefFree(virDomainDiskDefPtr def)
 {
+    unsigned int i;
+
     if (!def)
         return;

     VIR_FREE(def->serial);
     VIR_FREE(def->src);
-    VIR_FREE(def->hosts);
     VIR_FREE(def->dst);
     VIR_FREE(def->driverName);
     VIR_FREE(def->driverType);
     virStorageEncryptionFree(def->encryption);
     virDomainDeviceInfoClear(&def->info);

+    for (i = 0 ; i < def->nhosts ; i++)
+        virDomainDiskHostDefFree(&def->hosts[i]);
+
     VIR_FREE(def);
 }

+void virDomainDiskHostDefFree(virDomainDiskHostDefPtr def)
+{
+    if (!def)
+        return;
+
+    VIR_FREE(def->name);
+    VIR_FREE(def->port);
+}
+
 void virDomainControllerDefFree(virDomainControllerDefPtr def)
 {
     if (!def)
@@ -1643,7 +1656,12 @@ virDomainDiskDefParseXML(virCapsPtr caps,
                                              protocol);
                         goto error;
                     }
-                    source = virXMLPropString(cur, "name");
+                    if (!(source = virXMLPropString(cur, "name")) &&
+                        def->protocol != VIR_DOMAIN_DISK_PROTOCOL_NBD) {
+                        virDomainReportError(VIR_ERR_INTERNAL_ERROR,
+                                             _("missing name for disk source"));
+                        goto error;
+                    }
                     host = cur->children;
                     while (host != NULL) {
                         if (host->type == XML_ELEMENT_NODE &&
@@ -1876,8 +1894,7 @@ cleanup:
     VIR_FREE(target);
     VIR_FREE(source);
     while (nhosts > 0) {
-        VIR_FREE(hosts[nhosts - 1].name);
-        VIR_FREE(hosts[nhosts - 1].port);
+        virDomainDiskHostDefFree(&hosts[nhosts - 1]);
         nhosts--;
     }
     VIR_FREE(hosts);
diff --git a/src/conf/domain_conf.h b/src/conf/domain_conf.h
index 6c97289..c1e39ba 100644
--- a/src/conf/domain_conf.h
+++ b/src/conf/domain_conf.h
@@ -1070,6 +1070,7 @@ virDomainObjPtr virDomainFindByName(const virDomainObjListPtr doms,
 void virDomainGraphicsDefFree(virDomainGraphicsDefPtr def);
 void virDomainInputDefFree(virDomainInputDefPtr def);
 void virDomainDiskDefFree(virDomainDiskDefPtr def);
+void virDomainDiskHostDefFree(virDomainDiskHostDefPtr def);
 void virDomainControllerDefFree(virDomainControllerDefPtr def);
 void virDomainFSDefFree(virDomainFSDefPtr def);
 void virDomainNetDefFree(virDomainNetDefPtr def);
diff --git a/src/qemu/qemu_conf.c b/src/qemu/qemu_conf.c
index 55e193f..d1368dc 100644
--- a/src/qemu/qemu_conf.c
+++ b/src/qemu/qemu_conf.c
@@ -4010,6 +4010,8 @@ qemudBuildCommandLine(virConnectPtr conn,
     int last_good_net = -1;
     bool hasHwVirt = false;
     virCommandPtr cmd;
+    bool has_rbd_hosts = false;
+    virBuffer rbd_hosts = VIR_BUFFER_INITIALIZER;

     uname_normalize(&ut);

@@ -4550,6 +4552,7 @@ qemudBuildCommandLine(virConnectPtr conn,
             int bootable = 0;
             virDomainDiskDefPtr disk = def->disks[i];
             int withDeviceArg = 0;
+            int j;

             /* Unless we have -device, then USB disks need special
                handling */
@@ -4599,6 +4602,27 @@ qemudBuildCommandLine(virConnectPtr conn,
             virCommandAddArg(cmd, optstr);
             VIR_FREE(optstr);

+            if (disk->type == VIR_DOMAIN_DISK_TYPE_NETWORK &&
+                disk->protocol == VIR_DOMAIN_DISK_PROTOCOL_RBD) {
+                for (j = 0 ; j < disk->nhosts ; j++) {
+                    if (!has_rbd_hosts) {
+                        virBufferAddLit(&rbd_hosts, "-m ");
+                        has_rbd_hosts = true;
+                    } else {
+                        virBufferAddLit(&rbd_hosts, ",");
+                    }
+                    virDomainDiskHostDefPtr host = &disk->hosts[j];
+                    if (host->port) {
+                        virBufferVSprintf(&rbd_hosts, "%s:%s",
+                                          host->name,
+                                          host->port);
+                    } else {
+                        virBufferVSprintf(&rbd_hosts, "%s",
+                                          host->name);
+                    }
+                }
+            }
+
             if (withDeviceArg) {
                 if (disk->bus == VIR_DOMAIN_DISK_BUS_FDC) {
                     virCommandAddArg(cmd, "-global");
@@ -4621,6 +4645,7 @@ qemudBuildCommandLine(virConnectPtr conn,
             char dev[NAME_MAX];
             char file[PATH_MAX];
             virDomainDiskDefPtr disk = def->disks[i];
+            int j;

             if (disk->bus == VIR_DOMAIN_DISK_BUS_USB) {
                 if (disk->device == VIR_DOMAIN_DISK_DEVICE_DISK) {
@@ -4684,6 +4709,23 @@ qemudBuildCommandLine(virConnectPtr conn,
                     break;
                 case VIR_DOMAIN_DISK_PROTOCOL_RBD:
                     snprintf(file, PATH_MAX, "rbd:%s,", disk->src);
+                    for (j = 0 ; j < disk->nhosts ; j++) {
+                        if (!has_rbd_hosts) {
+                            virBufferAddLit(&rbd_hosts, "-m ");
+                            has_rbd_hosts = true;
+                        } else {
+                            virBufferAddLit(&rbd_hosts, ",");
+                        }
+                        virDomainDiskHostDefPtr host = &disk->hosts[j];
+                        if (host->port) {
+                            virBufferVSprintf(&rbd_hosts, "%s:%s",
+                                              host->name,
+                                              host->port);
+                        } else {
+                            virBufferVSprintf(&rbd_hosts, "%s",
+                                              host->name);
+                        }
+                    }
                     break;
                 case VIR_DOMAIN_DISK_PROTOCOL_SHEEPDOG:
                     if (disk->nhosts == 0)
@@ -4703,6 +4745,13 @@ qemudBuildCommandLine(virConnectPtr conn,
         }
     }

+    if (virBufferError(&rbd_hosts)) {
+        virBufferFreeAndReset(&rbd_hosts);
+        goto no_memory;
+    }
+    if (has_rbd_hosts)
+        virCommandAddEnvPair(cmd, "CEPH_ARGS", virBufferContentAndReset(&rbd_hosts));
+
     if (qemuCmdFlags & QEMUD_CMD_FLAG_FSDEV) {
         for (i = 0 ; i < def->nfss ; i++) {
             char *optstr;
@@ -5468,6 +5517,7 @@ static int qemuStringToArgvEnv(const char *args,
     int envend;
     int i;
     const char *curr = args;
+    const char *start;
     const char **progenv = NULL;
     const char **progargv = NULL;

@@ -5475,14 +5525,22 @@ static int qemuStringToArgvEnv(const char *args,
     while (curr && *curr != '\0') {
         char *arg;
         const char *next;
-        if (*curr == '\'') {
-            curr++;
-            next = strchr(curr, '\'');
-        } else if (*curr == '"') {
-            curr++;
-            next = strchr(curr, '"');
+
+        start = curr;
+        /* accept a space in CEPH_ARGS */
+        if (STRPREFIX(curr, "CEPH_ARGS=-m ")) {
+            start += strlen("CEPH_ARGS=-m ");
+        }
+        if (*start == '\'') {
+            if (start == curr)
+                curr++;
+            next = strchr(start + 1, '\'');
+        } else if (*start == '"') {
+            if (start == curr)
+                curr++;
+            next = strchr(start + 1, '"');
         } else {
-            next = strchr(curr, ' ');
+            next = strchr(start, ' ');
         }
         if (!next)
             next = strchr(curr, '\n');
@@ -5712,6 +5770,7 @@ qemuParseCommandLineDisk(virCapsPtr caps,
                     char *host, *port;

                     def->type = VIR_DOMAIN_DISK_TYPE_NETWORK;
+                    def->protocol = VIR_DOMAIN_DISK_PROTOCOL_NBD;
                     host = def->src + strlen("nbd:");
                     port = strchr(host, ':');
                     if (!port) {
@@ -5743,6 +5802,7 @@ qemuParseCommandLineDisk(virCapsPtr caps,
                     char *p = def->src;

                     def->type = VIR_DOMAIN_DISK_TYPE_NETWORK;
+                    def->protocol = VIR_DOMAIN_DISK_PROTOCOL_RBD;
                     def->src = strdup(p + strlen("rbd:"));
                     if (!def->src) {
                         virReportOOMError();
@@ -5755,6 +5815,7 @@ qemuParseCommandLineDisk(virCapsPtr caps,
                     char *port, *vdi;

                     def->type = VIR_DOMAIN_DISK_TYPE_NETWORK;
+                    def->protocol = VIR_DOMAIN_DISK_PROTOCOL_SHEEPDOG;
                     def->src = strdup(p + strlen("sheepdog:"));
                     if (!def->src) {
                         virReportOOMError();
@@ -5870,7 +5931,8 @@ qemuParseCommandLineDisk(virCapsPtr caps,
     }

     if (!def->src &&
-        def->device == VIR_DOMAIN_DISK_DEVICE_DISK) {
+        def->device == VIR_DOMAIN_DISK_DEVICE_DISK &&
+        def->type != VIR_DOMAIN_DISK_TYPE_NETWORK) {
         qemuReportError(VIR_ERR_INTERNAL_ERROR,
                         _("missing file parameter in drive '%s'"), val);
         virDomainDiskDefFree(def);
@@ -6790,7 +6852,7 @@ virDomainDefPtr qemuParseCommandLine(virCapsPtr caps,
                     disk->src = NULL;
                     break;
                 case VIR_DOMAIN_DISK_PROTOCOL_RBD:
-                    /* TODO: set monitor hostnames */
+                    /* handled later since the hosts for all disks are in CEPH_ARGS */
                     break;
                 case VIR_DOMAIN_DISK_PROTOCOL_SHEEPDOG:
                     /* disk->src must be [vdiname] or [host]:[port]:[vdiname] */
@@ -7117,6 +7179,69 @@ virDomainDefPtr qemuParseCommandLine(virCapsPtr caps,
     }

 #undef WANT_VALUE
+    if (def->ndisks > 0) {
+        const char *ceph_args = qemuFindEnv(progenv, "CEPH_ARGS");
+        if (ceph_args) {
+            char *hosts, *port, *saveptr, *token;
+            virDomainDiskDefPtr first_rbd_disk = NULL;
+            for (i = 0 ; i < def->ndisks ; i++) {
+                virDomainDiskDefPtr disk = def->disks[i];
+                if (disk->type == VIR_DOMAIN_DISK_TYPE_NETWORK &&
+                    disk->protocol == VIR_DOMAIN_DISK_PROTOCOL_RBD) {
+                    first_rbd_disk = disk;
+                    break;
+                }
+            }
+
+            if (!first_rbd_disk) {
+                qemuReportError(VIR_ERR_INTERNAL_ERROR,
+                                _("CEPH_ARGS was set without an rbd disk"));
+                goto error;
+            }
+
+            /* CEPH_ARGS should be: -m host1[:port1][,host2[:port2]]... */
+            if (!STRPREFIX(ceph_args, "-m ")) {
+                qemuReportError(VIR_ERR_INTERNAL_ERROR,
+                                _("could not parse CEPH_ARGS '%s'"), ceph_args);
+                goto error;
+            }
+            hosts = strdup(strchr(ceph_args, ' ') + 1);
+            if (!hosts)
+                goto no_memory;
+            first_rbd_disk->nhosts = 0;
+            token = strtok_r(hosts, ",", &saveptr);
+            while (token != NULL) {
+                if (VIR_REALLOC_N(first_rbd_disk->hosts, first_rbd_disk->nhosts + 1) < 0) {
+                    VIR_FREE(hosts);
+                    goto no_memory;
+                }
+                port = strchr(token, ':');
+                if (port) {
+                    *port++ = '\0';
+                    port = strdup(port);
+                    if (!port) {
+                        VIR_FREE(hosts);
+                        goto no_memory;
+                    }
+                }
+                first_rbd_disk->hosts[first_rbd_disk->nhosts].port = port;
+                first_rbd_disk->hosts[first_rbd_disk->nhosts].name = strdup(token);
+                if (!first_rbd_disk->hosts[first_rbd_disk->nhosts].name) {
+                    VIR_FREE(hosts);
+                    goto no_memory;
+                }
+                first_rbd_disk->nhosts++;
+                token = strtok_r(NULL, ",", &saveptr);
+            }
+            VIR_FREE(hosts);
+
+            if (first_rbd_disk->nhosts == 0) {
+                qemuReportError(VIR_ERR_INTERNAL_ERROR,
+                                _("found no rbd hosts in CEPH_ARGS '%s'"), ceph_args);
+                goto error;
+            }
+        }
+    }

     if (!nographics && def->ngraphics == 0) {
         virDomainGraphicsDefPtr sdl;
-- 
1.5.6.5
