From: Sage Weil <sage@newdream.net>
Subject: Re: Example of RADOS AIO?
Date: Sun, 19 Dec 2010 11:19:15 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1012191116560.10950@cobra.newdream.net>
References: <7D2A2270-AEE9-4FE2-810F-E84BC0B2BD6A@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45760 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932396Ab0LSTNx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 19 Dec 2010 14:13:53 -0500
In-Reply-To: <7D2A2270-AEE9-4FE2-810F-E84BC0B2BD6A@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tatsuya Kawano <tatsuya6502@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Sun, 19 Dec 2010, Tatsuya Kawano wrote:
> Is there any example of asynchronous IO on RADOS (librados)? When I 
> write some bytes to an object, I'm only interested on the ack, which 
> means writes are applied to all the OSDs within the same placement group 
> but not yet committed to the disks. I'll use this feature to write HBase 
> journals.

There is an example in the rados_bencher.h file, and in 
testrados[pp].c[c].  

One thing to keep in mind, though, is that in some cases commit is 
actually faster.  Sometimes writing to the fs can be bursty (latency 
spikes while btrfs is doing a commit).  If you have a writeahead journal, 
the commit always comes first.  And if you have a fast journal device 
(SSD, NVRAM, RAID card with NVRAM, etc.) it will also be predictably fast.

And if it's a journal you rely on for consistency, I'd be very careful 
about relaxing your safety guarantees!

sage
