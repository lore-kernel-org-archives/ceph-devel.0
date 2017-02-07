From: =?UTF-8?B?QmFydMWCb21pZWogxZp3acSZY2tp?=
        <bartlomiej.swiecki@corp.ovh.com>
Subject: Re: Proposition - latency histogram
Date: Tue, 7 Feb 2017 17:30:39 +0100
Message-ID: <372caf99-4fc4-f6a9-6620-5dfacdbfa758@corp.ovh.com>
References: <69bf4eec-3959-f021-ad8f-d1b6d3e2ceaf@corp.ovh.com>
 <b2b52f75-0e26-2dac-df6a-ea7bfd91a973@corp.ovh.com>
 <985bd632-be25-e281-9249-d4ef5772c821@corp.ovh.com>
 <59a75537-852a-94ad-b28d-958d7e0555f2@corp.ovh.com>
 <CALe9h7dyLo8QKJOG6tjL5CwS4Yoq+naidrK1iw5tJGD6yp6vbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 10.mo302.mail-out.ovh.net ([137.74.110.83]:48792 "EHLO
        10.mo302.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755083AbdBGQat (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Feb 2017 11:30:49 -0500
In-Reply-To: <CALe9h7dyLo8QKJOG6tjL5CwS4Yoq+naidrK1iw5tJGD6yp6vbA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi John,

This looks awesome! I really hope to see this kind of tools in ceph-mgr.

Actually the idea of adding histograms came up after some nasty performance
issues we investigated in one of our production clusters where this kind
of tool would help us identify the issue much quicker.

What I think would be really helpful is to
  1) be able to automatically detect anomalies - in case of this 2D 
histogram
     it could be as simple as splitting the whole square into set of regions
     (i.e. regions with meaning: OK, WARN, ERROR) and check if there's 
activity
     inside of them
  2) if there's an anomaly, provide manual tools to "zoom" into the issue so
     that the cause can be precisely investigated

 From what I understood so far, ceph-mgr is going exactly into that 
direction.

Regards,
Bartek

On 02/06/2017 12:54 PM, John Spray wrote:
> On Tue, Jan 31, 2017 at 3:33 PM, Bartłomiej Święcki
> <bartlomiej.swiecki@corp.ovh.com> wrote:
>> Attached is a sample output from test python script (included in PR)
>> to display live results.
> This is very cool, and inspired me to build a colored version in to a
> toy gui that I've been using to exercise ceph-mgr.
> http://imgur.com/a/TG5kc (it a super-primitive rendering using linear
> color scale on cells of a <table>)
>
> I did that by exposing the perf counters via the MCommand (`tell`)
> interface on the OSD so that the UI could poll them.
>
> I think there are two main use cases for these plots:
>   * System-wide (average of OSDs): what are my doing/experiencing?
>   * Individual OSD: is this OSD healthy?  Potentially would plot this
> as a delta against the systemwide average to highlight OSDs behaving
> badly.
>
> Currently, ordinary perf counters are getting shipped back to ceph-mgr
> continuously, so we would need to decide whether we want to do the
> same for the larger histogram ones, or whether we would expose them
> via `tell` so that any interested parties could fetch them on demand.
> The main benefit to continuously sending them would be that ceph-mgr
> could maintain a continuous sum/average across all the OSDs.  The cost
> depends how widely we use this data type: if there were only a few
> histograms per osd (osd read, osd write, store read, store write),
> then I suspect we could get away with transmitting them around quite
> freely.
>
> The 2D data is awesome and I can't see us not wanting this, though
> there will also be at least some key places we want 1D data,
> especially for the MDS where metadata ops don't have a size dimension.
>
> John
>
>
>>
>> On 01/31/2017 04:22 PM, Bartłomiej Święcki wrote:
>>> Hi,
>>>
>>> Bringing back performance histograms:
>>> https://github.com/ceph/ceph/pull/12829
>>> I've updated the PR, rebased on master and made internal changes less
>>> aggressive.
>>>
>>> All ctest tests passing and I haven't seen any issues with performance
>>> (and I can actually see much better what the performance characteristics
>>> are
>>>
>>> Waiting for your comments,
>>> Bartek
>>>
>>>
>>>
>>> Looking
>>>
>>> On 01/09/2017 12:27 PM, Bartłomiej Święcki wrote:
>>>> Hi,
>>>>
>>>> I've made a simple implementation of performance histograms.
>>>> Implementation is not very sophisticated
>>>> but I think it could be a good start for more detailed discussion.
>>>>
>>>> Here's the PR: https://github.com/ceph/ceph/pull/12829
>>>>
>>>>
>>>> Regards,
>>>> Bartek
>>>>
>>>>
>>>> On 11/28/2016 05:22 PM, Bartłomiej Święcki wrote:
>>>>> Hi,
>>>>>
>>>>>
>>>>> Currently we can query OSD for op latency but it's given as an average.
>>>>> Average may not give
>>>>> the bets information in this case - i.e. spikes can easily get hidden
>>>>> there.
>>>>>
>>>>> Instead of an average we could easily do a simple histogram - quantize
>>>>> the latency into
>>>>> predefined set of time intervals, for each of them have a simple
>>>>> performance counter,
>>>>> at each op increase one of them. Since those are per OSD, we could have
>>>>> pretty high resolution
>>>>> with fractional memory usage, performance impact should be negligible
>>>>> since only one (two if split
>>>>> into read and write) of those counters would be incremented per one osd
>>>>> op.
>>>>>
>>>>> In addition we could also do this in 2D - each counter matching given
>>>>> latency range and op size range.
>>>>> having such 2D table would show both latency histogram, request size
>>>>> histogram and combinations of those
>>>>> (i.e. latency histogram of ~4k ops only).
>>>>>
>>>>> What do you think about this idea? I can prepare some code - a simple
>>>>> proof of concept looks really
>>>>> straightforward to implement.
>>>>>
>>>>>
>>>>> Bartek
>>>>>
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>

