From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 0/8] fix some issues from cppchecker/clang++
Date: Tue,  5 Feb 2013 23:52:22 +0100
Message-ID: <1360104750-16098-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:50835 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754285Ab3BEWwg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Feb 2013 17:52:36 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>

These patches fix some issues found by using cppchecker/clang++.

Danny Al-Gaaf (8):
  WorkQueue.h: fix cast
  ceph_crypto.cc: remove unused shutdown() outside crypto ifdef's
  obj_bencher.cc: use vector instead of VLA's
  include/buffer.h: fix operator=
  include/types.h: change operator<< function parameter
  include/xlist.h: fix C-style pointer casting
  messages/MOSDRepScrub.h: initialize member variable in constructor
  msg/Message.h: fix C-style pointer casting

 src/common/WorkQueue.h      |  4 ++--
 src/common/ceph_crypto.cc   |  1 -
 src/common/obj_bencher.cc   | 13 +++++++------
 src/include/buffer.h        | 10 +++++++---
 src/include/types.h         |  2 +-
 src/include/xlist.h         |  6 +++---
 src/messages/MOSDRepScrub.h |  2 +-
 src/msg/Message.h           |  4 ++--
 8 files changed, 23 insertions(+), 19 deletions(-)

-- 
1.8.1.2

