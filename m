From: Sage Weil <sage@newdream.net>
Subject: Re: write operations
Date: Sat, 23 Jul 2011 14:48:50 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1107231440211.15589@cobra.newdream.net>
References: <CAJMJAuM74+eod5PMKC_VowxwAMyutbKJr0oY8xX2ELFAybZk5w@mail.gmail.com>
 <Pine.LNX.4.64.1107230728180.30052@cobra.newdream.net>
 <CAJMJAuOFXpUq92a6hLzhBrdUG4q2_wuR-iz4eab=hdtf3yKStg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50305 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751297Ab1GWVpF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 23 Jul 2011 17:45:05 -0400
In-Reply-To: <CAJMJAuOFXpUq92a6hLzhBrdUG4q2_wuR-iz4eab=hdtf3yKStg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Bill Hastings <bllhastings@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Sat, 23 Jul 2011, Bill Hastings wrote:
> Let us say I have a random write workload. I want to write 100 blocks to
> block X on replicas A, B and C. Let's assume that in replica C I wrote only
> 99 bytes and the replica crashes. How does it is correct itself?

The writes are applied atomically.  Any given replica will either apply 
the complete write or not.  Whether the write prevails depends on whether 
at least one replica survives long enough without crashing to apply it.  
Even then it is usually moot, since the client will retry until the write 
is ACKed, which doesn't happen until all replicas apply.  But if 
_everyone_ (osds and client) crashes, you either get the full write or 
nothing.
 
> Also you mention you stripe at 4MB chunks and HDFS by default at 64 MB. Do
> you also have the notion of block reports as in HDFS?

There are no block reports in Ceph (<insert snarky remark about HDFS and 
GFS architecture here>).  The closest thing would be the pg stat reports, 
which is a summary of basic PG information (object, byte counts) and osd 
utilization (statfs(2) results) periodically sent to the monitors.  
Instead of reporting hundreds of thousands of blocks, however, Ceph OSDs 
usually have on the order of 100 PGs, so this is a few KB at most.

sage


> 
> Thanks
> Bill.
> 
> On Sat, Jul 23, 2011 at 7:30 AM, Sage Weil <sage@newdream.net> wrote:
> 
> > On Sat, 23 Jul 2011, Bill Hastings wrote:
> > > Hi Sage
> > >
> > > Sorry to send this to you directly. All attempts to send emails to
> > > ceph-devel@vger.kernel.org are failing for me. Here is my questions:
> >
> > vger throws out all HTML email.  Make sure you send in plaintext.
> >
> > > How do writes work in Ceph? If I open a file and write say 255 bytes say
> > > intervals of 10 secs 1000 times. Are small amounts of data cached and
> > then
> > > pushed out to the server? I want to know the flow of the write operation
> > > through the system.
> >
> > The page cache will normally absorb this and write out large chunks. This
> > is governed by the Linux VM, and behavior will be more or less identical
> > to any other file system (ext3, NFS, etc.).
> >
> > > If I am doing a large streaming write are writes chunked the way they are
> > in
> > > HDFS for instance?
> >
> > Ceph (by default) stripes files over 4MB objects.  The default policy is
> > configurable on a per-directory or per-file basis.
> >
> > sage
> >
> 
