From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 0/12] Fixes for mds cluster
Date: Fri,  6 Dec 2013 16:46:31 +0800
Message-ID: <1386319603-2610-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:23345 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753977Ab3LFIqs (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 6 Dec 2013 03:46:48 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

The last 5 patches are client part of protocol change that handles
corner cases of capability import/export. The mds counterpart is at
  https://github.com/ceph/ceph.git wip-mds-cluster2

The rest patches fix -ESTALE and other misc issues with mds cluster

These patches are also at:
  https://github.com/ceph/ceph-client.git wip-mds-cluster

Regards
Yan, Zheng
