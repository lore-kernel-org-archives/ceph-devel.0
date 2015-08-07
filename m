From: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>
Subject: RE: FileStore should not use syncfs(2)
Date: Fri, 7 Aug 2015 06:50:17 +0000
Message-ID: <6F3FA899187F0043BA1827A69DA2F7CC02261433@shsmsx102.ccr.corp.intel.com>
References: <alpine.DEB.2.00.1508051415070.26854@cobra.newdream.net>
 <55C28667.7080600@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:31040 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754068AbbHGGuZ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Aug 2015 02:50:25 -0400
In-Reply-To: <55C28667.7080600@redhat.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>, Sage Weil <sweil@redhat.com>, "Somnath.Roy@sandisk.com" <Somnath.Roy@sandisk.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "sjust@redhat.com" <sjust@redhat.com>

> FWIW, I often see performance increase when favoring inode/dentry cache, but
> probably with far fewer inodes that the setup you just saw.  It sounds like there
> needs to be some maximum limit on the inode/dentry cache to prevent this
> kind of behavior but still favor it up until that point.  Having said that, maybe
> avoiding syncfs is best as you say below.

We also see that in most of the case. Usually we set this to 1 (prefer inode) as a tuning BKM for small file storage.

Can we walk around it by enlarge the size of FDCache and tune /proc/sys/vm/vfs_cache_pressure to 100(prefer data)? That means we try to use FDCache to replace inode/dentry cache as possible.



> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> owner@vger.kernel.org] On Behalf Of Mark Nelson
> Sent: Thursday, August 6, 2015 5:56 AM
> To: Sage Weil; Somnath.Roy@sandisk.com
> Cc: ceph-devel@vger.kernel.org; sjust@redhat.com
> Subject: Re: FileStore should not use syncfs(2)
> 
> 
> 
> On 08/05/2015 04:26 PM, Sage Weil wrote:
> > Today I learned that syncfs(2) does an O(n) search of the superblock's
> > inode list searching for dirty items.  I've always assumed that it was
> > only traversing dirty inodes (e.g., a list of dirty inodes), but that
> > appears not to be the case, even on the latest kernels.
> >
> > That means that the more RAM in the box, the larger (generally) the
> > inode cache, the longer syncfs(2) will take, and the more CPU you'll
> > waste doing it.  The box I was looking at had 256GB of RAM, 36 OSDs,
> > and a load of ~40 servicing a very light workload, and each syncfs(2)
> > call was taking ~7 seconds (usually to write out a single inode).
> >
> > A possible workaround for such boxes is to turn
> > /proc/sys/vm/vfs_cache_pressure way up (so that the kernel favors
> > caching pages instead of inodes/dentries)...
> 
> FWIW, I often see performance increase when favoring inode/dentry cache, but
> probably with far fewer inodes that the setup you just saw.  It sounds like there
> needs to be some maximum limit on the inode/dentry cache to prevent this
> kind of behavior but still favor it up until that point.  Having said that, maybe
> avoiding syncfs is best as you say below.
> 
> >
> > I think the take-away though is that we do need to bite the bullet and
> > make FileStore f[data]sync all the right things so that the syncfs
> > call can be avoided.  This is the path you were originally headed
> > down, Somnath, and I think it's the right one.
> >
> > The main thing to watch out for is that according to POSIX you really
> > need to fsync directories.  With XFS that isn't the case since all
> > metadata operations are going into the journal and that's fully
> > ordered, but we don't want to allow data loss on e.g. ext4 (we need to
> > check what the metadata ordering behavior is there) or other file systems.
> >
> > :(
> >
> > sage
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> > in the body of a message to majordomo@vger.kernel.org More majordomo
> > info at  http://vger.kernel.org/majordomo-info.html
> >
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body
> of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
