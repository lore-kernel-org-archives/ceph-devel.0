From: Loic Dachary <loic@dachary.org>
Subject: udev events on a disk, at boot time
Date: Tue, 21 Jun 2016 16:35:04 +0200
Message-ID: <57695098.50403@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:51315 "EHLO
	slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752083AbcFUOfH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Jun 2016 10:35:07 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Ilya,

On Debian Jessie 8.5 which has

root@000000000000:/home/ubuntu# uname -a
Linux 000000000000.teuthology 3.16.0-4-amd64 #1 SMP Debian 3.16.7-ckt25=
-2 (2016-04-08) x86_64 GNU/Linux
root@000000000000:/home/ubuntu# udevadm --version
215

it looks like there are no udev ADD events at boot time and the OSD do =
not activate. After booting, if the disk is removed and re-added (via o=
penstack server volume add / remove for instance), the OSD comes up as =
expected, which confirms the udev rules and the OSD are good.

This can be worked around by running ceph-disk activate-all which scans=
 all disks when run from /etc/init/ceph-osd-all-starter.conf at boot ti=
me. The workaround requires that /dev/disk/by-parttypeuuid is populated=
[1] and this can be done by installing the 60-ceph-partuuid-workaround.=
rules [2] file.

Before trying to workaround the problem, I'd like to understand what is=
 the difference with CentOS 7.2 which has

# uname -a
Linux target167114254243.teuthology 3.10.0-327.el7.x86_64 #1 SMP Thu No=
v 19 22:10:57 UTC 2015 x86_64 x86_64 x86_64 GNU/Linux
# udevadm --version
219

and correctly fires the ADD events at boot time.

A CentOS 7(minor version unknown) user reported the same problem as Deb=
ian Jessie 8.5 but I don't have information about the udev version nor =
the kernel version. I suspect this behavior has more to do with the ude=
v + kernel version combination than with the distribution.

I've not actually traced the udev events at boot time because I'm not s=
ure how to do that. Hopefully you have an idea about why this is happen=
ing. Otherwise I'll try to collect hard evidence.

Cheers

[1] https://github.com/ceph/ceph/blob/master/src/ceph-disk/ceph_disk/ma=
in.py#L3737
[2] https://github.com/ceph/ceph/blob/infernalis/udev/60-ceph-partuuid-=
workaround.rules

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
