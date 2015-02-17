From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: CDS process
Date: Wed, 18 Feb 2015 00:42:31 +0800
Message-ID: <CACJqLybBYTBh23zyZ3gykGZdYtxfHV-F6Gu53v0s48AGQB-z+Q@mail.gmail.com>
References: <alpine.DEB.2.00.1502050540360.27042@cobra.newdream.net>
	<54D38E03.4030807@inktank.com>
	<CAAZbbf2dpsj1MuzRY1REvF1Ow=UhX9HZhtO7=Hro_E7uiWRVtw@mail.gmail.com>
	<alpine.DEB.2.00.1502161739290.22050@cobra.newdream.net>
	<CAAZbbf21CQ_JTt-=OqHF2grf+2NXgwzBC51K8kSMEz0eZSEhsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:37737 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752112AbbBQQmc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 Feb 2015 11:42:32 -0500
Received: by mail-wg0-f49.google.com with SMTP id l18so37106865wgh.8
        for <ceph-devel@vger.kernel.org>; Tue, 17 Feb 2015 08:42:31 -0800 (PST)
In-Reply-To: <CAAZbbf21CQ_JTt-=OqHF2grf+2NXgwzBC51K8kSMEz0eZSEhsA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Patrick McGarry <pmcgarry@redhat.com>
Cc: Sage Weil <sage@newdream.net>, Josh Durgin <josh.durgin@inktank.com>, Ceph Devel <ceph-devel@vger.kernel.org>

It seemed wiki is better for recording bp and other users(not dev?)
can have a nice look. If we put all in pad, it may be mess for
different bp?

We have some facts:
1. bp needed to be formatted and have a unified view for viewers
2. heavily changes will be applied during CDS mainly
3. latter(after CDS) changes to *bp* needed to be notify

So maybe we can register a bp on wiki at first, then heavily changes
will happen during CDS and also write in pad. After each session, we
need to rewrite(copy?)  back to wiki. This way can be a tradeoff
between pad and wiki?

On Wed, Feb 18, 2015 at 12:24 AM, Patrick McGarry <pmcgarry@redhat.com> wrote:
> Mostly I just want to do small incremental changes to the process,
> especially since it's happening so close to the summit.
>
> The only thing that I'll miss with an etherpad-only workflow is the
> notification on creations/edits, but I'll survive. I think it's just a
> matter of enforcing the use of blueprints, regardless of where they
> live.
>
>
>
> On Mon, Feb 16, 2015 at 8:42 PM, Sage Weil <sage@newdream.net> wrote:
>> On Mon, 16 Feb 2015, Patrick McGarry wrote:
>>> I think I'm going to take this forward in baby steps. I'm going to collect
>>> blueprints via the normal pathway and then just manually capture the data in
>>> ether pads when I populate the schedule. For J I'll just direct people
>>> directly to ether pads (assuming there is no major objection).
>>
>> Are you worried about the documented workflow and tooling in the wiki, or
>> just want to start with small changes to the process?  It's also the
>> copying part and most-empty blueprints that I suspect we can avoid without
>> loss of value.  I'm curious if we go super-light on the tooling if we'll
>> find that there are parts we miss or not.
>>
>> Any other thoughts?
>> sage
>>
>>
>>>
>>> On Thu, Feb 5, 2015 at 10:36 AM, Josh Durgin <josh.durgin@inktank.com>
>>> wrote:
>>>       On 02/05/2015 02:50 PM, Sage Weil wrote:
>>>             I wonder if we should simplify the cds workflow a
>>>             bit to go straight to an
>>>             etherpad outline of the blueprint instead of the
>>>             wiki blueprint doc.  I
>>>             find it a bit disorienting to be flipping between
>>>             the two, and after the
>>>             fact find it frustrating that there isn't a single
>>>             reference to go back to
>>>             for the outcome of the session (you have to look at
>>>             both the pad and the
>>>             bp).
>>>
>>>             Perhaps just using the pad from the get-go will
>>>             streamline things a bit
>>>             and make it a little more lightweight?  What does
>>>             everyone think?
>>>
>>>
>>> Sounds good to me. I've also wished there were a single location to
>>> capture a session; searching through the wiki for etherpads that
>>> aren't linked from the blueprint is a pain.
>>>
>>> Josh
>>>
>>>
>>>
>>>
>>> --
>>>
>>> Best Regards,
>>>
>>> Patrick McGarry
>>> Director Ceph Community || Red Hat
>>> http://ceph.com  ||  http://community.redhat.com
>>> @scuttlemonkey || @ceph
>>>
>>>
>
>
>
> --
>
> Best Regards,
>
> Patrick McGarry
> Director Ceph Community || Red Hat
> http://ceph.com  ||  http://community.redhat.com
> @scuttlemonkey || @ceph
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards,

Wheat
