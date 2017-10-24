From: Casey Bodley <cbodley@redhat.com>
Subject: Re: fun with seastar
Date: Tue, 24 Oct 2017 16:34:41 -0400
Message-ID: <d3ef03e7-3bb3-2b12-3f3f-bfa4b84e3ff5@redhat.com>
References: <91a5fd79-ff50-53f7-d187-97d024cee8ba@redhat.com>
 <268ffa36-bfc5-4fee-1c44-13e3050f6c9c@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f170.google.com ([209.85.220.170]:49370 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750897AbdJXUeo (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Oct 2017 16:34:44 -0400
Received: by mail-qk0-f170.google.com with SMTP id q83so27952460qke.6
        for <ceph-devel@vger.kernel.org>; Tue, 24 Oct 2017 13:34:44 -0700 (PDT)
In-Reply-To: <268ffa36-bfc5-4fee-1c44-13e3050f6c9c@gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.a.nelson@gmail.com>, The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>



On 10/23/2017 11:25 PM, Mark Nelson wrote:
> Hi Casey!
>
> On 10/23/2017 03:17 PM, Casey Bodley wrote:
>> Hi folks,
>>
>> I mentioned in last week's perf call that I've been experimenting with
>> the Seastar library [1] to see how well it can integrate with the ceph
>> codebase. So far I've managed to add bufferlist conversions to/from the
>> seastar buffer types, and build up a seastar messenger that can
>> send/receive ceph Messages. The branch [2] includes a simple echo server
>> unit test and a README with build instructions.
>>
>> This follows some prototype work a couple years ago by Adam Emerson and
>> myself, dubbed Project Crimson [3], to evaluate Seastar as the basis for
>> a low-latency OSD. Interesting parts of this project include a Cap'n
>> Proto-based messenger and an async ObjectStore interface with Memstore
>> implementation.
>
> So after I saw your initial work on project crimson a month or two ago 
> I went out and started working through the seastar tutorial. I never 
> really got past screwing around with it since I've been tied up in 
> other stuff, but it seems like you must like seastar enough to be 
> willing to sink some time into it.  Where are you planning on taking 
> this next?
>
> Mark

I don't think there are any solid plans yet, but I think it would be 
cool to hook up a ceph messenger to Adam's memstore and see how well it 
does with something like rados bench.

>
>>
>> -Casey
>>
>> [1] https://github.com/scylladb/seastar
>> [2] https://github.com/cbodley/ceph/commits/wip-seastar-msg
>> [3] https://github.com/cohortfsllc/crimson
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at http://vger.kernel.org/majordomo-info.html

