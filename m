From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 0/2] rbd: compression_hint option
Date: Mon,  1 Jun 2020 21:58:24 +0200
Message-ID: <20200601195826.17159-1-idryomov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbgFAT6h (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 1 Jun 2020 15:58:37 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48124C061A0E
        for <ceph-devel@vger.kernel.org>; Mon,  1 Jun 2020 12:58:37 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id q25so777705wmj.0
        for <ceph-devel@vger.kernel.org>; Mon, 01 Jun 2020 12:58:37 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Jason Dillaman <jdillama@redhat.com>

Hello,

This adds support for RADOS compressible/incompressible allocation
hints, available since Kraken.

Thanks,

                Ilya


Ilya Dryomov (2):
  libceph: support for alloc hint flags
  rbd: compression_hint option

 drivers/block/rbd.c             | 44 ++++++++++++++++++++++++++++++++-
 include/linux/ceph/osd_client.h |  4 ++-
 include/linux/ceph/rados.h      | 14 +++++++++++
 net/ceph/osd_client.c           |  8 +++++-
 4 files changed, 67 insertions(+), 3 deletions(-)

-- 
2.19.2
