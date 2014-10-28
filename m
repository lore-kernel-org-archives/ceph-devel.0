From: Alex Elder <elder@ieee.org>
Subject: Re: krbd blk-mq support ?
Date: Tue, 28 Oct 2014 17:31:12 -0500
Message-ID: <54501930.7070405@ieee.org>
References: <20141027094556.GA31604@infradead.org> <fc083e2c-6a73-4ff8-934c-4e3ba1d64b50@mailpro> <20141028180725.GA1138@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:36287 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755046AbaJ1WbQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Oct 2014 18:31:16 -0400
Received: by mail-pd0-f169.google.com with SMTP id y10so1634721pdj.28
        for <ceph-devel@vger.kernel.org>; Tue, 28 Oct 2014 15:31:15 -0700 (PDT)
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

I don't remember off hand.

In libceph I recall going to great lengths to retain the original
order of requests when they got re-sent after a connection reset.

I'll go look at the code a bit and see if I can refresh my memory
(though Sage may answer before I do).

					-Alex

> If not we could probably aim for per-cpu queues using blk-mq and a
> socket per cpu or similar.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

