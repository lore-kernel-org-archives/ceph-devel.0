From: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
Subject: Fix local messages and lost wake-up in SimpleMessenger
Date: Tue, 14 Aug 2012 01:55:11 -0300
Message-ID: <or7gt2ypox.fsf@livre.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lsd-gw.ic.unicamp.br ([143.106.7.165]:36868 "EHLO
	boneca.lsd.ic.unicamp.br" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751783Ab2HNGmE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Tue, 14 Aug 2012 02:42:04 -0400
Received: from freie (gw-to-emilia.oliva.athome.lsd.ic.unicamp.br [172.31.160.17] (may be forged))
	by boneca.lsd.ic.unicamp.br (8.14.5/8.14.5) with ESMTP id q7E64WqJ016834
	for <ceph-devel@vger.kernel.org>; Tue, 14 Aug 2012 03:04:32 -0300
Received: from livre.localdomain (livre-to-gw.oliva.athome.lsd.ic.unicamp.br [172.31.160.19])
	by freie (8.14.5/8.14.5) with ESMTP id q7E64VGn012815
	for <ceph-devel@vger.kernel.org>; Tue, 14 Aug 2012 03:04:31 -0300
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Don't wait for a signal if the dispatch queue is non-empty already,
and support a non-NULL pipe for local responses.  If we were to
require pipe to be NULL for that, the response would be lost.

Signed-off-by: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
---
 src/msg/SimpleMessenger.cc |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/msg/SimpleMessenger.cc b/src/msg/SimpleMessenger.cc
index 53e36cd..973219f 100644
--- a/src/msg/SimpleMessenger.cc
+++ b/src/msg/SimpleMessenger.cc
@@ -373,7 +373,7 @@ void SimpleMessenger::DispatchQueue::entry()
       }
       lock.Lock();
     }
-    if (!stop)
+    if (queued_pipes.empty() && !stop)
       cond.Wait(lock); //wait for something to be put on queue
   }
   lock.Unlock();
@@ -2477,7 +2477,7 @@ void SimpleMessenger::submit_message(Message *m, Connection *con, const entity_a
   }
 
   // local?
-  if (!pipe && my_inst.addr == dest_addr) {
+  if (my_inst.addr == dest_addr) {
     if (!destination_stopped) {
       // local
       ldout(cct,20) << "submit_message " << *m << " local" << dendl;
-- 
1.7.7.6

-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist      Red Hat Brazil Compiler Engineer
