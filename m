From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 0/6] fixes for cephfs
Date: Mon, 19 Nov 2012 10:49:03 +0800
Message-ID: <1353293349-15494-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:10829 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752786Ab2KSCtN (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 18 Nov 2012 21:49:13 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com

Hi,

These patchs are fixes for cephfs kernel client bugs when running
2 MDS with thrash_exports enabled.

These patches are also in:
  git://github.com/ukernel/ceph-client.git master

Regards
Yan, Zheng

