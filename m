From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 0/3] rbd: make sure we have latest osdmap on 'rbd map'
Date: Thu, 24 Apr 2014 20:23:24 +0400
Message-ID: <1398356607-10666-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f42.google.com ([74.125.83.42]:52371 "EHLO
	mail-ee0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753171AbaDXQXa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Apr 2014 12:23:30 -0400
Received: by mail-ee0-f42.google.com with SMTP id d17so2056784eek.1
        for <ceph-devel@vger.kernel.org>; Thu, 24 Apr 2014 09:23:29 -0700 (PDT)
Received: from localhost ([109.110.67.18])
        by mx.google.com with ESMTPSA id w46sm17090035eeo.35.2014.04.24.09.23.28
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 24 Apr 2014 09:23:29 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

This is a rewrite of the fix for #8184 to use MMonGetVersion message
instead of a kludgy timeout.

Thanks,

                Ilya


Ilya Dryomov (3):
  libceph: mon_get_version request infrastructure
  libceph: add ceph_monc_wait_osdmap()
  rbd: make sure we have latest osdmap on 'rbd map'

 drivers/block/rbd.c             |   27 ++++++--
 include/linux/ceph/mon_client.h |   13 ++--
 net/ceph/ceph_common.c          |    2 +
 net/ceph/debugfs.c              |    2 +
 net/ceph/mon_client.c           |  146 +++++++++++++++++++++++++++++++++++++--
 5 files changed, 175 insertions(+), 15 deletions(-)

-- 
1.7.10.4

