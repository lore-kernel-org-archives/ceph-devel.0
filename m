From: Sage Weil <sage@newdream.net>
Subject: Re: RDB Performance
Date: Wed, 21 Sep 2011 14:22:52 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1109211419520.22692@cobra.newdream.net>
References: <4E7A4D9E.3070305@tuxadero.com> <Pine.LNX.4.64.1109211354360.22692@cobra.newdream.net>
 <4E7A5477.1080105@tuxadero.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:32882 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750873Ab1IUVWx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Sep 2011 17:22:53 -0400
In-Reply-To: <4E7A5477.1080105@tuxadero.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Mailand <martin@tuxadero.com>
Cc: ceph-devel@vger.kernel.org

On Wed, 21 Sep 2011, Martin Mailand wrote:
> Hi Sage,
> good to hear that you are working on this issue. I tried qemu-kvm with the rbd
> block device patch, which I think uses librbd, but I couldn't measure any
> performance improvements.
>
> Which versions do I have to use, and do I have to activate the writeback
> window or is it default on?

In the qemu rbd: line, include an option like ":rbd_writeback_window=81920000",
where the size of the window is specified in bytes.  (It's off by 
default.)

Also, keep mind that unless you're using the latest qemu upstream (or our 
repo), the flush aren't being passed down properly, and your data won't 
quite be safe.  (That's the main reason why we're leaving it off by 
default for the time being.)

sage

> 
> Best Regards,
>  Martin
> 
> 
> Sage Weil schrieb:
> > On Wed, 21 Sep 2011, Martin Mailand wrote:
> > > hi,
> > > I have a few question about the rbd performance. I have a small ceph
> > > installation, three osd server one monitor server and one compute node
> > > which
> > > maps a rbd image to a block device, all server a connectet via a dedicated
> > > 1Gbs network.
> > > Each osd is capable of doing around 90MB/s tested with osd bench.
> > > But if I test the write speed of the rbd block device the performance ist
> > > quite poor.
> > > 
> > > I do the test with
> > > dd if=/dev/zero of=/dev/rbd0 bs=1M count=10000 oflag=direct,
> > > I get a throughput around 25MB/s.
> > > I used wireshark to graph the network throughput, the image is
> > > http://tuxadero.com/multistorage/ceph.jpg
> > > as you can see the throughput is not smooth.
> > > 
> > > The graph for the test without the oflag=direct is
> > > http://tuxadero.com/multistorage/ceph2.jpg
> > > which is much better, but I the compute node uses around 4-5G of it's RAM
> > > as a
> > > writeback cache, which is not acceptable for my application.
> > > 
> > > For comparison the graph for a scp transfer.
> > > http://tuxadero.com/multistorage/scp.jpg
> > > 
> > > I read in the ceph doku, that ever "package" has to be commited to the
> > > disk on
> > > the osd, before it is acknowledged to the client, could you please
> > > expalain
> > > what a package is? Probably not a TCP package.
> > 
> > You probably mean "object".. each write has to be on disk before it is
> > acknowledged.
> > 
> > > And on the mailinglist was a discussion about a writeback window, to my
> > > understanding it say how many byte can be unacknowledged in transit, is
> > > that right?
> > 
> > Right.
> > 
> > > How could I activate it?
> > 
> > So far it's currently only implemented in librbd (the userland
> > implementation).  The problem is that your dd is doing synchronous writes to
> > the block device, which are synchronously written to the OSD.  That means a
> > lot of time waiting around for the last write to complete before starting to
> > send the next one.
> > 
> > Normal hard disks have a cache that absorbs this.  They acknowledge the
> > write immediately, and only promise that the data will actually be durable
> > when you issue a flush command later.
> > 
> > In librbd, we just added a write window that gives you similar performance.
> > We acknowledge writes immediately and do the write asynchronously, with a
> > cap on the amount of outstanding bytes.  This doesn't coalesce small writes
> > into big ones like a real cache, but usually the filesystem does most of
> > that, so we should get similar performance.
> > 
> > Anyway, the kernrel implementation doesn't do that yet.  It's on the todo
> > list for the next 2 weeks...
> > 
> > sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
