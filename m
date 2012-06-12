From: Guido Winkelmann <guido-ceph@thisisnotatest.de>
Subject: Re: Random data corruption in VM, possibly caused by rbd
Date: Tue, 12 Jun 2012 14:31:47 +0200
Message-ID: <1815615.qFFlAnfNF8@pc10>
References: <21601270.dfB0BsVfyn@pc10> <25761303.PmWYZprmzc@pc10> <Pine.LNX.4.64.1206110920150.10557@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from unknownsite.de ([62.48.69.106]:55821 "EHLO hartes-hannover.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752286Ab2FLMb4 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 12 Jun 2012 08:31:56 -0400
In-Reply-To: <Pine.LNX.4.64.1206110920150.10557@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Oliver Francke <Oliver.Francke@filoo.de>, Josh Durgin <josh.durgin@inktank.com>, ceph-devel@vger.kernel.org

Am Montag, 11. Juni 2012, 09:30:42 schrieb Sage Weil:
> If you can reproduce it with 'debug filestore = 20' too, that will be
> better, as it will tell us what the FIEMAP ioctl is returning.

I ran another testrun with 'debug filestore = 20'.

> Also, if
> you can attach/post the contents of the object itself (rados -p rbd get
> rb.0.1.0000000002a0 /tmp/foo) we can make sure the object has the right
> data (and the sparse-read operation that librbd is doing is the culprit).

I tried that, with the block name that the steps further below gave me:

rados -p rbd get rb.0.13.00000000045a block

When I looked into the block, it looked like a bunch of temp files from the 
portage system with padding in between, although it should be random data... I 
think I got the wrong block after all...

Here's what I did:
Run the iotester again:
testserver-rbd11 iotester # date ; ./iotester /var/iotest ; date                                                                                                                                                                 
Tue Jun 12 13:51:58 CEST 2012                                                                                                               
Wrote 100 MiB of data in 2004 milliseconds                                                                                                  
[snip lots of irrelevant lines]
Wrote 100 MiB of data in 2537 milliseconds
Read 100 MiB of data in 3794 milliseconds
Read 100 MiB of data in 10150 milliseconds
Digest wrong for file "/var/iotest/4299a48eca63c75d6773bec3565190aa3b33c46e"
Tue Jun 12 13:55:00 CEST 2012

Run the fiemap tool on that file:

testserver-rbd11 ~ # ./fiemap 
/var/iotest/4299a48eca63c75d6773bec3565190aa3b33c46e
File /var/iotest/4299a48eca63c75d6773bec3565190aa3b33c46e has 1 extents:
#       Logical          Physical         Length           Flags
0:      0000000000000000 0000000116900000 0000000000100000 0001

> As for the log:
> 
> First, map the offset to an rbd block.  For example, taking the 'Physical'
> value of 00000000a8200000 from above:
> 
> $ printf "%012x\n" $((0x00000000a8200000 / (4096*1024) ))
> 0000000002a0

That gave me

 $ printf "%012x\n" $((0x0000000116900000 / (4096*1024) ))
00000000045a
 
> Then figure out what the object name prefix is:
> 
> $ rbd info <imagename> | grep prefix
>         block_name_prefix: rb.0.1

Result: block_name_prefix: rb.0.13

> Then add the block number, 0000000002a0 to that, e.g. rb.0.1.0000000002a0.

Result: rb.0.13.00000000045a

> Then map that back to an osd with
> 
> $ ceph osd map rbd rb.0.1.0000000002a0
> osdmap e19 pool 'rbd' (2) object 'rb.0.1.0000000002a0' -> pg 2.a2e06f65
> (2.5) -> up [0,2] acting [0,2]

That gives me
[root@storage1 ~]# ceph osd map rbd rb.0.13.00000000045a 2> /dev/null 
osdmap e101 pool 'rbd' (2) object 'rb.0.13.00000000045a' -> pg 2.80b039fb 
(2.7b) -> up [2,1] acting [2,1]
 
> You'll see the osd ids listed in brackets after 'active'.  We want the
> first one, 0 in my example.  The log from that OSD is what we need.

Okay, i'm attaching the compressed log for osd.2 and the compressed block to 
the issue report in the redmine.

	Guido
