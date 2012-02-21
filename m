From: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
Subject: [PATCH] Fix ceph-mds --journal-reset
Date: Tue, 21 Feb 2012 07:10:22 -0200
Message-ID: <oripj01ri9.fsf@livre.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lsd-gw.ic.unicamp.br ([143.106.7.165]:40547 "EHLO
	boneca.lsd.ic.unicamp.br" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755655Ab2BVWHX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Wed, 22 Feb 2012 17:07:23 -0500
Received: from freie.oliva.athome.lsd.ic.unicamp.br (gw-to-emilia.oliva.athome.lsd.ic.unicamp.br [172.31.160.17] (may be forged))
	by boneca.lsd.ic.unicamp.br (8.14.5/8.14.5) with ESMTP id q1MM7Hr2002460
	for <ceph-devel@vger.kernel.org>; Wed, 22 Feb 2012 20:07:20 -0200
Received: from livre.localdomain (livre-to-gw.oliva.athome.lsd.ic.unicamp.br [172.31.160.19])
	by freie.oliva.athome.lsd.ic.unicamp.br (8.14.5/8.14.5) with ESMTP id q1L9ANwp018000
	for <ceph-devel@vger.kernel.org>; Tue, 21 Feb 2012 07:10:23 -0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Complete configuration initialization for special actions, and
hold Resetter lock while running reset.

Signed-off-by: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
---
 src/ceph_mds.cc     |    1 +
 src/mds/Resetter.cc |    2 ++
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/src/ceph_mds.cc b/src/ceph_mds.cc
index acd88d2..23fafaf 100644
--- a/src/ceph_mds.cc
+++ b/src/ceph_mds.cc
@@ -65,6 +65,7 @@ void usage()
 static int do_cmds_special_action(const std::string &action,
 				  const std::string &dump_file, int rank)
 {
+  common_init_finish(g_ceph_context);
   SimpleMessenger *messenger = new SimpleMessenger(g_ceph_context);
   int r = messenger->bind(g_conf->public_addr, getpid());
   if (r < 0)
diff --git a/src/mds/Resetter.cc b/src/mds/Resetter.cc
index a10845c..f759881 100644
--- a/src/mds/Resetter.cc
+++ b/src/mds/Resetter.cc
@@ -83,6 +83,7 @@ void Resetter::reset()
   bool done;
   int r;
 
+  this->lock.Lock();
   lock.Lock();
   journaler->recover(new C_SafeCond(&lock, &cond, &done, &r));
   while (!done)
@@ -142,5 +143,6 @@ void Resetter::reset()
 
   cout << "done" << std::endl;
 
+  this->lock.Unlock();
   shutdown();
 }
-- 
1.7.7.6

-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist      Red Hat Brazil Compiler Engineer
