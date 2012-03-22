From: Sage Weil <sage@newdream.net>
Subject: osd heartbeat
Date: Thu, 22 Mar 2012 09:12:45 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1203220907580.28079@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39531 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755914Ab2CVQM7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Mar 2012 12:12:59 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 06E96BC7F7
	for <ceph-devel@vger.kernel.org>; Thu, 22 Mar 2012 09:12:46 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id D5A87BC7F7
	for <ceph-devel@vger.kernel.org>; Thu, 22 Mar 2012 09:12:45 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I pushed a wip-osd-hb branch that vastly simplifies the OSD heartbeats.  
The problem was that ages ago I went for a model with asymmetric 
heartbeats (at the time, replicas -> primaries) because it was elegant and 
seemed more efficient.  The reality was that the asynchrony between osdmap 
versions on different modes made this a huge pain to make reobust, 
particularly when it came to managing the persistence of sessions between 
nodes that are going up/down.

The new branch throws that all out and uses a simple ping/reply model.  
The retry behavior is simple, robust, and all the failure issues go away.  
The downside is that there are more messages moving around... but, they 
are tiny, so who cares...

This should address the problems Wido was seeing in #2116.

sage
