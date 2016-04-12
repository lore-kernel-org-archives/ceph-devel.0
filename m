From: Sage Weil <sage@newdream.net>
Subject: Re: [ceph-users] Deprecating ext4 support
Date: Tue, 12 Apr 2016 14:00:31 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1604121345060.29593@cpach.fuggernut.com>
References: <alpine.DEB.2.11.1604111632520.13448@cpach.fuggernut.com> <alpine.DEB.2.11.1604111742010.29593@cpach.fuggernut.com> <4CD9DBC4-1A26-4C03-8DC6-BF36A1156611@schermer.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36648 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757242AbcDLSAe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Apr 2016 14:00:34 -0400
In-Reply-To: <4CD9DBC4-1A26-4C03-8DC6-BF36A1156611@schermer.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jan Schermer <jan@schermer.cz>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>, ceph-maintainers@ceph.com

On Tue, 12 Apr 2016, Jan Schermer wrote:
> I'd like to raise these points, then
> 
> 1) some people (like me) will never ever use XFS if they have a choice
> given no choice, we will not use something that depends on XFS
> 
> 2) choice is always good

Okay!

> 3) doesn't majority of Ceph users only care about RBD?

Probably that's true now.  We shouldn't recommend something that prevents 
them from adding RGW to an existing cluster in the future, though.

> (Angry rant coming)
> Even our last performance testing of Ceph (Infernalis) showed abysmal 
> performance. The most damning sign is the consumption of CPU time at 
> unprecedented rate. Was it faster than Dumpling? Slightly, but it ate 
> more CPU also, so in effect it was not really "faster".
> 
> It would make *some* sense to only support ZFS or BTRFS because you can 
> offload things like clones/snapshots and consistency to the filesystem - 
> which would make the architecture much simpler and everything much 
> faster. Instead you insist on XFS and reimplement everything in 
> software. I always dismissed this because CPU time was ususally cheap, 
> but in practice it simply doesn't work. You duplicate things that 
> filesystems had solved for years now (namely crash consistency - though 
> we have seen that fail as well), instead of letting them do their work 
> and stripping the IO path to the bare necessity and letting someone 
> smarter and faster handle that.
> 
> IMO, If Ceph was moving in the right direction there would be no 
> "supported filesystem" debate, instead we'd be free to choose whatever 
> is there that provides the guarantees we need from filesystem (which is 
> usually every filesystem in the kernel) and Ceph would simply distribute 
> our IO around with CRUSH.
> 
> Right now CRUSH (and in effect what it allows us to do with data) is 
> _the_ reason people use Ceph, as there simply wasn't much else to use 
> for distributed storage. This isn't true anymore and the alternatives 
> are orders of magnitude faster and smaller.

This touched on pretty much every reason why we are ditching file 
systems entirely and moving toward BlueStore.

Local kernel file systems maintain their own internal consistency, but 
they only provide what consistency promises the POSIX interface 
does--which is almost nothing.  That's why every complicated data 
structure (e.g., database) stored on a file system ever includes it's own 
journal.  In our case, what POSIX provides isn't enough.  We can't even 
update a file and it's xattr atomically, let alone the much more 
complicated transitions we need to do.  We coudl "wing it" and hope for 
the best, then do an expensive crawl and rsync of data on recovery, but we 
chose very early on not to do that.  If you want a system that "just" 
layers over an existing filesystem, try you can try Gluster (although note 
that they have a different sort of pain with the ordering of xattr 
updates, and are moving toward a model that looks more like Ceph's backend 
in their next version).

Offloading stuff to the file system doesn't save you CPU--it just makes 
someone else responsible.  What does save you CPU is avoiding the 
complexity you don't need (i.e., half of what the kernel file system is 
doing, and everything we have to do to work around an ill-suited 
interface) and instead implement exactly the set of features that we need 
to get the job done.

FileStore is slow, mostly because of the above, but also because it is an 
old and not-very-enlightened design.  BlueStore is roughly 2x faster in 
early testing.

Finally, remember you *are* completely free to run Ceph on whatever file 
system you want--and many do.  We just aren't going to test them all for 
you and promise they will all work.  Remember that we have hit different 
bugs in every single one we've tried. It's not as simple as saying they 
just have to "provide the guarantees we need" given the complexity of the 
interface, and almost every time we've tried to use "supported" APIs that 
are remotely unusually (fallocate, zeroing extents... even xattrs) we've 
hit bugs or undocumented limits and idiosyncrasies on one fs or another.

Cheers-
sage
