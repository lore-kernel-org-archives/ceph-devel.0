From: Douglas Fuller <dfuller@redhat.com>
Subject: [PATCH 0/3] rbd: header read/refresh improvements
Date: Thu, 23 Apr 2015 12:06:30 -0700
Message-ID: <cover.1429814290.git.dfuller@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53750 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030449AbbDWTG6 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 23 Apr 2015 15:06:58 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (Postfix) with ESMTPS id AE1DAA10BC
	for <ceph-devel@vger.kernel.org>; Thu, 23 Apr 2015 19:06:58 +0000 (UTC)
Received: from rex001.front.sepia.ceph.com (vpn-56-33.rdu2.redhat.com [10.10.56.33])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t3NJ6vZV006593
	for <ceph-devel@vger.kernel.org>; Thu, 23 Apr 2015 15:06:58 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Support multiple class op calls in one ceph_msg and consolidate rbd header
read and refresh processes to use this feature to reduce the number of
ceph_msgs sent for that process. Refresh features on header refresh and
begin returning EIO if features have changed since mapping.

Douglas Fuller (3):
  ceph: support multiple class method calls in one ceph_msg
  rbd: combine object method calls in header refresh using fewer
    ceph_msgs
  rbd: re-read features during header refresh and detect changes.

 drivers/block/rbd.c             | 518 +++++++++++++++++++++++++++++-----------
 include/linux/ceph/osd_client.h |   3 +-
 net/ceph/messenger.c            |   4 +
 net/ceph/osd_client.c           |  92 ++++++-
 4 files changed, 470 insertions(+), 147 deletions(-)

-- 
1.9.3

