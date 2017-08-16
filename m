From: Douglas Fuller <dfuller@redhat.com>
Subject: [PATCHv2 0/1] fs/ceph: More accurate statfs
Date: Wed, 16 Aug 2017 10:19:26 -0400
Message-ID: <cover.1502892972.git.dfuller@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f179.google.com ([209.85.220.179]:35231 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751466AbdHPOTg (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Aug 2017 10:19:36 -0400
Received: by mail-qk0-f179.google.com with SMTP id d145so20983458qkc.2
        for <ceph-devel@vger.kernel.org>; Wed, 16 Aug 2017 07:19:35 -0700 (PDT)
Received: from localhost.localdomain (96-38-113-238.dhcp.jcsn.tn.charter.com. [96.38.113.238])
        by smtp.gmail.com with ESMTPSA id f56sm653141qta.79.2017.08.16.07.19.33
        for <ceph-devel@vger.kernel.org>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 16 Aug 2017 07:19:34 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

fs/ceph: More accurate statfs
    
Improve accuracy of statfs reporting for Ceph filesystems comprising
exactly one data pool. In this case, the Ceph monitor can now report
the space usage for the single data pool instead of the global data
for the entire Ceph cluster. Include support for this message in
mon_client and leverage it in ceph/super.
    
Reviewed-by: Yan, Zheng <zyan@redhat.com>
[v2. corrected byte order issues]
Signed-off-by: Douglas Fuller <dfuller@redhat.com>

Douglas Fuller (1):
  fs/ceph: More accurate statfs

 fs/ceph/super.c                 | 9 ++++++++-
 include/linux/ceph/ceph_fs.h    | 2 ++
 include/linux/ceph/mon_client.h | 2 +-
 net/ceph/mon_client.c           | 6 +++++-
 4 files changed, 16 insertions(+), 3 deletions(-)

-- 
2.11.0 (Apple Git-81)

