From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: Re: flashcache
Date: Wed, 16 Jan 2013 22:42:24 +0100
Message-ID: <CAJH6TXhCFvA6UF7e+wYOJAxuHi5Q1ug=TQao24Uxd7_AV_ppkg@mail.gmail.com>
References: <CAJH6TXiJjEq4C7k5p39Eo+pgwoq372r29RJriBee+irJPLvLpw@mail.gmail.com>
	<alpine.DEB.2.00.1301161325280.27925@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:64369 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757506Ab3APVmZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Jan 2013 16:42:25 -0500
Received: by mail-wi0-f169.google.com with SMTP id hq12so4012738wib.4
        for <ceph-devel@vger.kernel.org>; Wed, 16 Jan 2013 13:42:24 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1301161325280.27925@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

2013/1/16 Sage Weil <sage@inktank.com>:
> This sort of configuration effectively bundles the disk and SSD into a
> single unit, where the failure of either results in the loss of both.
> From Ceph's perspective, it doesn't matter if the thing it is sitting on
> is a single disk, an SSD+disk flashcache thing, or a big RAID array.  All
> that changes is the probability of failure.

Ok, it will fail, but this should not be an issue, in a cluster like
ceph, right?
With or without flashcache or SSD, ceph should be able to handle
disks/nodes/osds failures on its own by replicating in real time to
multiple server.

Should I worry about loosing data in case of failure? It should
rebalance automatically in case of failure with no data loss.

> I would worry that there is a lot of stuff piling onto the SSD and it may
> become your bottleneck.  My guess is that another 1-2 SSDs will be a
> better 'balance', but only experiementation will really tell us that.
>
> Otherwise, those seem to all be good things to put on teh SSD!

I can't add more than 2 SSD, I don't have enough space.
I can move OS to the first 2 spinning disks in raid1 software, if this
will improve performance of SSD

What about swap? I'm thinking to no use swap at all and start with 16/32GB RAM
