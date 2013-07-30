From: Sage Weil <sage@inktank.com>
Subject: blueprint: cache pool overlay
Date: Tue, 30 Jul 2013 09:16:01 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1307300911380.12830@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36652 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751633Ab3G3QQC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Jul 2013 12:16:02 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id EA33380049
	for <ceph-devel@vger.kernel.org>; Tue, 30 Jul 2013 09:16:01 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id C909680049
	for <ceph-devel@vger.kernel.org>; Tue, 30 Jul 2013 09:16:01 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I posted a blueprint with an alternative approach to tiered storage than 
the redirects I mentioned yesterday.  Instead of demoting data out of an 
existing pool to a colder pool, we could put a faster pool logically in 
front of an existing pool as a cache.  Think SSD or fusionio or similar.  
I think it is logically simpler, but address slightly different use 
cases--it helps with hot data, but doesn't really address archival of cold 
data (e.g., to an erasure coded pool).

http://wiki.ceph.com/01Planning/02Blueprints/Emperor/osd%3A_cache_pool_overlay

We should discuss this in the same session with the redirects blueprint 
and the blueprint on temperature tracking (which I'm not seeing listed; 
maybe Sam hasn't posted it yet).
