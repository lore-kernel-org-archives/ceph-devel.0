From: Josef Bacik <josef@redhat.com>
Subject: Re: Btrfs slowdown with ceph (how to reproduce)
Date: Mon, 23 Jan 2012 13:19:29 -0500
Message-ID: <20120123181928.GA3724@localhost.localdomain>
References: <CAO47_-8Eb_v8X95KxSZ2H-DNC3hLZkrfq1ce3CAfW2G9CUV5gQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41364 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750757Ab2AWSTe (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 23 Jan 2012 13:19:34 -0500
Content-Disposition: inline
In-Reply-To: <CAO47_-8Eb_v8X95KxSZ2H-DNC3hLZkrfq1ce3CAfW2G9CUV5gQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christian Brunner <chb@muc.de>
Cc: linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org

On Fri, Jan 20, 2012 at 01:13:37PM +0100, Christian Brunner wrote:
> As you might know, I have been seeing btrfs slowdowns in our ceph
> cluster for quite some time. Even with the latest btrfs code for 3.3
> I'm still seeing these problems. To make things reproducible, I've now
> written a small test, that imitates ceph's behavior:
> 
> On a freshly created btrfs filesystem (2 TB size, mounted with
> "noatime,nodiratime,compress=lzo,space_cache,inode_cache") I'm opening
> 100 files. After that I'm doing random writes on these files with a
> sync_file_range after each write (each write has a size of 100 bytes)
> and ioctl(BTRFS_IOC_SYNC) after every 100 writes.
> 
> After approximately 20 minutes, write activity suddenly increases
> fourfold and the average request size decreases (see chart in the
> attachment).
> 
> You can find IOstat output here: http://pastebin.com/Smbfg1aG
> 
> I hope that you are able to trace down the problem with the test
> program in the attachment.
 
Ran it, saw the problem, tried the dangerdonteveruse branch in Chris's tree and
formatted the fs with 64k node and leaf sizes and the problem appeared to go
away.  So surprise surprise fragmentation is biting us in the ass.  If you can
try running that branch with 64k node and leaf sizes with your ceph cluster and
see how that works out.  Course you should only do that if you dont mind if you
lose everything :).  Thanks,

Josef
