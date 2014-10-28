From: Alex Elder <elder@ieee.org>
Subject: Re: krbd blk-mq support ?
Date: Tue, 28 Oct 2014 18:11:08 -0500
Message-ID: <5450228C.3010907@ieee.org>
References: <20141027094556.GA31604@infradead.org> <fc083e2c-6a73-4ff8-934c-4e3ba1d64b50@mailpro> <20141028180725.GA1138@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:44995 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754519AbaJ1XLN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Oct 2014 19:11:13 -0400
Received: by mail-pa0-f46.google.com with SMTP id lf10so1792873pab.33
        for <ceph-devel@vger.kernel.org>; Tue, 28 Oct 2014 16:11:13 -0700 (PDT)
In-Reply-To: <20141028180725.GA1138@infradead.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>, Alexandre DERUMIER <aderumier@odiso.com>
Cc: Ceph Devel <ceph-devel@vger.kernel.org>

On 10/28/2014 01:07 PM, Christoph Hellwig wrote:
> On Mon, Oct 27, 2014 at 11:00:46AM +0100, Alexandre DERUMIER wrote:
>>>> Can you do a perf report -ag and then a perf report to see where these
>>>> cycles are spent?
>>
>> Yes, sure.
>>
>> I have attached the perf report to this mail.
>> (This is with kernel 3.14, don't have access to my 3.18  host for now)
>
> Oh, that's without the blk-mq patch?
>
> Either way the profile doesn't really sum up to a fully used up
> cpu.  Sage, Alex - are there any ordring constraints in the rbd client?
> If not we could probably aim for per-cpu queues using blk-mq and a
> socket per cpu or similar.

First, a disclaimer--I haven't really been following this discussion
very closely.

For an rbd image request (which is what gets created from requests
from the block queue), the order of completion doesn't matter, and
although the object requests are submitted in order that shouldn't
be required either.

The image request is broken into one or more object requests (usually
just one) and they are treated as a unit.  When the last object request
of a set for an image request has completed, the image request is
treated as completed.

I hope that helps.  If not, ask again a different way...

					-Alex

> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

