From: Sage Weil <sage@inktank.com>
Subject: rados io hints session
Date: Thu, 30 Oct 2014 13:53:41 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1410301345180.16204@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47915 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161189AbaJ3Uxm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Oct 2014 16:53:42 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id A13BC80068
	for <ceph-devel@vger.kernel.org>; Thu, 30 Oct 2014 13:53:41 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 68F7C80068
	for <ceph-devel@vger.kernel.org>; Thu, 30 Oct 2014 13:53:41 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I added these tickets:

9957 librados: add fadvise op
9958 osd: objectstore: add fadvise op
9959 osd: pass client fadvise hints through to objecstore
9960 osd: adjust hint(s) for replica vs primary writes 

I think there are still some open issues, though.  For example, let's 
say the client hints WILLNEED on a replicated pool.  Do we put that in 
the Transaction we apply to the *replicas* too, where we probably 
want to do DONTNEED (regardless of what the client says)?

Does having slightly different transactions for primary vs replica 
make Transaction encoding problematic?  -> Perhaps we put the hint ops in 
the local_t...

Other items:

9956 osd: reenable alloc hints if kernel is known to be safe

We need to get to the bottom of the fadvise vs sync_file_range thing.

sage
