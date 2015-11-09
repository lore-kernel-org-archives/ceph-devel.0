From: Sage Weil <sweil@redhat.com>
Subject: Re: ceph encoding optimization
Date: Mon, 9 Nov 2015 07:24:12 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1511090719050.27153@cobra.newdream.net>
References: <CANE=7sURCs6VHCGAYMjXr2LMD7E6CfwqWkjYQopCOaQ-OzW65g@mail.gmail.com> <CAJ4mKGYeEHiVL+6V0BQFq4bcZU1nP9Q0YAd2_OkiP8ZR9h+9Jw@mail.gmail.com> <CANE=7sVGYGX1fPoHETWnXCBDtGEB2DivQVowor77CEKVtXH1Ew@mail.gmail.com> <34ee94ce6bc34f318148d87490880bb3@R01UKEXCASM111.r01.fujitsu.local>
 <CACJqLyYOcRNa4xXj5FDB74XVtBZwN_TqoNzMXBdZV7HJB2DC3w@mail.gmail.com> <CACJqLyZdBw_xVoXUfqoKYdrQj3606EWBRowzDdyP0DqWLG7KZg@mail.gmail.com> <alpine.DEB.2.00.1511080627300.27153@cobra.newdream.net>
 <CAJ4mKGbGSz_G-A=uEDSxSZrREWYu2CnoHMCjVS8tDW_Yd3HKXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44500 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751302AbbKIPYT (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 9 Nov 2015 10:24:19 -0500
In-Reply-To: <CAJ4mKGbGSz_G-A=uEDSxSZrREWYu2CnoHMCjVS8tDW_Yd3HKXg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Dan Mick <dmick@redhat.com>, Haomai Wang <haomai@xsky.com>, "Piotr.Dalek@ts.fujitsu.com" <Piotr.Dalek@ts.fujitsu.com>, =?GB2312?B?s9jQxdTz?= <xmdxcxz@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, 9 Nov 2015, Gregory Farnum wrote:
> On Wed, Nov 4, 2015 at 7:07 AM, Gregory Farnum <gfarnum@redhat.com> wrote:
> > The problem with this approach is that the encoded versions need to be
> > platform-independent ? they are shared over the wire and written to
> > disks that might get transplanted to different machines. Apart from
> > padding bytes, we also need to worry about endianness of the machine,
> > etc. *And* we often mutate structures across versions in order to add
> > new abilities, relying on the encode-decode process to deal with any
> > changes to the system. How could we deal with that if just dumping the
> > raw memory?
> >
> > Now, maybe we could make these changes on some carefully-selected
> > structs, I'm not sure. But we'd need a way to pick them out, guarantee
> > that we aren't breaking interoperability concerns, etc; and it would
> > need to be something we can maintain as a group going forward. I'm not
> > sure how to satisfy those constraints without burning a little extra
> > CPU. :/
> > -Greg
> 
> So it turns out we've actually had issues with this. Sage merged
> (wrote?) some little-endian-only optimizations to the cephx code that
> broke big-endian systems by doing a direct memcpy. Apparently our
> tests don't find these issues, which makes me even more nervous about
> taking that sort of optimization into the tree. :(

I think the way to make this maintainable will be to

1) Find a clean approach with a simple #if or #ifdef condition for 
little endian and/or architectures that can handle unaligned int pointer 
access.

2) Maintain the parallel optimized implementation next to the generic 
encode/decode in a way that makes it as easy as possible to make changes 
and keep them in sync.

3) Optimize *only* the most recent encoding to minimize complexity.

4) Ensure that there is a set of encode/decode tests that verify they both 
work, triggered by make check (so that a simple make check on a big 
endian box will catch errors).  Ideally this'd be part of the 
test/encoding/readable.sh so that we run it over the entire corpus of old 
encodings..


sage
