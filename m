From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: CephFS: FSCache: Multiple "user" mounts: leads to kernel crash
 always
Date: Fri, 23 Jun 2017 21:58:03 +0800
Message-ID: <A6D5536E-A7FF-4766-B00C-0183B2E51A01@redhat.com>
References: <4FF0D797-6911-4A84-ACF8-428C553F664A@redhat.com>
 <1526449060.8319671.1497356505353.ref@mail.yahoo.com>
 <1526449060.8319671.1497356505353@mail.yahoo.com>
 <CANP1eJEzrt4VNvVghv81myiWdr=afY2Q8wESZUG1QfcLxUQrMw@mail.gmail.com>
 <1575453992.8635991.1497379073685@mail.yahoo.com>
 <1837992712.9057824.1497412489358@mail.yahoo.com>
 <93F8A0A5-0565-4E18-B8ED-25BBBF9E1982@redhat.com>
 <1398535033.1364189.1498138854902@mail.yahoo.com>
 <CANP1eJEJhaQS0mjTXo3m83f=MuXZVMjFKsxdG1nPOCjOdwwm8g@mail.gmail.com>
 <29300.1498222708@warthog.procyon.org.uk>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48660 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751217AbdFWN6F (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 23 Jun 2017 09:58:05 -0400
In-Reply-To: <29300.1498222708@warthog.procyon.org.uk>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Anish Gupta <anish_gupta@yahoo.com>, Milosz Tanski <milosz@adfin.com>, Sage Weil <sweil@redhat.com>, Jeff Layton <jlayton@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>


> On 23 Jun 2017, at 20:58, David Howells <dhowells@redhat.com> wrote:
> 
> Yan, Zheng <zyan@redhat.com> wrote:
> 
>> Is it convenience to fix this at fscache/cachefiles layer. The problem we
>> are facing is that each fscache instance needs a unique key. But if we
>> create unique key for each cephfs mount, we can't retain fscache across
>> mounts.
> 
> I don't know enough about how Ceph is organised to say what the exact problem
> is.

The problem is that user mounts the same ceph filesystem multiple times, each with different
mount options. ceph kernel module internally creates several instance mds clients, each mds
client has a fscache instance. If we give the same key to these fscache instances, kernel oops
happen. If we give unique key to each fscache instance, it’s hard to compose a key that allows
retaining fscache across mounts.

Maybe we can add a new mount option to cephfs. the mount option control if cephfs FSID or
‘FSID + SessionID’ is used as fscache key. And we only allow single mds client uses cephfs
FSID as fscache key.

Regards
Yan, Zheng   


> 
> But note that there are reasons I don't currently allow multiple live netfs
> inodes to share a cache object, if that's what you're talking about:
> 
> (1) Namespacing.  An index key in one network namespace may be identical to
>     an index key in another namespace - but because they are in different
>     network namespaces, they don't actually refer to the same remote objects.
> 
>     As I'm not entirely clear on how ceph works, here's an AFS example: I can
>     create two containers, each with a dedicated network card connected to a
>     separate network.  I can create separate cells with the same name on each
>     network and servers with identical addresses, volumes with the same names
>     and I will get files with the same FID.  To fscache they are
>     indistinguishable.
> 
> (2) Coherency.  Say I have two superblocks that refer to the same volume on a
>     server, and say I'm looking at the same file in each.  These two
>     instances of the file have separate local inodes and page caches - even
>     through they may refer to the same remote file.  The VFS and VM don't
>     know that they are the same thing.  inotify/fnotify doesn't know that
>     they're the same thing.
> 
>     So, if I write to one instance of the file, this (a) may not be reflected
>     in the other file and (b) when I push it to the server, the client may
>     get an invalidation request back against the other instance.
> 
>     This is a particular problem for NFS where you can make multiple mounts
>     of the same remote path with different network I/O parameters - and each
>     gives you a different superblock.
> 
> (3) Callbacks.  fscache can make requests of the netfs under some
>     circumstances - but if a cache object is connected to multiple objects,
>     where does it direct its request?
> 
> David

