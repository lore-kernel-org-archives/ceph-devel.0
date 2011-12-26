From: Sage Weil <sage@newdream.net>
Subject: Re: Some Question Regarding to RBD performance
Date: Mon, 26 Dec 2011 08:27:54 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1112260819590.3637@cobra.newdream.net>
References: <CAA9wQNfSH=8ei6Kk8VQ6nWELhL5SV0eXFHv58WkPL4bFQsjtqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44468 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750730Ab1LZQ1z (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 26 Dec 2011 11:27:55 -0500
In-Reply-To: <CAA9wQNfSH=8ei6Kk8VQ6nWELhL5SV0eXFHv58WkPL4bFQsjtqg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Leander Yu <leander.yu@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi Leander,

On Mon, 26 Dec 2011, Leander Yu wrote:
> Hi all,
> I have a question regarding to RBD performance. Recently I test RBD in
> 2 cluster, using dd if=/dev/zero of=/dev/rbd5 bs=4M count=1024
> oflag=direct. I got 33.4MB/s in one cluster , however got only 6MB/s
> in the other cluster.
> 
> I have confirmed that the network bandwidth is ok. and osd bench shows
> around 32 ~ 40 MB/s on all OSD. Is this performance normal? if not ,
> how can I troubleshoot it?
> I have move journal to ramdisk for testing and get performance boost
> to 7x MB/s. Does this means the HDD is the bottleneck ?
> 
> The other cluster that got 33.4 MB/s , it's osd bench shows around
> 44MB/s. The major difference between those two cluster is the better
> performed one use SAS with RAID controller the other use SATA with no
> RAID control.

If you are using the kernel client, each 4M write is fully synchronous, 
which means (among other things) that the client is completely idle while 
the write is being replicated by the OSDs.  This makes the performance 
very sensitive to the write latency; it's not really testing write 
throughput.  Your SAS RAID controller is probably doing writeback caching 
of some kind that keeps the write latency low, while the SATA disks 
clearly are not.

'dd oflag=direct' is probably not the benchmark you want; no application 
should do a single synchronous IO at a time and expect good throughput.  
The more interesting number would be steady-state buffered write 
throughput when you have a file system on top, or something along those 
lines.

sage
