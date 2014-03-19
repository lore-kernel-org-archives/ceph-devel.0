From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 0/5] wip-tunables3
Date: Wed, 19 Mar 2014 18:09:04 +0200
Message-ID: <1395245349-4513-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f53.google.com ([74.125.83.53]:61052 "EHLO
	mail-ee0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964941AbaCSQJN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Mar 2014 12:09:13 -0400
Received: by mail-ee0-f53.google.com with SMTP id b57so6114563eek.40
        for <ceph-devel@vger.kernel.org>; Wed, 19 Mar 2014 09:09:12 -0700 (PDT)
Received: from localhost ([109.110.66.126])
        by mx.google.com with ESMTPSA id x45sm55546572eef.15.2014.03.19.09.09.10
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 19 Mar 2014 09:09:11 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

This series updates the kernel implementation of CRUSH with a couple of
fixes and a new chooseleaf_vary_r tunable (all ported from ceph.git).
TUNABLES3 feature bit is shared with PRIMARY_AFFINITY, which will also
be posted in a couple of days in order to get everything into 3.15.

Thanks,

                Ilya


Ilya Dryomov (5):
  crush: fix off-by-one errors in total_tries refactor
  crush: allow crush rules to set (re)tries counts to 0
  crush: add chooseleaf_vary_r tunable
  crush: add SET_CHOOSELEAF_VARY_R step
  crush: support chooseleaf_vary_r tunable (tunables3) by default

 include/linux/ceph/ceph_features.h |   10 ++++-
 include/linux/crush/crush.h        |    7 +++
 net/ceph/crush/mapper.c            |   85 ++++++++++++++++++++++++------------
 3 files changed, 74 insertions(+), 28 deletions(-)

-- 
1.7.10.4

