From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 00/16] Various fixes for mds
Date: Mon, 19 Nov 2012 10:43:32 +0800
Message-ID: <1353293028-15238-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:27822 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752823Ab2KSCnw (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 18 Nov 2012 21:43:52 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com

Hi,

This series of patches are fixes for various of problems I encountered
when running 2 MDS with thrash_exports enabled. The first 3 patches
are general fixes for MDS, the rest patches are fixes for bugs that
only happen in multiple MDS setup.

I tested these patches using 2 MDS with thrash_exports enabled and
sinlge kernel client. They survived fsstress test for hours, the MDS
handled about 500000 requests.

These patches are also in:
  git://github.com/ukernel/ceph.git master

Regards
Yan, Zheng

