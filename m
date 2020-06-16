From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 0/3] libceph: target_copy() fixups
Date: Tue, 16 Jun 2020 09:44:12 +0200
Message-ID: <20200616074415.9989-1-idryomov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbgFPHop (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Jun 2020 03:44:45 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3DBC05BD43
        for <ceph-devel@vger.kernel.org>; Tue, 16 Jun 2020 00:44:43 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id t21so13501819edr.12
        for <ceph-devel@vger.kernel.org>; Tue, 16 Jun 2020 00:44:43 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>

Hello,

Split into three commits for backporting reasons: the first two can be
picked up by stable, the third should get some soak time in testing.

Thanks,

                Ilya


Ilya Dryomov (3):
  libceph: don't omit recovery_deletes in target_copy()
  libceph: don't omit used_replica in target_copy()
  libceph: use target_copy() in send_linger()

 net/ceph/osd_client.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.19.2
