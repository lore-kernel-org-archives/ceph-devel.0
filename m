From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH v2 0/5] libceph: CEPH_OSD_OP_SETALLOCHINT osd op
Date: Tue, 25 Feb 2014 17:36:42 +0200
Message-ID: <1393342607-23653-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:53958 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752653AbaBYPgv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Feb 2014 10:36:51 -0500
Received: by mail-la0-f41.google.com with SMTP id gl10so4317808lab.0
        for <ceph-devel@vger.kernel.org>; Tue, 25 Feb 2014 07:36:50 -0800 (PST)
Received: from localhost ([109.110.66.27])
        by mx.google.com with ESMTPSA id gi5sm22686572lbc.4.2014.02.25.07.36.48
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 25 Feb 2014 07:36:49 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

This is a v2 of the CEPH_OSD_OP_SETALLOCHINT osd op series.
Incorporated are Sage's and Alex's comments.  The rationale and the
basic design is outlined in the "rados io hints" thread on ceph-devel.

Discussion in the wip-hint thread is still on-going, but where it's
headed is unclear.  This posting is simply to reflect the state of the
series after a thorough review by Alex.

Thanks,

                Ilya


Ilya Dryomov (5):
  libceph: encode CEPH_OSD_OP_FLAG_* op flags
  libceph: add support for CEPH_OSD_OP_SETALLOCHINT osd op
  libceph: bump CEPH_OSD_MAX_OP to 3
  rbd: num_ops parameter for rbd_osd_req_create()
  rbd: prefix rbd writes with CEPH_OSD_OP_SETALLOCHINT osd op

 drivers/block/rbd.c             |   79 +++++++++++++++++++++++++++------------
 include/linux/ceph/osd_client.h |   13 ++++++-
 include/linux/ceph/rados.h      |   10 ++++-
 net/ceph/osd_client.c           |   33 ++++++++++++++++
 4 files changed, 110 insertions(+), 25 deletions(-)

-- 
1.7.10.4

