From: "Daniel P. Berrange" <berrange@redhat.com>
Subject: Re: [libvirt] [PATCH 5/5] qemu/rbd: improve rbd device specification
Date: Wed, 12 Oct 2011 17:48:58 +0100
Message-ID: <20111012164858.GE3444@redhat.com>
References: <1316492023-17749-1-git-send-email-sage@newdream.net>
 <1316492023-17749-6-git-send-email-sage@newdream.net>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:63944 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752907Ab1JLQtL (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 12 Oct 2011 12:49:11 -0400
Content-Disposition: inline
In-Reply-To: <1316492023-17749-6-git-send-email-sage@newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: libvir-list@redhat.com, ceph-devel@vger.kernel.org

On Mon, Sep 19, 2011 at 09:13:43PM -0700, Sage Weil wrote:
> This improves the support for qemu rbd devices by adding support for a few
> key features (e.g., authentication) and cleaning up the way in which
> rbd configuration options are passed to qemu.
> 
> And <auth> member of the disk source xml specifies how librbd should
> authenticate.  The id property is the Ceph/RBD user to authenticate as,
> and the domain property is a identifier (local to libvirt) for the Ceph
> cluster in question.  If both are specified, we look for a libvirt secret
> of type CEPH with matching id and domain properties.
> 
> The old RBD support relied on setting an environment variable to
> communicate information to qemu/librbd.  Instead, pass those options
> explicitly to qemu.  Update the qemu argument parsing and unit tests
> accordingly.
> 
> Signed-off-by: Sage Weil <sage@newdream.net>
> ---
>  src/qemu/qemu_command.c                            |  268 +++++++++++---------
>  .../qemuxml2argv-disk-drive-network-rbd.args       |    6 +-
>  .../qemuxml2argv-disk-drive-network-rbd.xml        |    1 +
>  3 files changed, 157 insertions(+), 118 deletions(-)
> +static int buildRBDString(virConnectPtr conn,
> +                          virDomainDiskDefPtr disk,
> +                          virBufferPtr opt)
> +{
> +    int i;
> +    char idDomain[80];
> +    virSecretPtr sec;
> +    char *secret;
> +    size_t secret_size;
> +
> +    virBufferAsprintf(opt, "rbd:%s", disk->src);
> +    if (disk->authId) {
> +        virBufferEscape(opt, ":", ":id=%s", disk->authId);
> +    }
> +    if (disk->authDomain) {
> +        /* look up secret */
> +        snprintf(idDomain, sizeof(idDomain), "%s/%s", disk->authId,
> +                 disk->authDomain);
> +        sec = virSecretLookupByUsage(conn,
> +                                     VIR_SECRET_USAGE_TYPE_CEPH,
> +                                     idDomain);

This is where you'd want to use  virSecretLookupByUUID.

> +        if (sec) {
> +            char *base64;
> +
> +            secret = (char *)conn->secretDriver->getValue(sec, &secret_size, 0,
> +                                   VIR_SECRET_GET_VALUE_INTERNAL_CALL);

No need for the cast to 'char *', since void * casts to anything in C.

But you do need to handle case of the return'd secret being 'NULL'
and return to the caller in that case.

> +            /* qemu/librbd wants it base64 encoded */
> +            base64_encode_alloc(secret, secret_size, &base64);
> +            virBufferEscape(opt, ":", ":key=%s:auth_supported=cephx\\;none",
> +                            base64);
> +            VIR_FREE(base64);
> +            VIR_FREE(secret);
> +            virUnrefSecret(sec);
> +        } else {
> +            VIR_WARN("rbd id '%s' domain '%s' specified but secret not found",
> +                     disk->authId, disk->authDomain);

You ought to use  qemuReportError() here and return to the caller

> +        }
> +    }
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

> @@ -1453,8 +1594,9 @@ qemuBuildDriveStr(virConnectPtr conn,
>                                    disk->hosts->name, disk->hosts->port);
>                  break;
>              case VIR_DOMAIN_DISK_PROTOCOL_RBD:
> -                /* TODO: set monitor hostnames */
> -                virBufferAsprintf(&opt, "file=rbd:%s,", disk->src);
> +                virBufferStrcat(&opt, "file=", NULL);
> +                buildRBDString(conn, disk, &opt);
> +                virBufferStrcat(&opt, ",", NULL);
>                  break;
>              case VIR_DOMAIN_DISK_PROTOCOL_SHEEPDOG:
>                  if (disk->nhosts == 0)
> @@ -3597,24 +3715,11 @@ qemuBuildCommandLine(virConnectPtr conn,
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
> -                        }
> +                    {
> +                        virBuffer opt = VIR_BUFFER_INITIALIZER;
> +                        buildRBDString(conn, disk, &opt);
> +                        virAsprintf(&file, "%s",
> +                                    virBufferContentAndReset(&opt));

This last statement leaks.  'virBufferContentAndReset' gives you back
the internal buffer to keep, so there's no need to duplicate it using
asprintf. Also you need to check for an error. So you want this

     if (virBufferError(&opt)) {
          virReportOOMError();
          goto cleanup;
     }
     file = virBufferContentAndReset(&opt);


Generally I think you're going in the right direction with this
patch.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://autobuild.org       -o-         http://search.cpan.org/~danberr/ :|
|: http://entangle-photo.org       -o-       http://live.gnome.org/gtk-vnc :|
