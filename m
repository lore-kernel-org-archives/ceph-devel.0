From: Sage Weil <sage@inktank.com>
Subject: Re: rbd kernel driver on the osd server
Date: Sun, 13 Jan 2013 19:42:41 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301131938100.10804@cobra.newdream.net>
References: <20130113160840.GF27442@hro-mlt-02.local> <50F2F632.6060402@widodh.nl> <20130113184615.GG27442@hro-mlt-02.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39486 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755219Ab3ANDmm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 13 Jan 2013 22:42:42 -0500
In-Reply-To: <20130113184615.GG27442@hro-mlt-02.local>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-15?Q?Harald_R=F6=DFler?= <Harald.Roessler@btd.de>
Cc: Wido den Hollander <wido@widodh.nl>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sun, 13 Jan 2013, Harald R??ler wrote:
> >    Hi,
> > 
> >    On 01/13/2013 05:08 PM, Harald R??ler wrote:
> >    > Hi,
> >    >
> >    > couple of month ago I read about a limitation to run an RBD kernel
> >    driver on the osd server. Is this limitation still valid? The reason in
> >    Ubuntu and Debian there is no support for the RBD devices in QEMU. At the
> >    moment, in our setup  the KVM's are running on the OSD servers.
> >    >
> > 
> >    I don't think so, but somebody might correct me here.
> 
> I am the same opinion, but I was not sure, I found this information on 
> some websites including in the "old" CEPH wiki and in the CEPH IRC logs.

The other problem to consider is the possibility of deadlock under memory 
pressure.  This is a problem with any network file system or block device 
that is backed by a user-level process on the same host.  When the VM 
system is under memory pressure, it will ask the fs to write out some 
dirty pages, which will be sent to a user-level process, that may need to 
allocate memory, which will block until the kernel is able to free more 
memory.  Deadlock.

Machines with lots of memory and very conservative VM settings can 
probably avoid this in practice, but it is technically possible, 
and with default settings isn't terribly hard to trigger.

sage


> 
> 
> > 
> >    The OSDs nowadays use syncfs which leads them to only syncing their
> >    filesystem instead of ALL the filesystems on that host.
> > 
> >    It might however be that Qemu calls sync() instead of syncfs() which
> >    still causes everything to be synced, which can lead to problems I guess.
> 
> Thank you for this information, If I got it right, use the kernel driver on the host system I can expect more performance than via QEMU. I will test it on our development system.
> 
> > 
> >    Regarding your reason for doing this, RBD is supported in Ubuntu's Qemu.
> > 
> >    Under Ubuntu precise it already works:
> >    http://packages.ubuntu.com/precise/qemu-kvm
> > 
> >    The problem is that the shipped version of Ceph is 0.41, which might be
> >    too old.
> > 
> >    I've been following the Blueprint for Ubuntu 13.04 and that will have
> >    all the Ceph stuff (Qemu and libvirt) you want with version 0.56.1
> 
> I will keep this in mind. Thanks!!
> 
> > 
> >    I'd look into that.
> > 
> >    Wido
> > 
> >    > Best Regards
> >    > Harald Roessler
> >    > --
> >    > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >    > the body of a message to majordomo@vger.kernel.org
> >    > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >    >
> >    --
> >    To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >    the body of a message to majordomo@vger.kernel.org
> >    More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> Best Regards
> Harald Roessler
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
