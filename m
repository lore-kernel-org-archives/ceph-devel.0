From: Sage Weil <sage@newdream.net>
Subject: RE: bluestore onode encoding efficiency
Date: Thu, 16 Jun 2016 20:57:35 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1606162050170.27611@piezo.novalocal>
References: <alpine.DEB.2.11.1606151556380.26786@cpach.fuggernut.com> <alpine.DEB.2.11.1606161232490.1686@cpach.fuggernut.com> <BLUPR0201MB152456D7353D8195A04B3E7CE8560@BLUPR0201MB1524.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from batalion.com ([64.111.99.127]:44868 "EHLO localhost.localdomain"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753976AbcFPVEH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 16 Jun 2016 17:04:07 -0400
In-Reply-To: <BLUPR0201MB152456D7353D8195A04B3E7CE8560@BLUPR0201MB1524.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Allen Samuels <Allen.Samuels@sandisk.com>
Cc: Mark Nelson <mnelson@redhat.com>, Evgeniy Firsov <Evgeniy.Firsov@sandisk.com>, Jianjian Huo <jianjian.huo@samsung.com>, Somnath Roy <Somnath.Roy@sandisk.com>, Igor Fedotov <ifedotov@mirantis.com>, Manavalan Krishnan <Manavalan.Krishnan@sandisk.com>, Varada Kari <Varada.Kari@sandisk.com>, Ramesh Chander <Ramesh.Chander@sandisk.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, 16 Jun 2016, Allen Samuels wrote:
> > -----Original Message-----
> > From: Sage Weil [mailto:sage@newdream.net]
> > Sent: Thursday, June 16, 2016 9:47 AM
> > To: Allen Samuels <Allen.Samuels@sandisk.com>
> > Cc: Mark Nelson <mnelson@redhat.com>; Evgeniy Firsov
> > <Evgeniy.Firsov@sandisk.com>; Jianjian Huo <jianjian.huo@samsung.com>;
> > Somnath Roy <Somnath.Roy@sandisk.com>; Igor Fedotov
> > <ifedotov@mirantis.com>; Manavalan Krishnan
> > <Manavalan.Krishnan@sandisk.com>; Varada Kari
> > <Varada.Kari@sandisk.com>; Ramesh Chander
> > <Ramesh.Chander@sandisk.com>; ceph-devel@vger.kernel.org
> > Subject: Re: bluestore onode encoding efficiency
> > 
> > Based on some of Allen's comments I've updated my branch with (so far)
> > three different encoders:
> > 
> > 1) varint - general purpose small integers (lops off high and low zero
> > bits)
> > 
> >   first byte:
> >     low 2 bits = how many low nibbles of zeros
> >     5 bits = data
> >     1 high bit = another byte follows
> >   subsequent bytes:
> >     7 bits = data
> >     1 high bit = another byte follows
> > 
> > 2) delta varint
> > 
> >   first byte:
> >     1 low bit = sign (0 = positive, 1 = negative)
> >     low 2 bits = how many low nibbles of zeros
> >     4 bits = data
> >     1 high bit = another byte follows
> >   subsequent bytes:
> >     7 bits = data
> >     1 high bit = another byte follows
> > 
> > 3) raw lba:
> > 
> >   first 3 bytes:
> >     low 2 bits = how many low bits of zeros
> >       00 = none
> >       01 = 12 (4k alignment)
> >       10 = 16 (64k alignment)
> >       11 = 20 (256k alignment)
> >     21 bits = data
> >     1 high bit = another byte follows
> >   subsequent bytes:
> >     7 bits = data
> >     1 high bit = another byte follows
> 
> Let's do some math here :)
> 
> Let's say I want to optimize for 4, 8, 16 and 32 TB devices going 
> forward.
> 
> That's 2^42, 43, 44 and 45 respectively.
> 
> If assume a 4K blocksize/alignment, then we need 30, 31, 32 and 33 
> significant bits after downshifting for encoding.
> 
> That means for 30 bits I'll have 21 + 7 + 2 encoded bits which requires 
> 5 bytes for a 4TB device. However, 1/2 of the addresses only need 29 
> bits (and 1/4 need 28, etc.) So the approximate blended size is about 
> 4.75 Bytes for a 4TB (1/4 of the addresses can save a byte) And about 
> 4.875 Bytes for 8TB (1/8 of the addresses can save a byte). We won't 
> need another byte until we operate on 128TB devices.
> 
> If we switch to 64K alignment (reasonable for many HDD use-cases), then 
> the #'s change to be 26, 27, 28 and 29 respectively,
> 
> That's 21 + 5 for 4TB which gets encoded in 4 bytes. 8 and 16TB also 
> take 4Bytes, you need 32TB before you need 5Bytes.
> 
> If we change the encoding above so that the first chunk is 4 bytes 
> (easier to deal with :)) and leave everything alone, then we have 39 
> bits of mantissa Now for a 4KB align / 4TB device you only need 4.5 
> Bytes which is a savings of .25 Bytes, which will could easily be 
> significant when you have up to 1K phys addrs / oNode.

Yeah, I did my math wrong... I thought I was getting 3 bytes for ~1TB 
devices at 64K alignment.  Not that those drives are common even now 
anyway, though.  Moving to 4 bytes will be a faster encode/decode too.
 
> I could argue for a skew on the format encoding, i.e., 0x for 4K, 110 
> for 16K, 111 for byte align, ,etc. and gain another bit picking up a 
> further .5 bytes on a 4TB device.

The other nice thing about this is we get another options for dropping low 
bits:

 0* = 12 (4k)
 100* = byte align
 101* = 16 (64k)
 110* = 20 (256k)
 111* = 24 (1024k)

or perhaps go by 3's.

BTW, here's the first set of size cleanups.  It rips out unused fields, 
including the overlay stuff.  We can re-add it later if we decide it's a 
strategy worth pursuing.

	https://github.com/ceph/ceph/pull/9756

sage


> The 16-bit alignment case isn't materially affected by this.
> 
> In conclusion. I think -- at a minimum -- you should switch to a first 4 
> bytes (rather than a first 3 bytes) for this use case. It doesn't seem 
> to have any negative and there are significant positives.
> 
> A weaker case would be to switch the two bit encoding to something that 
> favored 4K (the likely most prevalent) alignment, picking up another bit 
> before a multi-byte encoding is needed.
> 
> > 
> > 4) lba delta (distance between two lba's, e.g., when encoding a list of
> > extents)
> > 
> >   first byte:
> >     1 low bit = sign (0 = positive, 1 = negative)
> >     2 bits = how many low bits of zeros
> >       00 = none
> >       01 = 12 (4k alignment)
> >       10 = 16 (64k alignment)
> >       11 = 20 (256k alignment)
> >     4 bits = data
> >     1 bit = another byte follows
> >   subsequent bytes:
> >     7 bits = data
> >     1 bit = another byte follows
> > 
> >   Notably on this one we have 4 bits of data *and* when we roll over to
> >   the next value you'll get 4 trailing 0's and we ask for one
> >   more nibble of trailing 0's... still in one encoded byte.
> > 
> > 
> > I think this'll be a decent set of building blocks to encoding the existing
> > structures efficiently (and still in a generic way) before getting specific with
> > common patterns.
> > 
> > 	https://github.com/ceph/ceph/pull/9728/files
> > 
> > sage
> > 
> > 
> > On Wed, 15 Jun 2016, Sage Weil wrote:
> > >
> > > If we have those, I'm not sure #1 will be worth it--the zeroed offset
> > > fields will encode with one byte.
> > >
> > > > (3) re-jiggering of blob/extents when possible. Much of the
> > > > two-level blob/extent map exists to support compression. When you're
> > > > not compressed you can collapse this into a single blob and avoid
> > > > the encoding overhead for it.
> > >
> > > Hmm, good idea.  As long as the csum parameters match we can do this.
> > > The existing function
> > >
> > > int bluestore_onode_t::compress_extent_map()
> > >
> > > currently just combines consecutive lextent's that point to contiguous
> > > regions in the same blob.  We could extend this to combine blobs that
> > > are combinable.
> > >
> > > > There are other potential optimizations too that are artifacts of
> > > > the current code. For example, we support different checksum
> > > > algorithms/values on a per-blob basis. Clearly moving this to a
> > > > per-oNode basis is acceptable and would simplify and shrink the
> > > > encoding even more.
> > >
> > > The latest csum branch
> > >
> > >         https://github.com/ceph/ceph/pull/9526
> > >
> > > varies csum_order on a per-blob basis (for example, larger csum chunks
> > > for compressed blobs and small csum chunks for uncompressed blobs with
> > > 4k overwrites).  The alg is probably consistent across the onode, but
> > > the will uglify the code a bit to pass it into the blob_t csum
> > > methods.  I'd prefer to hold off on this.  With the varint encoding
> > > above it'll only be one byte per blob at least.
> > >
> > > sage
> > >
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> > > in the body of a message to majordomo@vger.kernel.org More
> > majordomo
> > > info at  http://vger.kernel.org/majordomo-info.html
> > >
> > >
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
