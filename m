From: Sage Weil <sage@newdream.net>
Subject: Re: Adding compression support for bluestore.
Date: Thu, 17 Mar 2016 11:33:38 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1603171123090.14377@cpach.fuggernut.com>
References: <56C1FCF3.4030505@mirantis.com> <CACJqLyb=X1i7tsYeKOEJRdJEEMBGvgW817eY5Bo9YBXDszUDmw@mail.gmail.com> <56C3BAA3.3070804@mirantis.com> <CY1PR0201MB1897E7F1DE04B5E4577B16EDE8A00@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1602220718380.13988@cpach.fuggernut.com> <56CDF40C.9060405@mirantis.com> <CY1PR0201MB1897BC7052AD6F7FB01DCAB4E8A50@CY1PR0201MB1897.namprd02.prod.outlook.com> <56D08E30.20308@mirantis.com> <alpine.DEB.2.11.1603151243030.32086@cpach.fuggernut.com>
 <56E9A727.1030400@mirantis.com> <alpine.DEB.2.11.1603161515360.14377@cpach.fuggernut.com> <56EACAAD.90002@mirantis.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52919 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932675AbcCQPd4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Mar 2016 11:33:56 -0400
In-Reply-To: <56EACAAD.90002@mirantis.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Igor Fedotov <ifedotov@mirantis.com>
Cc: Allen Samuels <Allen.Samuels@sandisk.com>, ceph-devel <ceph-devel@vger.kernel.org>

> > > Just to clarify I understand the idea properly. Are you suggesting 
> > > to simply write out new block to a new extent and update block map 
> > > (and read procedure) to use that new extent or remains of the 
> > > overwritten extents depending on the read offset? And overwritten 
> > > extents are preserved intact until they are fully hidden or some 
> > > background cleanup procedure merge them.
> > > If so I can see following pros and cons:
> > > + write is faster
> > > - compressed data read is potentially slower as you might need to
> > > decompress more compressed blocks.
> > > - space usage is higher
> > > - need for garbage collector i.e. additional complexity

Yes.

> > > Thus the question is what use patterns are at foreground and should 
> > > be the most effective. IMO read performance and space saving are 
> > > more important for the cases where compression is needed.
> Any feedback on the above please!

I'd say "maybe".  It's easy to say we should focus on read performance 
now, but as soon as we have "support for compression" everybody is going 
to want to turn it on on all of their clusters to spend less money on hard 
disks.  That will definitely include RBD users, where write latency is 
very important.

I'm hesitant to take an architectural direction that locks us in.  With 
something layered over BlueStore I think we're forced to do it all in the 
initial phase; with the monolithic approach that integrates it into 
BlueStore's write path we have the option to do either one--perhaps based 
on the particular request or hints or whatever.

> > > > What do you think?
> > > > 
> > > > It would be nice to choose a simpler strategy for the first pass that
> > > > handles a subset of write patterns (i.e., sequential writes, possibly
> > > > unaligned) that is still a step in the direction of the more robust
> > > > strategy we expect to implement after that.
> > > > 
> > > I'd probably agree but.... I don't see a good way how one can implement
> > > compression for specific write patterns only.
> > > We need to either ensure that these patterns are used exclusively ( append
> > > only / sequential only flags? ) or provide some means to fall back to
> > > regular
> > > mode when inappropriate write occurs.
> > > Don't think both are good and/or easy enough.
> > Well, if we simply don't implement a garbage collector, then for
> > sequential+aligned writes we don't end up with stuff that needs garbage
> > collection.  Even the sequential case might be doable if we make it
> > possible to fill the extent with a sequence of compressed strings (as long
> > as we haven't reached the compressed length, try to restart the
> > decompression stream).
> It's still unclear to me if such specific patterns should be exclusively
> applied to the object. E.g. by using specific object creation mode mode.
> Or we should detect them automatically and be able to fall back to regular
> write ( i.e. disable compression )  when write doesn't conform to the
> supported pattern.

I think initially supporting only the append workload is a simple check 
for whether the offset == the object size (and maybe whether it is 
aligned).  No persistent flags or hints needed there.

> And I'm not following the idea about "a sequence of compressed strings". Could
> you please elaborate?

Let's say we have 32KB compressed_blocks, and the client is doing 1000 
byte appends.  We will allocate a 32 chunk on disk, and only fill it with 
say ~500 bytes of compressed data.  When the next write comes around, we 
could compress it too and append it to the block without decompressing the 
previous string.

By string I mean that each compression cycle looks something like

 start(...)
 while (more data)
   compress_some_stuff(...)
 finish(...)

i.e., there's a header and maybe a footer in the compressed string.  If we 
are decompressing and the decompressor says "done" but there is more data 
in our compressed block, we could repeat the process until we get to the 
end of the compressed data.

But it might not matter or be worth it.  If the compressed blocks are 
smallish then decompressing, appending, and recompressing isn't going to 
be that expensive anyway.  I'm mostly worried about small appends, e.g. by 
rbd mirroring (imaging 4 KB writes + some metadata) or the MDS journal.

sage
