From: "Daniel P. Berrange" <berrange@redhat.com>
Subject: Re: [libvirt] [PATCH 2/5] storage: add authId, authDomain to
 virDomainDiskDef
Date: Wed, 12 Oct 2011 17:38:34 +0100
Message-ID: <20111012163834.GC3444@redhat.com>
References: <1316492023-17749-1-git-send-email-sage@newdream.net>
 <1316492023-17749-3-git-send-email-sage@newdream.net>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47206 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751453Ab1JLQiq (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 12 Oct 2011 12:38:46 -0400
Content-Disposition: inline
In-Reply-To: <1316492023-17749-3-git-send-email-sage@newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: libvir-list@redhat.com, ceph-devel@vger.kernel.org

On Mon, Sep 19, 2011 at 09:13:40PM -0700, Sage Weil wrote:
> Add additional fields to let you specify the how to authenticate with a
> network disk type.  The authId is the name to authenticate as, and the
> authDomain optionally describes the domain that user exists in.  The latter
> allows us to locate a secret in using the libvirt secrets API, as the user
> is may not unique if libvirt is talking to multiple backend clusters.
> 
> Signed-off-by: Sage Weil <sage@newdream.net>
> ---
>  docs/schemas/domain.rng |    6 ++++++
>  src/conf/domain_conf.c  |   43 ++++++++++++++++++++++++++++++++++---------
>  src/conf/domain_conf.h  |    2 ++
>  3 files changed, 42 insertions(+), 9 deletions(-)
> 
> diff --git a/docs/schemas/domain.rng b/docs/schemas/domain.rng
> index 6ccbeed..3574f03 100644
> --- a/docs/schemas/domain.rng
> +++ b/docs/schemas/domain.rng
> @@ -736,6 +736,12 @@
>                  </attribute>
>                  <optional>
>                    <attribute name="name"/>
> +		  <element name="auth">
> +		    <attribute name="id"/>
> +		    <optional>
> +		      <attribute name="domain"/>
> +		    </optional>
> +		  </element>
>                  </optional>
>                  <zeroOrMore>
>                    <element name="host">
> diff --git a/src/conf/domain_conf.c b/src/conf/domain_conf.c
> index 010ce57..5b80a9e 100644
> --- a/src/conf/domain_conf.c
> +++ b/src/conf/domain_conf.c
> @@ -2066,7 +2066,7 @@ virDomainDiskDefParseXML(virCapsPtr caps,
>                           unsigned int flags)
>  {
>      virDomainDiskDefPtr def;
> -    xmlNodePtr cur, host;
> +    xmlNodePtr cur, child;
>      char *type = NULL;
>      char *device = NULL;
>      char *driverName = NULL;
> @@ -2084,6 +2084,8 @@ virDomainDiskDefParseXML(virCapsPtr caps,
>      char *devaddr = NULL;
>      virStorageEncryptionPtr encryption = NULL;
>      char *serial = NULL;
> +    char *authId = NULL;
> +    char *authDomain = NULL;
>  
>      if (VIR_ALLOC(def) < 0) {
>          virReportOOMError();
> @@ -2137,10 +2139,10 @@ virDomainDiskDefParseXML(virCapsPtr caps,
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
> @@ -2149,20 +2151,30 @@ virDomainDiskDefParseXML(virCapsPtr caps,
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
> +                        if (child->type == XML_ELEMENT_NODE &&
> +                            xmlStrEqual(child->name, BAD_CAST "auth")) {
> +                            authId = virXMLPropString(child, "id");
> +                            if (!authId) {
> +                                virDomainReportError(VIR_ERR_INTERNAL_ERROR,
> +                                                     "%s", _("missing id for auth"));
> +                                goto error;
> +                            }
> +                            authDomain = virXMLPropString(child, "domain");
> +                        }
> +                        child = child->next;
>                      }
>                      break;
>                  default:
> @@ -2373,6 +2385,10 @@ virDomainDiskDefParseXML(virCapsPtr caps,
>      hosts = NULL;
>      def->nhosts = nhosts;
>      nhosts = 0;
> +    def->authId = authId;
> +    authId = NULL;
> +    def->authDomain = authDomain;
> +    authDomain = NULL;
>      def->driverName = driverName;
>      driverName = NULL;
>      def->driverType = driverType;
> @@ -2408,6 +2424,8 @@ cleanup:
>      VIR_FREE(hosts);
>      VIR_FREE(protocol);
>      VIR_FREE(device);
> +    VIR_FREE(authDomain);
> +    VIR_FREE(authId);
>      VIR_FREE(driverType);
>      VIR_FREE(driverName);
>      VIR_FREE(cachetag);
> @@ -8645,12 +8663,19 @@ virDomainDiskDefFormat(virBufferPtr buf,
>              if (def->src) {
>                  virBufferEscapeString(buf, " name='%s'", def->src);
>              }
> -            if (def->nhosts == 0) {
> +            if (def->nhosts == 0 && def->authId == NULL) {
>                  virBufferAsprintf(buf, "/>\n");
>              } else {
>                  int i;
>  
>                  virBufferAsprintf(buf, ">\n");
> +                if (def->authId) {
> +                    virBufferAsprintf(buf, "        <auth id='%s'",
> +                                      def->authId);
> +                    if (def->authDomain)
> +                        virBufferAsprintf(buf, " domain='%s'", def->authDomain);
> +                    virBufferStrcat(buf, "/>\n", NULL);
> +                }
>                  for (i = 0; i < def->nhosts; i++) {
>                      virBufferEscapeString(buf, "        <host name='%s'",
>                                            def->hosts[i].name);
> diff --git a/src/conf/domain_conf.h b/src/conf/domain_conf.h
> index abf9cbd..8a997e1 100644
> --- a/src/conf/domain_conf.h
> +++ b/src/conf/domain_conf.h
> @@ -221,6 +221,8 @@ struct _virDomainDiskDef {
>      int protocol;
>      int nhosts;
>      virDomainDiskHostDefPtr hosts;
> +    char *authDomain;     /* ceph cluster name */
> +    char *authId;         /* ceph auth id */
>      char *driverName;
>      char *driverType;
>      char *serial;

Based on my comments in patch 0, I would suggest something along the
lines of:

    enum virDomainDiskSecretType {
       VIR_DOMAIN_DISK_SECRET_TYPE_NONE,
       VIR_DOMAIN_DISK_SECRET_TYPE_UUID,
       VIR_DOMAIN_DISK_SECRET_TYPE_USAGE,
    };

    struct {
       char *username;
       int secretType;
       union {
         unsigned char uuid[VIR_UUID_BUFLEN];
         char *usage;
       } secret;
    } auth;


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://autobuild.org       -o-         http://search.cpan.org/~danberr/ :|
|: http://entangle-photo.org       -o-       http://live.gnome.org/gtk-vnc :|
