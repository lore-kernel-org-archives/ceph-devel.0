From: Sage Weil <sage@newdream.net>
Subject: Re: FileStore should not use syncfs(2)
Date: Thu, 6 Aug 2015 05:47:29 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1508060545260.22099@cobra.newdream.net>
References: <alpine.DEB.2.00.1508051415070.26854@cobra.newdream.net> <755F6B91B3BE364F9BCA11EA3F9E0C6F2CDFBE42@SACMBXIP01.sdcorp.global.sandisk.com> <CACJqLyYfh=s3n_iKq0UPnWpeirKV=BVEf7LHv-dKC+xiAG6W=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38881 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755628AbbHFMr3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Aug 2015 08:47:29 -0400
In-Reply-To: <CACJqLyYfh=s3n_iKq0UPnWpeirKV=BVEf7LHv-dKC+xiAG6W=Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomaiwang@gmail.com>
Cc: Somnath Roy <Somnath.Roy@sandisk.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "sjust@redhat.com" <sjust@redhat.com>

On Thu, 6 Aug 2015, Haomai Wang wrote:
> Agree
> 
> On Thu, Aug 6, 2015 at 5:38 AM, Somnath Roy <Somnath.Roy@sandisk.com> wrote:
> > Thanks Sage for digging down..I was suspecting something similar.. As I mentioned in today's call, in idle time also syncfs is taking ~60ms. I have 64 GB of RAM in the system.
> > The workaround I was talking about today  is working pretty good so far. In this implementation, I am not giving much work to syncfs as each worker thread is writing with o_dsync mode. I am issuing syncfs before trimming the journal and most of the time I saw it is taking < 100 ms.
> 
> Actually I prefer we don't use syncfs anymore. I more like to use
> "aio+dio+Filestore custom cache" to deal with all "syncfs+pagecache"
> things. So we even can make cache more smart to aware of upper levels
> instead of fadvise* calls. Second we can use "checkpoint" method like
> mysql innodb, we can know the bw of frontend(filejournal) and decide
> how much and how often we want to flush(using aio+dio).
> 
> Anyway, because it's a big project, we may prefer to work at newstore
> instead of filestore.
> 
> > I have to wake up the sync_thread now after each worker thread finished writing. I will benchmark both the approaches. As we discussed earlier, in case of only fsync approach, we still need to do a db sync to make sure the leveldb stuff persisted, right ?
> >
> > Thanks & Regards
> > Somnath
> >
> > -----Original Message-----
> > From: Sage Weil [mailto:sweil@redhat.com]
> > Sent: Wednesday, August 05, 2015 2:27 PM
> > To: Somnath Roy
> > Cc: ceph-devel@vger.kernel.org; sjust@redhat.com
> > Subject: FileStore should not use syncfs(2)
> >
> > Today I learned that syncfs(2) does an O(n) search of the superblock's inode list searching for dirty items.  I've always assumed that it was only traversing dirty inodes (e.g., a list of dirty inodes), but that appears not to be the case, even on the latest kernels.
> >
> > That means that the more RAM in the box, the larger (generally) the inode cache, the longer syncfs(2) will take, and the more CPU you'll waste doing it.  The box I was looking at had 256GB of RAM, 36 OSDs, and a load of ~40 servicing a very light workload, and each syncfs(2) call was taking ~7 seconds (usually to write out a single inode).
> >
> > A possible workaround for such boxes is to turn /proc/sys/vm/vfs_cache_pressure way up (so that the kernel favors caching pages instead of inodes/dentries)...
> >
> > I think the take-away though is that we do need to bite the bullet and make FileStore f[data]sync all the right things so that the syncfs call can be avoided.  This is the path you were originally headed down, Somnath, and I think it's the right one.
> >
> > The main thing to watch out for is that according to POSIX you really need to fsync directories.  With XFS that isn't the case since all metadata operations are going into the journal and that's fully ordered, but we don't want to allow data loss on e.g. ext4 (we need to check what the metadata ordering behavior is there) or other file systems.
> 
> I guess there only a little directory modify operations, is it true?
> Maybe we only need to do syncfs when modifying directories?

I'd say there are a few broad cases:

 - creating or deleting objects.  simply fsyncing the file is 
sufficient on XFS; we should confirm what the behavior is on other 
distros.  But even if we d the fsync on the dir this is simple to 
implement.

 - renaming objects (collection_move_rename).  Easy to add an fsync here.

 - HashIndex rehashing.  This is where I get nervous... and setting some 
flag that triggers a full syncfs might be an interim solution since it's a 
pretty rare event.  OTOH, adding the fsync calls in the HashIndex code 
probably isn't so bad to audit and get right either...

sage
