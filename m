From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 0/6] fix build and packaging issues
Date: Fri,  4 Jan 2013 18:51:25 +0100
Message-ID: <1357321891-20202-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:54168 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754534Ab3ADRvf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Jan 2013 12:51:35 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>

This set of patches contains fixes for some build and packaging issues.

Danny Al-Gaaf (6):
  src/java/Makefile.am: fix default java dir
  ceph.spec.in: fix handling of java files
  ceph.spec.in: rename libcephfs-java package to cephfs-java
  ceph.spec.in: fix libcephfs-jni package name
  configure.ac: remove AC_PROG_RANLIB
  configure.ac: change junit4 handling

 ceph.spec.in         | 21 +++++++++------------
 configure.ac         |  8 +++++---
 src/java/Makefile.am |  6 +++---
 3 files changed, 17 insertions(+), 18 deletions(-)

-- 
1.8.0.2

