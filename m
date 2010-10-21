From: Ted Ts'o <tytso@mit.edu>
Subject: Re: OOM's on the Ceph client machine
Date: Thu, 21 Oct 2010 16:36:48 -0400
Message-ID: <20101021203648.GH3127@thunk.org>
References: <E1P5pFk-0001oE-Mv@tytso-glaptop>
 <AANLkTi=U_RLy8Nd-yeTqK4gK1EWuZOk=8drg4K_Uwk3+@mail.gmail.com>
 <20101013033406.GD4833@thunk.org>
 <Pine.LNX.4.64.1010130917210.7988@cobra.newdream.net>
 <20101014000306.GB11103@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from thunk.org ([69.25.196.29]:39903 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756254Ab0JUUg4 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 21 Oct 2010 16:36:56 -0400
Content-Disposition: inline
In-Reply-To: <20101014000306.GB11103@thunk.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Gregory Farnum <gregf@hq.newdream.net>, ceph-devel@vger.kernel.org, mrubin@google.com

On Wed, Oct 13, 2010 at 08:03:06PM -0400, Ted Ts'o wrote:
> On Wed, Oct 13, 2010 at 10:29:43AM -0700, Sage Weil wrote:
> > There have been a number of memory leak fixes since then, at least one of 
> > which may be causing your problem (it was caused by an uninitialized 
> > variable and didn't usually trigger for us, but may in your environment).  
> > Can you retry with the latest mainline?  The benchmark completes without 
> > problems in my test environment.
> 
> Sure.  This may have to wait until early next week for me to retry
> with the latest mainline, but I'll definitely move to 2.6.36 in the
> near future.

Just to give you an update.  I've tried to use 2.6.34 with nearly all
of the commits that apply to fs/ceph between 2.6.34 and 2.6.36-rc7
both with the 0.21 version of Ceph servers, as well as 0.22 plus some
testing bug fixes (up to fd42c852).  In both cases, using newer Ceph
client causes the FFSB process to hang when it tries running the sync
command.  The dmesg is filled with lines like this:

[ 4756.662789] ceph: skipping osd40 192.168.11.8:6808 seq 2495, expected 2496
[ 4756.662832] ceph: skipping osd7 192.168.12.18:6800 seq 4274, expected 4275
[ 4756.662843] ceph: skipping osd14 192.168.12.15:6802 seq 4124, expected 4125
[ 4756.662853] ceph: skipping osd38 192.168.11.3:6806 seq 3289, expected 3290
[ 4756.663093] ceph: skipping osd7 192.168.12.18:6800 seq 4275, expected 4276
[ 4756.882336] ceph: skipping osd7 192.168.12.18:6800 seq 4276, expected 4277
[ 4757.996962] ceph: skipping osd40 192.168.11.8:6808 seq 2496, expected 2497
[ 4757.997267] ceph: skipping osd7 192.168.12.18:6800 seq 4277, expected 4278
[ 4758.000149] ceph: skipping osd38 192.168.11.3:6806 seq 3290, expected 3291
[ 4758.003755] ceph: skipping osd14 192.168.12.15:6802 seq 4125, expected 4126
[ 4758.018078] ceph: skipping osd14 192.168.12.15:6802 seq 4126, expected 4127
[ 4758.018787] ceph: skipping osd7 192.168.12.18:6800 seq 4278, expected 4279
[ 4758.020263] ceph: skipping osd40 192.168.11.8:6808 seq 2497, expected 2498
[ 4758.020370] ceph: skipping osd10 192.168.11.8:6802 seq 946, expected 947
[ 4761.670848] ceph:  tid 4422463 timed out on osd7, will reset osd
[ 4761.813068] ceph:  tid 4480042 timed out on osd40, will reset osd
[ 4761.956584] ceph:  tid 4487615 timed out on osd14, will reset osd
[ 4762.102343] ceph:  tid 4645028 timed out on osd38, will reset osd
[ 4762.249425] ceph: skipping osd10 192.168.11.8:6802 seq 947, expected 948
[ 4767.257944] ceph: skipping osd10 192.168.11.8:6802 seq 948, expected 949
[ 4768.047058] ceph: skipping osd10 192.168.11.8:6802 seq 949, expected 950
[ 4772.260309] ceph:  tid 4817033 timed out on osd10, will reset osd

It's very possible (likely, even) that this was caused by my backwards
porting of the various ceph patches to 2.6.34.  Hopefully later today
I'll be able to do an actual test run using 2.6.36, without needing to
use "git cherry-pick" on some 170 odd patches.  For a variety of
reasons it was easier for me to use 2.6.34 as a base (drivers, patches
that support dmesg dumps over the network after kernel panic/oops, and
other stuff needed for our environment) but I should be able to move
to 2.6.36 soon.

I also ran into strange problems (which I haven't tried to
characterize accurately enough for a bug report) when using the 2.6.34
client against the new 0.22 release.  Is this expected to work?  If
so, I can try to more accurately characterize what was going on.  

Also, It seems that there are issues moving back and forth between
0.21 and 0.22 without reformating the ceph client.  Is that accurate?
It looked like when I tried going back to 0.21, I needed to rerun
mkcephfs, or else the 0.21 cmon, cosd or cmds daemons would die with
various failures when they saw that 0.22 data files.  That's not
surprising, but it does make it a little harder for me to go back and
forth between 0.21 and 0.22 for the purpose of differential debugging.

If I can get something stable working with 0.22 against either the
2.6.34 or 2.6.36 Ceph client, I'll drop my efforts using 0.21.

Thanks, regards,

	      	      	       	    	    - Ted
