From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 0/5] libceph: trivial warning fixes
Date: Tue, 23 May 2017 18:33:53 +0200
Message-ID: <1495557238-1077-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f172.google.com ([209.85.220.172]:33972 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933184AbdEWQeL (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 23 May 2017 12:34:11 -0400
Received: by mail-qk0-f172.google.com with SMTP id k74so134847942qke.1
        for <ceph-devel@vger.kernel.org>; Tue, 23 May 2017 09:34:11 -0700 (PDT)
Received: from orange.brq.redhat.com. (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id o15sm784055qki.47.2017.05.23.09.34.09
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 May 2017 09:34:09 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

These are fixes for make W=1 warnings reported by Stephen a few days
ago.

Thanks,

                Ilya


Ilya Dryomov (5):
  libceph: use kbasename() and kill ceph_file_part()
  libceph: make ceph_msg_data_advance() return void
  libceph: drop version variable from ceph_monmap_decode()
  libceph: validate blob_struct_v in process_one_ticket()
  libceph: fix error handling in process_one_ticket()

 include/linux/ceph/ceph_debug.h |  6 +++---
 net/ceph/auth_x.c               | 13 ++++++++-----
 net/ceph/ceph_common.c          | 13 -------------
 net/ceph/messenger.c            | 11 ++++-------
 net/ceph/mon_client.c           |  4 +---
 5 files changed, 16 insertions(+), 31 deletions(-)

-- 
2.4.3

