From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: nfsv41 over AF_VSOCK (nfs-ganesha)
Date: Tue, 27 Oct 2015 14:49:43 +0000
Message-ID: <20151027144943.GB5626@stefanha-x1.localdomain>
References: <1602558852.33130185.1445028743632.JavaMail.zimbra@redhat.com>
 <1249838657.33136909.1445029697101.JavaMail.zimbra@redhat.com>
 <CALe9h7cGzjgBO=K-p7PF=MQViawh8ZKd6u_u4E5A_JSf5zhMVg@mail.gmail.com>
 <CALe9h7fTUKJkxTxX4wKYwvJMOUXRneR+jB49p9M1Ji3-DVGuhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47394 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932512AbbJ0Otq (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 27 Oct 2015 10:49:46 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (Postfix) with ESMTPS id BAD3DA58B7
	for <ceph-devel@vger.kernel.org>; Tue, 27 Oct 2015 14:49:45 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CALe9h7fTUKJkxTxX4wKYwvJMOUXRneR+jB49p9M1Ji3-DVGuhw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Stefan Hajnoczi <shajnocz@redhat.com>

On Fri, Oct 23, 2015 at 02:27:22PM +0100, John Spray wrote:
> On Mon, Oct 19, 2015 at 5:13 PM, John Spray <jspray@redhat.com> wrote:
> >> If you try this, send feedback.
> >>
> 
> OK, got this up and running.
> 
> I've shared the kernel/qemu/nfsutils packages I built here:
> https://copr.fedoraproject.org/coprs/jspray/vsock-nfs/builds/
> 
> (at time of writing the kernel one is still building, and I'm running
> with ganesha out of a source tree)
> 
> Observations:
>  * Running VM as qemu user gives EPERM opening vsock device, even
> after changing permissions on the device node (for which I guess we'll
> want udev rules at some stage) -- is there a particular capability
> that we need to grant the qemu user?  Was looking into this to make it
> convenient to run inside libvirt.

libvirtd runs as root and opens /dev/vhost-*.  It passes file
descriptors to the unprivileged QEMU process.  I think this is how
things work in production (with SELinux enabled too).

On a development machine it is easier to either run QEMU as root or set
uid:gid on /dev/vhost-vsock.

So we don't need to do anything, although libvirt code will need to be
written to support vhost-vsock.  It should be very similar to the
existing vhost-net code in libvirt.

>  * NFS writes from the guest are lagging for like a minute before
> completing, my hunch is that this is something in the NFS client
> recovery stuff (in ganesha) that's not coping with vsock, the
> operations seem to complete at the point where the server declares
> itself "NOT IN GRACE".
>  * For those (like myself) unaccustomed to running ganesha, do not run
> it straight out of a source tree and expect everything to work, by
> default even VFS exports won't work that way (mounts work but clients
> see an empty tree) because it can't find the built FSAL .so.  You can
> write a config file that works, but it's easier just to make install
> it.
>  * (Anecdotal, seen while messing with other stuff) client mount seems
> to hang if I kill ganesha and then start it again, not sure if this is
> a ganesha issue or a general vsock issue.

If you experience hangs when the other side closes the connection you
may need:
https://github.com/stefanha/linux/commit/ae3c6c9b1534c1df5213a72f38e377ecd0852e14

Stefan
