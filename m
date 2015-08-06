From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: FileStore should not use syncfs(2)
Date: Thu, 6 Aug 2015 17:44:43 +0800
Message-ID: <CAAM7YAnH8QaKP1RY3zbLX=3eZd-4tVX1EL=sH-x4y0P5ydDtfQ@mail.gmail.com>
References: <alpine.DEB.2.00.1508051415070.26854@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:34385 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753311AbbHFJoo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Aug 2015 05:44:44 -0400
Received: by lbbtg9 with SMTP id tg9so1605929lbb.1
        for <ceph-devel@vger.kernel.org>; Thu, 06 Aug 2015 02:44:43 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1508051415070.26854@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Somnath.Roy@sandisk.com, ceph-devel <ceph-devel@vger.kernel.org>, sjust@redhat.com

On Thu, Aug 6, 2015 at 5:26 AM, Sage Weil <sweil@redhat.com> wrote:
> Today I learned that syncfs(2) does an O(n) search of the superblock's
> inode list searching for dirty items.  I've always assumed that it was
> only traversing dirty inodes (e.g., a list of dirty inodes), but that
> appears not to be the case, even on the latest kernels.
>

I checked syncfs code in 3.10/4.1 kernel. I think both kernels only
traverse dirty inodes (inodes in
bdi_writeback::{b_dirty,b_io,b_more_io} lists). what am I missing?


> That means that the more RAM in the box, the larger (generally) the inode
> cache, the longer syncfs(2) will take, and the more CPU you'll waste doing
> it.  The box I was looking at had 256GB of RAM, 36 OSDs, and a load of ~40
> servicing a very light workload, and each syncfs(2) call was taking ~7
> seconds (usually to write out a single inode).
>
> A possible workaround for such boxes is to turn
> /proc/sys/vm/vfs_cache_pressure way up (so that the kernel favors caching
> pages instead of inodes/dentries)...
>
> I think the take-away though is that we do need to bite the bullet and
> make FileStore f[data]sync all the right things so that the syncfs call
> can be avoided.  This is the path you were originally headed down,
> Somnath, and I think it's the right one.
>
> The main thing to watch out for is that according to POSIX you really need
> to fsync directories.  With XFS that isn't the case since all metadata
> operations are going into the journal and that's fully ordered, but we
> don't want to allow data loss on e.g. ext4 (we need to check what the
> metadata ordering behavior is there) or other file systems.
>
> :(
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
