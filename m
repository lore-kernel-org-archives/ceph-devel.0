From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: puzzling disapearance of /dev/sdc1
Date: Fri, 18 Dec 2015 16:31:01 +0100
Message-ID: <CAOi1vP_2s7KFvxWJZSJB-=rY0eA7GR7AqAvaKHcQfkUWtOr+hg@mail.gmail.com>
References: <5672AAD7.8030004@dachary.org>
	<alpine.DEB.2.00.1512170530200.10312@cobra.newdream.net>
	<5672C258.1020700@dachary.org>
	<CAOi1vP_602U1BB0+epJ6ROJjiF7d-1uLv75M_SYPDeR2Oa47ig@mail.gmail.com>
	<5673FE37.8010408@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:32972 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752981AbbLRPbD convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Dec 2015 10:31:03 -0500
Received: by mail-wm0-f41.google.com with SMTP id p187so69557102wmp.0
        for <ceph-devel@vger.kernel.org>; Fri, 18 Dec 2015 07:31:02 -0800 (PST)
In-Reply-To: <5673FE37.8010408@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Fri, Dec 18, 2015 at 1:38 PM, Loic Dachary <loic@dachary.org> wrote:
> Hi Ilya,
>
> It turns out that sgdisk 0.8.6 -i 2 /dev/vdb removes partitions and re-adds them on CentOS 7 with a 3.10.0-229.11.1.el7 kernel, in the same way partprobe does. It is used intensively by ceph-disk and inevitably leads to races where a device temporarily disapears. The same command (sgdisk 0.8.8) on Ubuntu 14.04 with a 3.13.0-62-generic kernel only generates two udev change events and does not remove / add partitions. The source code between sgdisk 0.8.6 and sgdisk 0.8.8 did not change in a significant way and the output of strace -e ioctl sgdisk -i 2 /dev/vdb is identical in both environments.
>
> ioctl(3, BLKGETSIZE, 20971520)          = 0
> ioctl(3, BLKGETSIZE64, 10737418240)     = 0
> ioctl(3, BLKSSZGET, 512)                = 0
> ioctl(3, BLKSSZGET, 512)                = 0
> ioctl(3, BLKSSZGET, 512)                = 0
> ioctl(3, BLKSSZGET, 512)                = 0
> ioctl(3, HDIO_GETGEO, {heads=16, sectors=63, cylinders=16383, start=0}) = 0
> ioctl(3, HDIO_GETGEO, {heads=16, sectors=63, cylinders=16383, start=0}) = 0
> ioctl(3, BLKGETSIZE, 20971520)          = 0
> ioctl(3, BLKGETSIZE64, 10737418240)     = 0
> ioctl(3, BLKSSZGET, 512)                = 0
> ioctl(3, BLKSSZGET, 512)                = 0
> ioctl(3, BLKGETSIZE, 20971520)          = 0
> ioctl(3, BLKGETSIZE64, 10737418240)     = 0
> ioctl(3, BLKSSZGET, 512)                = 0
> ioctl(3, BLKSSZGET, 512)                = 0
> ioctl(3, BLKSSZGET, 512)                = 0
> ioctl(3, BLKSSZGET, 512)                = 0
> ioctl(3, BLKSSZGET, 512)                = 0
> ioctl(3, BLKSSZGET, 512)                = 0
> ioctl(3, BLKSSZGET, 512)                = 0
> ioctl(3, BLKSSZGET, 512)                = 0
> ioctl(3, BLKSSZGET, 512)                = 0
> ioctl(3, BLKSSZGET, 512)                = 0
> ioctl(3, BLKSSZGET, 512)                = 0
> ioctl(3, BLKSSZGET, 512)                = 0
> ioctl(3, BLKSSZGET, 512)                = 0
>
> This leads me to the conclusion that the difference is in how the kernel reacts to these ioctl.

I'm pretty sure it's not the kernel versions that matter here, but
systemd versions.  Those are all get-property ioctls, and I don't think
sgdisk -i does anything with the partition table.

What it probably does though is it opens the disk for write for some
reason.  When it closes it, udevd (systemd-udevd process) picks that
close up via inotify and issues the BLKRRPART ioctl, instructing the
kernel to re-read the partition table.  Technically, that's different
from what partprobe does, but it still generates those udev events you
are seeing in the monitor.

AFAICT udevd started doing this in v214.

Thanks,

                Ilya
