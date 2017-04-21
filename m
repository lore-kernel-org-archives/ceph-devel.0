From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: Ceph-deploy for FreeBSD
Date: Fri, 21 Apr 2017 11:30:30 +0200
Message-ID: <60cbcda4-4bcd-90d8-6d5d-bda62b61379e@suse.cz>
References: <30f688f7-a156-5275-94cb-fbc07b7d449e@digiware.nl>
 <76dc3a7e-80bb-6c9d-d502-535258ce0b54@digiware.nl>
 <CAJ4mKGZmMv+ZcuBEkvaqajW7ntK26TDEbT77DM+nDFsPxsyDOw@mail.gmail.com>
 <68eaf07b-e611-fb55-ca9c-08dceb8cae14@digiware.nl>
 <5d1fbebf-243b-ece9-0a77-961f4d269c53@suse.cz>
 <CAJ4mKGZzDTN4KQxFyM0Oify-w0PvxVaX77qwXSYhhMpRGpRkDg@mail.gmail.com>
 <de44a5b4-593e-ed88-c3f4-93520fea972e@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43048 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S948107AbdDUJad (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 21 Apr 2017 05:30:33 -0400
In-Reply-To: <de44a5b4-593e-ed88-c3f4-93520fea972e@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>, Gregory Farnum <gfarnum@redhat.com>
Cc: Joao Eduardo Luis <joao@suse.com>, Ceph Development <ceph-devel@vger.kernel.org>, "Dachary, Loic" <loic@dachary.org>

Bringing Loic into CC in hopes he'll correct my mistakes and 
misconceptions below.

> So systemd is digging around in /dev and /sys proding for devices with
> Ceph properties, and then starts the required ceph-(mon|osd|mds|mgr).
> Or Udev-events telling systemd to act on a device that presents itself
> in the system?

I don't know about ceph-(mon|mds|mgr), but for osd it works 
approximately like the following:

See udev/95-ceph-osd.rules

systemd triggers udev, and the udev rules look for partitions with 
certain "partition GUID codes" ("ceph data" and "ceph journal" 
respectively) and run "ceph-disk trigger" on them.

Cluster deployment tooling is expected to run "ceph-disk prepare" to set 
up the partition GUID codes. AFAIK "ceph-disk activate" is run for each 
OSD at startup as a consequence of "ceph-disk trigger".

HTH,
Nathan
