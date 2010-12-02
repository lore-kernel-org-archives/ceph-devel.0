From: "Daniel P. Berrange" <berrange@redhat.com>
Subject: Re: [PATCH] add network disk support
Date: Thu, 2 Dec 2010 13:19:28 +0000
Message-ID: <20101202131928.GV2502@redhat.com>
References: <1290718196-14080-1-git-send-email-morita.kazutaka@lab.ntt.co.jp>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42674 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757253Ab0LBNT6 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 2 Dec 2010 08:19:58 -0500
Content-Disposition: inline
In-Reply-To: <1290718196-14080-1-git-send-email-morita.kazutaka@lab.ntt.co.jp>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: MORITA Kazutaka <morita.kazutaka@lab.ntt.co.jp>
Cc: libvir-list@redhat.com, sheepdog@lists.wpkg.org, ceph-devel@vger.kernel.org

On Fri, Nov 26, 2010 at 05:49:56AM +0900, MORITA Kazutaka wrote:
> This patch adds network disk support to libvirt/QEMU.  The currently
> supported protcols are nbd, rbd, and sheepdog.  The XML syntax is like
> this:
> 
>     <disk type="network" device="disk">
>       <driver name="qemu" type="raw" />
>       <source protocol='rbd|sheepdog|nbd' name="...some image identifier...">
>         <host name="mon1.example.org" port="6000">
>         <host name="mon2.example.org" port="6000">
>         <host name="mon3.example.org" port="6000">
>       </source>
>       <target dev="vda" bus="virtio" />
>     </disk>

This design looks good to me.

> 
> Signed-off-by: MORITA Kazutaka <morita.kazutaka@lab.ntt.co.jp>
> ---
> 
> This patch addresses the discussion on
>   https://www.redhat.com/archives/libvir-list/2010-November/msg00759.html
> 
> Josh mentioned that the monitor hostnames of RBD can be set through
> the environment variables, but I couldn't find any documentations
> about it, so the monitors are not set in this patch.  I hope someone
> who is familiar with RBD implements it.
> 
> @@ -1620,6 +1629,30 @@ virDomainDiskDefParseXML(virCapsPtr caps,
>                  case VIR_DOMAIN_DISK_TYPE_DIR:
>                      source = virXMLPropString(cur, "dir");
>                      break;
> +                case VIR_DOMAIN_DISK_TYPE_NETWORK:
> +                    protocol = virXMLPropString(cur, "protocol");
> +                    if (protocol == NULL) {
> +                        virDomainReportError(VIR_ERR_XML_ERROR,
> +                                             "%s", _("missing protocol type"));
> +                        break;
> +                    }
> +                    def->protocol = virDomainDiskProtocolTypeFromString(protocol);

Should check for def->protocal < 0 & raise an error, which
would indicate that 'protocol' was not one of the expected
values.

> +                    source = virXMLPropString(cur, "name");
> +                    host = cur->children;
> +                    while (host != NULL) {
> +                        if (host->type == XML_ELEMENT_NODE &&
> +                            xmlStrEqual(host->name, BAD_CAST "host")) {
> +                            if (VIR_REALLOC_N(hosts, def->nhosts + 1) < 0) {
> +                                virReportOOMError();
> +                                goto error;
> +                            }
> +                            hosts[def->nhosts].name = virXMLPropString(host, "name");
> +                            hosts[def->nhosts].port = virXMLPropString(host, "port");
> +                            def->nhosts++;

Ought to check for NULLs returned by virXMLPropString here
I think.


> +                        }
> +                        host = host->next;
> +                    }
> +                    break;
>                  default:
>                      virDomainReportError(VIR_ERR_INTERNAL_ERROR,
>                                           _("unexpected disk type %s"),
> @@ -1685,7 +1718,7 @@ virDomainDiskDefParseXML(virCapsPtr caps,
>  
>      /* Only CDROM and Floppy devices are allowed missing source path
>       * to indicate no media present */
> -    if (source == NULL &&
> +    if (source == NULL && hosts == NULL &&
>          def->device != VIR_DOMAIN_DISK_DEVICE_CDROM &&
>          def->device != VIR_DOMAIN_DISK_DEVICE_FLOPPY) {
>          virDomainReportError(VIR_ERR_NO_SOURCE,
> @@ -1791,6 +1824,8 @@ virDomainDiskDefParseXML(virCapsPtr caps,
>      source = NULL;
>      def->dst = target;
>      target = NULL;
> +    def->hosts = hosts;
> +    hosts = NULL;
>      def->driverName = driverName;
>      driverName = NULL;
>      def->driverType = driverType;
> @@ -1819,6 +1854,8 @@ cleanup:
>      VIR_FREE(type);
>      VIR_FREE(target);
>      VIR_FREE(source);
> +    VIR_FREE(hosts);

I think you need to free the fields inside 'hosts' too, otherwise
we'd leak memory for the port + host strings in the error path.

> diff --git a/src/qemu/qemu_conf.c b/src/qemu/qemu_conf.c
> index 35caccc..63abd75 100644
> --- a/src/qemu/qemu_conf.c
> +++ b/src/qemu/qemu_conf.c
> @@ -2714,7 +2714,7 @@ qemuBuildDriveStr(virDomainDiskDefPtr disk,
>          break;
>      }
>  
> -    if (disk->src) {
> +    if (disk->src || disk->nhosts > 0) {

If you check for nhosts > 0 here

>          if (disk->type == VIR_DOMAIN_DISK_TYPE_DIR) {
>              /* QEMU only supports magic FAT format for now */
>              if (disk->driverType &&
> @@ -2733,6 +2733,24 @@ qemuBuildDriveStr(virDomainDiskDefPtr disk,
>                  virBufferVSprintf(&opt, "file=fat:floppy:%s,", disk->src);
>              else
>                  virBufferVSprintf(&opt, "file=fat:%s,", disk->src);
> +        } else if (disk->type == VIR_DOMAIN_DISK_TYPE_NETWORK) {
> +            switch (disk->protocol) {
> +            case VIR_DOMAIN_DISK_PROTOCOL_NBD:
> +                virBufferVSprintf(&opt, "file=nbd:%s:%s,",
> +                                  disk->hosts->name, disk->hosts->port);
> +                break;
> +            case VIR_DOMAIN_DISK_PROTOCOL_RBD:
> +                virBufferVSprintf(&opt, "file=rbd:%s,", disk->src);
> +                break;
> +            case VIR_DOMAIN_DISK_PROTOCOL_SHEEPDOG:
> +                if (disk->nhosts > 0)
> +                    virBufferVSprintf(&opt, "file=sheepdog:%s:%s:%s,",
> +                                      disk->hosts->name, disk->hosts->port,
> +                                      disk->src);
> +                else
> +                    virBufferVSprintf(&opt, "file=sheepdog:%s,", disk->src);
> +                break;

This else branch for sheepdog will never execute. So I think
it is better to check the nhosts value in each of these
conditionals. eg We should report an error if nhosts == 0,
or nhosts > 1 for NBD since it only wants 1 host. Likewise
for other protocols as nedeed.

> @@ -5794,7 +5830,67 @@ qemuParseCommandLineDisk(virCapsPtr caps,
>                  values[i] = NULL;
>                  if (STRPREFIX(def->src, "/dev/"))
>                      def->type = VIR_DOMAIN_DISK_TYPE_BLOCK;
> -                else
> +                else if (STRPREFIX(def->src, "nbd:")) {
> +                    char *host, *port;
> +
> +                    def->type = VIR_DOMAIN_DISK_TYPE_NETWORK;
> +                    host = def->src + strlen("nbd:");
> +                    port = strchr(host, ':');
> +                    if (!port) {
> +                        def = NULL;
> +                        qemuReportError(VIR_ERR_INTERNAL_ERROR,
> +                                        _("cannot parse nbd filename '%s'"), def->src);
> +                        goto cleanup;
> +                    }
> +                    *port++ = '\0';
> +                    if (VIR_ALLOC(def->hosts) < 0) {
> +                        virReportOOMError();
> +                        goto cleanup;
> +                    }
> +                    def->nhosts = 1;
> +                    def->hosts->name = strdup(host);
> +                    def->hosts->port = strdup(port);

Should check for NULL in both of these strdup cases.

> +
> +                    VIR_FREE(def->src);
> +                    def->src = NULL;
> +                } else if (STRPREFIX(def->src, "rbd:")) {
> +                    char *p = def->src;
> +
> +                    def->type = VIR_DOMAIN_DISK_TYPE_NETWORK;
> +                    def->src = strdup(p + strlen("rbd:"));

And this one, and a few more strdup's later in the patch.

Regards,
Daniel
