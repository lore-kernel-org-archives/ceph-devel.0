From: Douglas Fuller <dfuller@redhat.com>
Subject: [PATCH 0/1] More accurate statfs
Date: Tue, 15 Aug 2017 14:54:50 -0400
Message-ID: <cover.1502823001.git.dfuller@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f179.google.com ([209.85.220.179]:33299 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752495AbdHOSzN (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Aug 2017 14:55:13 -0400
Received: by mail-qk0-f179.google.com with SMTP id a77so9009394qkb.0
        for <ceph-devel@vger.kernel.org>; Tue, 15 Aug 2017 11:55:13 -0700 (PDT)
Received: from localhost.localdomain (96-38-113-238.dhcp.jcsn.tn.charter.com. [96.38.113.238])
        by smtp.gmail.com with ESMTPSA id q127sm6640631qkf.9.2017.08.15.11.55.08
        for <ceph-devel@vger.kernel.org>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 15 Aug 2017 11:55:08 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Improve accuracy of statfs reporting for Ceph filesystems comprising
exactly one data pool. In this case, the Ceph monitor can now report
the space usage for the single data pool instead of the global data
for the entire Ceph cluster. Include support for this message in
mon_client and leverage it in ceph/super.
    
Signed-off-by: Douglas Fuller <dfuller@redhat.com>

Douglas Fuller (1):
  fs/ceph: More accurate statfs

 fs/ceph/super.c                 | 9 ++++++++-
 include/linux/ceph/ceph_fs.h    | 2 ++
 include/linux/ceph/mon_client.h | 2 +-
 net/ceph/mon_client.c           | 6 +++++-
 4 files changed, 16 insertions(+), 3 deletions(-)

-- 
2.11.0
