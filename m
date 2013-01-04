From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 0/6] fixes for cephfs kernel client
Date: Fri,  4 Jan 2013 19:34:15 +0800
Message-ID: <1357299261-20591-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:48663 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753870Ab3ADLe0 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 4 Jan 2013 06:34:26 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

These patches are client side modification for multiple MDS setup.
I'm not quite sure if patch 6 is correct, please review it.

These patches are also in:
  git://github.com/ukernel/ceph-client.git wip-ceph
