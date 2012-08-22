From: Tommi Virtanen <tv@inktank.com>
Subject: Re: Ceph performance improvement
Date: Wed, 22 Aug 2012 09:03:47 -0700
Message-ID: <CADvuQRHQmK991u8NO3YH5qifTz-bj87YUfh2xmGRLrMVNZFGQw@mail.gmail.com>
References: <50349E62.90405@ledeuns.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:57542 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932391Ab2HVQEI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Aug 2012 12:04:08 -0400
Received: by vbbff1 with SMTP id ff1so1199888vbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 22 Aug 2012 09:04:07 -0700 (PDT)
In-Reply-To: <50349E62.90405@ledeuns.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Denis Fondras <ceph@ledeuns.net>
Cc: ceph-devel@vger.kernel.org

On Wed, Aug 22, 2012 at 1:54 AM, Denis Fondras <ceph@ledeuns.net> wrote:
> First of all, here is my setup :
> for the system, 1x 64GB SSD (Crucial C300 - /dev/sda) for the journal and 4x
> 3TB drive (Western Digital WD30EZRX). Everything but the boot partition is
> BTRFS-formated and 4K-aligned.
...
> [osd]
>         osd data = /home/osd.$id
>         osd journal = /home/osd.$id.journal
>         osd journal size = 1000
>         keyring = /etc/ceph/keyring.$name
>
> [osd.0]
>         host = ceph-osd-0
>         btrfs devs =
> /dev/disk/by-id/scsi-SATA_WDC_WD30EZRX-00_WD-WMAWZ0152201
>         btrfs options = rw,noatime

Are you sure your osd data and journal are on the disks you think? The
/home paths look suspicious -- especially for journal, which often
should be a block device.

Can you share output of "mount" and "ls -ld /home/osd.*"
