From: kbuild test robot <fengguang.wu@intel.com>
Subject: [ceph-client:testing 5/12] fs/ceph/export.c:357:33-39: WARNING:
 PTR_ERR_OR_ZERO can be used
Date: Sat, 27 Jan 2018 11:06:40 +0800
Message-ID: <201801271138.z5XXxB1x%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:48281 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751349AbeA0DGy (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 26 Jan 2018 22:06:54 -0500
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>
Cc: kbuild-all@01.org, ceph-devel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>

tree:   https://github.com/ceph/ceph-client.git testing
head:   287135af0883d8d3debf78a559b547e0665210c2
commit: 961bfcf78c8f91fcab6764c1a18f7782674df916 [5/12] [DO NOT MERGE] ceph: snapshot nfs re-export


coccinelle warnings: (new ones prefixed by >>)

>> fs/ceph/export.c:357:33-39: WARNING: PTR_ERR_OR_ZERO can be used

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
