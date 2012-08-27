From: Sage Weil <sage@inktank.com>
Subject: Re: Transforming a bufferlist iterator into new bufferlist
Date: Mon, 27 Aug 2012 14:01:48 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1208271401230.29719@cobra.newdream.net>
References: <CAPrxi590uJZWYpcWb-uhNucH57_AcSEepbGi-0M9o5zQPf=ZvQ@mail.gmail.com> <alpine.DEB.2.00.1208271300200.29719@cobra.newdream.net> <CAPYLRzin2A-0G=28=perU6m0WtA2ihwTonXxTrSYyRt+O0WbyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49754 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754639Ab2H0VBt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Aug 2012 17:01:49 -0400
In-Reply-To: <CAPYLRzin2A-0G=28=perU6m0WtA2ihwTonXxTrSYyRt+O0WbyA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Noah Watkins <jayhawk@cs.ucsc.edu>, ceph-devel <ceph-devel@vger.kernel.org>


On Mon, 27 Aug 2012, Gregory Farnum wrote:

> On Mon, Aug 27, 2012 at 1:01 PM, Sage Weil <sage@inktank.com> wrote:
> > On Mon, 27 Aug 2012, Noah Watkins wrote:
> >> I have a bufferlist use case that I can't quite resolve. I'm packing
> >> up a struct and a blob, but not sure how to seek to the beginning of
> >> the blob correctly during decode:
> >>
> >> 1. Setup bufferlist
> >>
> >>   /* add header */
> >>   struct header hdr;
> >>   ::encode(hdr, bl);
> >>
> >>   /* add payload blob */
> >>   bl.append(buf, len);
> >
> > Instead, do
> >
> > bufferlist b;
> > b.append(buf, len);
> > ::encode(b, bl);
> >
> > that'll include a length in front of it...
> >
> >
> >> 2. Later in decode ...
> >>
> >>   /* get header */
> >>   bufferlist::iterator it = in.begin();
> >>   ::decode(hdr, it);
> >>
> >>   **problem: Want to get a bufferlist for the payload, which is
> >> presumably exactly where the iterator now points. How should that
> >> transformation happen with zero-copy?
> >
> > and then
> >
> > bufferlist b;
> > ::decode(b, it);
> >
> > will get it back.
> 
> Does that maintain zero-copy semantics? (It could; I just wasn't aware
> that we'd special-cased bufferlist decodes enough to do so.)

It does.  This basic approach is used all over the place.  You really have 
to go out of your way to make bufferlists copy data.
