From: Jake Grimmett <jog@mrc-lmb.cam.ac.uk>
Subject: Re: ceph-mds crash v12.0.3
Date: Wed, 14 Jun 2017 16:49:38 +0100
Message-ID: <fbb1a455-48c3-16c4-fbbf-2a46e720bb67@mrc-lmb.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ppsw-31.csi.cam.ac.uk ([131.111.8.131]:55724 "EHLO
        ppsw-31.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752230AbdFNQFj (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Jun 2017 12:05:39 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, Jake Grimmett <jake.grimmett@gmail.com>

Dear All,

Sorry, but I need to add +1 to the mds crash reports with ceph
12.0.3-1507-g52f0deb

This happened to me after updating from 12.0.2
All was fairly OK for a few hours, I/O  around 500MB/s, then both MDS
servers crashed, and have not worked since.

The two MDS servers, are active:standby, both now crash immediately
after being started.

This cluster has been upgraded from Kraken, through several Luminous
versions, so I did a clean install of SL7.3 on one MDS server, and still
have crashes on this machine.

Cluster has 40 x 8TB drives (EC 4+1), with dual replicated NVME
providing a hotpool to drive the Cephfs layer. df -h /cephfs is/was
200TB. All OSD's are bluestore, and were generated on Luminous.

I enabled snapshots a few days ago, and keep 144 snapshots (one taken
every 10 minutes, each is kept for 24 hours only) about 30TB is copied
into the fs each day. If snapshots caused the crash, I can regenerate
the data, but they are very useful.

One MDS gave this log...

<http://www.mrc-lmb.cam.ac.uk/jog/ceph-mds.cephfs1.log>

many thanks for any suggestions, and it's great to see the experimental
flag removed from bluestore!

Jake
