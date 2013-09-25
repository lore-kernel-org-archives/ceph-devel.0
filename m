From: Sage Weil <sage@inktank.com>
Subject: userspace lockdep
Date: Wed, 25 Sep 2013 09:08:02 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1309250905130.12717@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56003 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754373Ab3IYQID (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Sep 2013 12:08:03 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id E44BC8047B
	for <ceph-devel@vger.kernel.org>; Wed, 25 Sep 2013 09:08:02 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id C0F848047B
	for <ceph-devel@vger.kernel.org>; Wed, 25 Sep 2013 09:08:02 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

http://lwn.net/Articles/536363/

Sasha Levin put together a userland LD_PRELOAD wrapper around the Linux 
kernel lockdep.  Colin's Locksmith is also linked from the comments.

It's been a while since I looked at locksmith, but I seem to remember 
thinking that there was something that ceph's lockdep does that 
wasn't captured (class-based instead of instance-based graph?).

In any case, if anyone is interested in this stuff, it may be possible to 
use one of these libraries and rip out our kludgey lockdep implementation.  
That would be nice!

sage

