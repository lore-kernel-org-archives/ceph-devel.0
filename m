From: Li Wang <liwang@ubuntukylin.com>
Subject: [PATCH] Ceph-qa: change the fsx.sh to support hole punching test
Date: Sun, 21 Jul 2013 23:45:08 +0800
Message-ID: <1374421509-3988-1-git-send-email-liwang@ubuntukylin.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m59-178.qiye.163.com ([123.58.178.59]:48089 "EHLO
	m59-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755756Ab3GUPpQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 21 Jul 2013 11:45:16 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, Li Wang <liwang@ubuntukylin.com>, Yunchuan Wen <yunchuanwen@ubuntukylin.com>

This patch change the fsx.sh to pull better fsx.c from xfstests site
to support hole punching test.

Signed-off-by: Yunchuan Wen <yunchuanwen@ubuntukylin.com>
Signed-off-by: Li Wang <liwang@ubuntukylin.com>
---
 qa/workunits/suites/fsx.sh |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/qa/workunits/suites/fsx.sh b/qa/workunits/suites/fsx.sh
index 32d5b63..c48164c 100755
--- a/qa/workunits/suites/fsx.sh
+++ b/qa/workunits/suites/fsx.sh
@@ -2,8 +2,10 @@
 
 set -e
 
-wget http://ceph.com/qa/fsx.c
-gcc fsx.c -o fsx
+apt-get install git libacl1-dev xfslibs-dev libattr1-dev -y
+git clone git://ceph.newdream.net/git/xfstests.git
+make -C xfstests
+cp xfstests/ltp/fsx .
 
 ./fsx   1MB -N 50000 -p 10000 -l 1048576
 ./fsx  10MB -N 50000 -p 10000 -l 10485760
-- 
1.7.9.5

