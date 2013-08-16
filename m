From: Sage Weil <sage@inktank.com>
Subject: ceph-deploy mon pitfall..
Date: Fri, 16 Aug 2013 09:47:42 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1308160927320.27695@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46419 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754022Ab3HPQrn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Aug 2013 12:47:43 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: alfredo.deza@inktank.com
Cc: ceph-devel@vger.kernel.org

A user complaining with the usual 'gatherkeys fails' showed up on IRC the 
other night and I finally tracked it down to a stray keyring file in 
/etc/ceph that was present prior to mon create.  Because the keyring file 
was there, ceph-create-keys skips creating a new keyring.  And then it 
can't do the next step because the keyring is wrong.

I suspect the fix here is to make mon create complain and fail if there is 
a keyring already present in /etc/ceph?  Maybe with a force flag?

The sequences we should consider:

- fresh install, creating initial monitors (no conf or keyring should be 
there)

- adding a new mon to an existing cluster.  conf might be there, keyring 
usually won't.  but it could be, if they did the 'ceph admin HOST' or 
whatever it is to push out the keyring and config on that host at some 
point previously.

Probably a check and force option similar to the config will do the trick?

sage
