From: Travis Rhoden <trhoden@gmail.com>
Subject: Re: max useful journal size
Date: Fri, 18 Jan 2013 17:47:57 -0500
Message-ID: <CACkq2mpwzsAtTRh7Cg0-c3GXTf8-V3OnrO6ojxE5gDnks9MMDQ@mail.gmail.com>
References: <CACkq2mokPwwgue_OjsZngzGLLt5XODZiJdD5YwCDJ1um5TQ9eA@mail.gmail.com>
 <CAPYLRzjkw92FU-q7tDWJSCuOjOE5OBaYZfPE0NT67cK532Gdwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ea0-f172.google.com ([209.85.215.172]:61591 "EHLO
	mail-ea0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751092Ab3ARWsT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Jan 2013 17:48:19 -0500
Received: by mail-ea0-f172.google.com with SMTP id f13so1716780eaa.3
        for <ceph-devel@vger.kernel.org>; Fri, 18 Jan 2013 14:48:17 -0800 (PST)
In-Reply-To: <CAPYLRzjkw92FU-q7tDWJSCuOjOE5OBaYZfPE0NT67cK532Gdwg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: John Wilkins <john.wilkins@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Jan 18, 2013 at 5:43 PM, Gregory Farnum <greg@inktank.com> wrote:
> On Fri, Jan 18, 2013 at 2:20 PM, Travis Rhoden <trhoden@gmail.com> wrote:
>> Hey folks,
>>
>> The Ceph docs give the following recommendation on sizing your journal:
>>
>> osd journal size = {2 * (expected throughput * filestore min sync interval)}
>>
>> The default value of min sync interval is .01.  If you use throughput
>> of a mediocre 7200RPM drive of 100MB/sec, this comes to 2 MB.  That
>> seems like the lower bound to have the journal do anything at all.
>
> Ah. This should refer to the max sync interval, not the min!

I wondered about that.  But wasn't confident enough to ask about it.
>
>> My question is what is the upper bound?  There's clearly a limit to
>> how big make, such that it just becomes wasted space.  The reason I
>> want to know is that since I will be journals on SSDs, with each
>> journal being a dedicated partition, there is a benefit to not making
>> the partition bigger than it needs to be.  All that unpartitioned
>> space can be used by the SSD firmware for wear-leveling and other
>> things (so long as it remains unpartitioned).
>>
>> Would the following calc be appopriate?
>>
>> Assume an SSD write speed of 400MB/sec.  Default max sync interval is 5.
>>
>> 2 * (400 MB/sec * 5sec) = 4 GB.
>>
>> So is it appropriate to assume that if I can't write to an SSD faster
>> than 400 MB/sec, and I keep the default sync interval values, a
>> journal greater than 4GB is just a waste?
>>
>> I had been using 10GB journals...  seems like overkill.
>>
>> Or put another way, if I want to use 10GB journals, I should bump the
>> max sync interval to 12.5.
>
> It can of course grow as large as you let it, and I would leave some
> extra room as a margin. The main consideration is that the journal
> doesn't like getting too far ahead of the filestore, and that's what
> the above calculation uses to set size.

Is "max sync interval" a hard stop, though?  I mean, once 5 seconds
pass, it's going to flush/sync no matter what, right? So there is no
point in making it much bigger than what can be written to the journal
in those 5 seconds.  I feel like I must be missing something, though,
otherwise the recommendation wouldn't to make the journal 2x that
size.

> -Greg
