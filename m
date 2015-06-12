From: Douglas Fuller <dfuller@redhat.com>
Subject: [PATCH 0/6] support watch/notify version 2
Date: Fri, 12 Jun 2015 08:56:53 -0700
Message-ID: <cover.1434124007.git.dfuller@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47878 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750832AbbFLP6w (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 12 Jun 2015 11:58:52 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id C8AD3376B96
	for <ceph-devel@vger.kernel.org>; Fri, 12 Jun 2015 15:58:51 +0000 (UTC)
Received: from rex001.front.sepia.ceph.com ([10.17.112.1])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t5CFwpGk025558
	for <ceph-devel@vger.kernel.org>; Fri, 12 Jun 2015 11:58:51 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

osd_client, rbd: add support for version 2 of watch/notify

Support watch/notify 2 in osd_client and update rbd for compatibility.
Map ceph_osd_event to expected watch/notify messages and store watch
and watch error callbacks. Implement CEPH_OSD_WATCH_OP_PING and
CEPH_OSD_WATCH_OP_RECONNECT. Handle CEPH_WATCH_EVENT_DISCONNECT.
Handle CEPH_WATCH_EVENT_NOTIFY_COMPLETE and provide a data item for
clients to consume.

Signed-off-by: Douglas Fuller <dfuller@redhat.com>

Douglas Fuller (3):
  osd_client, rbd: update event interface for watch/notify2
  osd_client: add support for notify payloads via notify event
  osd_client: send watch ping messages

Mike Christie (3):
  ceph/rbd: add support for watch notify payloads
  ceph/rbd: add support for header version 2 and 3
  ceph/rbd: update watch-notify ceph_osd_op

 drivers/block/rbd.c             |  56 ++++--
 include/linux/ceph/osd_client.h |  54 ++++--
 include/linux/ceph/rados.h      |  24 ++-
 net/ceph/osd_client.c           | 379 +++++++++++++++++++++++++++++++++++-----
 4 files changed, 439 insertions(+), 74 deletions(-)

-- 
1.9.3

