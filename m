From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: [PATCH] PG: Do not discard op data too early
Date: Fri, 26 Oct 2012 15:07:44 -0600
Message-ID: <508AFBA0.4030603@sandia.gov>
References: <1348782975-7082-1-git-send-email-jaschut@sandia.gov>
 <CAPYLRzh_ngQt11Dv17YFJCj5pR3RJino6dbsw3HZ6WGAAhfu-w@mail.gmail.com>
 <5064D1CA.4030206@sandia.gov>
 <CAPYLRzgXNCOYqjbF8SyWOSwHU6kvLNJR6Wd8kgsJu6Z7YXWMYw@mail.gmail.com>
 <5064D509.1070203@sandia.gov>
 <CAPYLRzhkjf7E36E9BCcHoTvPggfE9FPJKp5+QAELgwRZ-9X-ig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:40828 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966503Ab2JZVII (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Oct 2012 17:08:08 -0400
In-Reply-To: <CAPYLRzhkjf7E36E9BCcHoTvPggfE9FPJKp5+QAELgwRZ-9X-ig@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Sage Weil <sage@inktank.com>, Samuel Just <sam.just@inktank.com>, ceph-devel@vger.kernel.org

On 10/26/2012 02:52 PM, Gregory Farnum wrote:
> Wanted to touch base on this patch again. If Sage and Sam agree that
> we don't want to play any tricks with memory accounting, we should
> pull this patch in. I'm pretty sure we want it for Bobtail!

I've been running with it since I posted it.
I think it would be great if you could pick it up!

-- Jim

> -Greg
>
> On Thu, Sep 27, 2012 at 3:36 PM, Jim Schutt<jaschut@sandia.gov>  wrote:
>> On 09/27/2012 04:27 PM, Gregory Farnum wrote:
>>>
>>> On Thu, Sep 27, 2012 at 3:23 PM, Jim Schutt<jaschut@sandia.gov>   wrote:
>>>>
>>>> On 09/27/2012 04:07 PM, Gregory Farnum wrote:
>>>>>
>>>>>
>>>>> Have you tested that this does what you want? If it does, I think
>>>>> we'll want to implement this so that we actually release the memory,
>>>>> but continue accounting it.
>>>>
>>>>
>>>>
>>>> Yes.  I have diagnostic patches where I add an "advisory" option
>>>> to Throttle, and apply it in advisory mode to the cluster throttler.
>>>> In advisory mode Throttle counts bytes but never throttles.
>>>
>>>
>>> Can't you also do this if you just set up a throttler with a limit of 0?
>>> :)
>>
>>
>> Hmmm, I expect so.  I guess I just didn't think of doing it that way....
>>
>>
>>>
>>>>
>>>> When I run all the clients I can muster (222) against a relatively
>>>> small number of OSDs (48-96), with osd_client_message_size_cap set
>>>> to 10,000,000 bytes I see spikes of>   100,000,000 bytes tied up
>>>> in ops that came through the cluster messenger, and I see long
>>>> wait times (>   60 secs) on ops coming through the client throttler.
>>>>
>>>> With this patch applied, I can raise osd_client_message_size_cap
>>>> to 40,000,000 bytes, but I rarely see more than 80,000,000 bytes
>>>> tied up in ops that came through the cluster messenger.  Wait times
>>>> for ops coming through the client policy throttler are lower,
>>>> overall daemon memory usage is lower, but throughput is the same.
>>>>
>>>> Overall, with this patch applied, my storage cluster "feels" much
>>>> less brittle when overloaded.
>>>
>>>
>>> Okay, cool. Are you interested in reducing the memory usage a little
>>> more by deallocating the memory separately from accounting it?
>>>
>>>
>>
>> My testing doesn't indicate a need -- even keeping the memory
>> around until the op is done, my daemons use less memory overall
>> to get the same throughput.  So, unless some other load condition
>> indicates a need, I'd counsel simplicity.
>>
>> -- Jim
>>
>>
>>
>
>


