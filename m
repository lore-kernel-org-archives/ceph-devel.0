From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 00/39] fixes for MDS cluster recovery
Date: Sun, 17 Mar 2013 22:51:03 +0800
Message-ID: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:34328 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756413Ab3CQOvt (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 17 Mar 2013 10:51:49 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, greg@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

This serie fixes issues I encountered when running random MDS restart tests.
With these patches, my 3 MDS setup that runs fsstress + thrash_exports can
survive restarting one or two MDS dozens of times.

But there still are lots of unsolved problems, Sometimes rstat corruption,
request hangs ...

This patch series are also in:
  git://github.com/ukernel/ceph.git wip-mds

Regards
Yan, Zheng
