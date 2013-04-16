From: Sage Weil <sage@inktank.com>
Subject: other rbd stuff
Date: Tue, 16 Apr 2013 15:02:10 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1304161446540.5978@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52776 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965255Ab3DPWCL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Apr 2013 18:02:11 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: josh.durgin@inktank.com
Cc: ceph-devel@vger.kernel.org

- wip-4531 looks good.  should i merge it?

- figured out the DiffIterate failures (rbd caching), see wip-4683.  
flushing from diff_iterate should be fine right?

- the qemu-iotests are failing because of the rbd progress on stderr.  
sent a patch to qemu list with a 2>/dev/null.  note that qemu-iotests is 
not part of qemu.git, so our test script should clone from there instead.  
or we can make our own copy of the old standalone repo and host it 
ourselves...

sage
