From: Two Spirit <twospirit6905@gmail.com>
Subject: Feature Request ceph -s recovery and resync estimated completion times
Date: Sat, 2 Sep 2017 19:29:46 -0700
Message-ID: <CAKRxpuu6ZoyyPhpEtH4AG-qMepEXqeN++2HZyPKhVzgggCOYyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:37168 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752806AbdICC3r (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 2 Sep 2017 22:29:47 -0400
Received: by mail-io0-f177.google.com with SMTP id 62so3560847iok.4
        for <ceph-devel@vger.kernel.org>; Sat, 02 Sep 2017 19:29:47 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hello,

I seem to be in the degraded data redundancy mode most of the time and
a lot of recovery io going on. I use ceph -s to get an idea of how
long before I go to active+clean. With smaller test setups, I could
see 20-40% and within a short time I would be active+clean, but as I
test with more data, even tho I see a smaller %, it seems like it is
taking forever. I don't have an idea of how long in estimated hours
recovery will complete. I've shown some mdadm RAID outputs that I find
very helpful as I can tell by looking at the finish information to get
an idea of how long to come back and recheck the status.

It would be nice to see that out of Ceph if possible to give some
estimation of completion based on current instantaneous recovery
rates.

 90774/1418378 objects misplaced (6.400%)
            Degraded data redundancy: 48414/1418378 objects degraded
(3.413%), 16 pgs unclean, 10 pgs degraded, 4 pgs undersized



md0 : active raid1 sdc1[2] sdb1[3]
      2095040 blocks super 1.2 [2/1] [U_]
      [>....................]  recovery =  0.4% (9600/2095040)
finish=3.6min speed=9600K/sec



md0 : active raid1 sdb1[0] sdc1[1]
     2095040 blocks super 1.2 [2/2] [UU]
      [===>.................]  resync = 19.7% (414656/2095040)
finish=0.2min speed=138218K/sec
