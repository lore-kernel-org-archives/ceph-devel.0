From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 0/6] more fixes for MDS cluster recovery
Date: Mon, 28 Jan 2013 10:28:20 +0800
Message-ID: <1359340106-24257-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:58841 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751705Ab3A1C23 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 27 Jan 2013 21:28:29 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Patch 1 is an updated version of patch 19 in previous patch series.

The rest patches fix additional issue of MDS cluster recovery. With
these patches, my 3 MDS step (thrash_exports=1, verify_scatter=1, 
two clients ran fsstress) passed overnight test that restarts all
MDS every 3 minutes.

These patches are also in:
  git://github.com/ukernel/ceph.git wip-mds

Regards
Yan, Zheng
