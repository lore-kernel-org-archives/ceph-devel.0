From: "Jim Schutt" <jaschut@sandia.gov>
Subject: [PATCH] FileJournal: correctly check return value of lseek in
 write_fd
Date: Thu, 27 Sep 2012 12:06:29 -0600
Message-ID: <1348769189-140200-1-git-send-email-jaschut@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:37571 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752220Ab2I0SHI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Sep 2012 14:07:08 -0400
Received: from interceptor1.sandia.gov (interceptor1.sandia.gov [132.175.109.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by sentry-two.sandia.gov (Postfix) with ESMTP id 15908D2C695
	for <ceph-devel@vger.kernel.org>; Thu, 27 Sep 2012 12:07:00 -0600 (MDT)
Received: from sentry.sandia.gov (mm04snlnto.sandia.gov [132.175.109.21]) by interceptor1.sandia.gov (RSA Interceptor) for <ceph-devel@vger.kernel.org>; Thu, 27 Sep 2012 12:06:54 -0600
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Jim Schutt <jaschut@sandia.gov>


Signed-off-by: Jim Schutt <jaschut@sandia.gov>
---
 src/os/FileJournal.cc |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/os/FileJournal.cc b/src/os/FileJournal.cc
index d1c92dc..2254720 100644
--- a/src/os/FileJournal.cc
+++ b/src/os/FileJournal.cc
@@ -945,9 +945,10 @@ void FileJournal::align_bl(off64_t pos, bufferlist& bl)
 int FileJournal::write_bl(off64_t& pos, bufferlist& bl)
 {
   align_bl(pos, bl);
+  int ret;
 
-  int ret = ::lseek64(fd, pos, SEEK_SET);
-  if (ret) {
+  off64_t spos = ::lseek64(fd, pos, SEEK_SET);
+  if (spos < 0) {
     ret = -errno;
     derr << "FileJournal::write_bl : lseek64 failed " << cpp_strerror(ret) << dendl;
     return ret;
-- 
1.7.8.2


