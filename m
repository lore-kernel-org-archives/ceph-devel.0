From: Loic Dachary <loic@dachary.org>
Subject: puzzling ceph with systemd boot sequence error
Date: Tue, 29 Nov 2016 12:23:05 +0100
Message-ID: <348e1d53-2195-2e43-bc89-ce1788cc3700@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:34183 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756357AbcK2LXL (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Nov 2016 06:23:11 -0500
Received: from mfilter1-d.gandi.net (mfilter1-d.gandi.net [217.70.178.130])
        by relay6-d.mail.gandi.net (Postfix) with ESMTP id D5C85FB8F2
        for <ceph-devel@vger.kernel.org>; Tue, 29 Nov 2016 12:23:09 +0100 (CET)
Received: from relay6-d.mail.gandi.net ([IPv6:::ffff:217.70.183.198])
        by mfilter1-d.gandi.net (mfilter1-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
        with ESMTP id mDh-XLnRiKU2 for <ceph-devel@vger.kernel.org>;
        Tue, 29 Nov 2016 12:23:07 +0100 (CET)
Received: from [192.168.1.7] (x4db34ecb.dyn.telefonica.de [77.179.78.203])
        (Authenticated sender: loic@dachary.org)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 41C37FB8E7
        for <ceph-devel@vger.kernel.org>; Tue, 29 Nov 2016 12:23:05 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

An error has been reported a few times [1] on RHEL 7.2 with jewel 10.2.3 (not exactly jewel 10.2.3 but the modified RedHat version of it, however I don't think the differences are significant in that context and it is likely that CentOS or Ubuntu 16.04 users run into the same problem, only not frequently enough to report it).

In a nutshell the partition on which ceph OSD are supposed to be mounted is not available when the OSD tries to start, at boot time. So the OSD tries a few times complaining the directory is not there and gives up. It could be a simple unit ordering problem if systemd did not have a way to order the units... but it does. And all units implicitly depends on local-fs.target which ensures they run after local file systems are mounted, even if it means waiting for LVM volumes to be available.

What really puzzles me is that despite /var being mounted, the OSD can't find the desired directory. The output of journalctl --all --this-boot --no-pager -o_verbose shows (redacted for brievety) /var is mounted before the OSD tries to start:

Fri 2016-11-25 08:23:03.653729 CET

    UNIT=var.mount
    MESSAGE=Mounting /var...

Fri 2016-11-25 08:23:03.943381 CET

    _CMDLINE=/usr/lib/systemd/systemd --switched-root --system --deserialize 21
    UNIT=var.mount
    MESSAGE=Mounted /var.

Fri 2016-11-25 08:23:13.452598 CET

    UNIT=ceph-osd@0.service
    MESSAGE=Starting Ceph object storage daemon...

Fri 2016-11-25 08:23:18.633909 CET

    _SYSTEMD_UNIT=ceph-osd@0.service
    MESSAGE=2016-11-25 08:23:18.633504 7f251db78800 -1 [0;31m ** ERROR: unable to open OSD superblock on /var/lib/ceph/osd/XXXX-0: (2) No such file or directory
    _CMDLINE=/usr/bin/ceph-osd -f --cluster XXXX --id 0 --setuser ceph --setgroup ceph

If systemctl start ceph-osd@0.service is run manually later on, it works as expected. The failure is not permanent, it looks like a race.

I'll keep investigating and update the issue [1] as I make progress. If someone has a clue about what's going on, it would be good news. Even reports of similar problems would help, specially if they happen on other distributions. I'm hoping this is something simple that I don't see because I stared at the problem for too long :-)

Cheers

[1] http://tracker.ceph.com/issues/17889 OSD udev / systemd may race with lvm at boot time

-- 
Loïc Dachary, Artisan Logiciel Libre


