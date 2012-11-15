From: Sage Weil <sage@inktank.com>
Subject: Re: ceph-osd cpu usage
Date: Thu, 15 Nov 2012 07:14:20 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1211150710550.4011@cobra.newdream.net>
References: <50A4CA65.2030508@profihost.ag>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43547 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1768118Ab2KOPOU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Nov 2012 10:14:20 -0500
In-Reply-To: <50A4CA65.2030508@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, 15 Nov 2012, Stefan Priebe - Profihost AG wrote:
> Hello list,
> 
> my main problem right now is that ceph does not scale for me (more vms using
> rbd). It does not scale as the ceph-osd is using all my CPU core all the time
> (8 cores) with just 4 SSDs. The SSDs are far away from being loaded.
> 
> What is the best way to find out what the ceph-osd process is doing all the
> time?
> 
> A gperf graph is attached.

Hmm, most significant time seems to be in the allocator and doing 
fsetxattr(2) (10%!).  Also some path traversal stuff.

Can you try the wip-fd-simple-cache branch, which tries to spend less time 
closing and reopening files?  I'm curious how much of a different it will 
make for you for both IOPS and CPU utilization.

It is also possible to use leveldb for most attrs.  If you set 
'filestore xattr use omap = true' it should put most attrs in leveldb.

sage
