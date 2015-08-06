From: Sage Weil <sweil@redhat.com>
Subject: Re: FileStore should not use syncfs(2)
Date: Thu, 6 Aug 2015 06:00:42 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1508060559410.22099@cobra.newdream.net>
References: <alpine.DEB.2.00.1508051415070.26854@cobra.newdream.net> <20150806112747.GA21742@infradead.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44831 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750758AbbHFNAp (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 6 Aug 2015 09:00:45 -0400
In-Reply-To: <20150806112747.GA21742@infradead.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Somnath.Roy@sandisk.com, ceph-devel@vger.kernel.org, sjust@redhat.com

On Thu, 6 Aug 2015, Christoph Hellwig wrote:
> On Wed, Aug 05, 2015 at 02:26:30PM -0700, Sage Weil wrote:
> > Today I learned that syncfs(2) does an O(n) search of the superblock's 
> > inode list searching for dirty items.  I've always assumed that it was 
> > only traversing dirty inodes (e.g., a list of dirty inodes), but that 
> > appears not to be the case, even on the latest kernels.
> 
> I'm pretty sure Dave had some patches for that,  Even if they aren't
> included it's not an unsolved problem.
> 
> > The main thing to watch out for is that according to POSIX you really need 
> > to fsync directories.  With XFS that isn't the case since all metadata 
> > operations are going into the journal and that's fully ordered, but we 
> > don't want to allow data loss on e.g. ext4 (we need to check what the 
> > metadata ordering behavior is there) or other file systems.
> 
> That additional fsync in XFS is basically free, so better get it right
> and let the file system micro optimize for you.

I'm guessing the strategy here should be to fsync the file (leaf) and then 
any affected ancestors, such that the directory fsyncs are effectively 
no-ops?  Or does it matter?

Thanks!
sage

