From: Jeff Plaisance <jeffplaisance@gmail.com>
Subject: Re: Transforming a bufferlist iterator into new bufferlist
Date: Mon, 27 Aug 2012 16:11:43 -0500
Message-ID: <CAGeO36duo7D8uiWz7Ma=dBgoxEuxySv+fqC0mKsqVNLbEHENYw@mail.gmail.com>
References: <CAPrxi590uJZWYpcWb-uhNucH57_AcSEepbGi-0M9o5zQPf=ZvQ@mail.gmail.com>
	<alpine.DEB.2.00.1208271300200.29719@cobra.newdream.net>
	<CAPYLRzin2A-0G=28=perU6m0WtA2ihwTonXxTrSYyRt+O0WbyA@mail.gmail.com>
	<alpine.DEB.2.00.1208271401230.29719@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:37515 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754218Ab2H0VLo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Aug 2012 17:11:44 -0400
Received: by pbbrr13 with SMTP id rr13so8105808pbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 27 Aug 2012 14:11:44 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1208271401230.29719@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Gregory Farnum <greg@inktank.com>, Noah Watkins <jayhawk@cs.ucsc.edu>, ceph-devel <ceph-devel@vger.kernel.org>

Are there plans to document bufferlist?  One of the hardest parts of
figuring out how to use libradospp for me was figuring out bufferlist.

On Mon, Aug 27, 2012 at 4:01 PM, Sage Weil <sage@inktank.com> wrote:
>
> On Mon, 27 Aug 2012, Gregory Farnum wrote:
>
>> On Mon, Aug 27, 2012 at 1:01 PM, Sage Weil <sage@inktank.com> wrote:
>> > On Mon, 27 Aug 2012, Noah Watkins wrote:
>> >> I have a bufferlist use case that I can't quite resolve. I'm packing
>> >> up a struct and a blob, but not sure how to seek to the beginning of
>> >> the blob correctly during decode:
>> >>
>> >> 1. Setup bufferlist
>> >>
>> >>   /* add header */
>> >>   struct header hdr;
>> >>   ::encode(hdr, bl);
>> >>
>> >>   /* add payload blob */
>> >>   bl.append(buf, len);
>> >
>> > Instead, do
>> >
>> > bufferlist b;
>> > b.append(buf, len);
>> > ::encode(b, bl);
>> >
>> > that'll include a length in front of it...
>> >
>> >
>> >> 2. Later in decode ...
>> >>
>> >>   /* get header */
>> >>   bufferlist::iterator it = in.begin();
>> >>   ::decode(hdr, it);
>> >>
>> >>   **problem: Want to get a bufferlist for the payload, which is
>> >> presumably exactly where the iterator now points. How should that
>> >> transformation happen with zero-copy?
>> >
>> > and then
>> >
>> > bufferlist b;
>> > ::decode(b, it);
>> >
>> > will get it back.
>>
>> Does that maintain zero-copy semantics? (It could; I just wasn't aware
>> that we'd special-cased bufferlist decodes enough to do so.)
>
> It does.  This basic approach is used all over the place.  You really have
> to go out of your way to make bufferlists copy data.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
