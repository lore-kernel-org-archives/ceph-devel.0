From: "Daniel P. Berrange" <berrange@redhat.com>
Subject: Re: [RFC PATCH v3 2/4] storage: add auth to virDomainDiskDef
Date: Thu, 27 Oct 2011 09:33:02 +0100
Message-ID: <20111027083301.GB20878@redhat.com>
References: <cover.1319072460.git.josh.durgin@dreamhost.com>
 <24e32a383e9e614a3d192fa709e73c22a069ce9e.1319072460.git.josh.durgin@dreamhost.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43809 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754726Ab1J0IdB (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 27 Oct 2011 04:33:01 -0400
Content-Disposition: inline
In-Reply-To: <24e32a383e9e614a3d192fa709e73c22a069ce9e.1319072460.git.josh.durgin@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@dreamhost.com>
Cc: libvir-list@redhat.com, ceph-devel@vger.kernel.org

On Thu, Oct 20, 2011 at 11:01:25AM -0700, Josh Durgin wrote:
> Add additional fields to let you specify the how to authenticate with a disk.
> The secret to use may be referenced by a usage string or a UUID, i.e.:
> 
> <auth username='myuser'>
>   <secret type='ceph' usage='secretname'/>
> </auth>
> 
> or
> 
> <auth username='myuser'>
>   <secret type='ceph' uuid='0a81f5b2-8403-7b23-c8d6-21ccc2f80d6f'/>
> </auth>
> 
> Signed-off-by: Josh Durgin <josh.durgin@dreamhost.com>
> ---
>  docs/schemas/domaincommon.rng |   29 +++++++++++
>  src/Makefile.am               |    3 +-
>  src/conf/domain_conf.c        |  105 +++++++++++++++++++++++++++++++++++++---
>  src/conf/domain_conf.h        |   17 +++++++
>  4 files changed, 145 insertions(+), 9 deletions(-)
> 

> diff --git a/src/Makefile.am b/src/Makefile.am
> index 2555f81..7f48981 100644
> --- a/src/Makefile.am
> +++ b/src/Makefile.am
> @@ -128,7 +128,8 @@ DOMAIN_CONF_SOURCES =						\
>  		conf/capabilities.c conf/capabilities.h		\
>  		conf/domain_conf.c conf/domain_conf.h		\
>  		conf/domain_audit.c conf/domain_audit.h		\
> -		conf/domain_nwfilter.c conf/domain_nwfilter.h
> +		conf/domain_nwfilter.c conf/domain_nwfilter.h   \
> +		conf/secret_conf.c


Unless I'm missing something, I don't think your code changes to
domain_conf.c actually introduce any dependancy on secret_conf.c
You include secret_conf.h, but that is only to get access to one
of the enum values. So there's no dep on the secret_conf.c code
and you can just drop this hunk


>  
>  DOMAIN_EVENT_SOURCES =						\
>  		conf/domain_event.c conf/domain_event.h
> diff --git a/src/conf/domain_conf.c b/src/conf/domain_conf.c
> index 5959593..1de3742 100644
> --- a/src/conf/domain_conf.c
> +++ b/src/conf/domain_conf.c
> @@ -49,6 +49,7 @@
>  #include "virfile.h"
>  #include "bitmap.h"
>  #include "count-one-bits.h"
> +#include "secret_conf.h"
>  
>  #define VIR_FROM_THIS VIR_FROM_DOMAIN
>  
> @@ -185,6 +186,11 @@ VIR_ENUM_IMPL(virDomainDiskProtocol, VIR_DOMAIN_DISK_PROTOCOL_LAST,
>                "rbd",
>                "sheepdog")
>  
> +VIR_ENUM_IMPL(virDomainDiskSecretType, VIR_DOMAIN_DISK_SECRET_TYPE_LAST,
> +              "none",
> +              "uuid",
> +              "usage")
> +
>  VIR_ENUM_IMPL(virDomainDiskIo, VIR_DOMAIN_DISK_IO_LAST,
>                "default",
>                "native",
> @@ -782,6 +788,9 @@ void virDomainDiskDefFree(virDomainDiskDefPtr def)
>      VIR_FREE(def->dst);
>      VIR_FREE(def->driverName);
>      VIR_FREE(def->driverType);
> +    VIR_FREE(def->auth.username);
> +    if (def->auth.secretType == VIR_DOMAIN_DISK_SECRET_TYPE_USAGE)
> +        VIR_FREE(def->auth.secret.usage);
>      virStorageEncryptionFree(def->encryption);
>      virDomainDeviceInfoClear(&def->info);
>  
> @@ -2298,7 +2307,7 @@ virDomainDiskDefParseXML(virCapsPtr caps,
>                           unsigned int flags)
>  {
>      virDomainDiskDefPtr def;
> -    xmlNodePtr cur, host;
> +    xmlNodePtr cur, child;
>      char *type = NULL;
>      char *device = NULL;
>      char *snapshot = NULL;
> @@ -2319,6 +2328,10 @@ virDomainDiskDefParseXML(virCapsPtr caps,
>      char *devaddr = NULL;
>      virStorageEncryptionPtr encryption = NULL;
>      char *serial = NULL;
> +    char *authUsername = NULL;
> +    char *authUsage = NULL;
> +    char *authUUID = NULL;
> +    char *usageType = NULL;
>  
>      if (VIR_ALLOC(def) < 0) {
>          virReportOOMError();
> @@ -2374,10 +2387,10 @@ virDomainDiskDefParseXML(virCapsPtr caps,
>                                               _("missing name for disk source"));
>                          goto error;
>                      }
> -                    host = cur->children;
> -                    while (host != NULL) {
> -                        if (host->type == XML_ELEMENT_NODE &&
> -                            xmlStrEqual(host->name, BAD_CAST "host")) {
> +                    child = cur->children;
> +                    while (child != NULL) {
> +                        if (child->type == XML_ELEMENT_NODE &&
> +                            xmlStrEqual(child->name, BAD_CAST "host")) {
>                              if (VIR_REALLOC_N(hosts, nhosts + 1) < 0) {
>                                  virReportOOMError();
>                                  goto error;
> @@ -2386,20 +2399,20 @@ virDomainDiskDefParseXML(virCapsPtr caps,
>                              hosts[nhosts].port = NULL;
>                              nhosts++;
>  
> -                            hosts[nhosts - 1].name = virXMLPropString(host, "name");
> +                            hosts[nhosts - 1].name = virXMLPropString(child, "name");
>                              if (!hosts[nhosts - 1].name) {
>                                  virDomainReportError(VIR_ERR_INTERNAL_ERROR,
>                                                       "%s", _("missing name for host"));
>                                  goto error;
>                              }
> -                            hosts[nhosts - 1].port = virXMLPropString(host, "port");
> +                            hosts[nhosts - 1].port = virXMLPropString(child, "port");
>                              if (!hosts[nhosts - 1].port) {
>                                  virDomainReportError(VIR_ERR_INTERNAL_ERROR,
>                                                       "%s", _("missing port for host"));
>                                  goto error;
>                              }
>                          }
> -                        host = host->next;
> +                        child = child->next;
>                      }
>                      break;
>                  default:
> @@ -2436,6 +2449,58 @@ virDomainDiskDefParseXML(virCapsPtr caps,
>                  iotag = virXMLPropString(cur, "io");
>                  ioeventfd = virXMLPropString(cur, "ioeventfd");
>                  event_idx = virXMLPropString(cur, "event_idx");
> +            } else if (xmlStrEqual(cur->name, BAD_CAST "auth")) {
> +                authUsername = virXMLPropString(cur, "username");
> +                if (authUsername == NULL) {
> +                    virDomainReportError(VIR_ERR_INTERNAL_ERROR,
> +                                         _("missing username for auth"));
> +                    goto error;
> +                }
> +
> +                def->auth.secretType = VIR_DOMAIN_DISK_SECRET_TYPE_NONE;
> +                child = cur->children;
> +                while (child != NULL) {
> +                    if (child->type == XML_ELEMENT_NODE &&
> +                        xmlStrEqual(child->name, BAD_CAST "secret")) {
> +                        usageType = virXMLPropString(child, "type");
> +                        if (usageType == NULL) {
> +                            virDomainReportError(VIR_ERR_XML_ERROR,
> +                                                 _("missing type for secret"));
> +                            goto error;
> +                        }
> +                        if (virSecretUsageTypeTypeFromString(usageType) !=
> +                            VIR_SECRET_USAGE_TYPE_CEPH) {
> +                            virDomainReportError(VIR_ERR_XML_ERROR,
> +                                                 _("invalid secret type %s"),
> +                                                 usageType);
> +                            goto error;
> +                        }
> +
> +                        authUUID = virXMLPropString(child, "uuid");
> +                        authUsage = virXMLPropString(child, "usage");
> +
> +                        if (authUUID != NULL && authUsage != NULL) {
> +                            virDomainReportError(VIR_ERR_XML_ERROR,
> +                                                 _("only one of uuid and usage can be specfied"));
> +                            goto error;
> +                        }
> +                        if (authUUID != NULL) {
> +                            def->auth.secretType = VIR_DOMAIN_DISK_SECRET_TYPE_UUID;
> +                            if (virUUIDParse(authUUID,
> +                                             def->auth.secret.uuid) < 0) {
> +                                virDomainReportError(VIR_ERR_XML_ERROR,
> +                                                     _("malformed uuid %s"),
> +                                                     authUUID);
> +                                goto error;
> +                            }
> +                        } else if (authUsage != NULL) {
> +                            def->auth.secretType = VIR_DOMAIN_DISK_SECRET_TYPE_USAGE;
> +                            def->auth.secret.usage = authUsage;
> +                            authUsage = NULL;
> +                        }
> +                    }
> +                    child = child->next;
> +                }
>              } else if (xmlStrEqual(cur->name, BAD_CAST "readonly")) {
>                  def->readonly = 1;
>              } else if (xmlStrEqual(cur->name, BAD_CAST "shareable")) {
> @@ -2654,6 +2719,8 @@ virDomainDiskDefParseXML(virCapsPtr caps,
>      hosts = NULL;
>      def->nhosts = nhosts;
>      nhosts = 0;
> +    def->auth.username = authUsername;
> +    authUsername = NULL;
>      def->driverName = driverName;
>      driverName = NULL;
>      def->driverType = driverType;
> @@ -2690,6 +2757,10 @@ cleanup:
>      VIR_FREE(hosts);
>      VIR_FREE(protocol);
>      VIR_FREE(device);
> +    VIR_FREE(authUsername);
> +    VIR_FREE(usageType);
> +    VIR_FREE(authUUID);
> +    VIR_FREE(authUsage);
>      VIR_FREE(driverType);
>      VIR_FREE(driverName);
>      VIR_FREE(cachetag);
> @@ -9176,6 +9247,7 @@ virDomainDiskDefFormat(virBufferPtr buf,
>      const char *iomode = virDomainDiskIoTypeToString(def->iomode);
>      const char *ioeventfd = virDomainIoEventFdTypeToString(def->ioeventfd);
>      const char *event_idx = virDomainVirtioEventIdxTypeToString(def->event_idx);
> +    char uuidstr[VIR_UUID_STRING_BUFLEN];
>  
>      if (!type) {
>          virDomainReportError(VIR_ERR_INTERNAL_ERROR,
> @@ -9234,6 +9306,23 @@ virDomainDiskDefFormat(virBufferPtr buf,
>          virBufferAsprintf(buf, "/>\n");
>      }
>  
> +    if (def->auth.username) {
> +        virBufferAsprintf(buf, "      <auth username='%s'>\n",
> +                          def->auth.username);
> +        if (def->auth.secretType == VIR_DOMAIN_DISK_SECRET_TYPE_UUID) {
> +            virUUIDFormat(def->auth.secret.uuid, uuidstr);
> +            virBufferAsprintf(buf,
> +                              "        <secret type='passphrase' uuid='%s'/>\n",
> +                              uuidstr);
> +        }
> +        if (def->auth.secretType == VIR_DOMAIN_DISK_SECRET_TYPE_USAGE) {
> +            virBufferAsprintf(buf,
> +                              "        <secret type='passphrase' usage='%s'/>\n",
> +                              def->auth.secret.usage);
> +        }
> +        virBufferAsprintf(buf, "      </auth>\n");
> +    }
> +
>      if (def->src || def->nhosts > 0) {
>          switch (def->type) {
>          case VIR_DOMAIN_DISK_TYPE_FILE:
> diff --git a/src/conf/domain_conf.h b/src/conf/domain_conf.h
> index 2119b5a..0d08040 100644
> --- a/src/conf/domain_conf.h
> +++ b/src/conf/domain_conf.h
> @@ -269,6 +269,14 @@ enum virDomainSnapshotState {
>      VIR_DOMAIN_DISK_SNAPSHOT = VIR_DOMAIN_LAST,
>  };
>  
> +enum virDomainDiskSecretType {
> +    VIR_DOMAIN_DISK_SECRET_TYPE_NONE,
> +    VIR_DOMAIN_DISK_SECRET_TYPE_UUID,
> +    VIR_DOMAIN_DISK_SECRET_TYPE_USAGE,
> +
> +    VIR_DOMAIN_DISK_SECRET_TYPE_LAST
> +};
> +
>  /* Stores the virtual disk configuration */
>  typedef struct _virDomainDiskDef virDomainDiskDef;
>  typedef virDomainDiskDef *virDomainDiskDefPtr;
> @@ -281,6 +289,14 @@ struct _virDomainDiskDef {
>      int protocol;
>      int nhosts;
>      virDomainDiskHostDefPtr hosts;
> +    struct {
> +        char *username;
> +        int secretType;
> +        union {
> +            unsigned char uuid[VIR_UUID_BUFLEN];
> +            char *usage;
> +        } secret;
> +    } auth;
>      char *driverName;
>      char *driverType;
>      char *serial;
> @@ -1868,6 +1884,7 @@ VIR_ENUM_DECL(virDomainDiskCache)
>  VIR_ENUM_DECL(virDomainDiskErrorPolicy)
>  VIR_ENUM_DECL(virDomainDiskProtocol)
>  VIR_ENUM_DECL(virDomainDiskIo)
> +VIR_ENUM_DECL(virDomainDiskSecretType)
>  VIR_ENUM_DECL(virDomainDiskSnapshot)
>  VIR_ENUM_DECL(virDomainIoEventFd)
>  VIR_ENUM_DECL(virDomainVirtioEventIdx)

ACK with the Makefile.am hunk dropped


Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://autobuild.org       -o-         http://search.cpan.org/~danberr/ :|
|: http://entangle-photo.org       -o-       http://live.gnome.org/gtk-vnc :|
