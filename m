From: Sage Weil <sage@inktank.com>
Subject: leveldb compaction overhead
Date: Wed, 29 May 2013 14:07:48 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1305291406080.16097@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34302 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966887Ab3E2VHs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 May 2013 17:07:48 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 8103080060
	for <ceph-devel@vger.kernel.org>; Wed, 29 May 2013 14:07:48 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 7145880060
	for <ceph-devel@vger.kernel.org>; Wed, 29 May 2013 14:07:48 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all-

I have a couple of branches (wip-5176 and wip-5176-cuttlefish) that try to 
make the leveldb compaction on the monitor less expensive by doing it in 
an async thread and compaction only the trimmed range.  If anyone who is 
experience high monitor io on cuttlefish would like to test it out, 
feedback on whether/how much it improves things would be much appreciated!

Thanks-
sage
