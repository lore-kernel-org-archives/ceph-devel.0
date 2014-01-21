From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 00/11] Fixes for mds cluster
Date: Tue, 21 Jan 2014 12:15:35 +0800
Message-ID: <1390277745-20142-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:65179 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752548AbaAUEPv (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 20 Jan 2014 23:15:51 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

The last 5 patches are client part of protocol change that handles
corner cases of capability import/export. The mds counterpart is at
  https://github.com/ceph/ceph.git wip-mds-cluster2

The rest patches fix -ESTALE and other misc issues with mds cluster

These patches are also at:
  https://github.com/ceph/ceph-client.git wip-mds-cluster

Regards
Yan, Zheng
