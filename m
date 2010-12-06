From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: Odd "data used" reporting behavior by ceph -w
Date: Mon, 6 Dec 2010 16:30:29 -0700
Message-ID: <1291678229.4879.342.camel@sale659.sandia.gov>
References: <1291412399.4879.288.camel@sale659.sandia.gov>
 <AANLkTi=3fJz8aoywUCMzBrOWtENfaqEJ__76PXHrmppQ@mail.gmail.com>
 <1291418749.4879.319.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1012042048060.28007@cobra.newdream.net>
 <1291677248.4879.334.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1012061524210.23275@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:45710 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752625Ab0LFXak (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Dec 2010 18:30:40 -0500
In-Reply-To: <Pine.LNX.4.64.1012061524210.23275@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Gregory Farnum <gregf@hq.newdream.net>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


On Mon, 2010-12-06 at 16:26 -0700, Sage Weil wrote:
> On Mon, 6 Dec 2010, Jim Schutt wrote:
> > Hi Sage,
> > 
> > On Sat, 2010-12-04 at 21:59 -0700, Sage Weil wrote:
> > > > 
> > > > Also, a possibly related behavior I've noticed is that
> > > > an 'ls' on a directory where I'm writing files
> > > > does not return until all the writers are finished.
> > > > 
> > > > I realize it's likely related to caps, but
> > > > I'm hoping that can be fixed up somehow?
> > > 
> > > It depends.  If the clients "wrote" that data into the buffer cache and 
> > > it's just taking a long time to flush it out, then things are working as 
> > > intended (given current locking state machine).  That can be improved, but 
> > > hasn't been a priority (see #541).  If the dd's are still writing and they 
> > > don't stop, something is wrong, either on the mds or kclient.
> > > 
> > 
> > So here's the results from a couple trials.  In the
> > below results, "do_pdd" is a simple wrapper around
> > "pdsh -w <clients> dd" that computes aggregate
> > results.
> > 
> > In one window I launch the parallel dd commands;
> > in another window, on a client of my filesystem,
> > I do the ls.
> 
> Can you retry it with 'ls -f' and 'ls -al'?  What I think is going on is 
> the default ls options also stat files to get a file mode and colorize, 
> and that's going slow.  It should be happening on the client, 
> file-by-file.  Either there is something broken that's blocking entirely, 
> or it's just slow enough per-file to do that that you don't make it 
> through before it's done.
> 
> 'ls -f' avoids statting files.  If that's fast it means there is no 
> problem with the readdir part of things.  'ls -al' output will tell us if 
> the stats are making slow progress or no progress.

Here we are:

---- window 1 ----
Mon Dec  6 16:26:25 MST 2010

On 64 clients:
  dd conv=fdatasync if=/dev/zero of=/mnt/ceph/zero.`hostname -s` bs=4k count=16k

Elapsed time:   41.09 seconds
Total data:     4294.967 MB (4096 MiB)
Aggregate rate: 104.526 MB/s
Mon Dec  6 16:27:06 MST 2010

---- window 2 ----
$ date;ls -f /mnt/ceph;date; ls -al /mnt/ceph;date
Mon Dec  6 16:26:32 MST 2010
.            zero.an1008  zero.an1018  zero.an356  zero.an366  zero.an376  zero.an994
..           zero.an1009  zero.an1019  zero.an357  zero.an367  zero.an377  zero.an995
zero.an1000  zero.an1010  zero.an1020  zero.an358  zero.an368  zero.an378  zero.an996
zero.an1001  zero.an1011  zero.an1021  zero.an359  zero.an369  zero.an379  zero.an997
zero.an1002  zero.an1012  zero.an1022  zero.an360  zero.an370  zero.an380  zero.an998
zero.an1003  zero.an1013  zero.an1023  zero.an361  zero.an371  zero.an381  zero.an999
zero.an1004  zero.an1014  zero.an1024  zero.an362  zero.an372  zero.an382
zero.an1005  zero.an1015  zero.an353   zero.an363  zero.an373  zero.an383
zero.an1006  zero.an1016  zero.an354   zero.an364  zero.an374  zero.an384
zero.an1007  zero.an1017  zero.an355   zero.an365  zero.an375  zero.an993
Mon Dec  6 16:26:32 MST 2010
total 3997696
drwxrwxrwt 1 root    root           0 Dec  6 15:52 .
drwxr-xr-x 7 root    root         220 Dec  6 08:46 ..
-rw-r--r-- 1 jaschut jaschut        0 Dec  6 16:26 zero.an1000
-rw-r--r-- 1 jaschut jaschut        0 Dec  6 16:26 zero.an1001
-rw-r--r-- 1 jaschut jaschut        0 Dec  6 16:26 zero.an1002
-rw-r--r-- 1 jaschut jaschut 67108864 Dec  6 16:26 zero.an1003
-rw-r--r-- 1 jaschut jaschut 67108864 Dec  6 16:26 zero.an1004
-rw-r--r-- 1 jaschut jaschut 67108864 Dec  6 16:26 zero.an1005
-rw-r--r-- 1 jaschut jaschut 67108864 Dec  6 16:26 zero.an1006
-rw-r--r-- 1 jaschut jaschut 67108864 Dec  6 16:26 zero.an1007
-rw-r--r-- 1 jaschut jaschut 67108864 Dec  6 16:26 zero.an1008
-rw-r--r-- 1 jaschut jaschut 67108864 Dec  6 16:26 zero.an1009
-rw-r--r-- 1 jaschut jaschut 67108864 Dec  6 16:26 zero.an1010
-rw-r--r-- 1 jaschut jaschut 67108864 Dec  6 16:26 zero.an1011
-rw-r--r-- 1 jaschut jaschut 67108864 Dec  6 16:26 zero.an1012
-rw-r--r-- 1 jaschut jaschut 67108864 Dec  6 16:26 zero.an1013
-rw-r--r-- 1 jaschut jaschut 67108864 Dec  6 16:26 zero.an1014
-rw-r--r-- 1 jaschut jaschut 67108864 Dec  6 16:26 zero.an1015
-rw-r--r-- 1 jaschut jaschut 67108864 Dec  6 16:26 zero.an1016
-rw-r--r-- 1 jaschut jaschut 67108864 Dec  6 16:26 zero.an1017
-rw-r--r-- 1 jaschut jaschut 67108864 Dec  6 16:26 zero.an1018
-rw-r--r-- 1 jaschut jaschut 67108864 Dec  6 16:26 zero.an1019
-rw-r--r-- 1 jaschut jaschut 67108864 Dec  6 16:26 zero.an1020
-rw-r--r-- 1 jaschut jaschut 67108864 Dec  6 16:26 zero.an1021
-rw-r--r-- 1 jaschut jaschut 67108864 Dec  6 16:26 zero.an1022
-rw-r--r-- 1 jaschut jaschut 67108864 Dec  6 16:26 zero.an1023
-rw-r--r-- 1 jaschut jaschut 67108864 Dec  6 16:26 zero.an1024
-rw-r--r-- 1 jaschut jaschut 67108864 Dec  6 16:26 zero.an353
-rw-r--r-- 1 jaschut jaschut 67108864 Dec  6 16:26 zero.an354
-rw-r--r-- 1 jaschut jaschut 67108864 Dec  6 16:26 zero.an355
-rw-r--r-- 1 jaschut jaschut 67108864 Dec  6 16:26 zero.an356
-rw-r--r-- 1 jaschut jaschut 67108864 Dec  6 16:26 zero.an357
-rw-r--r-- 1 jaschut jaschut 67108864 Dec  6 16:26 zero.an358
-rw-r--r-- 1 jaschut jaschut 67108864 Dec  6 16:26 zero.an359
-rw-r--r-- 1 jaschut jaschut 67108864 Dec  6 16:26 zero.an360
-rw-r--r-- 1 jaschut jaschut 67108864 Dec  6 16:26 zero.an361
-rw-r--r-- 1 jaschut jaschut 67108864 Dec  6 16:26 zero.an362
-rw-r--r-- 1 jaschut jaschut 67108864 Dec  6 16:26 zero.an363
-rw-r--r-- 1 jaschut jaschut 67108864 Dec  6 16:26 zero.an364
-rw-r--r-- 1 jaschut jaschut 67108864 Dec  6 16:26 zero.an365
-rw-r--r-- 1 jaschut jaschut 67108864 Dec  6 16:26 zero.an366
-rw-r--r-- 1 jaschut jaschut 67108864 Dec  6 16:26 zero.an367
-rw-r--r-- 1 jaschut jaschut 67108864 Dec  6 16:26 zero.an368
-rw-r--r-- 1 jaschut jaschut 67108864 Dec  6 16:26 zero.an369
-rw-r--r-- 1 jaschut jaschut 67108864 Dec  6 16:26 zero.an370
-rw-r--r-- 1 jaschut jaschut 67108864 Dec  6 16:26 zero.an371
-rw-r--r-- 1 jaschut jaschut 67108864 Dec  6 16:26 zero.an372
-rw-r--r-- 1 jaschut jaschut 67108864 Dec  6 16:26 zero.an373
-rw-r--r-- 1 jaschut jaschut 67108864 Dec  6 16:26 zero.an374
-rw-r--r-- 1 jaschut jaschut 67108864 Dec  6 16:26 zero.an375
-rw-r--r-- 1 jaschut jaschut 67108864 Dec  6 16:26 zero.an376
-rw-r--r-- 1 jaschut jaschut 67108864 Dec  6 16:26 zero.an377
-rw-r--r-- 1 jaschut jaschut 67108864 Dec  6 16:26 zero.an378
-rw-r--r-- 1 jaschut jaschut 67108864 Dec  6 16:26 zero.an379
-rw-r--r-- 1 jaschut jaschut 67108864 Dec  6 16:26 zero.an380
-rw-r--r-- 1 jaschut jaschut 67108864 Dec  6 16:26 zero.an381
-rw-r--r-- 1 jaschut jaschut 67108864 Dec  6 16:26 zero.an382
-rw-r--r-- 1 jaschut jaschut 67108864 Dec  6 16:26 zero.an383
-rw-r--r-- 1 jaschut jaschut 67108864 Dec  6 16:26 zero.an384
-rw-r--r-- 1 jaschut jaschut 67108864 Dec  6 16:26 zero.an993
-rw-r--r-- 1 jaschut jaschut 67108864 Dec  6 16:26 zero.an994
-rw-r--r-- 1 jaschut jaschut 67108864 Dec  6 16:26 zero.an995
-rw-r--r-- 1 jaschut jaschut 67108864 Dec  6 16:26 zero.an996
-rw-r--r-- 1 jaschut jaschut 67108864 Dec  6 16:26 zero.an997
-rw-r--r-- 1 jaschut jaschut 67108864 Dec  6 16:26 zero.an998
-rw-r--r-- 1 jaschut jaschut 67108864 Dec  6 16:26 zero.an999
Mon Dec  6 16:27:11 MST 2010


There was no output from ls -al until the dd commands finished.
Also, note above the size of zero.an1000, zero.an1001,
zero.an1002.

"ls -al /mnt/ceph" a few seconds later showed their correct size.

-- Jim
> 
> Thanks!
> sage
> 


