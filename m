From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH v2 0/5] ceph: fixes for nfs export
Date: Fri,  7 Mar 2014 17:04:32 +0800
Message-ID: <1394183077-399-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:17762 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750925AbaCGJEt (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 7 Mar 2014 04:04:49 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

Changes since v1:
 make ceph_fh_to_parent() use LOOKUPPARENT to find parent dentry.
 if LOOKUPPARENT fails, retry finding the dentry that corresponds
 to the 'parent_ino'
