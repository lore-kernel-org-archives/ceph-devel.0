From: David McBride <dwm37@cam.ac.uk>
Subject: Re: Ceph performance improvement
Date: Wed, 22 Aug 2012 11:24:20 +0100
Message-ID: <5034B354.1040109@cam.ac.uk>
References: <50349E62.90405@ledeuns.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ppsw-43.csi.cam.ac.uk ([131.111.8.143]:56465 "EHLO
	ppsw-43.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751964Ab2HVKqE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Aug 2012 06:46:04 -0400
In-Reply-To: <50349E62.90405@ledeuns.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Denis Fondras <ceph@ledeuns.net>
Cc: ceph-devel@vger.kernel.org

On 22/08/12 09:54, Denis Fondras wrote:

> The only point that prevents my from using it at datacenter-scale is
> performance.

> Here are some figures :
> * Test with "dd" on the OSD server (on drive
> /dev/disk/by-id/scsi-SATA_WDC_WD30EZRX-00_WD-WMAWZ0152201) :
> # dd if=/dev/zero of=testdd bs=4k count=4M
> 17179869184 bytes (17 GB) written, 123,746 s, 139 MB/s

That looks like you're writing to a filesystem on that disk, rather than 
the block device itself -- but lets say you've got 139MB/sec 
(1112Mbit/sec) of straight-line performance.

Note: this is already faster than your network link can go -- you can, 
at best, only achieve 120MB/sec over your gigabit link.

> * Test with "dd" from the client using RBD :
> # dd if=/dev/zero of=testdd bs=4k count=4M
> 17179869184 bytes (17 GB) written, 406,941 s, 42,2 MB/s

Is this a dd to the RBD device directly, or is this a write to a file in 
a filesystem created on top of it?

dd will write blocks synchronously -- that is, it will write one block, 
wait for the write to complete, then write the next block, and so on. 
Because of the durability guarantees provided by ceph, this will result 
in dd doing a lot of waiting around while writes are being sent over the 
network and written out on your OSD.

(If you're using the default replication count of 2, probably twice? 
I'm not exactly sure what Ceph does when it only has one OSD to work on..?)

> * Test with unpacking and deleting OpenBSD/5.1 src.tar.gz from the
> client using RBD :
> # time tar xzf src.tar.gz
> real    0m26.955s
> user    0m9.233s
> sys     0m11.425s

Just ignoring networking and storage for a moment, this also isn't a 
fair test: you're comparing the decompress-and-unpack time of a 139MB 
tarball on a 3GHz Pentium 4 with 1GB of RAM and a quad-core Xeon E5 that 
has 8GB.

Even ignoring the relative CPU difference, then unless you're doing 
something clever that you haven't described, there's no guarantee that 
the files in the latter case have actually been written to disk -- you 
have enough memory on your server for it to buffer all of those writes 
in RAM.  You'd need to add a sync() call or similar at the end of your 
timing run to ensure that all of those writes have actually been 
committed to disk.

> * Test with "dd" from the client using CephFS :
> # dd if=/dev/zero of=testdd bs=4k count=4M
> 17179869184 bytes (17 GB) written, 338,29 s, 50,8 MB/s

Again, the synchronous nature of 'dd' is probably severely affecting 
apparent performance.  I'd suggest looking at some other tools, like 
fio, bonnie++, or iozone, which might generate more representative load.

(Or, if you have a specific use-case in mind, something that generates 
an IO pattern like what you'll be using in production would be ideal!)

Cheers,
David
-- 
David McBride <dwm37@cam.ac.uk>
Unix Specialist, University Computing Service
