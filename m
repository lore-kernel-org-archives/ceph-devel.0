From: Sage Weil <sage@newdream.net>
Subject: [PATCH 5/5] qemu/rbd: improve rbd device specification
Date: Thu, 15 Sep 2011 13:52:24 -0700
Message-ID: <1316119944-25201-6-git-send-email-sage@newdream.net>
References: <1316119944-25201-1-git-send-email-sage@newdream.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49134 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934904Ab1IOUw3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Sep 2011 16:52:29 -0400
In-Reply-To: <1316119944-25201-1-git-send-email-sage@newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: libvir-list@redhat.com
Cc: ceph-devel@vger.kernel.org, Sage Weil <sage@newdream.net>

This improves the support for qemu rbd devices by adding support for a few
key features (e.g., authentication) and cleaning up the way in which
rbd configuration options are passed to qemu.

And <auth> member of the disk source xml specifies how librbd should
authenticate.  The id property is the Ceph/RBD user to authenticate as,
and the domain property is a identifier (local to libvirt) for the Ceph
cluster in question.  If both are specified, we look for a libvirt secret
of type CEPH with matching id and domain properties.

The old RBD support relied on setting an environment variable to
communicate information to qemu/librbd.  Instead, pass those options
explicitly to qemu.  Update the qemu argument parsing and unit tests
accordingly.

Signed-off-by: Sage Weil <sage@newdream.net>
---
 src/qemu/qemu_command.c                            |  268 +++++++++++---------
 .../qemuxml2argv-disk-drive-network-rbd.args       |    6 +-
 .../qemuxml2argv-disk-drive-network-rbd.xml        |    1 +
 3 files changed, 157 insertions(+), 118 deletions(-)

diff --git a/src/qemu/qemu_command.c b/src/qemu/qemu_command.c
index 32dcb79..00fb169 100644
--- a/src/qemu/qemu_command.c
+++ b/src/qemu/qemu_command.c
@@ -38,6 +38,7 @@
 #include "domain_audit.h"
 #include "domain_conf.h"
 #include "network/bridge_driver.h"
+#include "base64.h"
 
 #include <sys/utsname.h>
 #include <sys/stat.h>
@@ -1334,6 +1335,146 @@ qemuSafeSerialParamValue(const char *value)
     return 0;
 }
 
+static int buildRBDString(virConnectPtr conn,
+                          virDomainDiskDefPtr disk,
+                          virBufferPtr opt)
+{
+    int i;
+    char idDomain[80];
+    virSecretPtr sec;
+    char *secret;
+    size_t secret_size;
+
+    virBufferAsprintf(opt, "rbd:%s", disk->src);
+    if (disk->authId) {
+        virBufferEscape(opt, ":", ":id=%s", disk->authId);
+    }
+    if (disk->authDomain) {
+        /* look up secret */
+        snprintf(idDomain, sizeof(idDomain), "%s/%s", disk->authId,
+                 disk->authDomain);
+        sec = virSecretLookupByUsage(conn,
+                                     VIR_SECRET_USAGE_TYPE_CEPH,
+                                     idDomain);
+        if (sec) {
+            char *base64;
+
+            secret = (char *)conn->secretDriver->getValue(sec, &secret_size, 0,
+                                   VIR_SECRET_GET_VALUE_INTERNAL_CALL);
+            /* qemu/librbd wants it base64 encoded */
+            base64_encode_alloc(secret, secret_size, &base64);
+            virBufferEscape(opt, ":", ":key=%s:auth_supported=cephx\\;none",
+                            base64);
+            VIR_FREE(base64);
+            VIR_FREE(secret);
+            virUnrefSecret(sec);
+        } else {
+            VIR_WARN("rbd id '%s' domain '%s' specified but secret not found",
+                     disk->authId, disk->authDomain);
+        }
+    }
+    if (disk->nhosts > 0) {
+        virBufferStrcat(opt, ":mon_host=", NULL);
+        for (i = 0; i < disk->nhosts; ++i) {
+            if (i) {
+                virBufferStrcat(opt, "\\;", NULL);
+            }
+            if (disk->hosts[i].port) {
+                virBufferAsprintf(opt, "%s\\:%s",
+                                  disk->hosts[i].name,
+                                  disk->hosts[i].port);
+            } else {
+                virBufferAsprintf(opt, "%s", disk->hosts[i].name);
+            }
+        }
+    }
+
+    return 0;
+}
+
+static int addRBDHost(virDomainDiskDefPtr disk, char *hostport)
+{
+    char *port;
+    int ret;
+
+    disk->nhosts++;
+    ret = VIR_REALLOC_N(disk->hosts, disk->nhosts);
+    if (ret < 0) {
+        virReportOOMError();
+        return -1;
+    }
+
+    port = strstr(hostport, "\\:");
+    if (port) {
+        *port = '\0';
+        port += 2;
+        disk->hosts[disk->nhosts-1].port = strdup(port);
+    } else {
+        disk->hosts[disk->nhosts-1].port = strdup("6789");
+    }
+    disk->hosts[disk->nhosts-1].name = strdup(hostport);
+    return 0;
+}
+
+/* disk->src initially has everything after the rbd: prefix */
+static int parseRBDString(virDomainDiskDefPtr disk)
+{
+    char *options = NULL;
+    char *p, *e, *next;
+
+    p = strchr(disk->src, ':');
+    if (p) {
+        options = strdup(p + 1);
+        *p = '\0';
+    }
+
+    /* options */
+    if (!options)
+        return 0; /* all done */
+
+    p = options;
+    while (*p) {
+        /* find : delimiter or end of string */
+        for (e = p; *e && *e != ':'; ++e) {
+            if (*e == '\\') {
+                e++;
+                if (*e == '\0')
+                    break;
+            }
+        }
+        if (*e == '\0') {
+            next = e;    /* last kv pair */
+        } else {
+            next = e + 1;
+            *e = '\0';
+        }
+
+        if (STRPREFIX(p, "id=")) {
+            disk->authId = strdup(p + strlen("id="));
+        }
+        if (STRPREFIX(p, "mon_host=")) {
+            char *h, *sep;
+
+            h = p + strlen("mon_host=");
+            while (h < e) {
+                for (sep = h; sep < e; ++sep) {
+                    if (*sep == '\\' && (sep[1] == ',' ||
+                                         sep[1] == ';' ||
+                                         sep[1] == ' ')) {
+                        *sep = '\0';
+                        sep += 2;
+                        break;
+                    }
+                }
+                addRBDHost(disk, h);
+                h = sep;
+            }
+        }
+
+        p = next;
+    }
+    return 0;
+}
 
 char *
 qemuBuildDriveStr(virConnectPtr conn,
@@ -1453,8 +1594,9 @@ qemuBuildDriveStr(virConnectPtr conn,
                                   disk->hosts->name, disk->hosts->port);
                 break;
             case VIR_DOMAIN_DISK_PROTOCOL_RBD:
-                /* TODO: set monitor hostnames */
-                virBufferAsprintf(&opt, "file=rbd:%s,", disk->src);
+                virBufferStrcat(&opt, "file=", NULL);
+                buildRBDString(conn, disk, &opt);
+                virBufferStrcat(&opt, ",", NULL);
                 break;
             case VIR_DOMAIN_DISK_PROTOCOL_SHEEPDOG:
                 if (disk->nhosts == 0)
@@ -2851,8 +2993,6 @@ qemuBuildCommandLine(virConnectPtr conn,
     int last_good_net = -1;
     bool hasHwVirt = false;
     virCommandPtr cmd;
-    bool has_rbd_hosts = false;
-    virBuffer rbd_hosts = VIR_BUFFER_INITIALIZER;
     bool emitBootindex = false;
 
     uname_normalize(&ut);
@@ -3413,7 +3553,6 @@ qemuBuildCommandLine(virConnectPtr conn,
             virDomainDiskDefPtr disk = def->disks[i];
             int withDeviceArg = 0;
             bool deviceFlagMasked = false;
-            int j;
 
             /* Unless we have -device, then USB disks need special
                handling */
@@ -3471,26 +3610,6 @@ qemuBuildCommandLine(virConnectPtr conn,
             virCommandAddArg(cmd, optstr);
             VIR_FREE(optstr);
 
-            if (disk->type == VIR_DOMAIN_DISK_TYPE_NETWORK &&
-                disk->protocol == VIR_DOMAIN_DISK_PROTOCOL_RBD) {
-                for (j = 0 ; j < disk->nhosts ; j++) {
-                    if (!has_rbd_hosts) {
-                        virBufferAddLit(&rbd_hosts, "CEPH_ARGS=-m ");
-                        has_rbd_hosts = true;
-                    } else {
-                        virBufferAddLit(&rbd_hosts, ",");
-                    }
-                    virDomainDiskHostDefPtr host = &disk->hosts[j];
-                    if (host->port) {
-                        virBufferAsprintf(&rbd_hosts, "%s:%s",
-                                          host->name,
-                                          host->port);
-                    } else {
-                        virBufferAdd(&rbd_hosts, host->name, -1);
-                    }
-                }
-            }
-
             if (!emitBootindex)
                 bootindex = 0;
             else if (disk->bootIndex)
@@ -3528,7 +3647,6 @@ qemuBuildCommandLine(virConnectPtr conn,
             char *file;
             const char *fmt;
             virDomainDiskDefPtr disk = def->disks[i];
-            int j;
 
             if (disk->bus == VIR_DOMAIN_DISK_BUS_USB) {
                 if (disk->device == VIR_DOMAIN_DISK_DEVICE_DISK) {
@@ -3597,24 +3715,11 @@ qemuBuildCommandLine(virConnectPtr conn,
                     }
                     break;
                 case VIR_DOMAIN_DISK_PROTOCOL_RBD:
-                    if (virAsprintf(&file, "rbd:%s,", disk->src) < 0) {
-                        goto no_memory;
-                    }
-                    for (j = 0 ; j < disk->nhosts ; j++) {
-                        if (!has_rbd_hosts) {
-                            virBufferAddLit(&rbd_hosts, "CEPH_ARGS=-m ");
-                            has_rbd_hosts = true;
-                        } else {
-                            virBufferAddLit(&rbd_hosts, ",");
-                        }
-                        virDomainDiskHostDefPtr host = &disk->hosts[j];
-                        if (host->port) {
-                            virBufferAsprintf(&rbd_hosts, "%s:%s",
-                                              host->name,
-                                              host->port);
-                        } else {
-                            virBufferAdd(&rbd_hosts, host->name, -1);
-                        }
+                    {
+                        virBuffer opt = VIR_BUFFER_INITIALIZER;
+                        buildRBDString(conn, disk, &opt);
+                        virAsprintf(&file, "%s",
+                                    virBufferContentAndReset(&opt));
                     }
                     break;
                 case VIR_DOMAIN_DISK_PROTOCOL_SHEEPDOG:
@@ -3643,9 +3748,6 @@ qemuBuildCommandLine(virConnectPtr conn,
         }
     }
 
-    if (has_rbd_hosts)
-        virCommandAddEnvBuffer(cmd, &rbd_hosts);
-
     if (qemuCapsGet(qemuCaps, QEMU_CAPS_FSDEV)) {
         for (i = 0 ; i < def->nfss ; i++) {
             char *optstr;
@@ -4777,7 +4879,6 @@ qemuBuildCommandLine(virConnectPtr conn,
         networkReleaseActualDevice(def->nets[i]);
     for (i = 0; i <= last_good_net; i++)
         virDomainConfNWFilterTeardown(def->nets[i]);
-    virBufferFreeAndReset(&rbd_hosts);
     virCommandFree(cmd);
     return NULL;
 }
@@ -4809,10 +4910,6 @@ static int qemuStringToArgvEnv(const char *args,
         const char *next;
 
         start = curr;
-        /* accept a space in CEPH_ARGS */
-        if (STRPREFIX(curr, "CEPH_ARGS=-m ")) {
-            start += strlen("CEPH_ARGS=-m ");
-        }
         if (*start == '\'') {
             if (start == curr)
                 curr++;
@@ -5091,6 +5188,8 @@ qemuParseCommandLineDisk(virCapsPtr caps,
                         virReportOOMError();
                         goto cleanup;
                     }
+                    if (parseRBDString(def) < 0)
+                        goto cleanup;
 
                     VIR_FREE(p);
                 } else if (STRPREFIX(def->src, "sheepdog:")) {
@@ -6195,7 +6294,8 @@ virDomainDefPtr qemuParseCommandLine(virCapsPtr caps,
                     disk->src = NULL;
                     break;
                 case VIR_DOMAIN_DISK_PROTOCOL_RBD:
-                    /* handled later since the hosts for all disks are in CEPH_ARGS */
+                    if (parseRBDString(disk) < 0)
+                        goto error;
                     break;
                 case VIR_DOMAIN_DISK_PROTOCOL_SHEEPDOG:
                     /* disk->src must be [vdiname] or [host]:[port]:[vdiname] */
@@ -6534,68 +6634,6 @@ virDomainDefPtr qemuParseCommandLine(virCapsPtr caps,
     }
 
 #undef WANT_VALUE
-    if (def->ndisks > 0) {
-        const char *ceph_args = qemuFindEnv(progenv, "CEPH_ARGS");
-        if (ceph_args) {
-            char *hosts, *port, *saveptr = NULL, *token;
-            virDomainDiskDefPtr first_rbd_disk = NULL;
-            for (i = 0 ; i < def->ndisks ; i++) {
-                if (def->disks[i]->type == VIR_DOMAIN_DISK_TYPE_NETWORK &&
-                    def->disks[i]->protocol == VIR_DOMAIN_DISK_PROTOCOL_RBD) {
-                    first_rbd_disk = def->disks[i];
-                    break;
-                }
-            }
-
-            if (!first_rbd_disk) {
-                qemuReportError(VIR_ERR_INTERNAL_ERROR,
-                                _("CEPH_ARGS was set without an rbd disk"));
-                goto error;
-            }
-
-            /* CEPH_ARGS should be: -m host1[:port1][,host2[:port2]]... */
-            if (!STRPREFIX(ceph_args, "-m ")) {
-                qemuReportError(VIR_ERR_INTERNAL_ERROR,
-                                _("could not parse CEPH_ARGS '%s'"), ceph_args);
-                goto error;
-            }
-            hosts = strdup(strchr(ceph_args, ' ') + 1);
-            if (!hosts)
-                goto no_memory;
-            first_rbd_disk->nhosts = 0;
-            token = strtok_r(hosts, ",", &saveptr);
-            while (token != NULL) {
-                if (VIR_REALLOC_N(first_rbd_disk->hosts, first_rbd_disk->nhosts + 1) < 0) {
-                    VIR_FREE(hosts);
-                    goto no_memory;
-                }
-                port = strchr(token, ':');
-                if (port) {
-                    *port++ = '\0';
-                    port = strdup(port);
-                    if (!port) {
-                        VIR_FREE(hosts);
-                        goto no_memory;
-                    }
-                }
-                first_rbd_disk->hosts[first_rbd_disk->nhosts].port = port;
-                first_rbd_disk->hosts[first_rbd_disk->nhosts].name = strdup(token);
-                if (!first_rbd_disk->hosts[first_rbd_disk->nhosts].name) {
-                    VIR_FREE(hosts);
-                    goto no_memory;
-                }
-                first_rbd_disk->nhosts++;
-                token = strtok_r(NULL, ",", &saveptr);
-            }
-            VIR_FREE(hosts);
-
-            if (first_rbd_disk->nhosts == 0) {
-                qemuReportError(VIR_ERR_INTERNAL_ERROR,
-                                _("found no rbd hosts in CEPH_ARGS '%s'"), ceph_args);
-                goto error;
-            }
-        }
-    }
 
     if (!nographics && def->ngraphics == 0) {
         virDomainGraphicsDefPtr sdl;
diff --git a/tests/qemuxml2argvdata/qemuxml2argv-disk-drive-network-rbd.args b/tests/qemuxml2argvdata/qemuxml2argv-disk-drive-network-rbd.args
index 3ab1219..68b9e95 100644
--- a/tests/qemuxml2argvdata/qemuxml2argv-disk-drive-network-rbd.args
+++ b/tests/qemuxml2argvdata/qemuxml2argv-disk-drive-network-rbd.args
@@ -1,6 +1,6 @@
-LC_ALL=C PATH=/bin HOME=/home/test USER=test LOGNAME=test CEPH_ARGS=-m \
-mon1.example.org:6321,mon2.example.org:6322,mon3.example.org:6322 \
+LC_ALL=C PATH=/bin HOME=/home/test USER=test LOGNAME=test \
 /usr/bin/qemu -S -M pc -m 214 -smp 1 -nographic -monitor \
 unix:/tmp/test-monitor,server,nowait -no-acpi -boot c -drive \
-file=/dev/HostVG/QEMUGuest1,if=ide,bus=0,unit=0 -drive file=rbd:pool/image,\
+file=/dev/HostVG/QEMUGuest1,if=ide,bus=0,unit=0 -drive \
+file=rbd:pool/image:id=myname:mon_host=mon1.example.org\:6321\;mon2.example.org\:6322\;mon3.example.org\:6322,\
 if=virtio,format=raw -net none -serial none -parallel none -usb
diff --git a/tests/qemuxml2argvdata/qemuxml2argv-disk-drive-network-rbd.xml b/tests/qemuxml2argvdata/qemuxml2argv-disk-drive-network-rbd.xml
index e920db1..f090834 100644
--- a/tests/qemuxml2argvdata/qemuxml2argv-disk-drive-network-rbd.xml
+++ b/tests/qemuxml2argvdata/qemuxml2argv-disk-drive-network-rbd.xml
@@ -22,6 +22,7 @@
     <disk type='network' device='disk'>
       <driver name='qemu' type='raw'/>
       <source protocol='rbd' name='pool/image'>
+        <auth id='myname'/>
         <host name='mon1.example.org' port='6321'/>
         <host name='mon2.example.org' port='6322'/>
         <host name='mon3.example.org' port='6322'/>
-- 
1.7.4.1

