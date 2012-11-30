From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 0/5] mds: fixes for mds
Date: Fri, 30 Nov 2012 10:36:49 +0800
Message-ID: <1354243014-21072-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:8401 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753813Ab2K3ChA (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 29 Nov 2012 21:37:00 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Hi,

The 1st patch fixes a rstat accounting bug. The 5th patch fixes journal
replay bug, the fix requires a minor disk format change.   

These patches are also in:
  git://github.com/ukernel/ceph.git wip-mds

Regards
Yan, Zheng
