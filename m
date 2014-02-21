From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 0/6] libceph: CEPH_OSD_OP_SETALLOCHINT osd op
Date: Fri, 21 Feb 2014 20:55:40 +0200
Message-ID: <1393008946-7931-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f51.google.com ([74.125.83.51]:45886 "EHLO
	mail-ee0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755548AbaBUSzv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 21 Feb 2014 13:55:51 -0500
Received: by mail-ee0-f51.google.com with SMTP id b57so1810515eek.24
        for <ceph-devel@vger.kernel.org>; Fri, 21 Feb 2014 10:55:50 -0800 (PST)
Received: from localhost ([109.110.66.27])
        by mx.google.com with ESMTPSA id o43sm29556970eef.12.2014.02.21.10.55.48
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 21 Feb 2014 10:55:48 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

This series adds support for CEPH_OSD_OP_SETALLOCHINT osd op to libceph
along with adjusting rbd to make use of it.  The rationale and the
basic desing was outlined in the "rados io hints" thread on ceph-devel
about a month ago.

Thanks,

                Ilya


Ilya Dryomov (6):
  libceph: encode CEPH_OSD_OP_FLAG_* op flags
  libceph: add support for CEPH_OSD_OP_SETALLOCHINT osd op
  libceph: bump CEPH_OSD_MAX_OP to 3
  rbd: do not hard-code CEPH_OSD_MAX_OP in rbd_osd_req_callback()
  rbd: num_ops parameter for rbd_osd_req_create()
  rbd: prefix rbd writes with CEPH_OSD_OP_SETALLOCHINT osd op

 drivers/block/rbd.c             |   90 ++++++++++++++++++++++++++++-----------
 include/linux/ceph/osd_client.h |   12 +++++-
 include/linux/ceph/rados.h      |   10 ++++-
 net/ceph/osd_client.c           |   32 ++++++++++++++
 4 files changed, 117 insertions(+), 27 deletions(-)

-- 
1.7.10.4

