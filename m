From: Sage Weil <sage@newdream.net>
Subject: Re: MDS crashing
Date: Fri, 10 Sep 2010 10:28:29 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1009090955470.19781@cobra.newdream.net>
References: <AANLkTinOE+zRi_UHq33xPkADp-xavEbxgiW+ezUhVciT@mail.gmail.com>
 <Pine.LNX.4.64.1009081019460.28511@cobra.newdream.net>
 <AANLkTi=1C07ETO72hcW-9F0j5Enzgxdtfv4hVfr+PrNL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56488 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754116Ab0IJR1J (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Sep 2010 13:27:09 -0400
In-Reply-To: <AANLkTi=1C07ETO72hcW-9F0j5Enzgxdtfv4hVfr+PrNL@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nat N <phenisha@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi Nat,

Can you try the below patch?  It looks like the journal replay isn't 
handling the 'session close' event in the journal properly because the 
client has already reconnected to the MDS.  (If so, shutting down the 
client would also allow the MDS to restart by avoiding the bug.)

Please let me know if this does the trick!

Thanks-
sage



diff --git a/src/mds/journal.cc b/src/mds/journal.cc
index ec2013d..64fc6a3 100644
--- a/src/mds/journal.cc
+++ b/src/mds/journal.cc
@@ -725,6 +725,8 @@ void ESession::replay(MDS *mds)
       Session *session = mds->sessionmap.get_session(client_inst.name);
       if (session->is_closed())
        mds->sessionmap.remove_session(session);
+      else
+       session->clear();    // the client has reconnected; keep the Session, but reset
     }
   }
 

