From: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
Subject: [PATCH] Relax journal trim_finish assertion to pass when (to == trimmed_pos).
Date: Tue, 12 Apr 2011 12:21:08 -0300
Message-ID: <or62qjxzq3.fsf@livre.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lsd-gw.ic.unicamp.br ([143.106.7.165]:55050 "EHLO
	boneca.lsd.ic.unicamp.br" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756321Ab1DLPVN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Tue, 12 Apr 2011 11:21:13 -0400
Received: from freie.oliva.athome.lsd.ic.unicamp.br (gw-to-emilia.oliva.athome.lsd.ic.unicamp.br [172.31.160.17] (may be forged))
	by boneca.lsd.ic.unicamp.br (8.14.4/8.14.4) with ESMTP id p3CFLAGq020283
	for <ceph-devel@vger.kernel.org>; Tue, 12 Apr 2011 12:21:11 -0300
Received: from livre.localdomain (livre-to-gw.oliva.athome.lsd.ic.unicamp.br [172.31.160.19])
	by freie.oliva.athome.lsd.ic.unicamp.br (8.14.4/8.14.4) with ESMTP id p3CFLAWK024262
	for <ceph-devel@vger.kernel.org>; Tue, 12 Apr 2011 12:21:10 -0300
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I'm getting relatively frequent MDS crashes.  I believe this happens as
a replay-standby node is about to take over once the MDS it follows is
restarted, most often because it stopped making progress for a long
time.  In the core files I checked, waitfor_trim was empty, so this
shouldn't have ill effects.  Since I'm not sure how to trigger this
particular assertion failure, I can't say that I've tested this patch
thoroughly, but unless the purpose of the assertion is to catch the ==
case, I think it's safe to put it in.

---
Relax journal trim_finish assertion to pass when (to == trimmed_pos).

Signed-off-by: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
---
 src/osdc/Journaler.cc |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/osdc/Journaler.cc b/src/osdc/Journaler.cc
index f3241c4..4f4811c 100644
--- a/src/osdc/Journaler.cc
+++ b/src/osdc/Journaler.cc
@@ -960,7 +960,7 @@ void Journaler::_trim_finish(int r, uint64_t to)
   assert(r >= 0);
   
   assert(to <= trimming_pos);
-  assert(to > trimmed_pos);
+  assert(to >= trimmed_pos);
   trimmed_pos = to;
 
   // finishers?
-- 
1.7.4.2

-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist      Red Hat Brazil Compiler Engineer
