From: Christoph Hellwig <hch@infradead.org>
Subject: Re: FileStore should not use syncfs(2)
Date: Thu, 6 Aug 2015 04:27:47 -0700
Message-ID: <20150806112747.GA21742@infradead.org>
References: <alpine.DEB.2.00.1508051415070.26854@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:54906 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754376AbbHFL17 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Aug 2015 07:27:59 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1508051415070.26854@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Somnath.Roy@sandisk.com, ceph-devel@vger.kernel.org, sjust@redhat.com

On Wed, Aug 05, 2015 at 02:26:30PM -0700, Sage Weil wrote:
> Today I learned that syncfs(2) does an O(n) search of the superblock's 
> inode list searching for dirty items.  I've always assumed that it was 
> only traversing dirty inodes (e.g., a list of dirty inodes), but that 
> appears not to be the case, even on the latest kernels.

I'm pretty sure Dave had some patches for that,  Even if they aren't
included it's not an unsolved problem.

> The main thing to watch out for is that according to POSIX you really need 
> to fsync directories.  With XFS that isn't the case since all metadata 
> operations are going into the journal and that's fully ordered, but we 
> don't want to allow data loss on e.g. ext4 (we need to check what the 
> metadata ordering behavior is there) or other file systems.

That additional fsync in XFS is basically free, so better get it right
and let the file system micro optimize for you.

