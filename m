From: Sage Weil <sage@inktank.com>
Subject: Re: Ceph support for Direct I/O
Date: Thu, 17 May 2012 14:29:43 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1205171428530.7629@cobra.newdream.net>
References: <loom.20120517T232245-455@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45742 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754132Ab2EQV3q (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 May 2012 17:29:46 -0400
In-Reply-To: <loom.20120517T232245-455@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chang <oykimchi@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Thu, 17 May 2012, Chang wrote:
> Hi,
> 
> I was trying to test write performance of Ceph, using direct I/O.
> 
> $ dd if=/dev/zero of=/mnt/ceph/my.dat bs=1M count=1 oflag=direct
> 
> But dd is just stuck without doing any write.
> 
> Without oflag, write is done fine.
> 
> In the above example, I used Ceph kernel module 0.20, built on kernel 2.6.32.

That's an extremely old version of ceph.  I don't remember when direct i/o 
became well tested, but it doesn't surprise me that that version doesn't 
work.

I would suggest anything after 3.0...

sage

> 
> I also tried Ceph fuse client to mount.
> In this case, the above dd command gives me:
> 
> "dd: opening `/mnt/ceph/my.dat': Invalid argument"
> 
> Is it because Ceph does not support direct I/O?
> 
> I'm using ceph 0.46, installed using Debian release package.
> There are three OSDs, 1 Mon and 1 MDS in the cluster.
> 
> Any help or clarification is appreciated.
> 
> Chang
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
