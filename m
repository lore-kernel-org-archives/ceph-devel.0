From: Douglas Fuller <dfuller@redhat.com>
Subject: [PATCHv2 0/3] rbd: header read/refresh improvements
Date: Fri, 24 Apr 2015 06:22:16 -0700
Message-ID: <cover.1429881439.git.dfuller@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42210 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751217AbbDXNWs (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 24 Apr 2015 09:22:48 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t3ODMmeQ001423
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <ceph-devel@vger.kernel.org>; Fri, 24 Apr 2015 09:22:48 -0400
Received: from rex001.front.sepia.ceph.com (vpn-55-141.rdu2.redhat.com [10.10.55.141])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t3ODMlWD020121
	for <ceph-devel@vger.kernel.org>; Fri, 24 Apr 2015 09:22:47 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Support multiple class op calls in one ceph_msg and consolidate rbd header
read and refresh processes to use this feature to reduce the number of
ceph_msgs sent for that process. Refresh features on header refresh and
begin returning EIO if features have changed since mapping.

v2: Edit history and address comments from Mike Christie.

Douglas Fuller (3):
  ceph: support multiple class method calls in one ceph_msg
  rbd: combine object method calls in header refresh using fewer
    ceph_msgs
  rbd: re-read features during header refresh and detect changes.

 drivers/block/rbd.c             | 512 +++++++++++++++++++++++++++++-----------
 include/linux/ceph/osd_client.h |   3 +-
 net/ceph/messenger.c            |   4 +
 net/ceph/osd_client.c           |  90 ++++++-
 4 files changed, 462 insertions(+), 147 deletions(-)

-- 
1.9.3

