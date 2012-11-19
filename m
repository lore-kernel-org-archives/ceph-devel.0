From: Drunkard Zhang <gongfan193@gmail.com>
Subject: Files lost after mds rebuild
Date: Mon, 19 Nov 2012 23:55:26 +0800
Message-ID: <CAJiejCTWvtn6yS+_9h07t4KWqRHPqT-Oe23KtXmnvf7ZZbsAAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:57346 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753423Ab2KSPzr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Nov 2012 10:55:47 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so6955978iea.19
        for <ceph-devel@vger.kernel.org>; Mon, 19 Nov 2012 07:55:47 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I created a ceph cluster for test, here's mistake I made:
Add a second mds: mds.ab, executed 'ceph mds set_max_mds 2', then
removed the mds just added;
Then 'ceph mds set_max_mds 1', the first mds.aa crashed, and became laggy.
As I can't repair mds.aa, so did 'ceph mds newfs metadata data
--yes-i-really-mean-it';
mds.aa was back, but 1TB data was in cluster lost, but disk space
still used, by 'ceps -s'.

Is there any chance I can get my data back? If can't, how can I
retrieve back the disk space.

Now it looks like:
log3 ~ # ceph -s
   health HEALTH_OK
   monmap e1: 1 mons at {log3=10.205.119.2:6789/0}, election epoch 0,
quorum 0 log3
   osdmap e1555: 28 osds: 20 up, 20 in
    pgmap v56518: 960 pgs: 960 active+clean; 1134 GB data, 2306 GB
used, 51353 GB / 55890 GB avail
   mdsmap e703: 1/1/1 up {0=aa=up:active}, 1 up:standby

log3 ~ # df | grep osd |sort
/dev/sdb1       2.8T  124G  2.5T   5% /ceph/osd.0
/dev/sdc1       2.8T  104G  2.6T   4% /ceph/osd.1
/dev/sdd1       2.8T   84G  2.6T   4% /ceph/osd.2
/dev/sde1       2.8T  117G  2.6T   5% /ceph/osd.3
/dev/sdf1       2.8T  105G  2.6T   4% /ceph/osd.4
/dev/sdg1       2.8T   84G  2.6T   4% /ceph/osd.5
/dev/sdh1       2.8T  140G  2.5T   6% /ceph/osd.6
/dev/sdi1       2.8T  134G  2.5T   5% /ceph/osd.8
/dev/sdj1       2.8T  112G  2.6T   5% /ceph/osd.7
/dev/sdk1       2.8T  159G  2.5T   6% /ceph/osd.9
/dev/sdl1       2.8T  126G  2.5T   5% /ceph/osd.10

osd on another host didn't show.
