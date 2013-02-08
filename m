From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 0/6] Fix some memory leaks in Ceph
Date: Fri,  8 Feb 2013 17:24:57 +0100
Message-ID: <1360340703-7170-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:39577 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1946705Ab3BHQZG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Feb 2013 11:25:06 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>

Here some patches to fix memory leaks in Ceph found by cppcheck.

Danny Al-Gaaf (6):
  common/fiemap.cc: fix realloc memory leak
  os/FileStore.cc: fix realloc memory leak in error case
  rgw/rgw_xml.cc: fix realloc memory leak in error case
  wireshark: fix some memory leaks
  SyntheticClient.cc: fix some memory leaks in the error handling
  rgw/rgw_rest.cc: fix 4K memory leak

 src/client/SyntheticClient.cc | 15 ++++++++++++---
 src/common/fiemap.cc          |  9 ++++++---
 src/os/FileStore.cc           |  7 +++++--
 src/rgw/rgw_rest.cc           |  4 +++-
 src/rgw/rgw_xml.cc            | 11 +++++++++--
 wireshark/ceph/packet-ceph.c  | 19 ++++++++++++++-----
 6 files changed, 49 insertions(+), 16 deletions(-)

-- 
1.8.1.2

