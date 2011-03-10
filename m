From: Henry Chang <henry.cy.chang@gmail.com>
Subject: Another question about PG::do_peer
Date: Thu, 10 Mar 2011 18:18:58 +0800
Message-ID: <AANLkTikWHRrOJom30_CFi2jqdZ3YP41AZqCE4_nM4Jk_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:55812 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751285Ab1CJKS7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Mar 2011 05:18:59 -0500
Received: by ywj3 with SMTP id 3so583041ywj.19
        for <ceph-devel@vger.kernel.org>; Thu, 10 Mar 2011 02:18:58 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

Another question is about PG::do_peer. I wonder if we should modify
the condition of inferring no missing as follows:

diff --git a/src/osd/PG.cc b/src/osd/PG.cc
index e634296..4ce3336 100644
--- a/src/osd/PG.cc
+++ b/src/osd/PG.cc
@@ -1632,7 +1632,7 @@ void PG::do_peer(ObjectStore::Transaction& t,
list<Context*>& tfin,
     if (pi.is_empty())
       continue;
     if (peer_missing.find(peer) == peer_missing.end()) {
-      if (pi.last_update == pi.last_complete) {
+      if (pi.last_update == pi.last_complete && pi.last_update >= log.tail) {
        dout(10) << " infering no missing (last_update==last_complete)
for osd" << peer << dendl;
        peer_missing[peer].num_missing();  // just create the entry.
        search_for_missing(peer_info[peer], &peer_missing[peer], peer);

If pi.last_update < log.tail, we cannot know if the peer has any
missing. Shouldn't we try to pull the peer's missing+backlog first
before inferring no missing and go ahead activating the pg?
Sorry for separating my questions into multiple emails.
-- 
Henry Chang
