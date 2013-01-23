From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 0/2] Fix some autoconf issues
Date: Wed, 23 Jan 2013 18:57:45 +0100
Message-ID: <1358963867-30235-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:45262 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755405Ab3AWR5v (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Wed, 23 Jan 2013 12:57:51 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>

These patches contains some autoconf fixes/cleanups.

Danny Al-Gaaf (2):
  configure: fix RPM_RELEASE
  configure: remove -m4_include(m4/acx_pthread.m4)

 configure.ac | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

-- 
1.8.1.1

