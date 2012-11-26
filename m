From: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
Subject: two trivial patches for the upcoming stable release
Date: Mon, 26 Nov 2012 18:26:02 -0200
Message-ID: <ord2z06rhh.fsf@livre.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lsd-gw.ic.unicamp.br ([143.106.7.165]:33409 "EHLO
	boneca.lsd.ic.unicamp.br" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756481Ab2KZUkW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Mon, 26 Nov 2012 15:40:22 -0500
Received: from freie (gw-to-emilia.oliva.athome.lsd.ic.unicamp.br [172.31.160.17] (may be forged))
	by boneca.lsd.ic.unicamp.br (8.14.5/8.14.5) with ESMTP id qAQKQCQu027470
	for <ceph-devel@vger.kernel.org>; Mon, 26 Nov 2012 18:26:12 -0200
Received: from livre.localdomain (livre-to-gw.oliva.athome.lsd.ic.unicamp.br [172.31.160.19])
	by freie (8.14.5/8.14.5) with ESMTP id qAQKQBRq010019
	for <ceph-devel@vger.kernel.org>; Mon, 26 Nov 2012 18:26:11 -0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

--=-=-=

The first one was posted before, to enable out-of-tree builds; it was
acked but apparently it fell through the cracks.

The second fixes a regression in log rotation on systems that don't use
invoke-rc.d.  The which command doesn't output anything to stdout when
it fails to find the requested command, and for some reason [ -x ]
passes, so we end up trying to run the non-existing invoke-rc.d instead
of falling back to other alternatives as intended.


--=-=-=
Content-Type: text/x-diff
Content-Disposition: inline;
 filename=search-for-srcdir-.git-in-check_version.patch

Search for srcdir/.git in check_version

From: Alexandre Oliva <oliva@lsd.ic.unicamp.br>

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

--=-=-=
Content-Type: text/x-diff
Content-Disposition: inline; filename=conf-logrotate-which.patch

logrotate on systems without invoke-rc.d

From: Alexandre Oliva <oliva@lsd.ic.unicamp.br>

The which command doesn't output anything to stdout when it can't find
the given program name, and then [ -x ] passes.  Use the exit status
of which to tell whether the command exists, before testing whether
it's executable, to fix it.

Signed-off-by: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
---

 src/logrotate.conf |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)


diff --git a/src/logrotate.conf b/src/logrotate.conf
index aef3572..97d4fcd 100644
--- a/src/logrotate.conf
+++ b/src/logrotate.conf
@@ -4,11 +4,11 @@
     compress
     sharedscripts
     postrotate
-        if [ -x `which invoke-rc.d` ]; then
+        if which invoke-rc.d && [ -x `which invoke-rc.d` ]; then
             invoke-rc.d ceph reload >/dev/null
-        elif [ -x `which service` ]; then
+        elif which service && [ -x `which service` ]; then
             service ceph reload >/dev/null
-        elif [ -x `which initctl` ]; then
+        elif which initctl && [ -x `which initctl` ]; then
             # upstart reload isn't very helpful here:
             #   https://bugs.launchpad.net/upstart/+bug/1012938
             for type in mon osd mds; do

--=-=-=



-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist      Red Hat Brazil Compiler Engineer

--=-=-=--
