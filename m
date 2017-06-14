From: John Spray <jspray@redhat.com>
Subject: Re: ceph-mds crash v12.0.3
Date: Wed, 14 Jun 2017 12:38:17 -0400
Message-ID: <CALe9h7deDZNUGFb1E8p3N55bjVG5JyTu63LKpph1N09q0KpsfQ@mail.gmail.com>
References: <fbb1a455-48c3-16c4-fbbf-2a46e720bb67@mrc-lmb.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f181.google.com ([209.85.128.181]:34066 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751816AbdFNQij (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Jun 2017 12:38:39 -0400
Received: by mail-wr0-f181.google.com with SMTP id 77so8130180wrb.1
        for <ceph-devel@vger.kernel.org>; Wed, 14 Jun 2017 09:38:38 -0700 (PDT)
In-Reply-To: <fbb1a455-48c3-16c4-fbbf-2a46e720bb67@mrc-lmb.cam.ac.uk>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jake Grimmett <jog@mrc-lmb.cam.ac.uk>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Jake Grimmett <jake.grimmett@gmail.com>

On Wed, Jun 14, 2017 at 11:49 AM, Jake Grimmett <jog@mrc-lmb.cam.ac.uk> wrote:
> Dear All,
>
> Sorry, but I need to add +1 to the mds crash reports with ceph
> 12.0.3-1507-g52f0deb
>
> This happened to me after updating from 12.0.2
> All was fairly OK for a few hours, I/O  around 500MB/s, then both MDS
> servers crashed, and have not worked since.
>
> The two MDS servers, are active:standby, both now crash immediately
> after being started.
>
> This cluster has been upgraded from Kraken, through several Luminous
> versions, so I did a clean install of SL7.3 on one MDS server, and still
> have crashes on this machine.
>
> Cluster has 40 x 8TB drives (EC 4+1), with dual replicated NVME
> providing a hotpool to drive the Cephfs layer. df -h /cephfs is/was
> 200TB. All OSD's are bluestore, and were generated on Luminous.
>
> I enabled snapshots a few days ago, and keep 144 snapshots (one taken
> every 10 minutes, each is kept for 24 hours only) about 30TB is copied
> into the fs each day. If snapshots caused the crash, I can regenerate
> the data, but they are very useful.
>
> One MDS gave this log...
>
> <http://www.mrc-lmb.cam.ac.uk/jog/ceph-mds.cephfs1.log>

I'm getting a Forbidden trying to load that.

John

> many thanks for any suggestions, and it's great to see the experimental
> flag removed from bluestore!
>
> Jake
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
