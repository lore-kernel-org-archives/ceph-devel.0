From: Sage Weil <sage@inktank.com>
Subject: Re: Random data corruption in VM, possibly caused by rbd
Date: Mon, 11 Jun 2012 10:12:49 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1206111011320.15669@cobra.newdream.net>
References: <21601270.dfB0BsVfyn@pc10> <25761303.PmWYZprmzc@pc10>
 <Pine.LNX.4.64.1206110920150.10557@cobra.newdream.net> <8220427.3utvH3jSx7@pc10>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35936 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751687Ab2FKRMx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Jun 2012 13:12:53 -0400
In-Reply-To: <8220427.3utvH3jSx7@pc10>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Guido Winkelmann <guido-ceph@thisisnotatest.de>
Cc: Oliver Francke <Oliver.Francke@filoo.de>, Josh Durgin <josh.durgin@inktank.com>, ceph-devel@vger.kernel.org

On Mon, 11 Jun 2012, Guido Winkelmann wrote:
> Am Montag, 11. Juni 2012, 09:30:42 schrieb Sage Weil:
> > On Mon, 11 Jun 2012, Guido Winkelmann wrote:
> > > Am Freitag, 8. Juni 2012, 06:55:19 schrieb Sage Weil:
> > > > On Fri, 8 Jun 2012, Oliver Francke wrote:
> 
> > > > Are you guys able to reproduce the corruption with 'debug osd = 20' and
> > > > 
> > > > 'debug ms = 1'?  Ideally we'd like to:
> > > >  - reproduce from a fresh vm, with osd logs
> > > >  - identify the bad file
> > > >  - map that file to a block offset (see
> > > >  
> > > >    http://ceph.com/qa/fiemap.[ch], linux_fiemap.h)
> > > >  
> > > >  - use that to identify the badness in the log
> > > > 
> > > > I suspect the cache is just masking the problem because it submits fewer
> > > > IOs...
> > > 
> > > Okay, I added 'debug osd = 20' and 'debug ms = 1' under [global] and
> > > 'filestore fiemap = false' under [osd] and started a new VM. That worked
> > > nicely, and the iotester found no corruptions. Then I removed 'filestore
> > > fiemap = false' from the config, restarted all osds and ran the iotester
> > > again. Output is as follows:
> > > 
> > > testserver-rbd11 iotester # date ; ./iotester /var/iotest ; date
> > > Mon Jun 11 17:34:44 CEST 2012
> > > Wrote 100 MiB of data in 1943 milliseconds
> > > Wrote 100 MiB of data in 1858 milliseconds
> > > Wrote 100 MiB of data in 2213 milliseconds
> > > Wrote 100 MiB of data in 3441 milliseconds
> > > Wrote 100 MiB of data in 2705 milliseconds
> > > Wrote 100 MiB of data in 1778 milliseconds
> > > Wrote 100 MiB of data in 1974 milliseconds
> > > Wrote 100 MiB of data in 2780 milliseconds
> > > Wrote 100 MiB of data in 1961 milliseconds
> > > Wrote 100 MiB of data in 2366 milliseconds
> > > Wrote 100 MiB of data in 1886 milliseconds
> > > Wrote 100 MiB of data in 3589 milliseconds
> > > Wrote 100 MiB of data in 1973 milliseconds
> > > Wrote 100 MiB of data in 2506 milliseconds
> > > Wrote 100 MiB of data in 1937 milliseconds
> > > Wrote 100 MiB of data in 3404 milliseconds
> > > Wrote 100 MiB of data in 1990 milliseconds
> > > Wrote 100 MiB of data in 3713 milliseconds
> > > Read 100 MiB of data in 4856 milliseconds
> > > Digest wrong for file
> > > "/var/iotest/b45e1a59f26830fb98af1ba9ed1360106f5580aa" Mon Jun 11
> > > 17:35:34 CEST 2012
> > > testserver-rbd11 iotester # ~/fiemap
> > > /var/iotest/b45e1a59f26830fb98af1ba9ed1360106f5580aa
> > > File /var/iotest/b45e1a59f26830fb98af1ba9ed1360106f5580aa has 1 extents:
> > > #       Logical          Physical         Length           Flags
> > > 0:      0000000000000000 00000000a8200000 0000000000100000 000
> > > 
> > > I looked into the file in question, and it started with zero-bytes from
> > > the
> > > start until position 0xbff, even though it was supposed to all random
> > > data.
> > > 
> > > I have included timestamps in the hopes they might make it easier to find
> > > the related entries in the logs.
> > > 
> > > So what do I do now? The logs are very large and complex, and I don't
> > > understand most of what's in there. I don't even know which OSD served
> > > that
> > > particular block/object.
> > 
> > If you can reproduce it with 'debug filestore = 20' too, that will be
> > better, as it will tell us what the FIEMAP ioctl is returning.  Also, if
> > you can attach/post the contents of the object itself (rados -p rbd get
> > rb.0.1.0000000002a0 /tmp/foo) we can make sure the object has the right
> > data (and the sparse-read operation that librbd is doing is the culprit).
> 
> Um. Maybe... That's the problem with using random data, I can't just look at 
> it and recognize it. I guess tomorrow I'll slap something together to see if I 
> can find any 1 Meg-range of data in there that matches the expect checksum.

The process below will identify the object in question..

> > 
> > As for the log:
> > 
> > First, map the offset to an rbd block.  For example, taking the 'Physical'
> > value of 00000000a8200000 from above:
> > 
> > $ printf "%012x\n" $((0x00000000a8200000 / (4096*1024) ))
> > 0000000002a0
> > 
> > Then figure out what the object name prefix is:
> > 
> > $ rbd info <imagename> | grep prefix
> >         block_name_prefix: rb.0.1
> > 
> > Then add the block number, 0000000002a0 to that, e.g. rb.0.1.0000000002a0.
> > 
> > Then map that back to an osd with
> > 
> > $ ceph osd map rbd rb.0.1.0000000002a0
> > osdmap e19 pool 'rbd' (2) object 'rb.0.1.0000000002a0' -> pg 2.a2e06f65
> > (2.5) -> up [0,2] acting [0,2]
> > 
> > You'll see the osd ids listed in brackets after 'active'.  We want the
> > first one, 0 in my example.  The log from that OSD is what we need.
> 
> I'm getting
> 
> osdmap e89 pool 'rbd' (2) object 'rb.0.13.0000000002a0' -> pg 2.aca5eccb 
> (2.4b) -> up [1,2] acting [1,2]
> 
> from that command, so I guess it's osd.1 then.
> Do you have somewhere I can upload the log? It is 1.1 GiB in size. Bzip2 
> gets it down to 53 MiB, but that's still too large to be sent to a 
> mailing list...

Yeah, but it'll be more useful if its generated with 'debug filestore = 
20'... :)

sage
