From: Alex Elder <elder@inktank.com>
Subject: Re: windows rbd
Date: Fri, 17 May 2013 22:27:55 -0500
Message-ID: <5196F53B.8050402@inktank.com>
References: <6035A0D088A63A46850C3988ED045A4B57B57E55@BITCOM1.int.sbss.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:40904 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751162Ab3ERD14 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 May 2013 23:27:56 -0400
Received: by mail-ie0-f177.google.com with SMTP id 9so10842103iec.36
        for <ceph-devel@vger.kernel.org>; Fri, 17 May 2013 20:27:55 -0700 (PDT)
In-Reply-To: <6035A0D088A63A46850C3988ED045A4B57B57E55@BITCOM1.int.sbss.com.au>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: James Harper <james.harper@bendigoit.com.au>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 05/17/2013 08:22 PM, James Harper wrote:
> What would be the bare minimum to be implemented for a windows rbd
> kernel driver? In the Linux kernel I can see a drivers/block/rbd.c,
> which in turn uses net/ceph/*. There is also fs/ceph/* for the
> filesystem stuff.

I don't know a lot about porting anything from Linux to
Windows.  However, the rbd code relies on libceph (which as
you point out is the code under net/ceph in the Linux tree).
So libceph and rbd would need to go together.

Most of the code that implements kernel rbd itself is
portable, but the way it interfaces with the operating
system will I'm sure be quite different.  For example:
- getting requests from the block layer to process
- opening/closing sockets, and sending/receiving data
  through them
- the use of sysfs (/sys/bus/rbd/*) for the user space
  command line interface to communicate with the kernel
- locking (and other) basic OS primitives
- managing interrupts

It would probably be easier to work with the user space
rbd library (librbd), but that may not be integrated
with Windows the way you'd like

This is possibly a naive suggestion, but I know there
exists Unix-like environments for Windows (like Cygwin).
Perhaps that may provide an easier way to connect
Ceph technologies to a Windows environment.

					-Alex


> 
> Is a windows client even a worthwhile exercise? I know I can use an
> iscsi gateway or something like that but that adds complexity and
> probably latency, and kind of takes away from the distributed nature
> of ceph.
> 
> The other advantage of a native driver is that it could be integrated
> better with snapshot functionality for VSS, reducing system load for
> backups.
> 
> I can see one project to create a windows driver but it appears to be
> aborted... http://code.google.com/p/cephwin/
> 
> Is anyone else working on this at the moment?
> 
> James
> 
> 
> -- To unsubscribe from this list: send the line "unsubscribe
> ceph-devel" in the body of a message to majordomo@vger.kernel.org 
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

