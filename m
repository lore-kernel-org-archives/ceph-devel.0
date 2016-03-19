From: Allen Samuels <Allen.Samuels@sandisk.com>
Subject: RE: Adding compression support for bluestore.
Date: Sat, 19 Mar 2016 03:14:23 +0000
Message-ID: <CY1PR0201MB189786CE50165A290D5B953EE88D0@CY1PR0201MB1897.namprd02.prod.outlook.com>
References: <56C1FCF3.4030505@mirantis.com>
 <CACJqLyb=X1i7tsYeKOEJRdJEEMBGvgW817eY5Bo9YBXDszUDmw@mail.gmail.com>
 <56C3BAA3.3070804@mirantis.com>
 <CY1PR0201MB1897E7F1DE04B5E4577B16EDE8A00@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1602220718380.13988@cpach.fuggernut.com>
 <56CDF40C.9060405@mirantis.com>
 <CY1PR0201MB1897BC7052AD6F7FB01DCAB4E8A50@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <56D08E30.20308@mirantis.com>
 <alpine.DEB.2.11.1603151243030.32086@cpach.fuggernut.com>
 <56E9A727.1030400@mirantis.com>
 <alpine.DEB.2.11.1603161515360.14377@cpach.fuggernut.com>
 <56EACAAD.90002@mirantis.com>
 <alpine.DEB.2.11.1603171123090.14377@cpach.fuggernut.com>
 <56EC248E.3060502@mirantis.com>
 <EC1BE61F68296D4A8CE45AD3DEDB99E21AEF6926@SSIEXCH-MB3.ssi.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bl2on0066.outbound.protection.outlook.com ([65.55.169.66]:38592
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754481AbcCSDO3 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Mar 2016 23:14:29 -0400
In-Reply-To: <EC1BE61F68296D4A8CE45AD3DEDB99E21AEF6926@SSIEXCH-MB3.ssi.samsung.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Vikas Sinha-SSI <v.sinha@ssi.samsung.com>, Igor Fedotov <ifedotov@mirantis.com>, Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

> -----Original Message-----
> From: Vikas Sinha-SSI [mailto:v.sinha@ssi.samsung.com]
> Sent: Friday, March 18, 2016 12:18 PM
> To: Igor Fedotov <ifedotov@mirantis.com>; Sage Weil
> <sage@newdream.net>
> Cc: Allen Samuels <Allen.Samuels@sandisk.com>; ceph-devel <ceph-
> devel@vger.kernel.org>
> Subject: RE: Adding compression support for bluestore.
> 
> Hi Igor,
> Thanks a lot for this. Do you also consider supporting offline compression (via
> a background task, or at least something not in the main IO path)? Will the
> current proposal allow this, and do you consider this to be a useful option at
> all? My concern is with the performance impact of compression, and
> obviously I don't know whether it will be significant. Obviously I'm also
> concerned about adding more complexity.
> I would love to know your thoughts on this.
> Thanks,
> Vikas

The revised extent map proposal that I sent earlier would directly support this capability. There's no reason that a policy of doing NO inline compression is implemented followed by a background (WAL based or even deep-scrub based) compression activity. This is yet another reason why separating policy from mechanism is important.

> 
> 
> > -----Original Message-----
> > From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> > owner@vger.kernel.org] On Behalf Of Igor Fedotov
> > Sent: Friday, March 18, 2016 8:54 AM
> > To: Sage Weil
> > Cc: Allen Samuels; ceph-devel
> > Subject: Re: Adding compression support for bluestore.
> >
> >
> >
> > On 17.03.2016 18:33, Sage Weil wrote:
> > > I'd say "maybe". It's easy to say we should focus on read
> > > performance now, but as soon as we have "support for compression"
> > > everybody is going to want to turn it on on all of their clusters to
> > > spend less money on hard disks. That will definitely include RBD
> > > users, where write latency is very important. I'm hesitant to take
> > > an architectural direction that locks us in. With something layered
> > > over BlueStore I think we're forced to do it all in the initial
> > > phase; with the monolithic approach that integrates it into
> > > BlueStore's write path we have the option to do either one--perhaps
> > > based on the particular request or hints or whatever.
> > >>>>> What do you think?
> > >>>>>
> > >>>>> It would be nice to choose a simpler strategy for the first pass
> > >>>>> that handles a subset of write patterns (i.e., sequential
> > >>>>> writes, possibly
> > >>>>> unaligned) that is still a step in the direction of the more
> > >>>>> robust strategy we expect to implement after that.
> > >>>>>
> > >>>> I'd probably agree but.... I don't see a good way how one can
> > implement
> > >>>> compression for specific write patterns only.
> > >>>> We need to either ensure that these patterns are used exclusively
> > ( append
> > >>>> only / sequential only flags? ) or provide some means to fall
> > >>>> back to regular mode when inappropriate write occurs.
> > >>>> Don't think both are good and/or easy enough.
> > >>> Well, if we simply don't implement a garbage collector, then for
> > >>> sequential+aligned writes we don't end up with stuff that needs
> > >>> sequential+garbage
> > >>> collection.  Even the sequential case might be doable if we make
> > >>> it possible to fill the extent with a sequence of compressed
> > >>> strings (as long as we haven't reached the compressed length, try
> > >>> to restart the decompression stream).
> > >> It's still unclear to me if such specific patterns should be
> > >> exclusively applied to the object. E.g. by using specific object creation
> mode mode.
> > >> Or we should detect them automatically and be able to fall back to
> > >> regular write ( i.e. disable compression )  when write doesn't
> > >> conform to the supported pattern.
> > > I think initially supporting only the append workload is a simple
> > > check for whether the offset == the object size (and maybe whether
> > > it is aligned).  No persistent flags or hints needed there.
> > Well, but issues appear immediately after some overwrite request takes
> > place.
> > How to handle overwrites? To do compression for the overwritten or not?
> > If not - we need some way to be able to merge compressed and
> > uncompressed blocks. And so on and so forth IMO it's hard (or even
> > impossible) to apply compression for specific write patterns only
> > unless you prohibit other ones.
> > We can support a subset of compression policies ( i.e. ways how we
> > resolve compression issues: RMW at init phase, lazy overwrite, WAL
> > use, etc ) but not a subset of write patterns.
> >
> > >> And I'm not following the idea about "a sequence of compressed
> strings".
> > Could
> > >> you please elaborate?
> > > Let's say we have 32KB compressed_blocks, and the client is doing
> > > 1000 byte appends.  We will allocate a 32 chunk on disk, and only
> > > fill it with say ~500 bytes of compressed data.  When the next write
> > > comes around,
> > we
> > > could compress it too and append it to the block without
> > > decompressing
> > the
> > > previous string.
> > >
> > > By string I mean that each compression cycle looks something like
> > >
> > >   start(...)
> > >   while (more data)
> > >     compress_some_stuff(...)
> > >   finish(...)
> > >
> > > i.e., there's a header and maybe a footer in the compressed string.
> > > If we are decompressing and the decompressor says "done" but there
> > > is more
> > data
> > > in our compressed block, we could repeat the process until we get to
> > > the end of the compressed data.
> > Got it, thanks for clarification
> > > But it might not matter or be worth it.  If the compressed blocks
> > > are smallish then decompressing, appending, and recompressing isn't
> > > going to be that expensive anyway.  I'm mostly worried about small
> appends, e.g.
> > by
> > > rbd mirroring (imaging 4 KB writes + some metadata) or the MDS journal.
> > That's mainly about small appends not small writes, right?
> >
> > At this point I agree with Allen that we need variable policies to
> > handle compression. Most probably we wouldn't be able to create single
> > one that fits perfect for any write pattern.
> > The only concern about that is the complexity of such a task...
> > > sage
> > Thanks,
> > Igor
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> > in the body of a message to majordomo@vger.kernel.org More
> majordomo
> > info at  http://vger.kernel.org/majordomo-info.html
