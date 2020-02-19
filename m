From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] ceph: add halt mount option support
Date: Wed, 19 Feb 2020 21:42:11 +0100
Message-ID: <CAOi1vP9GEt89=RWbwPJ+X172DJL7=R49iBxWfOerARch-VYJDg@mail.gmail.com>
References: <20200216064945.61726-1-xiubli@redhat.com> <78ff80dd12d497be7a6606a60973f7e2d864e910.camel@kernel.org>
 <36e1f3a9-1688-9eb0-27d7-351a12bca85a@redhat.com> <4a4cfe2a5fc1de6f73fa3f557921c1ad5802add6.camel@kernel.org>
 <CAOi1vP_yGJGqkY+QLdQoruJrS3gawEC-_NqDnpucCWfXOHL-aQ@mail.gmail.com> <CA+2bHPZmjvbtFBNzviR6uYsM=bF92qC-Xkgm2uucBe6KJHjJbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io1-f65.google.com ([209.85.166.65]:38482 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgBSUlr (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Feb 2020 15:41:47 -0500
Received: by mail-io1-f65.google.com with SMTP id s24so2105361iog.5
        for <ceph-devel@vger.kernel.org>; Wed, 19 Feb 2020 12:41:45 -0800 (PST)
In-Reply-To: <CA+2bHPZmjvbtFBNzviR6uYsM=bF92qC-Xkgm2uucBe6KJHjJbg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Patrick Donnelly <pdonnell@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, Xiubo Li <xiubli@redhat.com>, Sage Weil <sage@redhat.com>, "Yan, Zheng" <zyan@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Feb 19, 2020 at 8:22 PM Patrick Donnelly <pdonnell@redhat.com> wrote:
>
> On Tue, Feb 18, 2020 at 6:59 AM Ilya Dryomov <idryomov@gmail.com> wrote:
> > > Yeah, I've mostly done this using DROP rules when I needed to test things.
> > > But, I think I was probably just guilty of speculating out loud here.
> >
> > I'm not sure what exactly Xiubo meant by "fulfilling" iptables rules
> > in libceph, but I will say that any kind of iptables manipulation from
> > within libceph is probably out of the question.
>
> I think we're getting confused about two thoughts on iptables: (1) to
> use iptables to effectively partition the mount instead of this new
> halt option; (2) use iptables in concert with halt to prevent FIN
> packets from being sent when the sockets are closed. I think we all
> agree (2) is not going to happen.

Right.

>
> > > I think doing this by just closing down the sockets is probably fine. I
> > > wouldn't pursue anything relating to to iptables here, unless we have
> > > some larger reason to go that route.
> >
> > IMO investing into a set of iptables and tc helpers for teuthology
> > makes a _lot_ of sense.  It isn't exactly the same as a cable pull,
> > but it's probably the next best thing.  First, it will be external to
> > the system under test.  Second, it can be made selective -- you can
> > cut a single session or all of them, simulate packet loss and latency
> > issues, etc.  Third, it can be used for recovery and failover/fencing
> > testing -- what happens when these packets get delivered two minutes
> > later?  None of this is possible with something that just attempts to
> > wedge the mount and acts as a point of no return.
>
> This sounds attractive but it does require each mount to have its own
> IP address? Or are there options? Maybe the kernel driver could mark
> the connection with a mount ID we could do filtering on it? From a
> quick Google, maybe [1] could be used for this purpose. I wonder
> however if the kernel driver would have to do that marking of the
> connection... and then we have iptables dependencies in the driver
> again which we don't want to do.

As I said yesterday, I think it should be doable with no kernel
changes -- either with IP aliases or with the help of some virtual
interface.  Exactly how, I'm not sure because I use VMs for my tests
and haven't had to touch iptables in a while, but I would be surprised
to learn otherwise given the myriad of options out there.

>
> From my perspective, this halt patch looks pretty simple and doesn't
> appear to be a huge maintenance burden. Is it really so objectionable?

Well, this patch is simple only because it isn't even remotely
equivalent to a cable pull.  I mean, it aborts in-flight requests
with EIO, closes sockets, etc.  Has it been tested against the test
cases that currently cold reset the node through the BMC?

If it has been tested and the current semantics are sufficient,
are you sure they will remain so in the future?  What happens when
a new test gets added that needs a harder shutdown?  We won't be
able to reuse existing "umount -f" infrastructure anymore...  What
if a new test needs to _actually_ kill the client?

And then a debugging knob that permanently wedges the client sure
can't be a mount option for all the obvious reasons.  This bit is easy
to fix, but the fact that it is submitted as a mount option makes me
suspect that the whole thing hasn't been thought through very well.

Thanks,

                Ilya
