From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 00/14] fixes for MDS
Date: Tue, 11 Dec 2012 16:30:46 +0800
Message-ID: <1355214660-26354-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:29584 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751821Ab2LKIbF (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 11 Dec 2012 03:31:05 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

The first patch fixes a journal bug that may corrupt the rstat accounting,
I think it should be included in the next release. The rest patches fix
various issues I encountered when running 3 MDSs with thrash_exports==1.

Regards
Yan, Zheng
