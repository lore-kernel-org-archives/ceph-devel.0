From: David Disseldorp <ddiss@suse.de>
Subject: [RFC PATCH 2/5] SQUASH rbd: fix recursive BLK_DEV_RBD_TCM dependency
Date: Wed, 29 Jul 2015 03:15:49 +0200
Message-ID: <1438132552-14673-3-git-send-email-ddiss@suse.de>
References: <1438132552-14673-1-git-send-email-ddiss@suse.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35656 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750945AbbG2BQA (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 28 Jul 2015 21:16:00 -0400
In-Reply-To: <1438132552-14673-1-git-send-email-ddiss@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: mchristi@redhat.com
Cc: ceph-devel@vger.kernel.org, David Disseldorp <ddiss@suse.de>

net/Kconfig:5:error: recursive dependency detected!
net/Kconfig:5:  symbol NET is selected by SCSI_NETLINK
drivers/scsi/Kconfig:50:	symbol SCSI_NETLINK is selected by
SCSI_FC_ATTRS
drivers/scsi/Kconfig:276:	symbol SCSI_FC_ATTRS is selected by
LIBFC
drivers/scsi/Kconfig:659:	symbol LIBFC is selected by TCM_QLA2XXX
drivers/scsi/qla2xxx/Kconfig:31:symbol TCM_QLA2XXX depends on
TARGET_CORE
drivers/target/Kconfig:2:	symbol TARGET_CORE is selected by
BLK_DEV_RBD_TCM
drivers/block/Kconfig:537:	symbol BLK_DEV_RBD_TCM depends on
BLK_DEV_RBD
drivers/block/Kconfig:520:	symbol BLK_DEV_RBD depends on INET
net/Kconfig:54: symbol INET depends on NET

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 drivers/block/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index d517744..fad92be 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -550,8 +550,7 @@ config BLK_DEV_RBD
 
 config BLK_DEV_RBD_TCM
        bool "Clustered TCM using Rados block devices (RBD)"
-       depends on BLK_DEV_RBD
-       select TARGET_CORE
+       depends on BLK_DEV_RBD && TARGET_CORE
        select TCM_IBLOCK
        default n
        help
-- 
2.1.4

