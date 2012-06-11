From: Guido Winkelmann <guido-ceph@thisisnotatest.de>
Subject: Re: Random data corruption in VM, possibly caused by rbd
Date: Mon, 11 Jun 2012 17:50:14 +0200
Message-ID: <25761303.PmWYZprmzc@pc10>
References: <21601270.dfB0BsVfyn@pc10> <4FD1FFD2.6050707@filoo.de> <Pine.LNX.4.64.1206080652031.10292@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from unknownsite.de ([62.48.69.106]:40474 "EHLO hartes-hannover.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752476Ab2FKPuU (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 11 Jun 2012 11:50:20 -0400
In-Reply-To: <Pine.LNX.4.64.1206080652031.10292@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Oliver Francke <Oliver.Francke@filoo.de>, Josh Durgin <josh.durgin@inktank.com>, ceph-devel@vger.kernel.org

Am Freitag, 8. Juni 2012, 06:55:19 schrieb Sage Weil:
> On Fri, 8 Jun 2012, Oliver Francke wrote:
> > Hi Guido,
> > 
> > yeah, there is something weird going on. I just started to establish some
> > test-VM's. Freshly imported from running *.qcow2 images.
> > Kernel panic with INIT, seg-faults and other "funny" stuff.
> > 
> > Just added the rbd_cache=true in my config, voila. All is
> > fast-n-up-n-running...
> > All my testing was done with cache enabled... Since our errors all came
> > from rbd_writeback from former ceph-versions...
> 
> Are you guys able to reproduce the corruption with 'debug osd = 20' and
> 'debug ms = 1'?  Ideally we'd like to:
> 
>  - reproduce from a fresh vm, with osd logs
>  - identify the bad file
>  - map that file to a block offset (see
>    http://ceph.com/qa/fiemap.[ch], linux_fiemap.h)
>  - use that to identify the badness in the log
> 
> I suspect the cache is just masking the problem because it submits fewer
> IOs...

Okay, I added 'debug osd = 20' and 'debug ms = 1' under [global] and 
'filestore fiemap = false' under [osd] and started a new VM. That worked 
nicely, and the iotester found no corruptions. Then I removed 'filestore 
fiemap = false' from the config, restarted all osds and ran the iotester 
again. Output is as follows:

testserver-rbd11 iotester # date ; ./iotester /var/iotest ; date
Mon Jun 11 17:34:44 CEST 2012
Wrote 100 MiB of data in 1943 milliseconds
Wrote 100 MiB of data in 1858 milliseconds
Wrote 100 MiB of data in 2213 milliseconds
Wrote 100 MiB of data in 3441 milliseconds
Wrote 100 MiB of data in 2705 milliseconds
Wrote 100 MiB of data in 1778 milliseconds
Wrote 100 MiB of data in 1974 milliseconds
Wrote 100 MiB of data in 2780 milliseconds
Wrote 100 MiB of data in 1961 milliseconds
Wrote 100 MiB of data in 2366 milliseconds
Wrote 100 MiB of data in 1886 milliseconds
Wrote 100 MiB of data in 3589 milliseconds
Wrote 100 MiB of data in 1973 milliseconds
Wrote 100 MiB of data in 2506 milliseconds
Wrote 100 MiB of data in 1937 milliseconds
Wrote 100 MiB of data in 3404 milliseconds
Wrote 100 MiB of data in 1990 milliseconds
Wrote 100 MiB of data in 3713 milliseconds
Read 100 MiB of data in 4856 milliseconds
Digest wrong for file "/var/iotest/b45e1a59f26830fb98af1ba9ed1360106f5580aa"
Mon Jun 11 17:35:34 CEST 2012
testserver-rbd11 iotester # ~/fiemap 
/var/iotest/b45e1a59f26830fb98af1ba9ed1360106f5580aa
File /var/iotest/b45e1a59f26830fb98af1ba9ed1360106f5580aa has 1 extents:
#       Logical          Physical         Length           Flags
0:      0000000000000000 00000000a8200000 0000000000100000 000

I looked into the file in question, and it started with zero-bytes from the 
start until position 0xbff, even though it was supposed to all random data.

I have included timestamps in the hopes they might make it easier to find the 
related entries in the logs.

So what do I do now? The logs are very large and complex, and I don't 
understand most of what's in there. I don't even know which OSD served that 
particular block/object.

Regards,

	Guido

