From: Alex Elder <elder@ieee.org>
Subject: Re: rbd unmap deadlock
Date: Fri, 02 May 2014 11:09:28 -0500
Message-ID: <5363C338.1090506@ieee.org>
References: <CABt9es9QGaVKT7KNtnXhrGNSSdhn12Kgn1e2nUSuUys3A-3Ysg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:57630 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753647AbaEBQJe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 May 2014 12:09:34 -0400
Received: by mail-ie0-f181.google.com with SMTP id y20so5026042ier.26
        for <ceph-devel@vger.kernel.org>; Fri, 02 May 2014 09:09:34 -0700 (PDT)
In-Reply-To: <CABt9es9QGaVKT7KNtnXhrGNSSdhn12Kgn1e2nUSuUys3A-3Ysg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Hannes Landeholm <hannes@jumpstarter.io>, Ceph Development <ceph-devel@vger.kernel.org>

On 05/02/2014 11:04 AM, Hannes Landeholm wrote:
> Hi, I just had a rbd unmap operation deadlock on my development
> machine. The file system was in heavy use before I did it but I have a
> sync barrier before the umount and unmap so it shouldn't matter. The
> rbd unmap hanged in "State:  D (disk sleep)". I have so far waited
> over 10 minutes, this normally takes < 1 sec.
>
> Here is the /proc/pid/stack output:
>
> [<ffffffff8107e23a>] flush_workqueue+0x11a/0x5a0
> [<ffffffffa031b415>] ceph_msgr_flush+0x15/0x20 [libceph]
> [<ffffffffa03219c6>] ceph_monc_stop+0x46/0x120 [libceph]
> [<ffffffffa031af28>] ceph_destroy_client+0x38/0xa0 [libceph]
> [<ffffffffa0359b88>] rbd_client_release+0x68/0xa0 [rbd]
> [<ffffffffa0359bec>] rbd_put_client+0x2c/0x30 [rbd]
> [<ffffffffa0359c06>] rbd_dev_destroy+0x16/0x30 [rbd]
> [<ffffffffa0359c77>] rbd_dev_image_release+0x57/0x60 [rbd]
> [<ffffffffa035adc7>] do_rbd_remove.isra.25+0x167/0x1b0 [rbd]
> [<ffffffffa035ae54>] rbd_remove+0x24/0x30 [rbd]
> [<ffffffff8136ea67>] bus_attr_store+0x27/0x30
> [<ffffffff81218d4d>] sysfs_kf_write+0x3d/0x50
> [<ffffffff8121c982>] kernfs_fop_write+0xd2/0x140
> [<ffffffff811a67fa>] vfs_write+0xba/0x1e0
> [<ffffffff811a7206>] SyS_write+0x46/0xc0
> [<ffffffff814e66e9>] system_call_fastpath+0x16/0x1b
> [<ffffffffffffffff>] 0xffffffffffffffff
>
> Unfortunately our rbd.ko does not appear to have any debug symbols.
>
> Other unmaps also hanged after this that have the same parent. (We are
> using layering.) Linux version: 3.14.1.

Is this "stock" 3.14.1?  Can you provide the full output of "uname -a"?
And if possible, either /proc/config.gz or /boot/config-3.13.1 (or
whichever file seems to match the currently-running kernel)?

Thank you.

					-Alex

>
> Thank you for your time,
> --
> Hannes Landeholm
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

