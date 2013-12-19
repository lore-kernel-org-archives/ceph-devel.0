From: Alexandre Oliva <oliva@gnu.org>
Subject: mds: fix Resetter locking
Date: Thu, 19 Dec 2013 05:21:55 -0200
Message-ID: <ord2kt71bg.fsf@livre.home>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from linux-libre.fsfla.org ([208.118.235.54]:51340 "EHLO
	linux-libre.fsfla.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750964Ab3LSHW0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Dec 2013 02:22:26 -0500
Received: from freie.home (home.lxoliva.fsfla.org [172.31.160.22])
	by linux-libre.fsfla.org (8.14.4/8.14.4/Debian-2ubuntu2) with ESMTP id rBJ7MLki029701
	for <ceph-devel@vger.kernel.org>; Thu, 19 Dec 2013 07:22:22 GMT
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

--=-=-=

For some weird reason I couldn't figure out, after I simultaneously
brought down all components of my ceph cluster and then brought them
back up, the mds wouldn't come back, complaining about a zero-sized
entry in its journal some 8+MB behind the end of the journal.  I hadn't
ever got this problem, and it's not entirely unusual for me to restart
all cluster components at once after some configuration change.

Anyway...  Long story short, after some poking at the mds journal to see
if I could figure out how to get it back up, I gave up and decided to
use the --reset-journal hammer.  Except that it just sat there, never
completing or even getting noticed by the cluster.  After a bit of
additional investigation, the following patch was born, and now my
Emperor cluster is back up.  Phew! :-)


--=-=-=
Content-Type: text/x-diff
Content-Disposition: inline; filename=mds-reset-journal-fix-locking.patch

mds: fix Resetter locking

From: Alexandre Oliva <oliva@gnu.org>

ceph-mds --reset-journal didn't work; it would deadlock waiting for
the osdmap.  Comparing the init code in the Dumper (that worked) with
that in the Resetter (that didn't), I noticed the lock had to be
released before waiting for the osdmap.

Now the resetter works.  However, both the resetter and the dumper
fail an assertion after they've performed their task; I didn't look
into it:

../../src/msg/SimpleMessenger.cc: In function 'void SimpleMessenger::reaper()' t
hread 7fdc188d27c0 time 2013-12-19 04:48:16.930895
../../src/msg/SimpleMessenger.cc: 230: FAILED assert(!cleared)
 ceph version 0.72.1-6-g6bca44e (6bca44ec129d11f1c4f38357db8ae435616f2c7c)
 1: (SimpleMessenger::reaper()+0x706) [0x880da6]
 2: (SimpleMessenger::wait()+0x36f) [0x88180f]
 3: (Resetter::reset()+0x714) [0x56e664]
 4: (main()+0x1359) [0x562769]
 5: (__libc_start_main()+0xf5) [0x3632e21b45]
 6: /l/tmp/build/ceph/build/src/ceph-mds() [0x564e49]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to int
erpret this.   
2013-12-19 04:48:16.934093 7fdc188d27c0 -1 ../../src/msg/SimpleMessenger.cc: In 
function 'void SimpleMessenger::reaper()' thread 7fdc188d27c0 time 2013-12-19 04
:48:16.930895  
../../src/msg/SimpleMessenger.cc: 230: FAILED assert(!cleared)

Signed-off-by: Alexandre Oliva <oliva@gnu.org>
---
 src/mds/Resetter.cc |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/mds/Resetter.cc b/src/mds/Resetter.cc
index e968cdc..ed409a4 100644
--- a/src/mds/Resetter.cc
+++ b/src/mds/Resetter.cc
@@ -79,9 +79,9 @@ void Resetter::init(int rank)
   objecter->init_unlocked();
   lock.Lock();
   objecter->init_locked();
+  lock.Unlock();
   objecter->wait_for_osd_map();
   timer.init();
-  lock.Unlock();
 }
 
 void Resetter::shutdown()

--=-=-=


-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist      Red Hat Brazil Compiler Engineer

--=-=-=--
