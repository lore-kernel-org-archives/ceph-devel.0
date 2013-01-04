From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 00/29] Various fixes for MDS
Date: Fri,  4 Jan 2013 17:01:51 +0800
Message-ID: <1357290140-17044-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:51114 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750738Ab3ADJCZ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 4 Jan 2013 04:02:25 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

This patch series fix various issues I encountered when running 3 MDS.
I test this patch series by runing fsstress on two clients, using the
same test directory. The MDS and clients could survived overnight test
at times.

This patch series are also in:
  git://github.com/ukernel/ceph.git wip-mds
