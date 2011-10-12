From: "Daniel P. Berrange" <berrange@redhat.com>
Subject: Re: [libvirt] [PATCH 3/5] qemu: pass virConnectPtr into
 Domain{Attach, Detach}*
Date: Wed, 12 Oct 2011 17:40:47 +0100
Message-ID: <20111012164047.GD3444@redhat.com>
References: <1316492023-17749-1-git-send-email-sage@newdream.net>
 <1316492023-17749-4-git-send-email-sage@newdream.net>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:14984 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751791Ab1JLQk7 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 12 Oct 2011 12:40:59 -0400
Content-Disposition: inline
In-Reply-To: <1316492023-17749-4-git-send-email-sage@newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: libvir-list@redhat.com, ceph-devel@vger.kernel.org

On Mon, Sep 19, 2011 at 09:13:41PM -0700, Sage Weil wrote:
> The qemu RBD driver needs access to the conn in order to get the secret
> needed for connecting to the ceph cluster.
> 
> Signed-off-by: Sage Weil <sage@newdream.net>
> ---
>  src/qemu/qemu_command.c |    5 +++--
>  src/qemu/qemu_command.h |    3 ++-
>  src/qemu/qemu_driver.c  |   17 ++++++++---------
>  src/qemu/qemu_hotplug.c |   15 +++++++++------
>  src/qemu/qemu_hotplug.h |    9 ++++++---
>  5 files changed, 28 insertions(+), 21 deletions(-)
> 
> diff --git a/src/qemu/qemu_command.c b/src/qemu/qemu_command.c
> index 76df0aa..32dcb79 100644
> --- a/src/qemu/qemu_command.c
> +++ b/src/qemu/qemu_command.c
> @@ -1336,7 +1336,8 @@ qemuSafeSerialParamValue(const char *value)
>  
>  
>  char *
> -qemuBuildDriveStr(virDomainDiskDefPtr disk,
> +qemuBuildDriveStr(virConnectPtr conn,
> +                  virDomainDiskDefPtr disk,
>                    bool bootable,
>                    virBitmapPtr qemuCaps)
>  {
> @@ -3460,7 +3461,7 @@ qemuBuildCommandLine(virConnectPtr conn,
>                      deviceFlagMasked = true;
>                  }
>              }
> -            optstr = qemuBuildDriveStr(disk,
> +            optstr = qemuBuildDriveStr(conn, disk,
>                                         emitBootindex ? false : !!bootindex,
>                                         qemuCaps);
>              if (deviceFlagMasked)
> diff --git a/src/qemu/qemu_command.h b/src/qemu/qemu_command.h
> index 87660f2..4a90544 100644
> --- a/src/qemu/qemu_command.h
> +++ b/src/qemu/qemu_command.h
> @@ -75,7 +75,8 @@ char *qemuDeviceDriveHostAlias(virDomainDiskDefPtr disk,
>                                 virBitmapPtr qemuCaps);
>  
>  /* Both legacy & current support */
> -char *qemuBuildDriveStr(virDomainDiskDefPtr disk,
> +char *qemuBuildDriveStr(virConnectPtr conn,
> +                        virDomainDiskDefPtr disk,
>                          bool bootable,
>                          virBitmapPtr qemuCaps);
>  char *qemuBuildFSStr(virDomainFSDefPtr fs,
> diff --git a/src/qemu/qemu_driver.c b/src/qemu/qemu_driver.c
> index ce19be7..a1b73e7 100644
> --- a/src/qemu/qemu_driver.c
> +++ b/src/qemu/qemu_driver.c
> @@ -4773,7 +4773,8 @@ qemudDomainUndefine(virDomainPtr dom)
>  }
>  
>  static int
> -qemuDomainAttachDeviceDiskLive(struct qemud_driver *driver,
> +qemuDomainAttachDeviceDiskLive(virConnectPtr conn,
> +                               struct qemud_driver *driver,
>                                 virDomainObjPtr vm,
>                                 virDomainDeviceDefPtr dev)
>  {
> @@ -4805,12 +4806,12 @@ qemuDomainAttachDeviceDiskLive(struct qemud_driver *driver,
>          break;
>      case VIR_DOMAIN_DISK_DEVICE_DISK:
>          if (disk->bus == VIR_DOMAIN_DISK_BUS_USB)
> -            ret = qemuDomainAttachUsbMassstorageDevice(driver, vm,
> +            ret = qemuDomainAttachUsbMassstorageDevice(conn, driver, vm,
>                                                         disk);
>          else if (disk->bus == VIR_DOMAIN_DISK_BUS_VIRTIO)
> -            ret = qemuDomainAttachPciDiskDevice(driver, vm, disk);
> +            ret = qemuDomainAttachPciDiskDevice(conn, driver, vm, disk);
>          else if (disk->bus == VIR_DOMAIN_DISK_BUS_SCSI)
> -            ret = qemuDomainAttachSCSIDisk(driver, vm, disk);
> +            ret = qemuDomainAttachSCSIDisk(conn, driver, vm, disk);
>          else
>              qemuReportError(VIR_ERR_CONFIG_UNSUPPORTED,
>                              _("disk bus '%s' cannot be hotplugged."),
> @@ -4866,7 +4867,7 @@ qemuDomainAttachDeviceLive(virDomainObjPtr vm,
>      switch (dev->type) {
>      case VIR_DOMAIN_DEVICE_DISK:
>          qemuDomainObjCheckDiskTaint(driver, vm, dev->data.disk, -1);
> -        ret = qemuDomainAttachDeviceDiskLive(driver, vm, dev);
> +        ret = qemuDomainAttachDeviceDiskLive(dom->conn, driver, vm, dev);
>          if (!ret)
>              dev->data.disk = NULL;
>          break;
> @@ -5396,8 +5397,7 @@ static int qemuDomainAttachDeviceFlags(virDomainPtr dom, const char *xml,
>  
>  static int qemuDomainAttachDevice(virDomainPtr dom, const char *xml)
>  {
> -    return qemuDomainAttachDeviceFlags(dom, xml,
> -                                       VIR_DOMAIN_AFFECT_LIVE);
> +    return qemuDomainAttachDeviceFlags(dom, xml, VIR_DOMAIN_AFFECT_LIVE);
>  }
>  
>  
> @@ -5416,8 +5416,7 @@ static int qemuDomainDetachDeviceFlags(virDomainPtr dom, const char *xml,
>  
>  static int qemuDomainDetachDevice(virDomainPtr dom, const char *xml)
>  {
> -    return qemuDomainDetachDeviceFlags(dom, xml,
> -                                       VIR_DOMAIN_AFFECT_LIVE);
> +    return qemuDomainDetachDeviceFlags(dom, xml, VIR_DOMAIN_AFFECT_LIVE);
>  }
>  
>  static int qemudDomainGetAutostart(virDomainPtr dom,
> diff --git a/src/qemu/qemu_hotplug.c b/src/qemu/qemu_hotplug.c
> index 5f449fb..3568609 100644
> --- a/src/qemu/qemu_hotplug.c
> +++ b/src/qemu/qemu_hotplug.c
> @@ -151,7 +151,8 @@ error:
>  }
>  
>  
> -int qemuDomainAttachPciDiskDevice(struct qemud_driver *driver,
> +int qemuDomainAttachPciDiskDevice(virConnectPtr conn,
> +                                  struct qemud_driver *driver,
>                                    virDomainObjPtr vm,
>                                    virDomainDiskDefPtr disk)
>  {
> @@ -187,7 +188,7 @@ int qemuDomainAttachPciDiskDevice(struct qemud_driver *driver,
>          if (qemuAssignDeviceDiskAlias(disk, priv->qemuCaps) < 0)
>              goto error;
>  
> -        if (!(drivestr = qemuBuildDriveStr(disk, false, priv->qemuCaps)))
> +        if (!(drivestr = qemuBuildDriveStr(conn, disk, false, priv->qemuCaps)))
>              goto error;
>  
>          if (!(devstr = qemuBuildDriveDevStr(disk, 0, priv->qemuCaps)))
> @@ -372,7 +373,8 @@ qemuDomainFindOrCreateSCSIDiskController(struct qemud_driver *driver,
>  }
>  
>  
> -int qemuDomainAttachSCSIDisk(struct qemud_driver *driver,
> +int qemuDomainAttachSCSIDisk(virConnectPtr conn,
> +                             struct qemud_driver *driver,
>                               virDomainObjPtr vm,
>                               virDomainDiskDefPtr disk)
>  {
> @@ -416,7 +418,7 @@ int qemuDomainAttachSCSIDisk(struct qemud_driver *driver,
>              goto error;
>      }
>  
> -    if (!(drivestr = qemuBuildDriveStr(disk, false, priv->qemuCaps)))
> +    if (!(drivestr = qemuBuildDriveStr(conn, disk, false, priv->qemuCaps)))
>          goto error;
>  
>      for (i = 0 ; i <= disk->info.addr.drive.controller ; i++) {
> @@ -495,7 +497,8 @@ error:
>  }
>  
>  
> -int qemuDomainAttachUsbMassstorageDevice(struct qemud_driver *driver,
> +int qemuDomainAttachUsbMassstorageDevice(virConnectPtr conn,
> +                                         struct qemud_driver *driver,
>                                           virDomainObjPtr vm,
>                                           virDomainDiskDefPtr disk)
>  {
> @@ -532,7 +535,7 @@ int qemuDomainAttachUsbMassstorageDevice(struct qemud_driver *driver,
>      if (qemuCapsGet(priv->qemuCaps, QEMU_CAPS_DEVICE)) {
>          if (qemuAssignDeviceDiskAlias(disk, priv->qemuCaps) < 0)
>              goto error;
> -        if (!(drivestr = qemuBuildDriveStr(disk, false, priv->qemuCaps)))
> +        if (!(drivestr = qemuBuildDriveStr(conn, disk, false, priv->qemuCaps)))
>              goto error;
>          if (!(devstr = qemuBuildDriveDevStr(disk, 0, priv->qemuCaps)))
>              goto error;
> diff --git a/src/qemu/qemu_hotplug.h b/src/qemu/qemu_hotplug.h
> index 009f1f6..14017bf 100644
> --- a/src/qemu/qemu_hotplug.h
> +++ b/src/qemu/qemu_hotplug.h
> @@ -31,16 +31,19 @@ int qemuDomainChangeEjectableMedia(struct qemud_driver *driver,
>                                     virDomainObjPtr vm,
>                                     virDomainDiskDefPtr disk,
>                                     bool force);
> -int qemuDomainAttachPciDiskDevice(struct qemud_driver *driver,
> +int qemuDomainAttachPciDiskDevice(virConnectPtr conn,
> +                                  struct qemud_driver *driver,
>                                    virDomainObjPtr vm,
>                                    virDomainDiskDefPtr disk);
>  int qemuDomainAttachPciControllerDevice(struct qemud_driver *driver,
>                                          virDomainObjPtr vm,
>                                          virDomainControllerDefPtr controller);
> -int qemuDomainAttachSCSIDisk(struct qemud_driver *driver,
> +int qemuDomainAttachSCSIDisk(virConnectPtr conn,
> +                             struct qemud_driver *driver,
>                               virDomainObjPtr vm,
>                               virDomainDiskDefPtr disk);
> -int qemuDomainAttachUsbMassstorageDevice(struct qemud_driver *driver,
> +int qemuDomainAttachUsbMassstorageDevice(virConnectPtr conn,
> +                                         struct qemud_driver *driver,
>                                           virDomainObjPtr vm,
>                                           virDomainDiskDefPtr disk);
>  int qemuDomainAttachNetDevice(virConnectPtr conn,

ACK, this all looks fine. In fact given that it wasn't there already,
I have a feeling that hotplug of qcow2 encrypted disks is currently
broken, which is something I need to look into.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://autobuild.org       -o-         http://search.cpan.org/~danberr/ :|
|: http://entangle-photo.org       -o-       http://live.gnome.org/gtk-vnc :|
