From: Mark Nelson <mnelson@redhat.com>
Subject: Re: fun with seastar
Date: Tue, 24 Oct 2017 16:22:16 -0500
Message-ID: <817f6905-8a45-a73f-bff4-6d575054eb0d@redhat.com>
References: <91a5fd79-ff50-53f7-d187-97d024cee8ba@redhat.com>
 <268ffa36-bfc5-4fee-1c44-13e3050f6c9c@gmail.com>
 <d3ef03e7-3bb3-2b12-3f3f-bfa4b84e3ff5@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43686 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751506AbdJXVWS (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 24 Oct 2017 17:22:18 -0400
In-Reply-To: <d3ef03e7-3bb3-2b12-3f3f-bfa4b84e3ff5@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Casey Bodley <cbodley@redhat.com>, Mark Nelson <mark.a.nelson@gmail.com>, The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On 10/24/2017 03:34 PM, Casey Bodley wrote:
>
>
> On 10/23/2017 11:25 PM, Mark Nelson wrote:
>> Hi Casey!
>>
>> On 10/23/2017 03:17 PM, Casey Bodley wrote:
>>> Hi folks,
>>>
>>> I mentioned in last week's perf call that I've been experimenting with
>>> the Seastar library [1] to see how well it can integrate with the ceph
>>> codebase. So far I've managed to add bufferlist conversions to/from the
>>> seastar buffer types, and build up a seastar messenger that can
>>> send/receive ceph Messages. The branch [2] includes a simple echo server
>>> unit test and a README with build instructions.
>>>
>>> This follows some prototype work a couple years ago by Adam Emerson and
>>> myself, dubbed Project Crimson [3], to evaluate Seastar as the basis for
>>> a low-latency OSD. Interesting parts of this project include a Cap'n
>>> Proto-based messenger and an async ObjectStore interface with Memstore
>>> implementation.
>>
>> So after I saw your initial work on project crimson a month or two ago
>> I went out and started working through the seastar tutorial. I never
>> really got past screwing around with it since I've been tied up in
>> other stuff, but it seems like you must like seastar enough to be
>> willing to sink some time into it.  Where are you planning on taking
>> this next?
>>
>> Mark
>
> I don't think there are any solid plans yet, but I think it would be
> cool to hook up a ceph messenger to Adam's memstore and see how well it
> does with something like rados bench.

How tough would it be to do that?  At the very least it would be a 
really interesting experiment.  I'd be happy to take it for a spin if 
you can get something cobbled together. :)

Mark

>
>>
>>>
>>> -Casey
>>>
>>> [1] https://github.com/scylladb/seastar
>>> [2] https://github.com/cbodley/ceph/commits/wip-seastar-msg
>>> [3] https://github.com/cohortfsllc/crimson
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
