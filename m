From: Li Wang <liwang@ubuntukylin.com>
Subject: [PATCH 0/2] Fix resource leak
Date: Mon, 18 Nov 2013 15:40:17 +0800
Message-ID: <cover.1384760071.git.liwang@ubuntukylin.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m53-178.qiye.163.com ([123.58.178.53]:40023 "EHLO
	m53-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051Ab3KRHkl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Nov 2013 02:40:41 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, Li Wang <liwang@ubuntukylin.com>

Fix two coverity issues.

Li Wang (2):
  rbd: Release resource before return
  mds: Release resource before return

 src/mds/MDCache.cc |    2 +-
 src/rbd.cc         |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
1.7.9.5

