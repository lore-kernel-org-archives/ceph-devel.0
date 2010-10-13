From: Sage Weil <sage@newdream.net>
Subject: Re: OOM's on the Ceph client machine
Date: Wed, 13 Oct 2010 10:29:43 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1010130917210.7988@cobra.newdream.net>
References: <E1P5pFk-0001oE-Mv@tytso-glaptop>
 <AANLkTi=U_RLy8Nd-yeTqK4gK1EWuZOk=8drg4K_Uwk3+@mail.gmail.com>
 <20101013033406.GD4833@thunk.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53564 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486Ab0JMR1E (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Oct 2010 13:27:04 -0400
In-Reply-To: <20101013033406.GD4833@thunk.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ted Ts'o <tytso@mit.edu>
Cc: Gregory Farnum <gregf@hq.newdream.net>, ceph-devel@vger.kernel.org, mrubin@google.com

Hi Ted,

On Tue, 12 Oct 2010, Ted Ts'o wrote:
> On Tue, Oct 12, 2010 at 07:30:48PM -0700, Gregory Farnum wrote:
> > Does this mean you're using cfuse rather than the kernel client?
> > FUSE performance in general is fairly disappointing and our cfuse is
> > probably not as fast as the kernel client even so, though I don't
> > think it should be *that* unhappy in most environments.
> 
> No, I'm using the kernel client (from 2.6.34).  Specifically, I'm
> doing a "modprobe ceph; mount -t ceph 1.2.3.4:/ /mnt"
> 
> Sorry, I should have mentioned that.  I can use a more recent kernel
> (i.e., 2.6.36-rc7) if that's likely to help.

There have been a number of memory leak fixes since then, at least one of 
which may be causing your problem (it was caused by an uninitialized 
variable and didn't usually trigger for us, but may in your environment).  
Can you retry with the latest mainline?  The benchmark completes without 
problems in my test environment.

> > So you have 5 journals running on one spindle? This could be the cause
> > of your slightly low sequential write performance; in the current
> > default configuration writes have to go to the journal before going to
> > the main disk and with multiple OSDs on one journal spindle they could
> > be getting in each other's way.
> 
> Hmm, what do you recommend, then?  The problem is if the journal only
> needs to be a few gigabytes (I used a 5GB file), using an entire 1T or
> 2T disk just so each of the journals can have their own spindle is
> pretty wasteful.

If fsync on a single file in journal-less ext4 doesn't do any extra work, 
I would just put the (preallocated) journal file together with the data on 
each disk.  Usually that's bad news because of the journal flushing, but 
you shouldn't have that problem.  Alternatively, you could use a small 
separate partition on the same spindle.  

sage
