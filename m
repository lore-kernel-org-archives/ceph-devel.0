From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 0/2] fixes for undeletable empty directory
Date: Tue,  4 Dec 2012 16:09:46 +0800
Message-ID: <1354608588-25840-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:5684 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750833Ab2LDIJv (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 4 Dec 2012 03:09:51 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

These two patches fix MDS restart issues that may corrupt the fragstat accounting
and cause undeletable empty directory. These two patches, together with the patch
"mds: fix journaling issue regarding rstat accounting", have passed overnight
"fsstress + restart MDS every 120s" test. No undeletable directory was found.

These patches are also in:
  git://github.com/ukernel/ceph.git wip-mds

Regards
Yan, Zheng
