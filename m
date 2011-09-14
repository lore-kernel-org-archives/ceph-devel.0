From: "Jim Schutt" <jaschut@sandia.gov>
Subject: [PATCH] ceph_common.sh: Do not sudo to root unless needed
Date: Wed, 14 Sep 2011 09:09:37 -0600
Message-ID: <1316012977-13675-1-git-send-email-jaschut@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:53350 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751710Ab1INPJ6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Sep 2011 11:09:58 -0400
Received: from interceptor1.sandia.gov (interceptor1.sandia.gov [132.175.109.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by sentry-two.sandia.gov (Postfix) with ESMTP id 19DC6268AEB
	for <ceph-devel@vger.kernel.org>; Wed, 14 Sep 2011 09:09:55 -0600 (MDT)
Received: from sentry.sandia.gov (mm03snlnto.sandia.gov [132.175.109.20]) by interceptor1.sandia.gov (RSA Interceptor) for <ceph-devel@vger.kernel.org>; Wed, 14 Sep 2011 09:09:47 -0600
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Jim Schutt <jaschut@sandia.gov>

Using do_root_cmd() doesn't really need to sudo to root
if you're already root.

Commit 71dc75bdafe62a098c0493ad62f2d0d2a6ca7946 causes a regression:
when system "foo" has a sudoers config that requires a tty,
init-ceph now fails like this:
  sudo: sorry, you must have a tty to run sudo

when it is invoked by root with something like this:
   ssh foo /etc/init.d/init-ceph start

Signed-off-by: Jim Schutt <jaschut@sandia.gov>
---
 src/ceph_common.sh |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/src/ceph_common.sh b/src/ceph_common.sh
index adb8783..1da42bd 100644
--- a/src/ceph_common.sh
+++ b/src/ceph_common.sh
@@ -97,7 +97,12 @@ do_root_cmd() {
     if [ -z "$ssh" ]; then
 	[ $verbose -eq 1 ] && echo "--- $host# $1"
 	ulimit -c unlimited
-	sudo bash -c "$1" || { echo "failed: '$1'" ; exit 1; }
+	whoami=`whoami`
+	if [ "$whoami" = "root" ]; then
+	    bash -c "$1" || { echo "failed: '$1'" ; exit 1; }
+	else
+	    sudo bash -c "$1" || { echo "failed: '$1'" ; exit 1; }
+	fi
     else
 	[ $verbose -eq 1 ] && echo "--- $rootssh $2 \"cd $sshdir ; ulimit -c unlimited ; $1\""
 	$rootssh $2 "cd $sshdir ; ulimit -c unlimited ; $1" || { echo "failed: '$rootssh $1'" ; exit 1; }
-- 
1.7.1


