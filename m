From: David Disseldorp <ddiss@suse.de>
Subject: [RFC PATCH 0/5] rbd_tcm cluster COMPARE AND WRITE
Date: Wed, 29 Jul 2015 03:15:47 +0200
Message-ID: <1438132552-14673-1-git-send-email-ddiss@suse.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35657 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751369AbbG2BQA (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 28 Jul 2015 21:16:00 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: mchristi@redhat.com
Cc: ceph-devel@vger.kernel.org

Hi Mike,

This RFC patch-set expands on your recently proposed cluster API changes
to add rbd_tcm COMPARE AND WRITE support.

Rather than offloading the entire COMPARE AND WRITE operation to the
cluster back-end, these changes extend on the existing local semaphore
usage, to additionally take an RBD COMPARE AND WRITE device lock. RBD
device lock acquisition is handled via a newly added rbd_tcm workqueue.

I'd appreciate feedback on the overall direction of these changes.

Cheers, David

--

 drivers/block/Kconfig                |   3 +-
 drivers/block/rbd.h                  |   3 +
 drivers/block/rbd_main.c             |  26 ++--
 drivers/block/rbd_tcm.c              | 208 +++++++++++++++++++++++++++
 drivers/target/target_core_sbc.c     |  28 +++-
 include/target/target_core_cluster.h |   4 +
 6 files changed, 253 insertions(+), 19 deletions(-)

