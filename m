From: Loic Dachary <loic@dachary.org>
Subject: Re: puzzling ceph with systemd boot sequence error
Date: Wed, 30 Nov 2016 07:24:24 +0100
Message-ID: <b853373c-5490-ff27-2283-e3c0d36b1060@dachary.org>
References: <348e1d53-2195-2e43-bc89-ce1788cc3700@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:49391 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751606AbcK3GY3 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Nov 2016 01:24:29 -0500
Received: from mfilter28-d.gandi.net (mfilter28-d.gandi.net [217.70.178.159])
        by relay2-d.mail.gandi.net (Postfix) with ESMTP id 8783AC5A61
        for <ceph-devel@vger.kernel.org>; Wed, 30 Nov 2016 07:24:27 +0100 (CET)
Received: from relay2-d.mail.gandi.net ([IPv6:::ffff:217.70.183.194])
        by mfilter28-d.gandi.net (mfilter28-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
        with ESMTP id Bql36Bdw479n for <ceph-devel@vger.kernel.org>;
        Wed, 30 Nov 2016 07:24:25 +0100 (CET)
Received: from [192.168.1.7] (x4db35934.dyn.telefonica.de [77.179.89.52])
        (Authenticated sender: loic@dachary.org)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id AF3BFC5A56
        for <ceph-devel@vger.kernel.org>; Wed, 30 Nov 2016 07:24:25 +0100 (CET)
In-Reply-To: <348e1d53-2195-2e43-bc89-ce1788cc3700@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

I was misreading the error message.

* ERROR: unable to open OSD superblock on /var/lib/ceph/osd/XXXX-0: (2) No such file or directory

does not mean /var/lib/ceph/osd/XXXX-0 does not exist. It means files within /var/lib/ceph/osd/XXXX-0 do not exist. It would be clearer if the path of the missing file name was displayed instead of the directory [1].

Cheers

[1] https://github.com/ceph/ceph/blob/jewel/src/ceph_osd.cc#L411

On 29/11/2016 12:23, Loic Dachary wrote:
> Hi,
> 
> An error has been reported a few times [1] on RHEL 7.2 with jewel 10.2.3 (not exactly jewel 10.2.3 but the modified RedHat version of it, however I don't think the differences are significant in that context and it is likely that CentOS or Ubuntu 16.04 users run into the same problem, only not frequently enough to report it).
> 
> In a nutshell the partition on which ceph OSD are supposed to be mounted is not available when the OSD tries to start, at boot time. So the OSD tries a few times complaining the directory is not there and gives up. It could be a simple unit ordering problem if systemd did not have a way to order the units... but it does. And all units implicitly depends on local-fs.target which ensures they run after local file systems are mounted, even if it means waiting for LVM volumes to be available.
> 
> What really puzzles me is that despite /var being mounted, the OSD can't find the desired directory. The output of journalctl --all --this-boot --no-pager -o_verbose shows (redacted for brievety) /var is mounted before the OSD tries to start:
> 
> Fri 2016-11-25 08:23:03.653729 CET
> 
>     UNIT=var.mount
>     MESSAGE=Mounting /var...
> 
> Fri 2016-11-25 08:23:03.943381 CET
> 
>     _CMDLINE=/usr/lib/systemd/systemd --switched-root --system --deserialize 21
>     UNIT=var.mount
>     MESSAGE=Mounted /var.
> 
> Fri 2016-11-25 08:23:13.452598 CET
> 
>     UNIT=ceph-osd@0.service
>     MESSAGE=Starting Ceph object storage daemon...
> 
> Fri 2016-11-25 08:23:18.633909 CET
> 
>     _SYSTEMD_UNIT=ceph-osd@0.service
>     MESSAGE=2016-11-25 08:23:18.633504 7f251db78800 -1 [0;31m ** ERROR: unable to open OSD superblock on /var/lib/ceph/osd/XXXX-0: (2) No such file or directory
>     _CMDLINE=/usr/bin/ceph-osd -f --cluster XXXX --id 0 --setuser ceph --setgroup ceph
> 
> If systemctl start ceph-osd@0.service is run manually later on, it works as expected. The failure is not permanent, it looks like a race.
> 
> I'll keep investigating and update the issue [1] as I make progress. If someone has a clue about what's going on, it would be good news. Even reports of similar problems would help, specially if they happen on other distributions. I'm hoping this is something simple that I don't see because I stared at the problem for too long :-)
> 
> Cheers
> 
> [1] http://tracker.ceph.com/issues/17889 OSD udev / systemd may race with lvm at boot time
> 

-- 
Loïc Dachary, Artisan Logiciel Libre
