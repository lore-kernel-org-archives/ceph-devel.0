From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Sessions and Persistence
Date: Fri, 15 Apr 2016 15:38:39 -0700
Message-ID: <CAJ4mKGaM=3i_hDGcRZRNbme616O_ARQ0Z4HBZ8qBt-nxLTg-5Q@mail.gmail.com>
References: <20160415210536.GA16458@ultraspiritum.redhat.com>
	<CAJ4mKGbhPrFbMKJi_hKAP1rKzjnX8GqQGMP+m7C_io-m1VDquA@mail.gmail.com>
	<20160415222936.GA6461@ultraspiritum.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f41.google.com ([209.85.213.41]:34256 "EHLO
	mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355AbcDOWik (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Apr 2016 18:38:40 -0400
Received: by mail-vk0-f41.google.com with SMTP id e185so163652308vkb.1
        for <ceph-devel@vger.kernel.org>; Fri, 15 Apr 2016 15:38:40 -0700 (PDT)
In-Reply-To: <20160415222936.GA6461@ultraspiritum.redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On Fri, Apr 15, 2016 at 3:29 PM, Adam C. Emerson <aemerson@redhat.com> wrote:
> On 15/04/2016, Gregory Farnum wrote:
>> So the most common time we really get replay operations is when one of
>> the OSDs crash or a PG's acting set changes for some other reason.
>> Which means these "cached" operation results need to be persisted to
>> disk and then cleaned up, a la the pglog.
>> I don't see anything in these data structures that explains how we do
>> that efficiently, which is the biggest problem and the reason we don't
>> already do reply caching. Am I missing something?
>
> So! I had been considering the usual case of resend to be transient connection
> drop between client and OSD. (An example of why feedback is nice :)

Well, I guess I don't have in-the-field information about the relative
prevalence of these scenarios. But we definitely can't include
features in RADOS that work "as long as you don't have acting set
changes". ;)

>
> I /had/ thought of persisting thee things as a possible feature we would want to
> add that administrators could turn on or off depending on the level of
> reliability they wanted (and if they had some NVRAM on the machine.)
>
> I had not thought specifically about persisting them QUICKLY in the
> spinning disk case. One optimization would be refusing to cache read-only
> ops so we don't have to pay for a disk-write unless we're using a disk
> write. My intuition would suggest a per-OSD op-log that gets written
> and committed when the PGLog entry gets committed, but I admit that's
> just spur of the moment. It needs a bit more design work, but bundling
> it with some of the writes we have to do already seems promising.

This is something I've suggested in the past, but I think it's at the
stage where somebody needs to write code demonstrating it is something
approaching performant. If it is, I don't think anybody opposes the
idea; if it's not, then throughput/IOP regressions are not a tradeoff
Sam/Sage are willing to make for this IIRC (and, though I am more
optimistic than I remember them being about our odds of success, I
suppose I'm not either).
-Greg
