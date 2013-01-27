From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 0/2] fix some compiler warnings
Date: Sun, 27 Jan 2013 21:57:30 +0100
Message-ID: <1359320252-2445-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:60523 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756118Ab3A0U5h (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Sun, 27 Jan 2013 15:57:37 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>

Attached two patches to fix some compiler warnings.

Danny Al-Gaaf (2):
  utime: fix narrowing conversion compiler warning in sleep()
  rbd: don't ignore return value of system()

 src/include/utime.h |  2 +-
 src/rbd.cc          | 36 ++++++++++++++++++++++++++++++------
 2 files changed, 31 insertions(+), 7 deletions(-)

-- 
1.8.1.1

