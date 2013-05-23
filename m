From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 0/30] mds: lookup-by-ino & fixes
Date: Thu, 23 May 2013 16:06:28 +0800
Message-ID: <1369296418-14871-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:39281 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751438Ab3EWINE (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 23 May 2013 04:13:04 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, greg@inktank.com, sam.lang@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Patch 1~21 are random fixes for MDS cluster. Patch 22~28 rework
the backtrace handling. Patch 29 introduces lookup-by-ino helper.
Path 30 uses the lookup-by-ino helper to fix issue #4850.

This patch series are also in:
  git://github.com/ukernel/ceph.git wip-mds

Regards
Yan, Zheng
