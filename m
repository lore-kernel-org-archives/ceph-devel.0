From: Ted Ts'o <tytso@mit.edu>
Subject: Re: OOM's on the Ceph client machine
Date: Tue, 12 Oct 2010 23:34:06 -0400
Message-ID: <20101013033406.GD4833@thunk.org>
References: <E1P5pFk-0001oE-Mv@tytso-glaptop>
 <AANLkTi=U_RLy8Nd-yeTqK4gK1EWuZOk=8drg4K_Uwk3+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from thunk.org ([69.25.196.29]:33721 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752585Ab0JMDeO (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 12 Oct 2010 23:34:14 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTi=U_RLy8Nd-yeTqK4gK1EWuZOk=8drg4K_Uwk3+@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>
Cc: ceph-devel@vger.kernel.org, mrubin@google.com

On Tue, Oct 12, 2010 at 07:30:48PM -0700, Gregory Farnum wrote:
> Does this mean you're using cfuse rather than the kernel client?
> FUSE performance in general is fairly disappointing and our cfuse is
> probably not as fast as the kernel client even so, though I don't
> think it should be *that* unhappy in most environments.

No, I'm using the kernel client (from 2.6.34).  Specifically, I'm
doing a "modprobe ceph; mount -t ceph 1.2.3.4:/ /mnt"

Sorry, I should have mentioned that.  I can use a more recent kernel
(i.e., 2.6.36-rc7) if that's likely to help.

> So you have 5 journals running on one spindle? This could be the cause
> of your slightly low sequential write performance; in the current
> default configuration writes have to go to the journal before going to
> the main disk and with multiple OSDs on one journal spindle they could
> be getting in each other's way.

Hmm, what do you recommend, then?  The problem is if the journal only
needs to be a few gigabytes (I used a 5GB file), using an entire 1T or
2T disk just so each of the journals can have their own spindle is
pretty wasteful.

> Also, how much memory do you have on these machines?

32GB

> I'm not familiar with FFSB and there doesn't seem to be any
> easily-accessible documentation, can you tell us a little more about
> how it works? For instance, how are the test files created (are they
> written out for the reads and then tested? Does the random write
> create the files as it goes, or are they pre-existing and then
> overwritten)?

There's a quicky explanation of these workloads at
http://btrfs.boxacle.net (I'm using the raid configuration FFSB
files), but essentially, the large file create test is creating 100MB
files as quickly as possible.  In the rest of the tests we create 1024
100MB files, and then try (a) reading from them sequentially as
quickly as possible, (b) picking a random file, and a random offset,
and read 5MB, and repeat, (c) picking a random file, and a random
offset, and write 5MB, and repeat.  The creation of the 1024 100MB
files (if necessary; the tests will reuse the previously created set
of 100MB files) is not counted in the benchmark time.  So in the last
three tests there is no block allocation; just the time it takes to
read or overwrite existing data blocks.

Note BTW that this is not intrinsic to FFSB; FFSB stands for the
"flexible filesystem benchmark" system.  All of this is configurable
using the ffsb config files.  I'm just reusing the "boxacle workloads"
just because they are convenient, and I'm familiar with how they work
on local disk filesystems.  They're used for example for benchmarking
ext4 here: http://free.linux.hp.com/~enw/ext4/2.6.35/, and for btrfs
here: http://btrfs.boxacle.net.  (And when the IBM folks have done
btrfs benchmarks, since they are so detailed and the
hardware/configurations are so well described, I've also used them to
help improve ext4's performance.)

> A few thoughts/wild guesses:
> I'm not sure exactly what the limit is, but 114MB/s reads are close to
> what you can get over a 1Gb link.
> If single-threaded FFSB means there's only one request in-flight at a
> time there may be a latency issue which is causing those 35MB/s reads.
> The kernel client ought to be prefetching but maybe it's not doing so
> properly, and I don't recall how much prefetching cfuse is actually
> capable of. Sage can say more on this.

I'm not using cfuse; I'm using the in-kernel Ceph module.  As far as
network latency is concerned, ping RTT time is under 0.25ms.

And sure maybe it's a prefetching issue --- but in that case I would
have expected 8 thread would have had better than 2x the 1 thread case.

     	      	       	     	      	     - Ted
