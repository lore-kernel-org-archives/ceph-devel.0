From: MORITA Kazutaka <morita.kazutaka-Zyj7fXuS5i5L9jVzuh4AOg@public.gmane.org>
Subject: [PATCH v2] add network disk support
Date: Mon,  6 Dec 2010 16:24:09 +0900
Message-ID: <1291620249-19645-1-git-send-email-morita.kazutaka@lab.ntt.co.jp>
References: <20101202131928.GV2502@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <sheepdog-bounces-CJ+3F33aHDCwRfvgX43A7Q@public.gmane.org>
In-Reply-To: <20101202131928.GV2502-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <http://lists.wpkg.org/mailman/options/sheepdog>,
	<mailto:sheepdog-request-CJ+3F33aHDCwRfvgX43A7Q@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.wpkg.org/pipermail/sheepdog>
List-Post: <mailto:sheepdog-CJ+3F33aHDCwRfvgX43A7Q@public.gmane.org>
List-Help: <mailto:sheepdog-request-CJ+3F33aHDCwRfvgX43A7Q@public.gmane.org?subject=help>
List-Subscribe: <http://lists.wpkg.org/mailman/listinfo/sheepdog>,
	<mailto:sheepdog-request-CJ+3F33aHDCwRfvgX43A7Q@public.gmane.org?subject=subscribe>
Sender: sheepdog-bounces-CJ+3F33aHDCwRfvgX43A7Q@public.gmane.org
Errors-To: sheepdog-bounces-CJ+3F33aHDCwRfvgX43A7Q@public.gmane.org
To: berrange-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, libvir-list-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sheepdog-CJ+3F33aHDCwRfvgX43A7Q@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

This patch adds network disk support to libvirt/QEMU.  The currently
supported protocols are nbd, rbd, and sheepdog.  The XML syntax is like
this:

    <disk type="network" device="disk">
      <driver name="qemu" type="raw" />
      <source protocol='rbd|sheepdog|nbd' name="...some image identifier...">
        <host name="mon1.example.org" port="6000">
        <host name="mon2.example.org" port="6000">
        <host name="mon3.example.org" port="6000">
      </source>
      <target dev="vda" bus="virtio" />
    </disk>

Signed-off-by: MORITA Kazutaka <morita.kazutaka-Zyj7fXuS5i5L9jVzuh4AOg@public.gmane.org>
---

Hi,

Thanks for your comments, Daniel.  Here is a fixed version.

Changes from v1 to v2 are:
 - check whether the XML input is valid or not more strictly
 - fix memory leak in the error path
 - add NULL check of the return value of strdup()

Thanks,

Kazutaka


 docs/schemas/domain.rng |   31 +++++++
 src/conf/domain_conf.c  |   95 +++++++++++++++++++-
 src/conf/domain_conf.h  |   20 ++++
 src/qemu/qemu_conf.c    |  221 ++++++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 358 insertions(+), 9 deletions(-)

diff --git a/docs/schemas/domain.rng b/docs/schemas/domain.rng
index 08ebefb..3b76c9f 100644
--- a/docs/schemas/domain.rng
+++ b/docs/schemas/domain.rng
@@ -612,6 +612,37 @@
             <ref name="diskspec"/>
           </interleave>
         </group>
+        <group>
+          <attribute name="type">
+            <value>network</value>
+          </attribute>
+          <interleave>
+            <optional>
+              <element name="source">
+                <attribute name="protocol">
+                  <choice>
+                    <value>nbd</value>
+                    <value>rbd</value>
+                    <value>sheepdog</value>
+                  </choice>
+                </attribute>
+                <attribute name="name"/>
+                <zeroOrMore>
+                  <element name="host">
+                    <attribute name="name">
+                      <ref name="genericName"/>
+                    </attribute>
+                    <attribute name="port">
+                      <ref name="unsignedInt"/>
+                    </attribute>
+                  </element>
+                </zeroOrMore>
+                <empty/>
+              </element>
+            </optional>
+            <ref name="diskspec"/>
+          </interleave>
+        </group>
         <ref name="diskspec"/>
       </choice>
     </element>
diff --git a/src/conf/domain_conf.c b/src/conf/domain_conf.c
index 9516427..1350e22 100644
--- a/src/conf/domain_conf.c
+++ b/src/conf/domain_conf.c
@@ -112,7 +112,8 @@ VIR_ENUM_IMPL(virDomainDeviceAddress, VIR_DOMAIN_DEVICE_ADDRESS_TYPE_LAST,
 VIR_ENUM_IMPL(virDomainDisk, VIR_DOMAIN_DISK_TYPE_LAST,
               "block",
               "file",
-              "dir")
+              "dir",
+              "network")
 
 VIR_ENUM_IMPL(virDomainDiskDevice, VIR_DOMAIN_DISK_DEVICE_LAST,
               "disk",
@@ -141,6 +142,11 @@ VIR_ENUM_IMPL(virDomainDiskErrorPolicy, VIR_DOMAIN_DISK_ERROR_POLICY_LAST,
               "ignore",
               "enospace")
 
+VIR_ENUM_IMPL(virDomainDiskProtocol, VIR_DOMAIN_DISK_PROTOCOL_LAST,
+              "nbd",
+              "rbd",
+              "sheepdog")
+
 VIR_ENUM_IMPL(virDomainController, VIR_DOMAIN_CONTROLLER_TYPE_LAST,
               "ide",
               "fdc",
@@ -507,6 +513,7 @@ void virDomainDiskDefFree(virDomainDiskDefPtr def)
 
     VIR_FREE(def->serial);
     VIR_FREE(def->src);
+    VIR_FREE(def->hosts);
     VIR_FREE(def->dst);
     VIR_FREE(def->driverName);
     VIR_FREE(def->driverType);
@@ -1573,13 +1580,16 @@ virDomainDiskDefParseXML(virCapsPtr caps,
                          xmlNodePtr node,
                          int flags) {
     virDomainDiskDefPtr def;
-    xmlNodePtr cur;
+    xmlNodePtr cur, host;
     char *type = NULL;
     char *device = NULL;
     char *driverName = NULL;
     char *driverType = NULL;
     char *source = NULL;
     char *target = NULL;
+    char *protocol = NULL;
+    virDomainDiskHostDefPtr hosts = NULL;
+    int nhosts = 0;
     char *bus = NULL;
     char *cachetag = NULL;
     char *error_policy = NULL;
@@ -1606,7 +1616,7 @@ virDomainDiskDefParseXML(virCapsPtr caps,
     cur = node->children;
     while (cur != NULL) {
         if (cur->type == XML_ELEMENT_NODE) {
-            if ((source == NULL) &&
+            if ((source == NULL && hosts == NULL) &&
                 (xmlStrEqual(cur->name, BAD_CAST "source"))) {
 
                 switch (def->type) {
@@ -1619,6 +1629,49 @@ virDomainDiskDefParseXML(virCapsPtr caps,
                 case VIR_DOMAIN_DISK_TYPE_DIR:
                     source = virXMLPropString(cur, "dir");
                     break;
+                case VIR_DOMAIN_DISK_TYPE_NETWORK:
+                    protocol = virXMLPropString(cur, "protocol");
+                    if (protocol == NULL) {
+                        virDomainReportError(VIR_ERR_INTERNAL_ERROR,
+                                             "%s", _("missing protocol type"));
+                        goto error;
+                    }
+                    def->protocol = virDomainDiskProtocolTypeFromString(protocol);
+                    if (def->protocol < 0) {
+                        virDomainReportError(VIR_ERR_INTERNAL_ERROR,
+                                             _("unknown protocol type '%s'"),
+                                             protocol);
+                        goto error;
+                    }
+                    source = virXMLPropString(cur, "name");
+                    host = cur->children;
+                    while (host != NULL) {
+                        if (host->type == XML_ELEMENT_NODE &&
+                            xmlStrEqual(host->name, BAD_CAST "host")) {
+                            if (VIR_REALLOC_N(hosts, nhosts + 1) < 0) {
+                                virReportOOMError();
+                                goto error;
+                            }
+                            hosts[nhosts].name = NULL;
+                            hosts[nhosts].port = NULL;
+                            nhosts++;
+
+                            hosts[nhosts - 1].name = virXMLPropString(host, "name");
+                            if (!hosts[nhosts - 1].name) {
+                                virDomainReportError(VIR_ERR_INTERNAL_ERROR,
+                                                     "%s", _("missing name for host"));
+                                goto error;
+                            }
+                            hosts[nhosts - 1].port = virXMLPropString(host, "port");
+                            if (!hosts[nhosts - 1].port) {
+                                virDomainReportError(VIR_ERR_INTERNAL_ERROR,
+                                                     "%s", _("missing port for host"));
+                                goto error;
+                            }
+                        }
+                        host = host->next;
+                    }
+                    break;
                 default:
                     virDomainReportError(VIR_ERR_INTERNAL_ERROR,
                                          _("unexpected disk type %s"),
@@ -1684,7 +1737,7 @@ virDomainDiskDefParseXML(virCapsPtr caps,
 
     /* Only CDROM and Floppy devices are allowed missing source path
      * to indicate no media present */
-    if (source == NULL &&
+    if (source == NULL && hosts == NULL &&
         def->device != VIR_DOMAIN_DISK_DEVICE_CDROM &&
         def->device != VIR_DOMAIN_DISK_DEVICE_FLOPPY) {
         virDomainReportError(VIR_ERR_NO_SOURCE,
@@ -1790,6 +1843,10 @@ virDomainDiskDefParseXML(virCapsPtr caps,
     source = NULL;
     def->dst = target;
     target = NULL;
+    def->hosts = hosts;
+    hosts = NULL;
+    def->nhosts = nhosts;
+    nhosts = 0;
     def->driverName = driverName;
     driverName = NULL;
     def->driverType = driverType;
@@ -1818,6 +1875,13 @@ cleanup:
     VIR_FREE(type);
     VIR_FREE(target);
     VIR_FREE(source);
+    while (nhosts > 0) {
+        VIR_FREE(hosts[nhosts - 1].name);
+        VIR_FREE(hosts[nhosts - 1].port);
+        nhosts--;
+    }
+    VIR_FREE(hosts);
+    VIR_FREE(protocol);
     VIR_FREE(device);
     VIR_FREE(driverType);
     VIR_FREE(driverName);
@@ -5886,7 +5950,7 @@ virDomainDiskDefFormat(virBufferPtr buf,
         virBufferVSprintf(buf, "/>\n");
     }
 
-    if (def->src) {
+    if (def->src || def->nhosts > 0) {
         switch (def->type) {
         case VIR_DOMAIN_DISK_TYPE_FILE:
             virBufferEscapeString(buf, "      <source file='%s'/>\n",
@@ -5900,6 +5964,27 @@ virDomainDiskDefFormat(virBufferPtr buf,
             virBufferEscapeString(buf, "      <source dir='%s'/>\n",
                                   def->src);
             break;
+        case VIR_DOMAIN_DISK_TYPE_NETWORK:
+            virBufferVSprintf(buf, "      <source protocol='%s'",
+                              virDomainDiskProtocolTypeToString(def->protocol));
+            if (def->src) {
+                virBufferEscapeString(buf, " name='%s'", def->src);
+            }
+            if (def->nhosts == 0) {
+                virBufferVSprintf(buf, "/>\n");
+            } else {
+                int i;
+
+                virBufferVSprintf(buf, ">\n");
+                for (i = 0; i < def->nhosts; i++) {
+                    virBufferEscapeString(buf, "        <host name='%s'",
+                                          def->hosts[i].name);
+                    virBufferEscapeString(buf, " port='%s'/>\n",
+                                          def->hosts[i].port);
+                }
+                virBufferVSprintf(buf, "      </source>\n");
+            }
+            break;
         default:
             virDomainReportError(VIR_ERR_INTERNAL_ERROR,
                                  _("unexpected disk type %s"),
diff --git a/src/conf/domain_conf.h b/src/conf/domain_conf.h
index 899b19f..6c97289 100644
--- a/src/conf/domain_conf.h
+++ b/src/conf/domain_conf.h
@@ -120,6 +120,7 @@ enum virDomainDiskType {
     VIR_DOMAIN_DISK_TYPE_BLOCK,
     VIR_DOMAIN_DISK_TYPE_FILE,
     VIR_DOMAIN_DISK_TYPE_DIR,
+    VIR_DOMAIN_DISK_TYPE_NETWORK,
 
     VIR_DOMAIN_DISK_TYPE_LAST
 };
@@ -164,6 +165,21 @@ enum  virDomainDiskErrorPolicy {
     VIR_DOMAIN_DISK_ERROR_POLICY_LAST
 };
 
+enum virDomainDiskProtocol {
+    VIR_DOMAIN_DISK_PROTOCOL_NBD,
+    VIR_DOMAIN_DISK_PROTOCOL_RBD,
+    VIR_DOMAIN_DISK_PROTOCOL_SHEEPDOG,
+
+    VIR_DOMAIN_DISK_PROTOCOL_LAST
+};
+
+typedef struct _virDomainDiskHostDef virDomainDiskHostDef;
+typedef virDomainDiskHostDef *virDomainDiskHostDefPtr;
+struct _virDomainDiskHostDef {
+    char *name;
+    char *port;
+};
+
 /* Stores the virtual disk configuration */
 typedef struct _virDomainDiskDef virDomainDiskDef;
 typedef virDomainDiskDef *virDomainDiskDefPtr;
@@ -173,6 +189,9 @@ struct _virDomainDiskDef {
     int bus;
     char *src;
     char *dst;
+    int protocol;
+    int nhosts;
+    virDomainDiskHostDefPtr hosts;
     char *driverName;
     char *driverType;
     char *serial;
@@ -1237,6 +1256,7 @@ VIR_ENUM_DECL(virDomainDiskDevice)
 VIR_ENUM_DECL(virDomainDiskBus)
 VIR_ENUM_DECL(virDomainDiskCache)
 VIR_ENUM_DECL(virDomainDiskErrorPolicy)
+VIR_ENUM_DECL(virDomainDiskProtocol)
 VIR_ENUM_DECL(virDomainController)
 VIR_ENUM_DECL(virDomainControllerModel)
 VIR_ENUM_DECL(virDomainFS)
diff --git a/src/qemu/qemu_conf.c b/src/qemu/qemu_conf.c
index 925585a..1296cef 100644
--- a/src/qemu/qemu_conf.c
+++ b/src/qemu/qemu_conf.c
@@ -2726,7 +2726,9 @@ qemuBuildDriveStr(virDomainDiskDefPtr disk,
         break;
     }
 
-    if (disk->src) {
+    /* disk->src is NULL when we use nbd disks */
+    if (disk->src || (disk->type == VIR_DOMAIN_DISK_TYPE_NETWORK &&
+                      disk->protocol == VIR_DOMAIN_DISK_PROTOCOL_NBD)) {
         if (disk->type == VIR_DOMAIN_DISK_TYPE_DIR) {
             /* QEMU only supports magic FAT format for now */
             if (disk->driverType &&
@@ -2745,6 +2747,31 @@ qemuBuildDriveStr(virDomainDiskDefPtr disk,
                 virBufferVSprintf(&opt, "file=fat:floppy:%s,", disk->src);
             else
                 virBufferVSprintf(&opt, "file=fat:%s,", disk->src);
+        } else if (disk->type == VIR_DOMAIN_DISK_TYPE_NETWORK) {
+            switch (disk->protocol) {
+            case VIR_DOMAIN_DISK_PROTOCOL_NBD:
+                if (disk->nhosts != 1) {
+                    qemuReportError(VIR_ERR_INTERNAL_ERROR, "%s",
+                                    _("NBD accepts only one host"));
+                    goto error;
+                }
+                virBufferVSprintf(&opt, "file=nbd:%s:%s,",
+                                  disk->hosts->name, disk->hosts->port);
+                break;
+            case VIR_DOMAIN_DISK_PROTOCOL_RBD:
+                /* TODO: set monitor hostnames */
+                virBufferVSprintf(&opt, "file=rbd:%s,", disk->src);
+                break;
+            case VIR_DOMAIN_DISK_PROTOCOL_SHEEPDOG:
+                if (disk->nhosts == 0)
+                    virBufferVSprintf(&opt, "file=sheepdog:%s,", disk->src);
+                else
+                    /* only one host is supported now */
+                    virBufferVSprintf(&opt, "file=sheepdog:%s:%s:%s,",
+                                      disk->hosts->name, disk->hosts->port,
+                                      disk->src);
+                break;
+            }
         } else {
             virBufferVSprintf(&opt, "file=%s,", disk->src);
         }
@@ -4636,6 +4663,30 @@ qemudBuildCommandLine(virConnectPtr conn,
                     snprintf(file, PATH_MAX, "fat:floppy:%s", disk->src);
                 else
                     snprintf(file, PATH_MAX, "fat:%s", disk->src);
+            } else if (disk->type == VIR_DOMAIN_DISK_TYPE_NETWORK) {
+                switch (disk->protocol) {
+                case VIR_DOMAIN_DISK_PROTOCOL_NBD:
+                    if (disk->nhosts != 1) {
+                        qemuReportError(VIR_ERR_INTERNAL_ERROR, "%s",
+                                        _("NBD accepts only one host"));
+                        goto error;
+                    }
+                    snprintf(file, PATH_MAX, "nbd:%s:%s,",
+                             disk->hosts->name, disk->hosts->port);
+                    break;
+                case VIR_DOMAIN_DISK_PROTOCOL_RBD:
+                    snprintf(file, PATH_MAX, "rbd:%s,", disk->src);
+                    break;
+                case VIR_DOMAIN_DISK_PROTOCOL_SHEEPDOG:
+                    if (disk->nhosts == 0)
+                        snprintf(file, PATH_MAX, "sheepdog:%s,", disk->src);
+                    else
+                        /* only one host is supported now */
+                        snprintf(file, PATH_MAX, "sheepdog:%s:%s:%s,",
+                                 disk->hosts->name, disk->hosts->port,
+                                 disk->src);
+                    break;
+                }
             } else {
                 snprintf(file, PATH_MAX, "%s", disk->src);
             }
@@ -5649,7 +5700,91 @@ qemuParseCommandLineDisk(virCapsPtr caps,
                 values[i] = NULL;
                 if (STRPREFIX(def->src, "/dev/"))
                     def->type = VIR_DOMAIN_DISK_TYPE_BLOCK;
-                else
+                else if (STRPREFIX(def->src, "nbd:")) {
+                    char *host, *port;
+
+                    def->type = VIR_DOMAIN_DISK_TYPE_NETWORK;
+                    host = def->src + strlen("nbd:");
+                    port = strchr(host, ':');
+                    if (!port) {
+                        def = NULL;
+                        qemuReportError(VIR_ERR_INTERNAL_ERROR,
+                                        _("cannot parse nbd filename '%s'"), def->src);
+                        goto cleanup;
+                    }
+                    *port++ = '\0';
+                    if (VIR_ALLOC(def->hosts) < 0) {
+                        virReportOOMError();
+                        goto cleanup;
+                    }
+                    def->nhosts = 1;
+                    def->hosts->name = strdup(host);
+                    if (!def->hosts->name) {
+                        virReportOOMError();
+                        goto cleanup;
+                    }
+                    def->hosts->port = strdup(port);
+                    if (!def->hosts->port) {
+                        virReportOOMError();
+                        goto cleanup;
+                    }
+
+                    VIR_FREE(def->src);
+                    def->src = NULL;
+                } else if (STRPREFIX(def->src, "rbd:")) {
+                    char *p = def->src;
+
+                    def->type = VIR_DOMAIN_DISK_TYPE_NETWORK;
+                    def->src = strdup(p + strlen("rbd:"));
+                    if (!def->src) {
+                        virReportOOMError();
+                        goto cleanup;
+                    }
+
+                    VIR_FREE(p);
+                } else if (STRPREFIX(def->src, "sheepdog:")) {
+                    char *p = def->src;
+                    char *port, *vdi;
+
+                    def->type = VIR_DOMAIN_DISK_TYPE_NETWORK;
+                    def->src = strdup(p + strlen("sheepdog:"));
+                    if (!def->src) {
+                        virReportOOMError();
+                        goto cleanup;
+                    }
+
+                    /* def->src must be [vdiname] or [host]:[port]:[vdiname] */
+                    port = strchr(def->src, ':');
+                    if (port) {
+                        *port++ = '\0';
+                        vdi = strchr(port, ':');
+                        if (!vdi) {
+                            def = NULL;
+                            qemuReportError(VIR_ERR_INTERNAL_ERROR,
+                                            _("cannot parse sheepdog filename '%s'"), p);
+                            goto cleanup;
+                        }
+                        *vdi++ = '\0';
+                        if (VIR_ALLOC(def->hosts) < 0) {
+                            virReportOOMError();
+                            goto cleanup;
+                        }
+                        def->nhosts = 1;
+                        def->hosts->name = def->src;
+                        def->hosts->port = strdup(port);
+                        if (!def->hosts->port) {
+                            virReportOOMError();
+                            goto cleanup;
+                        }
+                        def->src = strdup(vdi);
+                        if (!def->src) {
+                            virReportOOMError();
+                            goto cleanup;
+                        }
+                    }
+
+                    VIR_FREE(p);
+                } else
                     def->type = VIR_DOMAIN_DISK_TYPE_FILE;
             } else {
                 def->type = VIR_DOMAIN_DISK_TYPE_FILE;
@@ -6586,7 +6721,19 @@ virDomainDefPtr qemuParseCommandLine(virCapsPtr caps,
 
             if (STRPREFIX(val, "/dev/"))
                 disk->type = VIR_DOMAIN_DISK_TYPE_BLOCK;
-            else
+            else if (STRPREFIX(val, "nbd:")) {
+                disk->type = VIR_DOMAIN_DISK_TYPE_NETWORK;
+                disk->protocol = VIR_DOMAIN_DISK_PROTOCOL_NBD;
+                val += strlen("nbd:");
+            } else if (STRPREFIX(val, "rbd:")) {
+                disk->type = VIR_DOMAIN_DISK_TYPE_NETWORK;
+                disk->protocol = VIR_DOMAIN_DISK_PROTOCOL_RBD;
+                val += strlen("rbd:");
+            } else if (STRPREFIX(val, "sheepdog:")) {
+                disk->type = VIR_DOMAIN_DISK_TYPE_NETWORK;
+                disk->protocol = VIR_DOMAIN_DISK_PROTOCOL_SHEEPDOG;
+                val += strlen("sheepdog:");
+            } else
                 disk->type = VIR_DOMAIN_DISK_TYPE_FILE;
             if (STREQ(arg, "-cdrom")) {
                 disk->device = VIR_DOMAIN_DISK_DEVICE_CDROM;
@@ -6606,7 +6753,73 @@ virDomainDefPtr qemuParseCommandLine(virCapsPtr caps,
                 disk->dst = strdup(arg + 1);
             }
             disk->src = strdup(val);
-            if (!disk->src ||
+
+            if (disk->type == VIR_DOMAIN_DISK_TYPE_NETWORK) {
+                char *host, *port;
+
+                switch (disk->protocol) {
+                case VIR_DOMAIN_DISK_PROTOCOL_NBD:
+                    host = disk->src;
+                    port = strchr(host, ':');
+                    if (!port) {
+                        def = NULL;
+                        qemuReportError(VIR_ERR_INTERNAL_ERROR,
+                                        _("cannot parse nbd filename '%s'"), disk->src);
+                        goto error;
+                    }
+                    *port++ = '\0';
+                    if (VIR_ALLOC(disk->hosts) < 0) {
+                        virReportOOMError();
+                        goto error;
+                    }
+                    disk->nhosts = 1;
+                    disk->hosts->name = host;
+                    disk->hosts->port = strdup(port);
+                    if (!disk->hosts->port) {
+                        virReportOOMError();
+                        goto error;
+                    }
+                    disk->src = NULL;
+                    break;
+                case VIR_DOMAIN_DISK_PROTOCOL_RBD:
+                    /* TODO: set monitor hostnames */
+                    break;
+                case VIR_DOMAIN_DISK_PROTOCOL_SHEEPDOG:
+                    /* disk->src must be [vdiname] or [host]:[port]:[vdiname] */
+                    port = strchr(disk->src, ':');
+                    if (port) {
+                        char *vdi;
+
+                        *port++ = '\0';
+                        vdi = strchr(port, ':');
+                        if (!vdi) {
+                            qemuReportError(VIR_ERR_INTERNAL_ERROR,
+                                            _("cannot parse sheepdog filename '%s'"), val);
+                            goto error;
+                        }
+                        *vdi++ = '\0';
+                        if (VIR_ALLOC(disk->hosts) < 0) {
+                            virReportOOMError();
+                            goto error;
+                        }
+                        disk->nhosts = 1;
+                        disk->hosts->name = disk->src;
+                        disk->hosts->port = strdup(port);
+                        if (!disk->hosts->port) {
+                            virReportOOMError();
+                            goto error;
+                        }
+                        disk->src = strdup(vdi);
+                        if (!disk->src) {
+                            virReportOOMError();
+                            goto error;
+                        }
+                    }
+                    break;
+                }
+            }
+
+            if (!(disk->src || disk->nhosts > 0) ||
                 !disk->dst) {
                 virDomainDiskDefFree(disk);
                 goto no_memory;
-- 
1.7.1
