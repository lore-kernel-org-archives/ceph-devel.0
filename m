From: Jan Schermer <jan@schermer.cz>
Subject: Re: [ceph-users] Deprecating ext4 support
Date: Tue, 12 Apr 2016 21:19:07 +0200
Message-ID: <8CF37229-17C6-4E49-A623-FB8933631F60@schermer.cz>
References: <alpine.DEB.2.11.1604111632520.13448@cpach.fuggernut.com> <alpine.DEB.2.11.1604111742010.29593@cpach.fuggernut.com> <4CD9DBC4-1A26-4C03-8DC6-BF36A1156611@schermer.cz> <alpine.DEB.2.11.1604121345060.29593@cpach.fuggernut.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:37597 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933021AbcDLTTM convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Apr 2016 15:19:12 -0400
Received: by mail-wm0-f42.google.com with SMTP id n3so41046024wmn.0
        for <ceph-devel@vger.kernel.org>; Tue, 12 Apr 2016 12:19:11 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1604121345060.29593@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>, ceph-maintainers@ceph.com


> On 12 Apr 2016, at 20:00, Sage Weil <sage@newdream.net> wrote:
> 
> On Tue, 12 Apr 2016, Jan Schermer wrote:
>> I'd like to raise these points, then
>> 
>> 1) some people (like me) will never ever use XFS if they have a choice
>> given no choice, we will not use something that depends on XFS
>> 
>> 2) choice is always good
> 
> Okay!
> 
>> 3) doesn't majority of Ceph users only care about RBD?
> 
> Probably that's true now.  We shouldn't recommend something that prevents 
> them from adding RGW to an existing cluster in the future, though.
> 
>> (Angry rant coming)
>> Even our last performance testing of Ceph (Infernalis) showed abysmal 
>> performance. The most damning sign is the consumption of CPU time at 
>> unprecedented rate. Was it faster than Dumpling? Slightly, but it ate 
>> more CPU also, so in effect it was not really "faster".
>> 
>> It would make *some* sense to only support ZFS or BTRFS because you can 
>> offload things like clones/snapshots and consistency to the filesystem - 
>> which would make the architecture much simpler and everything much 
>> faster. Instead you insist on XFS and reimplement everything in 
>> software. I always dismissed this because CPU time was ususally cheap, 
>> but in practice it simply doesn't work. You duplicate things that 
>> filesystems had solved for years now (namely crash consistency - though 
>> we have seen that fail as well), instead of letting them do their work 
>> and stripping the IO path to the bare necessity and letting someone 
>> smarter and faster handle that.
>> 
>> IMO, If Ceph was moving in the right direction there would be no 
>> "supported filesystem" debate, instead we'd be free to choose whatever 
>> is there that provides the guarantees we need from filesystem (which is 
>> usually every filesystem in the kernel) and Ceph would simply distribute 
>> our IO around with CRUSH.
>> 
>> Right now CRUSH (and in effect what it allows us to do with data) is 
>> _the_ reason people use Ceph, as there simply wasn't much else to use 
>> for distributed storage. This isn't true anymore and the alternatives 
>> are orders of magnitude faster and smaller.
> 
> This touched on pretty much every reason why we are ditching file 
> systems entirely and moving toward BlueStore.

Nooooooooooooooo!

> 
> Local kernel file systems maintain their own internal consistency, but 
> they only provide what consistency promises the POSIX interface 
> does--which is almost nothing.

... which is exactly what everyone expects
... which is everything any app needs

>  That's why every complicated data 
> structure (e.g., database) stored on a file system ever includes it's own 
> journal.
... see?


>  In our case, what POSIX provides isn't enough.  We can't even 
> update a file and it's xattr atomically, let alone the much more 
> complicated transitions we need to do.
... have you thought that maybe xattrs weren't meant to be abused this way? Filesystems usually aren't designed to be a performant key=value stores.
btw at least i_version should be atomic?

And I still feel (ironically) that you don't understand what journals and commits/flushes are for if you make this argument...

Btw I think at least i_version xattr could be atomic.


>  We coudl "wing it" and hope for 
> the best, then do an expensive crawl and rsync of data on recovery, but we 
> chose very early on not to do that.  If you want a system that "just" 
> layers over an existing filesystem, try you can try Gluster (although note 
> that they have a different sort of pain with the ordering of xattr 
> updates, and are moving toward a model that looks more like Ceph's backend 
> in their next version).

True, which is why we dismissed it.

> 
> Offloading stuff to the file system doesn't save you CPU--it just makes 
> someone else responsible.  What does save you CPU is avoiding the 
> complexity you don't need (i.e., half of what the kernel file system is 
> doing, and everything we have to do to work around an ill-suited 
> interface) and instead implement exactly the set of features that we need 
> to get the job done.

In theory you are right.
In practice in-kernel filesystems are fast, and fuse filesystems are slow.
Ceph is like that - slow. And you want to be fast by writing more code :)

> 
> FileStore is slow, mostly because of the above, but also because it is an 
> old and not-very-enlightened design.  BlueStore is roughly 2x faster in 
> early testing.
... which is still literally orders of magnitude slower than a filesystem.
I dug into bluestore and how you want to implement it, and from what I understood you are reimplementing what the filesystem journal does...
It makes sense it will be 2x faster if you avoid the double-journalling, but I'd be very much surprised if it helped with CPU usage one bit - I certainly don't see my filesystems consuming significant amount of CPU time on any of my machines, and I seriously doubt you're going to do that better, sorry.



> 
> Finally, remember you *are* completely free to run Ceph on whatever file 
> system you want--and many do.  We just aren't going to test them all for 
> you and promise they will all work.  Remember that we have hit different 
> bugs in every single one we've tried. It's not as simple as saying they 
> just have to "provide the guarantees we need" given the complexity of the 
> interface, and almost every time we've tried to use "supported" APIs that 
> are remotely unusually (fallocate, zeroing extents... even xattrs) we've 
> hit bugs or undocumented limits and idiosyncrasies on one fs or another.

This can be a valid point, those are features people either don't use, or use quite differently. But just because you can stress the filesystems until they break doesn't mean you should go write a new one. What makes you think you will do a better job than all the people who made xfs/ext4/...?

Anyway, I don't know how more to debunk the "insufficient guarantees in POSIX filesystem transactions" myth that you insist on fixing, so I guess I'll have to wait until you rewrite everything up to the drive firmware to appreciate it :)

Jan


P.S. A joke for you
How many syscalls does it take for Ceph to write "lightbulb" to the disk?
10 000
ha ha?


> 
> Cheers-
> sage

