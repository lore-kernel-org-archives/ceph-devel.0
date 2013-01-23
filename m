From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 00/24] fixes for MDS cluster recovery
Date: Wed, 23 Jan 2013 11:08:36 +0800
Message-ID: <1358910541-15535-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:18683 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752766Ab3AWDJF (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 22 Jan 2013 22:09:05 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Patch 1 fixes a readdir bug I introduced, I think it should be included in next release.

Patch 2 and patch 3 are non-critical fixes for my previous patches.

Patch 4 modifies the EMetaBlob format to support journalling multiple root inodes

The rest patches in this series fix issues of MDS cluster recovery. Most of them are
related to cross authority rename. Without these patches, if I restarted a busy MDS
cluster (thrash_exports = 1), there were about 50% chance that MDS crash at the
replay or resolve stage. With these patches, the restarting MDS can almost always
enter the rejoin stage in my test.
  
This patch series are also in:
  git://github.com/ukernel/ceph.git wip-mds

Regards
Yan, Zheng
