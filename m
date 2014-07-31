From: Alexandre Oliva <oliva@gnu.org>
Subject: [PATCH] init: exec daemons or wrappers after setting up environment
Date: Wed, 30 Jul 2014 23:09:42 -0300
Message-ID: <orzjfqth21.fsf@free.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from linux-libre.fsfla.org ([208.118.235.54]:58492 "EHLO
	linux-libre.fsfla.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028AbaGaCNT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Jul 2014 22:13:19 -0400
Received: from freie.home (home.lxoliva.fsfla.org [172.31.160.22])
	by linux-libre.fsfla.org (8.14.4/8.14.4/Debian-2ubuntu2.1) with ESMTP id s6V29pnM020431
	for <ceph-devel@vger.kernel.org>; Thu, 31 Jul 2014 02:09:53 GMT
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Since with systemd we want to start daemons in foreground, adding an
exec before the daemon (or wrapper) name saves us a running shell just
waiting for the daemon to complete.  There's no reason to not do so
even when not using systemd, so, done...

Signed-off-by: Alexandre Oliva <oliva@gnu.org>
---
 src/init-ceph.in |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/init-ceph.in b/src/init-ceph.in
index 95723b0..cc3c3c7 100644
--- a/src/init-ceph.in
+++ b/src/init-ceph.in
@@ -277,9 +277,9 @@ for name in $what; do
 	    [ -n "$max_open_files" ] && files="ulimit -n $max_open_files;"
 
 	    if [ $SYSTEMD -eq 1 ]; then
-		cmd="systemd-run -r bash -c '$files $cmd --cluster $cluster -f'"
+		cmd="systemd-run -r bash -c '$files exec $cmd --cluster $cluster -f'"
 	    else
-		cmd="$files $wrap $cmd --cluster $cluster $runmode"
+		cmd="$files exec $wrap $cmd --cluster $cluster $runmode"
 	    fi
 
 	    if [ $dofsmount -eq 1 ] && [ -n "$fs_devs" ]; then

-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist|Red Hat Brasil GNU Toolchain Engineer
