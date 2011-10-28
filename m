From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: [PATCH v4 4/4] qemu/rbd: improve rbd device specification
Date: Fri, 28 Oct 2011 14:19:33 -0700
Message-ID: <fc9aba44da7d8be72fabeba1caf07901aaef202d.1319836201.git.josh.durgin@dreamhost.com>
References: <20111027083823.GD20878@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:46213 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933393Ab1J1VTq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 28 Oct 2011 17:19:46 -0400
In-Reply-To: <20111027083823.GD20878@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: libvir-list@redhat.com
Cc: ceph-devel@vger.kernel.org, berrange@redhat.com, eblake@redhat.com

From: Sage Weil <sage@newdream.net>

This improves the support for qemu rbd devices by adding support for a few
key features (e.g., authentication) and cleaning up the way in which
rbd configuration options are passed to qemu.

And <auth> member of the disk source xml specifies how librbd should
authenticate. The username attribute is the Ceph/RBD user to authenticate as.
The usage or uuid attributes specify which secret to use. Usage is an
arbitrary identifier local to libvirt.

The old RBD support relied on setting an environment variable to
communicate information to qemu/librbd.  Instead, pass those options
explicitly to qemu.  Update the qemu argument parsing and tests
accordingly.

Signed-off-by: Sage Weil <sage@newdream.net>
Signed-off-by: Josh Durgin <josh.durgin@dreamhost.com>
---

This fixes the things Daniel mentioned.

 src/qemu/qemu_command.c                            |  284 ++++++++++++--------
 .../qemuxml2argv-disk-drive-network-rbd-auth.args  |    6 +
 .../qemuxml2argv-disk-drive-network-rbd-auth.xml   |   37 +++
 .../qemuxml2argv-disk-drive-network-rbd.args       |    6 +-
 tests/qemuxml2argvtest.c                           |   56 ++++
 5 files changed, 272 insertions(+), 117 deletions(-)
 create mode 100644 tests/qemuxml2argvdata/qemuxml2argv-disk-drive-network-rbd-auth.args
 create mode 100644 tests/qemuxml2argvdata/qemuxml2argv-disk-drive-network-rbd-auth.xml

diff --git a/src/qemu/qemu_command.c b/src/qemu/qemu_command.c
index f5d89b9..48b0762 100644
--- a/src/qemu/qemu_command.c
+++ b/src/qemu/qemu_command.c
@@ -38,6 +38,7 @@
 #include "domain_audit.h"
 #include "domain_conf.h"
 #include "network/bridge_driver.h"
+#include "base64.h"
 
 #include <sys/utsname.h>
 #include <sys/stat.h>
@@ -1495,6 +1496,159 @@ qemuSafeSerialParamValue(const char *value)
     return 0;
 }
 
+static int qemuBuildRBDString(virConnectPtr conn,
+                              virDomainDiskDefPtr disk,
+                              virBufferPtr opt)
+{
+    int i;
+    virSecretPtr sec = NULL;
+    char *secret = NULL;
+    size_t secret_size;
+
+    virBufferAsprintf(opt, "rbd:%s", disk->src);
+    if (disk->auth.username) {
+        virBufferEscape(opt, ":", ":id=%s", disk->auth.username);
+        /* look up secret */
+        switch (disk->auth.secretType) {
+        case VIR_DOMAIN_DISK_SECRET_TYPE_UUID:
+            sec = virSecretLookupByUUID(conn,
+                                        disk->auth.secret.uuid);
+            break;
+        case VIR_DOMAIN_DISK_SECRET_TYPE_USAGE:
+            sec = virSecretLookupByUsage(conn,
+                                         VIR_SECRET_USAGE_TYPE_CEPH,
+                                         disk->auth.secret.usage);
+            break;
+        }
+
+        if (sec) {
+            char *base64;
+
+            secret = (char *)conn->secretDriver->getValue(sec, &secret_size, 0,
+                                                          VIR_SECRET_GET_VALUE_INTERNAL_CALL);
+            if (secret == NULL) {
+                qemuReportError(VIR_ERR_INTERNAL_ERROR,
+                                _("could not get the value of the secret for username %s"),
+                                disk->auth.username);
+                return -1;
+            }
+            /* qemu/librbd wants it base64 encoded */
+            base64_encode_alloc(secret, secret_size, &base64);
+            virBufferEscape(opt, ":", ":key=%s:auth_supported=cephx\\;none",
+                            base64);
+            VIR_FREE(base64);
+            VIR_FREE(secret);
+            virUnrefSecret(sec);
+        } else {
+            qemuReportError(VIR_ERR_INTERNAL_ERROR,
+                            _("rbd username '%s' specified but secret not found"),
+                            disk->auth.username);
+            return -1;
+        }
+    }
+
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
+static int qemuAddRBDHost(virDomainDiskDefPtr disk, char *hostport)
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
+static int qemuParseRBDString(virDomainDiskDefPtr disk)
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
+            disk->auth.username = strdup(p + strlen("id="));
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
+                qemuAddRBDHost(disk, h);
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
@@ -1614,8 +1768,10 @@ qemuBuildDriveStr(virConnectPtr conn,
                                   disk->hosts->name, disk->hosts->port);
                 break;
             case VIR_DOMAIN_DISK_PROTOCOL_RBD:
-                /* TODO: set monitor hostnames */
-                virBufferAsprintf(&opt, "file=rbd:%s,", disk->src);
+                virBufferStrcat(&opt, "file=", NULL);
+                if (qemuBuildRBDString(conn, disk, &opt) < 0)
+                    goto error;
+                virBufferStrcat(&opt, ",", NULL);
                 break;
             case VIR_DOMAIN_DISK_PROTOCOL_SHEEPDOG:
                 if (disk->nhosts == 0)
@@ -3284,8 +3440,6 @@ qemuBuildCommandLine(virConnectPtr conn,
     int last_good_net = -1;
     bool hasHwVirt = false;
     virCommandPtr cmd;
-    bool has_rbd_hosts = false;
-    virBuffer rbd_hosts = VIR_BUFFER_INITIALIZER;
     bool emitBootindex = false;
     int usbcontroller = 0;
     bool usblegacy = false;
@@ -3865,7 +4019,6 @@ qemuBuildCommandLine(virConnectPtr conn,
             virDomainDiskDefPtr disk = def->disks[i];
             int withDeviceArg = 0;
             bool deviceFlagMasked = false;
-            int j;
 
             /* Unless we have -device, then USB disks need special
                handling */
@@ -3923,26 +4076,6 @@ qemuBuildCommandLine(virConnectPtr conn,
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
@@ -3980,7 +4113,6 @@ qemuBuildCommandLine(virConnectPtr conn,
             char *file;
             const char *fmt;
             virDomainDiskDefPtr disk = def->disks[i];
-            int j;
 
             if (disk->bus == VIR_DOMAIN_DISK_BUS_USB) {
                 if (disk->device == VIR_DOMAIN_DISK_DEVICE_DISK) {
@@ -4049,24 +4181,15 @@ qemuBuildCommandLine(virConnectPtr conn,
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
+                    {
+                        virBuffer opt = VIR_BUFFER_INITIALIZER;
+                        if (qemuBuildRBDString(conn, disk, &opt) < 0)
+                            goto error;
+                        if (virBufferError(&opt)) {
+                            virReportOOMError();
+                            goto error;
                         }
+                        file = virBufferContentAndReset(&opt);
                     }
                     break;
                 case VIR_DOMAIN_DISK_PROTOCOL_SHEEPDOG:
@@ -4095,9 +4218,6 @@ qemuBuildCommandLine(virConnectPtr conn,
         }
     }
 
-    if (has_rbd_hosts)
-        virCommandAddEnvBuffer(cmd, &rbd_hosts);
-
     if (qemuCapsGet(qemuCaps, QEMU_CAPS_FSDEV)) {
         for (i = 0 ; i < def->nfss ; i++) {
             char *optstr;
@@ -5267,7 +5387,6 @@ qemuBuildCommandLine(virConnectPtr conn,
         networkReleaseActualDevice(def->nets[i]);
     for (i = 0; i <= last_good_net; i++)
         virDomainConfNWFilterTeardown(def->nets[i]);
-    virBufferFreeAndReset(&rbd_hosts);
     virCommandFree(cmd);
     return NULL;
 }
@@ -5299,10 +5418,6 @@ static int qemuStringToArgvEnv(const char *args,
         const char *next;
 
         start = curr;
-        /* accept a space in CEPH_ARGS */
-        if (STRPREFIX(curr, "CEPH_ARGS=-m ")) {
-            start += strlen("CEPH_ARGS=-m ");
-        }
         if (*start == '\'') {
             if (start == curr)
                 curr++;
@@ -5581,6 +5696,8 @@ qemuParseCommandLineDisk(virCapsPtr caps,
                         virReportOOMError();
                         goto cleanup;
                     }
+                    if (qemuParseRBDString(def) < 0)
+                        goto cleanup;
 
                     VIR_FREE(p);
                 } else if (STRPREFIX(def->src, "sheepdog:")) {
@@ -6700,7 +6817,8 @@ virDomainDefPtr qemuParseCommandLine(virCapsPtr caps,
                     disk->src = NULL;
                     break;
                 case VIR_DOMAIN_DISK_PROTOCOL_RBD:
-                    /* handled later since the hosts for all disks are in CEPH_ARGS */
+                    if (qemuParseRBDString(disk) < 0)
+                        goto error;
                     break;
                 case VIR_DOMAIN_DISK_PROTOCOL_SHEEPDOG:
                     /* disk->src must be [vdiname] or [host]:[port]:[vdiname] */
@@ -7039,68 +7157,6 @@ virDomainDefPtr qemuParseCommandLine(virCapsPtr caps,
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
diff --git a/tests/qemuxml2argvdata/qemuxml2argv-disk-drive-network-rbd-auth.args b/tests/qemuxml2argvdata/qemuxml2argv-disk-drive-network-rbd-auth.args
new file mode 100644
index 0000000..f827615
--- /dev/null
+++ b/tests/qemuxml2argvdata/qemuxml2argv-disk-drive-network-rbd-auth.args
@@ -0,0 +1,6 @@
+LC_ALL=C PATH=/bin HOME=/home/test USER=test LOGNAME=test \
+/usr/bin/qemu -S -M pc -m 214 -smp 1 -nographic -monitor \
+unix:/tmp/test-monitor,server,nowait -no-acpi -boot c -drive \
+file=/dev/HostVG/QEMUGuest1,if=ide,bus=0,unit=0 -drive \
+file=rbd:pool/image:id=myname:key=QVFDVm41aE82SHpGQWhBQXEwTkN2OGp0SmNJY0UrSE9CbE1RMUE=:auth_supported=cephx\;none:mon_host=mon1.example.org\:6321\;mon2.example.org\:6322\;mon3.example.org\:6322,\
+if=virtio,format=raw -net none -serial none -parallel none -usb
diff --git a/tests/qemuxml2argvdata/qemuxml2argv-disk-drive-network-rbd-auth.xml b/tests/qemuxml2argvdata/qemuxml2argv-disk-drive-network-rbd-auth.xml
new file mode 100644
index 0000000..88f7f7a
--- /dev/null
+++ b/tests/qemuxml2argvdata/qemuxml2argv-disk-drive-network-rbd-auth.xml
@@ -0,0 +1,37 @@
+<domain type='qemu'>
+  <name>QEMUGuest1</name>
+  <uuid>c7a5fdbd-edaf-9455-926a-d65c16db1809</uuid>
+  <memory>219136</memory>
+  <currentMemory>219136</currentMemory>
+  <vcpu>1</vcpu>
+  <os>
+    <type arch='i686' machine='pc'>hvm</type>
+    <boot dev='hd'/>
+  </os>
+  <clock offset='utc'/>
+  <on_poweroff>destroy</on_poweroff>
+  <on_reboot>restart</on_reboot>
+  <on_crash>destroy</on_crash>
+  <devices>
+    <emulator>/usr/bin/qemu</emulator>
+    <disk type='block' device='disk'>
+      <source dev='/dev/HostVG/QEMUGuest1'/>
+      <target dev='hda' bus='ide'/>
+      <address type='drive' controller='0' bus='0' unit='0'/>
+    </disk>
+    <disk type='network' device='disk'>
+      <driver name='qemu' type='raw'/>
+      <auth username='myname'>
+        <secret type='ceph' usage='mycluster_myname'/>
+      </auth>
+      <source protocol='rbd' name='pool/image'>
+        <host name='mon1.example.org' port='6321'/>
+        <host name='mon2.example.org' port='6322'/>
+        <host name='mon3.example.org' port='6322'/>
+      </source>
+      <target dev='vda' bus='virtio'/>
+    </disk>
+    <controller type='ide' index='0'/>
+    <memballoon model='virtio'/>
+  </devices>
+</domain>
diff --git a/tests/qemuxml2argvdata/qemuxml2argv-disk-drive-network-rbd.args b/tests/qemuxml2argvdata/qemuxml2argv-disk-drive-network-rbd.args
index 3ab1219..50651a5 100644
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
+file=rbd:pool/image:mon_host=mon1.example.org\:6321\;mon2.example.org\:6322\;mon3.example.org\:6322,\
 if=virtio,format=raw -net none -serial none -parallel none -usb
diff --git a/tests/qemuxml2argvtest.c b/tests/qemuxml2argvtest.c
index 4d6db01..34017aa 100644
--- a/tests/qemuxml2argvtest.c
+++ b/tests/qemuxml2argvtest.c
@@ -12,6 +12,7 @@
 
 # include "internal.h"
 # include "testutils.h"
+# include "util/memory.h"
 # include "qemu/qemu_capabilities.h"
 # include "qemu/qemu_command.h"
 # include "qemu/qemu_domain.h"
@@ -23,6 +24,58 @@
 static const char *abs_top_srcdir;
 static struct qemud_driver driver;
 
+static unsigned char *
+fakeSecretGetValue(virSecretPtr obj ATTRIBUTE_UNUSED,
+                   size_t *value_size,
+                   unsigned int fakeflags ATTRIBUTE_UNUSED,
+                   unsigned int internalFlags ATTRIBUTE_UNUSED)
+{
+    char *secret = strdup("AQCVn5hO6HzFAhAAq0NCv8jtJcIcE+HOBlMQ1A");
+    *value_size = strlen(secret);
+    return (unsigned char *) secret;
+}
+
+static virSecretPtr
+fakeSecretLookupByUsage(virConnectPtr conn,
+                        int usageType ATTRIBUTE_UNUSED,
+                        const char *usageID)
+{
+    virSecretPtr ret = NULL;
+    int err;
+    if (STRNEQ(usageID, "mycluster_myname"))
+        return NULL;
+    err = VIR_ALLOC(ret);
+    if (err < 0)
+        return NULL;
+    ret->magic = VIR_SECRET_MAGIC;
+    ret->conn = conn;
+    conn->refs++;
+    ret->refs = 1;
+    ret->usageID = strdup(usageID);
+    return ret;
+}
+
+static int
+fakeSecretClose(virConnectPtr conn ATTRIBUTE_UNUSED)
+{
+    return 0;
+}
+
+static virSecretDriver fakeSecretDriver = {
+    .name = "fake_secret",
+    .open = NULL,
+    .close = fakeSecretClose,
+    .numOfSecrets = NULL,
+    .listSecrets = NULL,
+    .lookupByUUID = NULL,
+    .lookupByUsage = fakeSecretLookupByUsage,
+    .defineXML = NULL,
+    .getXMLDesc = NULL,
+    .setValue = NULL,
+    .getValue = fakeSecretGetValue,
+    .undefine = NULL,
+};
+
 static int testCompareXMLToArgvFiles(const char *xml,
                                      const char *cmdline,
                                      virBitmapPtr extraFlags,
@@ -44,6 +97,7 @@ static int testCompareXMLToArgvFiles(const char *xml,
 
     if (!(conn = virGetConnect()))
         goto fail;
+    conn->secretDriver = &fakeSecretDriver;
 
     len = virtTestLoadFile(cmdline, &expectargv);
     if (len < 0)
@@ -357,6 +411,8 @@ mymain(void)
             QEMU_CAPS_DRIVE, QEMU_CAPS_DRIVE_FORMAT);
     DO_TEST("disk-drive-network-sheepdog", false,
             QEMU_CAPS_DRIVE, QEMU_CAPS_DRIVE_FORMAT);
+    DO_TEST("disk-drive-network-rbd-auth", false,
+            QEMU_CAPS_DRIVE, QEMU_CAPS_DRIVE_FORMAT);
     DO_TEST("disk-drive-no-boot", false,
             QEMU_CAPS_DRIVE, QEMU_CAPS_DEVICE, QEMU_CAPS_BOOTINDEX);
     DO_TEST("disk-usb", false, NONE);
-- 
1.7.1

