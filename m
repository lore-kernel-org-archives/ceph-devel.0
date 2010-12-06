From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: Odd "data used" reporting behavior by ceph -w
Date: Mon, 6 Dec 2010 16:21:11 -0700
Message-ID: <1291677671.4879.337.camel@sale659.sandia.gov>
References: <1291412399.4879.288.camel@sale659.sandia.gov>
 <AANLkTi=3fJz8aoywUCMzBrOWtENfaqEJ__76PXHrmppQ@mail.gmail.com>
 <1291418749.4879.319.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1012042048060.28007@cobra.newdream.net>
 <1291677248.4879.334.camel@sale659.sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:48342 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751204Ab0LFXV2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Dec 2010 18:21:28 -0500
In-Reply-To: <1291677248.4879.334.camel@sale659.sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Gregory Farnum <gregf@hq.newdream.net>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


On Mon, 2010-12-06 at 16:14 -0700, Jim Schutt wrote:
> Hi Sage,
> 
> On Sat, 2010-12-04 at 21:59 -0700, Sage Weil wrote:
> > > 
> > > Also, a possibly related behavior I've noticed is that
> > > an 'ls' on a directory where I'm writing files
> > > does not return until all the writers are finished.
> > > 
> > > I realize it's likely related to caps, but
> > > I'm hoping that can be fixed up somehow?
> > 
> > It depends.  If the clients "wrote" that data into the buffer cache and 
> > it's just taking a long time to flush it out, then things are working as 
> > intended (given current locking state machine).  That can be improved, but 
> > hasn't been a priority (see #541).  If the dd's are still writing and they 
> > don't stop, something is wrong, either on the mds or kclient.
> > 
> 
> So here's the results from a couple trials.  In the
> below results, "do_pdd" is a simple wrapper around
> "pdsh -w <clients> dd" that computes aggregate
> results.
> 
> In one window I launch the parallel dd commands;
> in another window, on a client of my filesystem,
> I do the ls.
> 
> The date stamps are my attempt to show the ls
> doesn't generate any output until the dd commands
> have finished.
> 
> trial one:
> 
> ---- window 1 ----
> $ date; ./do_pdd write 16; date
> Mon Dec  6 16:05:18 MST 2010
> 
> On 64 clients:
>   dd conv=fdatasync if=/dev/zero of=/mnt/ceph/zero.`hostname -s` bs=4k count=16k
> 
> Elapsed time:   39.39 seconds
> Total data:     4294.967 MB (4096 MiB)
> Aggregate rate: 109.037 MB/s
> Mon Dec  6 16:05:57 MST 2010

So that's embarrassing; I did multiple trials, and
grabbed the output for the wrong one.  Here's the
one with the correct timestamps:

$ date; ./do_pdd write 16; date
Mon Dec  6 16:06:08 MST 2010

On 64 clients:
  dd conv=fdatasync if=/dev/zero of=/mnt/ceph/zero.`hostname -s` bs=4k
count=16k

Elapsed time:   37.03 seconds
Total data:     4294.967 MB (4096 MiB)
Aggregate rate: 115.986 MB/s
Mon Dec  6 16:06:45 MST 2010

> ---- window 2 ----
> $ date;ls /mnt/ceph;date
> Mon Dec  6 16:06:22 MST 2010
> zero.an1000  zero.an1010  zero.an1020  zero.an358  zero.an368  zero.an378  zero.an996
> zero.an1001  zero.an1011  zero.an1021  zero.an359  zero.an369  zero.an379  zero.an997
> zero.an1002  zero.an1012  zero.an1022  zero.an360  zero.an370  zero.an380  zero.an998
> zero.an1003  zero.an1013  zero.an1023  zero.an361  zero.an371  zero.an381  zero.an999
> zero.an1004  zero.an1014  zero.an1024  zero.an362  zero.an372  zero.an382
> zero.an1005  zero.an1015  zero.an353   zero.an363  zero.an373  zero.an383
> zero.an1006  zero.an1016  zero.an354   zero.an364  zero.an374  zero.an384
> zero.an1007  zero.an1017  zero.an355   zero.an365  zero.an375  zero.an993
> zero.an1008  zero.an1018  zero.an356   zero.an366  zero.an376  zero.an994
> zero.an1009  zero.an1019  zero.an357   zero.an367  zero.an377  zero.an995
> Mon Dec  6 16:06:46 MST 2010
> 
> 
> trial two:
> 
> ---- window 1 ----
> $ date; ./do_pdd write 16; date
> Mon Dec  6 16:07:01 MST 2010
> 
> On 64 clients:
>   dd conv=fdatasync if=/dev/zero of=/mnt/ceph/zero.`hostname -s` bs=4k count=16k
> 
> Elapsed time:   35.31 seconds
> Total data:     4294.967 MB (4096 MiB)
> Aggregate rate: 121.636 MB/s
> Mon Dec  6 16:07:36 MST 2010
> ---- window 2 ----
> $ date;ls /mnt/ceph;date
> Mon Dec  6 16:07:12 MST 2010
> zero.an1000  zero.an1010  zero.an1020  zero.an358  zero.an368  zero.an378  zero.an996
> zero.an1001  zero.an1011  zero.an1021  zero.an359  zero.an369  zero.an379  zero.an997
> zero.an1002  zero.an1012  zero.an1022  zero.an360  zero.an370  zero.an380  zero.an998
> zero.an1003  zero.an1013  zero.an1023  zero.an361  zero.an371  zero.an381  zero.an999
> zero.an1004  zero.an1014  zero.an1024  zero.an362  zero.an372  zero.an382
> zero.an1005  zero.an1015  zero.an353   zero.an363  zero.an373  zero.an383
> zero.an1006  zero.an1016  zero.an354   zero.an364  zero.an374  zero.an384
> zero.an1007  zero.an1017  zero.an355   zero.an365  zero.an375  zero.an993
> zero.an1008  zero.an1018  zero.an356   zero.an366  zero.an376  zero.an994
> zero.an1009  zero.an1019  zero.an357   zero.an367  zero.an377  zero.an995
> Mon Dec  6 16:07:36 MST 2010
> 
> 
> Thanks -- Jim
> 


