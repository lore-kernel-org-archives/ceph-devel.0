From: =?UTF-8?Q?Pawe=c5=82_Sadowski?= <ceph@sadziu.pl>
Subject: Single slow OSD can cause unfound object
Date: Tue, 11 Oct 2016 11:35:16 +0200
Message-ID: <ed8ed02e-4fb7-25ad-3a5f-d462f70409e2@sadziu.pl>
Reply-To: ceph@sadziu.pl
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from h82-143-163-170-static.e-wro.net.pl ([82.143.163.170]:59845
        "EHLO mail.sadziu.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752504AbcJKJgC (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Oct 2016 05:36:02 -0400
Received: from proxy-109-190-254-6.ovh.net ([109.190.254.6] helo=[10.40.3.135])
        by mail.sadziu.pl with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <ceph@sadziu.pl>)
        id 1bttSw-0004aN-SI
        for ceph-devel@vger.kernel.org; Tue, 11 Oct 2016 11:35:19 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I managed to trigger unfound objects on a pool with size 3 and min_size
2 just by removing 'slow' OSD (out and then stop) which is quite
frightening. Shouldn't Ceph stop IO if there is only one copy in this
case (even during recovery/peering/etc)? I'm able to reproduce this on
Hammer (0.94.5, 0.94.9) and Jewel (10.2.3). So far I wasn't able to
trigger this behavior by just stopping such OSD (still testing).

Second thing: throttling mechanism is blocking recovery operations/whole
OSD[4] when there is a lot of client requests for missing objects. I
think it shouldn't be like that.

1: logs from Jewel
https://gist.github.com/anonymous/c8618adca8984132c82f16c351222883

2: steps to reproduce
 - put some load on the cluster (run FIO with high iodepth)
 - slow down single OSD (in my case reduce CPU time using cgroups:
cpu.cfs_quota_us 15000)
 - sleep 120
 - ceph osd out 6
 - sleep 15
 - stop ceph-osd id=6
 - unfound objects appear

This is not 100% reproducible but in my test lab (9 OSDs) I'm able to
trigger this very easily.

3:
mon-01:~ # ceph osd pool get rbd size
size: 3
mon-01:~ # ceph osd pool get rbd min_size
min_size: 2
mon-01:~ # ceph --version
ceph version 10.2.3 (ecc23778eb545d8dd55e2e4735b53cc93f92e65b)

4:
perf dump | grep -A 2 'throttle-osd_client_messages'
    "throttle-osd_client_messages": {
        "val": 100,
        "max": 100,

ops_in_flight:
https://gist.github.com/anonymous/643607fa3f959c91ba7a9794e5d99dea


-- 
PS


