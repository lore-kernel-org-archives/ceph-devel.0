From: kbuild test robot <lkp@intel.com>
Subject: [ceph-client:testing 2/4] fs/ceph/caps.c:4244:2-3: Unneeded semicolon
Date: Tue, 7 Apr 2020 13:19:44 +0800
Message-ID: <202004071337.Kr4o9xHr%lkp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:24262 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgDGFUh (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 7 Apr 2020 01:20:37 -0400
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: kbuild-all@lists.01.org, ceph-devel@vger.kernel.org

tree:   https://github.com/ceph/ceph-client.git testing
head:   35d3521ea33df79af4358eb1e75f4d89316bf879
commit: ed8895ddd103b886380f70cae1592dd2332278c2 [2/4] ceph: convert mdsc->cap_dirty to a per-session list

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>


coccinelle warnings: (new ones prefixed by >>)

>> fs/ceph/caps.c:4244:2-3: Unneeded semicolon

Please review and possibly fold the followup patch.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
