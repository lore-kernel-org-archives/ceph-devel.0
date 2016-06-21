From: Ruben Kerkhof <ruben@rubenkerkhof.com>
Subject: Re: udev events on a disk, at boot time
Date: Tue, 21 Jun 2016 17:30:26 +0200
Message-ID: <CAPed3OFeAJvLy+7G8YdwJ1pdi=p+tRatpPPQ=DmsvGjr-5QouA@mail.gmail.com>
References: <57695098.50403@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:33398 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751380AbcFUPjb convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Jun 2016 11:39:31 -0400
Received: by mail-ob0-f176.google.com with SMTP id xn17so27929142obc.0
        for <ceph-devel@vger.kernel.org>; Tue, 21 Jun 2016 08:38:10 -0700 (PDT)
In-Reply-To: <57695098.50403@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Dear Loic,

On Tue, Jun 21, 2016 at 4:35 PM, Loic Dachary <loic@dachary.org> wrote:
> Hi Ilya,
>
> On Debian Jessie 8.5 which has
>
> root@000000000000:/home/ubuntu# uname -a
> Linux 000000000000.teuthology 3.16.0-4-amd64 #1 SMP Debian 3.16.7-ckt25-2 (2016-04-08) x86_64 GNU/Linux
> root@000000000000:/home/ubuntu# udevadm --version
> 215
>
> it looks like there are no udev ADD events at boot time and the OSD do not activate. After booting, if the disk is removed and re-added (via openstack server volume add / remove for instance), the OSD comes up as expected, which confirms the udev rules and the OSD are good.
>
> This can be worked around by running ceph-disk activate-all which scans all disks when run from /etc/init/ceph-osd-all-starter.conf at boot time. The workaround requires that /dev/disk/by-parttypeuuid is populated[1] and this can be done by installing the 60-ceph-partuuid-workaround.rules [2] file.
>
> Before trying to workaround the problem, I'd like to understand what is the difference with CentOS 7.2 which has
>
> # uname -a
> Linux target167114254243.teuthology 3.10.0-327.el7.x86_64 #1 SMP Thu Nov 19 22:10:57 UTC 2015 x86_64 x86_64 x86_64 GNU/Linux
> # udevadm --version
> 219
>
> and correctly fires the ADD events at boot time.
>
> A CentOS 7(minor version unknown) user reported the same problem as Debian Jessie 8.5 but I don't have information about the udev version nor the kernel version. I suspect this behavior has more to do with the udev + kernel version combination than with the distribution.
>
> I've not actually traced the udev events at boot time because I'm not sure how to do that. Hopefully you have an idea about why this is happening. Otherwise I'll try to collect hard evidence.

I think I'm seeing the exact same issue as you describe on CentOS 7.2,
so this might not be limited to Debian Jessie.
After a reboot the OSDs do not activate.
With udev_log="debug" in /etc/udev/udev.conf, the journal doesn't show
any sign that /usr/lib/udev/rules.d/95-ceph-osd.rules is executed.

ruben@hlm1-pod12-ceph03: ~$ udevadm --version
219

ruben@hlm1-pod12-ceph03: ~$ uname -a
Linux hlm1-pod12-ceph03 3.10.0-327.18.2.el7.x86_64 #1 SMP Thu May 12
11:03:55 UTC 2016 x86_64 x86_64 x86_64 GNU/Linux

Let me know if there's anything I can do to help debug this.

Kind regards,

Ruben Kerkhof
