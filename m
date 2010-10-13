From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: OOM's on the Ceph client machine
Date: Tue, 12 Oct 2010 19:30:48 -0700
Message-ID: <AANLkTi=U_RLy8Nd-yeTqK4gK1EWuZOk=8drg4K_Uwk3+@mail.gmail.com>
References: <E1P5pFk-0001oE-Mv@tytso-glaptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:55599 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752362Ab0JMCat convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Oct 2010 22:30:49 -0400
Received: by qyk2 with SMTP id 2so159181qyk.19
        for <ceph-devel@vger.kernel.org>; Tue, 12 Oct 2010 19:30:48 -0700 (PDT)
In-Reply-To: <E1P5pFk-0001oE-Mv@tytso-glaptop>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: ceph-devel@vger.kernel.org, mrubin@google.com

On Tue, Oct 12, 2010 at 5:31 PM, Theodore Ts'o <tytso@mit.edu> wrote:
> Hi there,
>
> I've recently been playing with Ceph on an evaluation basis, and foun=
d
> that I was able to fairly reliably induce an OOM kill on my the ceph
> client machine by using FFSB with the following configuration file (s=
ee
> attached, below).
Does this mean you're using cfuse rather than the kernel client?
=46USE performance in general is fairly disappointing and our cfuse is
probably not as fast as the kernel client even so, though I don't
think it should be *that* unhappy in most environments.

> I am using Ceph v0.21.3 plus a few commits that were on the testing
> branch as of late September (commit ID 569d96b). =A0The Ceph cluster
> contains 10 commodity servers with 5 disks configured for Ceph object
> storage on each server (plus a separate spindle for the journal files=
),
> so there are 5 instances of cosd on each OSD server. =A0The disks are
> formatted using ext4 in no-journal mode. =A0I am using 3 servers for =
the
> MDS and montioring daemons, with the MDS and monitoring daemons
> colocated these 3 servers. =A0The machines all have gigabit ethernet
> cards.
So you have 5 journals running on one spindle? This could be the cause
of your slightly low sequential write performance; in the current
default configuration writes have to go to the journal before going to
the main disk and with multiple OSDs on one journal spindle they could
be getting in each other's way.
Also, how much memory do you have on these machines?

> P.S. =A0In case people are curious, here are the results of the "boxa=
cle"
> (http://btrfs.boxacle.net) FFSB workloads that I ran. =A0The results =
are
> fairly stable, except very often the 8 thread random_write workload i=
s a
> little hard to reproduce because it very often OOM's. =A0I've never g=
otten
> a 32 thread random_write workload measurement, since it very reliably
> OOM's on my client machine.
>
> Do these results look reasonable to you? =A0I confess I'm a little
> disappointed with the sequential and random read numbers in particula=
r.
> And given 10 servers and fifty spindles, even the large_file_create
> numbers seems surprising slow.
I'm not familiar with FFSB and there doesn't seem to be any
easily-accessible documentation, can you tell us a little more about
how it works? For instance, how are the test files created (are they
written out for the reads and then tested? Does the random write
create the files as it goes, or are they pre-existing and then
overwritten)?
A few thoughts/wild guesses:
I'm not sure exactly what the limit is, but 114MB/s reads are close to
what you can get over a 1Gb link.
If single-threaded FFSB means there's only one request in-flight at a
time there may be a latency issue which is causing those 35MB/s reads.
The kernel client ought to be prefetching but maybe it's not doing so
properly, and I don't recall how much prefetching cfuse is actually
capable of. Sage can say more on this.

> (Also, given the we are using gigabit ethernet in this evaluation
> cluster, the 1GB/sec seems ridiculously high, which suggests to me th=
at
> the fsync request wasn't honored -- FFSB includes the fsync time when
> calculating write bandwidth -- and it may explain why we are OOM'ing =
in
> the random_write workload.)
Err, yes. Extremely odd. In glancing over cfuse this looks like it's
working properly, but if you confirm that's what you're using I'll
trace it.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
