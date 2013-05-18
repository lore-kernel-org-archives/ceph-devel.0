From: James Harper <james.harper@bendigoit.com.au>
Subject: RE: windows rbd
Date: Sat, 18 May 2013 05:07:30 +0000
Message-ID: <6035A0D088A63A46850C3988ED045A4B57B58090@BITCOM1.int.sbss.com.au>
References: <6035A0D088A63A46850C3988ED045A4B57B57E55@BITCOM1.int.sbss.com.au>
 <5196F53B.8050402@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp2.bendigoit.com.au ([203.16.207.99]:50371 "EHLO
	smtp2.bendigoit.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755202Ab3ERFHh convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 18 May 2013 01:07:37 -0400
In-Reply-To: <5196F53B.8050402@inktank.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> 
> On 05/17/2013 08:22 PM, James Harper wrote:
> > What would be the bare minimum to be implemented for a windows rbd
> > kernel driver? In the Linux kernel I can see a drivers/block/rbd.c,
> > which in turn uses net/ceph/*. There is also fs/ceph/* for the
> > filesystem stuff.
> 
> I don't know a lot about porting anything from Linux to
> Windows.  However, the rbd code relies on libceph (which as
> you point out is the code under net/ceph in the Linux tree).
> So libceph and rbd would need to go together.
> 
> Most of the code that implements kernel rbd itself is
> portable, but the way it interfaces with the operating
> system will I'm sure be quite different.  For example:
> - getting requests from the block layer to process
> - opening/closing sockets, and sending/receiving data
>   through them
> - the use of sysfs (/sys/bus/rbd/*) for the user space
>   command line interface to communicate with the kernel
> - locking (and other) basic OS primitives
> - managing interrupts
> 
> It would probably be easier to work with the user space
> rbd library (librbd), but that may not be integrated
> with Windows the way you'd like
> 
> This is possibly a naive suggestion, but I know there
> exists Unix-like environments for Windows (like Cygwin).
> Perhaps that may provide an easier way to connect
> Ceph technologies to a Windows environment.
> 

I've thought about a tiny driver that would expose the block device to the kernel but rely wholly on userspace for everything else. I think the overheads of userspace->kernel->userspace would be too high, and then you could never boot from or use swap on your rbd device either. The linux userspace stuff appears to be C++ too, which can apparently be made to work in the windows kernel but is currently considered not a good idea, so probably porting the linux kernel code would be better. I've only had a quick look around in the code at this stage though.

I think Cygwin is too much overhead. I've tried to use it before for some of the xen libraries and it doesn't strike me as a general purpose solution.

I'm familiar enough with windows and linux kernel programming to "translate" those things from one to the other. I suspect:

> - getting requests from the block layer to process

This would become a storport driver. There are other ways of exposing a block device to Windows but emulating a scsi device would be the most flexible, I think. It would mean that windows would see it as a physical disk that needed partitioning though.

> - opening/closing sockets, and sending/receiving data
>   through them

I've not done this before... Vista brought in a new technology to do this to replace the old TDI... it's probably reasonable to only support newer operating systems.

> - the use of sysfs (/sys/bus/rbd/*) for the user space
>   command line interface to communicate with the kernel

This would be done with device interfaces. As usual the linux way seems more sensible :)

> - locking (and other) basic OS primitives
> - managing interrupts

Locking is quite different. No need for an actual hardware interrupt.

James

