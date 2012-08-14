From: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
Subject: Search for srcdir/.git in check_version
Date: Tue, 14 Aug 2012 00:59:42 -0300
Message-ID: <orboieypq9.fsf@livre.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lsd-gw.ic.unicamp.br ([143.106.7.165]:36868 "EHLO
	boneca.lsd.ic.unicamp.br" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751783Ab2HNGmB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Tue, 14 Aug 2012 02:42:01 -0400
Received: from freie (gw-to-emilia.oliva.athome.lsd.ic.unicamp.br [172.31.160.17] (may be forged))
	by boneca.lsd.ic.unicamp.br (8.14.5/8.14.5) with ESMTP id q7E63ieu016733
	for <ceph-devel@vger.kernel.org>; Tue, 14 Aug 2012 03:03:45 -0300
Received: from livre.localdomain (livre-to-gw.oliva.athome.lsd.ic.unicamp.br [172.31.160.19])
	by freie (8.14.5/8.14.5) with ESMTP id q7E63hWO012766
	for <ceph-devel@vger.kernel.org>; Tue, 14 Aug 2012 03:03:44 -0300
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Support srcdir != . looking for .git in srcdir when computing the ceph
release and git tag.

Signed-off-by: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
---
 src/check_version |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/src/check_version b/src/check_version
index e31ca49..8600c55 100755
--- a/src/check_version
+++ b/src/check_version
@@ -1,12 +1,13 @@
 #!/bin/sh
 
-if [ ! -d ../.git ]; then
-    echo "not updating .git_version (no ../.git)"
+dname=`dirname $0`
+
+if [ ! -d $dname/../.git ]; then
+    echo "not updating .git_version (no $dname/../.git)"
     exit 0
 fi
 
-dname=`dirname $0`
-cur=`git rev-parse HEAD 2>/dev/null; git describe 2>/dev/null`
+cur=`cd $dname && git rev-parse HEAD 2>/dev/null; git describe 2>/dev/null`
 [ -e $1 ] && old=`cat $1`
 
 if [ "$cur" != "$old" ]; then
-- 
1.7.7.6

-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist      Red Hat Brazil Compiler Engineer
