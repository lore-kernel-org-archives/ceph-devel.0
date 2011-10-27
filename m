From: "Daniel P. Berrange" <berrange@redhat.com>
Subject: Re: [RFC PATCH v3 4/4] qemu/rbd: improve rbd device specification
Date: Thu, 27 Oct 2011 09:38:23 +0100
Message-ID: <20111027083823.GD20878@redhat.com>
References: <cover.1319072460.git.josh.durgin@dreamhost.com>
 <6bfc3b538ee1e63df37c0891f3696113d62c631c.1319072460.git.josh.durgin@dreamhost.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40166 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754789Ab1J0IiY (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 27 Oct 2011 04:38:24 -0400
Content-Disposition: inline
In-Reply-To: <6bfc3b538ee1e63df37c0891f3696113d62c631c.1319072460.git.josh.durgin@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@dreamhost.com>
Cc: libvir-list@redhat.com, ceph-devel@vger.kernel.org

On Thu, Oct 20, 2011 at 11:01:27AM -0700, Josh Durgin wrote:
> From: Sage Weil <sage@newdream.net>
> 
> This improves the support for qemu rbd devices by adding support for a few
> key features (e.g., authentication) and cleaning up the way in which
> rbd configuration options are passed to qemu.
> 
> And <auth> member of the disk source xml specifies how librbd should
> authenticate. The username attribute is the Ceph/RBD user to authenticate as.
> The usage or uuid attributes specify which secret to use. Usage is an
> arbitrary identifier local to libvirt.
> 
> The old RBD support relied on setting an environment variable to
> communicate information to qemu/librbd.  Instead, pass those options
> explicitly to qemu.  Update the qemu argument parsing and tests
> accordingly.
> 
> Signed-off-by: Sage Weil <sage@newdream.net>
> Signed-off-by: Josh Durgin <josh.durgin@dreamhost.com>
> ---
>  src/qemu/qemu_command.c                            |  284 ++++++++++++--------
>  .../qemuxml2argv-disk-drive-network-rbd-auth.args  |    6 +
>  .../qemuxml2argv-disk-drive-network-rbd-auth.xml   |   37 +++
>  .../qemuxml2argv-disk-drive-network-rbd.args       |    6 +-
>  tests/qemuxml2argvtest.c                           |   52 ++++
>  5 files changed, 268 insertions(+), 117 deletions(-)
>  create mode 100644 tests/qemuxml2argvdata/qemuxml2argv-disk-drive-network-rbd-auth.args
>  create mode 100644 tests/qemuxml2argvdata/qemuxml2argv-disk-drive-network-rbd-auth.xml
> 
> diff --git a/src/qemu/qemu_command.c b/src/qemu/qemu_command.c
> index 4dfce88..b2c0eee 100644
> --- a/src/qemu/qemu_command.c
> +++ b/src/qemu/qemu_command.c
> @@ -38,6 +38,7 @@
>  #include "domain_audit.h"
>  #include "domain_conf.h"
>  #include "network/bridge_driver.h"
> +#include "base64.h"
>  
>  #include <sys/utsname.h>
>  #include <sys/stat.h>
> @@ -1489,6 +1490,159 @@ qemuSafeSerialParamValue(const char *value)
>      return 0;
>  }
>  
> +static int buildRBDString(virConnectPtr conn,
> +                          virDomainDiskDefPtr disk,
> +                          virBufferPtr opt)

For style reasons,  s/buildRBDString/qemuBuildRBDString/

> +{
> +    int i;
> +    virSecretPtr sec = NULL;
> +    char *secret = NULL;
> +    size_t secret_size;
> +
> +    virBufferAsprintf(opt, "rbd:%s", disk->src);
> +    if (disk->auth.username) {
> +        virBufferEscape(opt, ":", ":id=%s", disk->auth.username);
> +        /* look up secret */
> +        switch (disk->auth.secretType) {
> +        case VIR_DOMAIN_DISK_SECRET_TYPE_UUID:
> +            sec = virSecretLookupByUUID(conn,
> +                                        disk->auth.secret.uuid);
> +            break;
> +        case VIR_DOMAIN_DISK_SECRET_TYPE_USAGE:
> +            sec = virSecretLookupByUsage(conn,
> +                                         VIR_SECRET_USAGE_TYPE_CEPH,
> +                                         disk->auth.secret.usage);
> +            break;
> +        }
> +
> +        if (sec) {
> +            char *base64;
> +
> +            secret = (char *)conn->secretDriver->getValue(sec, &secret_size, 0,
> +                                                          VIR_SECRET_GET_VALUE_INTERNAL_CALL);
> +            if (secret == NULL) {
> +                qemuReportError(VIR_ERR_INTERNAL_ERROR,
> +                                _("could not get the value of the secret for username %s"),
> +                                disk->auth.username);
> +                return -1;
> +            }
> +            /* qemu/librbd wants it base64 encoded */
> +            base64_encode_alloc(secret, secret_size, &base64);
> +            virBufferEscape(opt, ":", ":key=%s:auth_supported=cephx\\;none",
> +                            base64);
> +            VIR_FREE(base64);
> +            VIR_FREE(secret);
> +            virUnrefSecret(sec);
> +        } else {
> +            qemuReportError(VIR_ERR_INTERNAL_ERROR,
> +                            _("rbd username '%s' specified but secret not found"),
> +                            disk->auth.username);
> +            return -1;
> +        }
> +    }
> +
> +    if (disk->nhosts > 0) {
> +        virBufferStrcat(opt, ":mon_host=", NULL);
> +        for (i = 0; i < disk->nhosts; ++i) {
> +            if (i) {
> +                virBufferStrcat(opt, "\\;", NULL);
> +            }
> +            if (disk->hosts[i].port) {
> +                virBufferAsprintf(opt, "%s\\:%s",
> +                                  disk->hosts[i].name,
> +                                  disk->hosts[i].port);
> +            } else {
> +                virBufferAsprintf(opt, "%s", disk->hosts[i].name);
> +            }
> +        }
> +    }
> +
> +    return 0;
> +}
> +
> +static int addRBDHost(virDomainDiskDefPtr disk, char *hostport)

s/add/qemuAdd/

> +{
> +    char *port;
> +    int ret;
> +
> +    disk->nhosts++;
> +    ret = VIR_REALLOC_N(disk->hosts, disk->nhosts);
> +    if (ret < 0) {
> +        virReportOOMError();
> +        return -1;
> +    }
> +
> +    port = strstr(hostport, "\\:");
> +    if (port) {
> +        *port = '\0';
> +        port += 2;
> +        disk->hosts[disk->nhosts-1].port = strdup(port);
> +    } else {
> +        disk->hosts[disk->nhosts-1].port = strdup("6789");
> +    }
> +    disk->hosts[disk->nhosts-1].name = strdup(hostport);
> +    return 0;
> +}
> +
> +/* disk->src initially has everything after the rbd: prefix */
> +static int parseRBDString(virDomainDiskDefPtr disk)

s/parse/qemuParse/

> +{
> +    char *options = NULL;
> +    char *p, *e, *next;
> +
> +    p = strchr(disk->src, ':');
> +    if (p) {
> +        options = strdup(p + 1);
> +        *p = '\0';
> +    }
> +
> +    /* options */
> +    if (!options)
> +        return 0; /* all done */
> +
> +    p = options;
> +    while (*p) {
> +        /* find : delimiter or end of string */
> +        for (e = p; *e && *e != ':'; ++e) {
> +            if (*e == '\\') {
> +                e++;
> +                if (*e == '\0')
> +                    break;
> +            }
> +        }
> +        if (*e == '\0') {
> +            next = e;    /* last kv pair */
> +        } else {
> +            next = e + 1;
> +            *e = '\0';
> +        }
> +
> +        if (STRPREFIX(p, "id=")) {
> +            disk->auth.username = strdup(p + strlen("id="));
> +        }
> +        if (STRPREFIX(p, "mon_host=")) {
> +            char *h, *sep;
> +
> +            h = p + strlen("mon_host=");
> +            while (h < e) {
> +                for (sep = h; sep < e; ++sep) {
> +                    if (*sep == '\\' && (sep[1] == ',' ||
> +                                         sep[1] == ';' ||
> +                                         sep[1] == ' ')) {
> +                        *sep = '\0';
> +                        sep += 2;
> +                        break;
> +                    }
> +                }
> +                addRBDHost(disk, h);
> +                h = sep;
> +            }
> +        }
> +
> +        p = next;
> +    }
> +    return 0;
> +}
>  
>  char *
>  qemuBuildDriveStr(virConnectPtr conn,
> @@ -1608,8 +1762,10 @@ qemuBuildDriveStr(virConnectPtr conn,
>                                    disk->hosts->name, disk->hosts->port);
>                  break;
>              case VIR_DOMAIN_DISK_PROTOCOL_RBD:
> -                /* TODO: set monitor hostnames */
> -                virBufferAsprintf(&opt, "file=rbd:%s,", disk->src);
> +                virBufferStrcat(&opt, "file=", NULL);
> +                if (buildRBDString(conn, disk, &opt) < 0)
> +                    goto error;
> +                virBufferStrcat(&opt, ",", NULL);
>                  break;
>              case VIR_DOMAIN_DISK_PROTOCOL_SHEEPDOG:
>                  if (disk->nhosts == 0)
> @@ -3278,8 +3434,6 @@ qemuBuildCommandLine(virConnectPtr conn,
>      int last_good_net = -1;
>      bool hasHwVirt = false;
>      virCommandPtr cmd;
> -    bool has_rbd_hosts = false;
> -    virBuffer rbd_hosts = VIR_BUFFER_INITIALIZER;
>      bool emitBootindex = false;
>      int usbcontroller = 0;
>      bool usblegacy = false;
> @@ -3861,7 +4015,6 @@ qemuBuildCommandLine(virConnectPtr conn,
>              virDomainDiskDefPtr disk = def->disks[i];
>              int withDeviceArg = 0;
>              bool deviceFlagMasked = false;
> -            int j;
>  
>              /* Unless we have -device, then USB disks need special
>                 handling */
> @@ -3919,26 +4072,6 @@ qemuBuildCommandLine(virConnectPtr conn,
>              virCommandAddArg(cmd, optstr);
>              VIR_FREE(optstr);
>  
> -            if (disk->type == VIR_DOMAIN_DISK_TYPE_NETWORK &&
> -                disk->protocol == VIR_DOMAIN_DISK_PROTOCOL_RBD) {
> -                for (j = 0 ; j < disk->nhosts ; j++) {
> -                    if (!has_rbd_hosts) {
> -                        virBufferAddLit(&rbd_hosts, "CEPH_ARGS=-m ");
> -                        has_rbd_hosts = true;
> -                    } else {
> -                        virBufferAddLit(&rbd_hosts, ",");
> -                    }
> -                    virDomainDiskHostDefPtr host = &disk->hosts[j];
> -                    if (host->port) {
> -                        virBufferAsprintf(&rbd_hosts, "%s:%s",
> -                                          host->name,
> -                                          host->port);
> -                    } else {
> -                        virBufferAdd(&rbd_hosts, host->name, -1);
> -                    }
> -                }
> -            }
> -
>              if (!emitBootindex)
>                  bootindex = 0;
>              else if (disk->bootIndex)
> @@ -3976,7 +4109,6 @@ qemuBuildCommandLine(virConnectPtr conn,
>              char *file;
>              const char *fmt;
>              virDomainDiskDefPtr disk = def->disks[i];
> -            int j;
>  
>              if (disk->bus == VIR_DOMAIN_DISK_BUS_USB) {
>                  if (disk->device == VIR_DOMAIN_DISK_DEVICE_DISK) {
> @@ -4045,24 +4177,15 @@ qemuBuildCommandLine(virConnectPtr conn,
>                      }
>                      break;
>                  case VIR_DOMAIN_DISK_PROTOCOL_RBD:
> -                    if (virAsprintf(&file, "rbd:%s,", disk->src) < 0) {
> -                        goto no_memory;
> -                    }
> -                    for (j = 0 ; j < disk->nhosts ; j++) {
> -                        if (!has_rbd_hosts) {
> -                            virBufferAddLit(&rbd_hosts, "CEPH_ARGS=-m ");
> -                            has_rbd_hosts = true;
> -                        } else {
> -                            virBufferAddLit(&rbd_hosts, ",");
> -                        }
> -                        virDomainDiskHostDefPtr host = &disk->hosts[j];
> -                        if (host->port) {
> -                            virBufferAsprintf(&rbd_hosts, "%s:%s",
> -                                              host->name,
> -                                              host->port);
> -                        } else {
> -                            virBufferAdd(&rbd_hosts, host->name, -1);
> +                    {
> +                        virBuffer opt = VIR_BUFFER_INITIALIZER;
> +                        if (buildRBDString(conn, disk, &opt) < 0)
> +                            goto error;
> +                        if (virBufferError(&opt)) {
> +                            virReportOOMError();
> +                            goto error;
>                          }
> +                        file = virBufferContentAndReset(&opt);
>                      }
>                      break;
>                  case VIR_DOMAIN_DISK_PROTOCOL_SHEEPDOG:
> @@ -4091,9 +4214,6 @@ qemuBuildCommandLine(virConnectPtr conn,
>          }
>      }
>  
> -    if (has_rbd_hosts)
> -        virCommandAddEnvBuffer(cmd, &rbd_hosts);
> -
>      if (qemuCapsGet(qemuCaps, QEMU_CAPS_FSDEV)) {
>          for (i = 0 ; i < def->nfss ; i++) {
>              char *optstr;
> @@ -5263,7 +5383,6 @@ qemuBuildCommandLine(virConnectPtr conn,
>          networkReleaseActualDevice(def->nets[i]);
>      for (i = 0; i <= last_good_net; i++)
>          virDomainConfNWFilterTeardown(def->nets[i]);
> -    virBufferFreeAndReset(&rbd_hosts);
>      virCommandFree(cmd);
>      return NULL;
>  }
> @@ -5295,10 +5414,6 @@ static int qemuStringToArgvEnv(const char *args,
>          const char *next;
>  
>          start = curr;
> -        /* accept a space in CEPH_ARGS */
> -        if (STRPREFIX(curr, "CEPH_ARGS=-m ")) {
> -            start += strlen("CEPH_ARGS=-m ");
> -        }
>          if (*start == '\'') {
>              if (start == curr)
>                  curr++;
> @@ -5577,6 +5692,8 @@ qemuParseCommandLineDisk(virCapsPtr caps,
>                          virReportOOMError();
>                          goto cleanup;
>                      }
> +                    if (parseRBDString(def) < 0)
> +                        goto cleanup;
>  
>                      VIR_FREE(p);
>                  } else if (STRPREFIX(def->src, "sheepdog:")) {
> @@ -6696,7 +6813,8 @@ virDomainDefPtr qemuParseCommandLine(virCapsPtr caps,
>                      disk->src = NULL;
>                      break;
>                  case VIR_DOMAIN_DISK_PROTOCOL_RBD:
> -                    /* handled later since the hosts for all disks are in CEPH_ARGS */
> +                    if (parseRBDString(disk) < 0)
> +                        goto error;
>                      break;
>                  case VIR_DOMAIN_DISK_PROTOCOL_SHEEPDOG:
>                      /* disk->src must be [vdiname] or [host]:[port]:[vdiname] */
> @@ -7035,68 +7153,6 @@ virDomainDefPtr qemuParseCommandLine(virCapsPtr caps,
>      }
>  
>  #undef WANT_VALUE
> -    if (def->ndisks > 0) {
> -        const char *ceph_args = qemuFindEnv(progenv, "CEPH_ARGS");
> -        if (ceph_args) {
> -            char *hosts, *port, *saveptr = NULL, *token;
> -            virDomainDiskDefPtr first_rbd_disk = NULL;
> -            for (i = 0 ; i < def->ndisks ; i++) {
> -                if (def->disks[i]->type == VIR_DOMAIN_DISK_TYPE_NETWORK &&
> -                    def->disks[i]->protocol == VIR_DOMAIN_DISK_PROTOCOL_RBD) {
> -                    first_rbd_disk = def->disks[i];
> -                    break;
> -                }
> -            }
> -
> -            if (!first_rbd_disk) {
> -                qemuReportError(VIR_ERR_INTERNAL_ERROR,
> -                                _("CEPH_ARGS was set without an rbd disk"));
> -                goto error;
> -            }
> -
> -            /* CEPH_ARGS should be: -m host1[:port1][,host2[:port2]]... */
> -            if (!STRPREFIX(ceph_args, "-m ")) {
> -                qemuReportError(VIR_ERR_INTERNAL_ERROR,
> -                                _("could not parse CEPH_ARGS '%s'"), ceph_args);
> -                goto error;
> -            }
> -            hosts = strdup(strchr(ceph_args, ' ') + 1);
> -            if (!hosts)
> -                goto no_memory;
> -            first_rbd_disk->nhosts = 0;
> -            token = strtok_r(hosts, ",", &saveptr);
> -            while (token != NULL) {
> -                if (VIR_REALLOC_N(first_rbd_disk->hosts, first_rbd_disk->nhosts + 1) < 0) {
> -                    VIR_FREE(hosts);
> -                    goto no_memory;
> -                }
> -                port = strchr(token, ':');
> -                if (port) {
> -                    *port++ = '\0';
> -                    port = strdup(port);
> -                    if (!port) {
> -                        VIR_FREE(hosts);
> -                        goto no_memory;
> -                    }
> -                }
> -                first_rbd_disk->hosts[first_rbd_disk->nhosts].port = port;
> -                first_rbd_disk->hosts[first_rbd_disk->nhosts].name = strdup(token);
> -                if (!first_rbd_disk->hosts[first_rbd_disk->nhosts].name) {
> -                    VIR_FREE(hosts);
> -                    goto no_memory;
> -                }
> -                first_rbd_disk->nhosts++;
> -                token = strtok_r(NULL, ",", &saveptr);
> -            }
> -            VIR_FREE(hosts);
> -
> -            if (first_rbd_disk->nhosts == 0) {
> -                qemuReportError(VIR_ERR_INTERNAL_ERROR,
> -                                _("found no rbd hosts in CEPH_ARGS '%s'"), ceph_args);
> -                goto error;
> -            }
> -        }
> -    }
>  
>      if (!nographics && def->ngraphics == 0) {
>          virDomainGraphicsDefPtr sdl;

> diff --git a/tests/qemuxml2argvtest.c b/tests/qemuxml2argvtest.c
> index a7ae925..31bd928 100644
> --- a/tests/qemuxml2argvtest.c
> +++ b/tests/qemuxml2argvtest.c
> @@ -23,6 +23,55 @@
>  static const char *abs_top_srcdir;
>  static struct qemud_driver driver;
>  
> +static unsigned char *
> +fakeSecretGetValue(virSecretPtr obj ATTRIBUTE_UNUSED,
> +                   size_t *value_size,
> +                   unsigned int fakeflags ATTRIBUTE_UNUSED,
> +                   unsigned int internalFlags ATTRIBUTE_UNUSED)
> +{
> +    char *secret = strdup("AQCVn5hO6HzFAhAAq0NCv8jtJcIcE+HOBlMQ1A");
> +    *value_size = strlen(secret);
> +    return (unsigned char *) secret;
> +}
> +
> +static virSecretPtr
> +fakeSecretLookupByUsage(virConnectPtr conn,
> +                        int usageType ATTRIBUTE_UNUSED,
> +                        const char *usageID)
> +{
> +    virSecretPtr ret = NULL;
> +    if (strcmp(usageID, "mycluster_myname"))

s/strcmp/STRNEQ/

> +        return ret;
> +    ret = malloc(sizeof(virSecret));

Need to use  VIR_ALLOC for this.

> +    ret->magic = VIR_SECRET_MAGIC;
> +    ret->conn = conn;
> +    conn->refs++;
> +    ret->refs = 1;
> +    ret->usageID = strdup(usageID);
> +    return ret;
> +}
> +

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://autobuild.org       -o-         http://search.cpan.org/~danberr/ :|
|: http://entangle-photo.org       -o-       http://live.gnome.org/gtk-vnc :|
