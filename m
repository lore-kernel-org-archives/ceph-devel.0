From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] devices: recognise rbd devices
Date: Thu, 31 Aug 2017 16:10:39 +0200
Message-ID: <CAOi1vP8PVEOg9P2yw4ARoszE6F+W=uN5kW0KqGBtXa0=08tZOQ@mail.gmail.com>
References: <1502900525-23375-1-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:34014 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751336AbdHaOKk (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Aug 2017 10:10:40 -0400
Received: by mail-io0-f195.google.com with SMTP id k22so4134997iod.1
        for <ceph-devel@vger.kernel.org>; Thu, 31 Aug 2017 07:10:40 -0700 (PDT)
In-Reply-To: <1502900525-23375-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: lvm-devel@redhat.com
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Alasdair Kergon <agk@redhat.com>

On Wed, Aug 16, 2017 at 6:22 PM, Ilya Dryomov <idryomov@gmail.com> wrote:
> Under single_major scheme introduced in kernel 3.14, rbd devices
> support up to 16 partitions.  In pre-single_major mode, rbd driver
> takes up the whole major.
>
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> ---
>  WHATS_NEW                 | 1 +
>  lib/device/device-types.h | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/WHATS_NEW b/WHATS_NEW
> index c8f072f3c387..b1f16cb054b5 100644
> --- a/WHATS_NEW
> +++ b/WHATS_NEW
> @@ -1,5 +1,6 @@
>  Version 2.02.174 -
>  =================================
> +  Recognise RADOS block devices (RBD) in filter.
>    Fix check for 2nd mda at end of disk fits if using pvcreate --restorefile.
>    Use maximum metadataarea size that fits with pvcreate --restorefile.
>    Always clear cached bootloaderarea when wiping label e.g. in pvcreate.
> diff --git a/lib/device/device-types.h b/lib/device/device-types.h
> index 2834cd11fd3a..57b430173e56 100644
> --- a/lib/device/device-types.h
> +++ b/lib/device/device-types.h
> @@ -64,5 +64,6 @@ static const dev_known_type_t _dev_known_types[] = {
>         {"nvme", 64, "NVM Express"},
>         {"zvol", 16, "ZFS Zvols"},
>         {"VxDMP", 16, "Veritas Dynamic Multipathing"},
> +       {"rbd", 16, "RADOS block device (RBD)"},
>         {"", 0, ""}
>  };

Ping...  This gained a trivial conflict in WHATS_NEW, should I resend?

Thanks,

                Ilya
