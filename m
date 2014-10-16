From: Sage Weil <sage@newdream.net>
Subject: delete your branches after merge
Date: Thu, 16 Oct 2014 13:00:42 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1410161258390.5521@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54273 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751472AbaJPUAm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Oct 2014 16:00:42 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id A2A7E800BB
	for <ceph-devel@vger.kernel.org>; Thu, 16 Oct 2014 13:00:42 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 7C282800BB
	for <ceph-devel@vger.kernel.org>; Thu, 16 Oct 2014 13:00:42 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Please try to click the 'delete branch' button after you merge pull 
requests on github.  It helps keep the number of branches in the main 
ceph.git slightly less crazy and reduces clutter.

(Note that the button only appears if the source branch is also ceph.git; 
for merges from other users' repos it's up to them to tidy up.)

Thanks!
sage
