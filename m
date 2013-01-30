From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 0/6] fix build (ceph.spec)
Date: Wed, 30 Jan 2013 19:00:39 +0100
Message-ID: <1359568845-7634-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:51037 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756484Ab3A3SAs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Wed, 30 Jan 2013 13:00:48 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>

This set fixes some issues in the spec file. 

I'm not sure what the reason for #35e5d74e5c5786bc91df5dc10b5c08c77305df4e
was. But I would revert it and fix the underlaying issues instead. Patch #2 
adds rbd-fuse to the file list and should fix build again. At least it
works for us at SUSE/RHEL/CentOS in the openSUSE build service.

Danny Al-Gaaf (6):
  Revert "Don't install rbd-fuse binary"
  ceph.spec.in: add rbd-fuse
  ceph.spec.in: move libcephfs_jni.so to ceph-devel
  ceph.spec.in: don't move libcephfs_jni files around
  ceph.spec.in: extend fix for libedit-devel on special SUSE versions
  ceph.spec.in: fix file section for ceph-resource-agents

 ceph.spec.in    | 13 ++++++++-----
 src/Makefile.am |  4 +---
 2 files changed, 9 insertions(+), 8 deletions(-)

-- 
1.8.1.1

