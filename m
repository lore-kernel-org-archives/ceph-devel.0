From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 0/6] libceph: luminous semantic changes and fixes
Date: Fri, 28 Jul 2017 14:41:24 +0200
Message-ID: <1501245690-2362-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33364 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751690AbdG1Mlk (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 28 Jul 2017 08:41:40 -0400
Received: by mail-wm0-f66.google.com with SMTP id q189so16146128wmd.0
        for <ceph-devel@vger.kernel.org>; Fri, 28 Jul 2017 05:41:39 -0700 (PDT)
Received: from orange.brq.redhat.com. (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id c13sm8263773wrc.7.2017.07.28.05.41.38
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jul 2017 05:41:38 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

All straightforward and tested, but I want to make sure I haven't
missed anything.

Thanks,

                Ilya


Ilya Dryomov (6):
  libceph: make encode_request_*() work with r_mempool requests
  libceph: don't call ->reencode_message() more than once per message
  libceph: fallback for when there isn't a pool-specific choose_arg
  crush: assume weight_set != null imples weight_set_size > 0
  libceph: upmap semantic changes
  libceph: make RECOVERY_DELETES feature create a new interval

 include/linux/ceph/osd_client.h |  1 +
 include/linux/ceph/osdmap.h     |  2 ++
 include/linux/ceph/rados.h      |  4 +++
 include/linux/crush/crush.h     |  2 +-
 net/ceph/crush/mapper.c         |  2 +-
 net/ceph/messenger.c            |  6 ++---
 net/ceph/osd_client.c           | 14 +++++++---
 net/ceph/osdmap.c               | 60 ++++++++++++++++++++---------------------
 8 files changed, 53 insertions(+), 38 deletions(-)

-- 
2.4.3

