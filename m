From: Sage Weil <sage@newdream.net>
Subject: Re: [ceph-users] Deprecating ext4 support
Date: Tue, 12 Apr 2016 15:58:42 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1604121525020.29593@cpach.fuggernut.com>
References: <alpine.DEB.2.11.1604111632520.13448@cpach.fuggernut.com> <alpine.DEB.2.11.1604111742010.29593@cpach.fuggernut.com> <4CD9DBC4-1A26-4C03-8DC6-BF36A1156611@schermer.cz> <alpine.DEB.2.11.1604121345060.29593@cpach.fuggernut.com>
 <8CF37229-17C6-4E49-A623-FB8933631F60@schermer.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37633 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756110AbcDLT6p (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Apr 2016 15:58:45 -0400
In-Reply-To: <8CF37229-17C6-4E49-A623-FB8933631F60@schermer.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jan Schermer <jan@schermer.cz>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>, ceph-maintainers@ceph.com

Okay, I'll bite.

On Tue, 12 Apr 2016, Jan Schermer wrote:
> > Local kernel file systems maintain their own internal consistency, but 
> > they only provide what consistency promises the POSIX interface 
> > does--which is almost nothing.
> 
> ... which is exactly what everyone expects
> ... which is everything any app needs
> 
> >  That's why every complicated data 
> > structure (e.g., database) stored on a file system ever includes it's own 
> > journal.
> ... see?

They do this because POSIX doesn't give them what they want.  They 
implement a *second* journal on top.  The result is that you get the 
overhead from both--the fs journal keeping its data structures consistent, 
the database keeping its consistent.  If you're not careful, that means 
the db has to do something like file write, fsync, db journal append, 
fsync.  And both fsyncs turn into a *fs* journal io and flush.  (Smart 
databases often avoid most of the fs overhead by putting everything in a 
single large file, but at that point the file system isn't actually doing 
anything except passing IO to the block layer).

There is nothing wrong with POSIX file systems.  They have the unenviable 
task of catering to a huge variety of workloads and applications, but are 
truly optimal for very few.  And that's fine.  If you want a local file 
system, you should use ext4 or XFS, not Ceph.

But it turns ceph-osd isn't a generic application--it has a pretty 
specific workload pattern, and POSIX doesn't give us the interfaces we 
want (mainly, atomic transactions or ordered object/file enumeration).

> >  We coudl "wing it" and hope for 
> > the best, then do an expensive crawl and rsync of data on recovery, but we 
> > chose very early on not to do that.  If you want a system that "just" 
> > layers over an existing filesystem, try you can try Gluster (although note 
> > that they have a different sort of pain with the ordering of xattr 
> > updates, and are moving toward a model that looks more like Ceph's backend 
> > in their next version).
> 
> True, which is why we dismissed it.

...and yet it does exactly what you asked for:

> > > IMO, If Ceph was moving in the right direction [...] Ceph would 
> > > simply distribute our IO around with CRUSH.

You want ceph to "just use a file system."  That's what gluster does--it 
just layers the distributed namespace right on top of a local namespace.  
If you didn't care about correctness or data safety, it would be 
beautiful, and just as fast as the local file system (modulo network).  
But if you want your data safe, you immediatley realize that local POSIX 
file systems don't get you want you need: the atomic update of two files 
on different servers so that you can keep your replicas in sync.  Gluster 
originally took the minimal path to accomplish this: a "simple" 
prepare/write/commit, using xattrs as transaction markers.  We took a 
heavyweight approach to support arbitrary transactions.  And both of us 
have independently concluded that the local fs is the wrong tool for the 
job.

> > Offloading stuff to the file system doesn't save you CPU--it just makes 
> > someone else responsible.  What does save you CPU is avoiding the 
> > complexity you don't need (i.e., half of what the kernel file system is 
> > doing, and everything we have to do to work around an ill-suited 
> > interface) and instead implement exactly the set of features that we need 
> > to get the job done.
> 
> In theory you are right.
> In practice in-kernel filesystems are fast, and fuse filesystems are slow.
> Ceph is like that - slow. And you want to be fast by writing more code :)

You get fast by writing the *right* code, and eliminating layers of the 
stack (the local file system, in this case) that are providing 
functionality you don't want (or more functionality than you need at too 
high a price).

> I dug into bluestore and how you want to implement it, and from what I 
> understood you are reimplementing what the filesystem journal does...

Yes.  The difference is that a single journal manages all of the metadata 
and data consistency in the system, instead of a local fs journal managing 
just block allocation and a second ceph journal managing ceph's data 
structures.

The main benefit, though, is that we can choose a different set of 
semantics, like the ability to overwrite data in a file/object and update 
metadata atomically.  You can't do that with POSIX without building a 
write-ahead journal and double-writing.

> Btw I think at least i_version xattr could be atomic.

Nope.  All major file systems (other than btrfs) overwrite data in place, 
which means it is impossible for any piece of metadata to accurately 
indicate whether you have the old data or the new data (or perhaps a bit 
of both).

> It makes sense it will be 2x faster if you avoid the double-journalling, 
> but I'd be very much surprised if it helped with CPU usage one bit - I 
> certainly don't see my filesystems consuming significant amount of CPU 
> time on any of my machines, and I seriously doubt you're going to do 
> that better, sorry.

Apples and oranges.  The file systems aren't doing what we're doing.  But 
once you combine the what we spend now in FileStore + a local fs, 
BlueStore will absolutely spend less CPU time.

> What makes you think you will do a better job than all the people who 
> made xfs/ext4/...?

I don't.  XFS et al are great file systems and for the most part I have no 
complaints about them.  The problem is that Ceph doesn't need a file 
system: it needs a transactional object store with a different set of 
features.  So that's what we're building.

sage
