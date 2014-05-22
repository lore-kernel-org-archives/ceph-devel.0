From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH v3 0/4] rbd: make sure we have latest osdmap on 'rbd map'
Date: Thu, 22 May 2014 20:50:04 +0400
Message-ID: <1400777408-7016-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:43530 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752009AbaEVQuM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 May 2014 12:50:12 -0400
Received: by mail-wi0-f176.google.com with SMTP id n15so9581381wiw.3
        for <ceph-devel@vger.kernel.org>; Thu, 22 May 2014 09:50:10 -0700 (PDT)
Received: from localhost ([109.110.67.203])
        by mx.google.com with ESMTPSA id b19sm1247922wic.5.2014.05.22.09.50.09
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 22 May 2014 09:50:10 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

This is a fix for #8184 that makes use of the updated
MMonGetVersionReply userspace code, which will now populate its tid
with the tid of the original MMonGetVersion request.

Thanks,

                Ilya


Ilya Dryomov (4):
  libceph: recognize poolop requests in debugfs
  libceph: mon_get_version request infrastructure
  libceph: add ceph_monc_wait_osdmap()
  rbd: make sure we have latest osdmap on 'rbd map'

 drivers/block/rbd.c             |   36 +++++++++-
 include/linux/ceph/mon_client.h |   11 ++-
 net/ceph/ceph_common.c          |    2 +
 net/ceph/debugfs.c              |    8 ++-
 net/ceph/mon_client.c           |  150 +++++++++++++++++++++++++++++++++++++--
 5 files changed, 194 insertions(+), 13 deletions(-)

-- 
1.7.10.4

