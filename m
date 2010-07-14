From: Christian Brunner <chb@muc.de>
Subject: [PATCH] lower loglevel for successfull mon hunting
Date: Wed, 14 Jul 2010 15:43:38 +0200
Message-ID: <20100714134338.GA22287@bambus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:48367 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752681Ab0GNNnp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Jul 2010 09:43:45 -0400
Received: by bwz1 with SMTP id 1so931243bwz.19
        for <ceph-devel@vger.kernel.org>; Wed, 14 Jul 2010 06:43:43 -0700 (PDT)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I'm receving log output on every rados_initialize (... found mon0). 
Since this makes the qemu-iotests fail, I'd suggest to lower the loglevel.

Christian

---
 src/mon/MonClient.cc |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/mon/MonClient.cc b/src/mon/MonClient.cc
index b5192b2..b405ec6 100644
--- a/src/mon/MonClient.cc
+++ b/src/mon/MonClient.cc
@@ -429,7 +429,7 @@ bool MonClient::ms_handle_reset(Connection *con)
 void MonClient::_finish_hunting()
 {
   if (hunting) {
-    dout(0) << "found mon" << cur_mon << dendl; 
+    dout(5) << "found mon" << cur_mon << dendl; 
     hunting = false;
   }
 }
-- 
1.6.5.2

