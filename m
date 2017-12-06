From: myoungwon oh <ohmyoungwon@gmail.com>
Subject: Re: Could you resend the link to the pull request?
Date: Wed, 6 Dec 2017 10:16:17 +0900
Message-ID: <CAFNt83Ys9q9HYkAbFre6dESQW44yf8+Wemf3KNP+5GfzVRXBkQ@mail.gmail.com>
References: <CAFQ4geQPTh00fpO0Y6BoCx1zV5eLrFEphZKoO5krV4OHhPaq5w@mail.gmail.com>
 <alpine.DEB.2.11.1712051635200.22619@piezo.novalocal> <CAJ4mKGY=p061ZDvJP7e863RJ_JUhCZS-dTPjmBA+Cazr3tn=+g@mail.gmail.com>
 <alpine.DEB.2.11.1712051818090.22619@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:45433 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753614AbdLFBQS (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Dec 2017 20:16:18 -0500
Received: by mail-pf0-f170.google.com with SMTP id u19so1529627pfa.12
        for <ceph-devel@vger.kernel.org>; Tue, 05 Dec 2017 17:16:18 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1712051818090.22619@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, Ken Iizawa <kiizawa@ucsc.edu>, ceph-devel <ceph-devel@vger.kernel.org>

Hi sage

I have worked on a rados op like TIER_PROMOTE (but, not finished yet)
I will make it a PR according to your comment.

Myoungwon
SK Telecom


2017-12-06 3:19 GMT+09:00 Sage Weil <sweil@redhat.com>:
> On Tue, 5 Dec 2017, Gregory Farnum wrote:
>> On Tue, Dec 5, 2017 at 8:39 AM, Sage Weil <sweil@redhat.com> wrote:
>> > On Tue, 5 Dec 2017, Ken Iizawa wrote:
>> >> I'm sorry, but I failed to save the link to the pull request you told
>> >> me about in today's meeting.
>> >> Could you resend the link?
>> >
>> > https://github.com/ceph/ceph/pull/15482
>> >
>> > There is a bunch of stuff in there, sorry.  What we really want is a rados
>> > op that triggers promote_object().  We don't have that quite yet.
>> >
>> > Myoungwon, is that something you've looked at yet?  I'm thinking of a
>> > rados op like TIER_PROMOTE (or something along those lines) that just
>> > triggers a promotion if it is a redirect/chunked manifest, and is a no-op
>> > otherwise.  (We could probably make it do something meaningful for a cache
>> > tier too, but I don't think it's worth the effort.)
>>
>> Didn't we previously have something like that? All I see in the source
>> now is a CACHE_EVICT|FLUSH|TRY_FLUSH (or some new? CACHE_PIN|UNPIN),
>> but ops to control promotion/demotion were definitely on the drawing
>> board at one point, and I thought it was implemented.
>>
>> Grepping through logs I do see we had a CEPH_OSD_RMW_FLAG_PROMOTE in
>> 2015, though that's later than I was thinking. Not sure if I'm just
>> missing the right term to search for or if I'm making it up.
>
> We never did.  The FLUSH/EVICT are the opposite (but roughly analogous)
> operations for a cache tier sitting above (vs an archive tier sitting
> below) the base tier, which are probably what you're thinking of? The
> struggle has historically been to *avoid* promotion, not to trigger
> promotion.
>
> sage
>
