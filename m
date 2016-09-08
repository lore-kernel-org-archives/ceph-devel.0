From: Casey Bodley <cbodley@redhat.com>
Subject: Re: rgw: feedback on auth engine selection
Date: Thu, 8 Sep 2016 14:23:05 -0400
Message-ID: <1a932fce-a05d-d690-953d-6f5b74467182@redhat.com>
References: <e2a2e0c9-51e7-b703-2c8d-7b489d4e8994@redhat.com>
 <CA+H5UW1Qf++2R36y05GFAFTcJO2YN77W4z1yjpUMgAHitnsG-Q@mail.gmail.com>
 <6113bdf0-10fb-a30d-e4a0-797df61f8bd0@redhat.com>
 <CA+H5UW2nL1nWa6YFW7yoiuu0WE-rYxYjMpm1X+Tw6_LbvSrwwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f172.google.com ([209.85.161.172]:34331 "EHLO
        mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752956AbcIHSXI (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Sep 2016 14:23:08 -0400
Received: by mail-yw0-f172.google.com with SMTP id g192so33957584ywh.1
        for <ceph-devel@vger.kernel.org>; Thu, 08 Sep 2016 11:23:08 -0700 (PDT)
In-Reply-To: <CA+H5UW2nL1nWa6YFW7yoiuu0WE-rYxYjMpm1X+Tw6_LbvSrwwQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Radoslaw Zarzynski <rzarzynski@mirantis.com>
Cc: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>



On 09/08/2016 01:19 PM, Radoslaw Zarzynski wrote:
> On Wed, Sep 7, 2016 at 11:05 PM, Casey Bodley <cbodley@redhat.com> wrote:
>> Some specific requirements that I recall from our past discussions include:
>>
>> - don't heap allocate auth state per request
> Great. I understood that we don't need to optimize the early
> run-time (setup, initialization) to eradicate dynamic allocations.
> This would allow to make the things easier to read through
> skipping some crazy CRTP/SFINAE stuff.
>
>> - don't construct or call into AuthEngines that shouldn't be enabled for the
>> given handler
> This sounds like a step further in comparison with the current
> solution. In the past we had a lot of "ifs" executed per request.
> Currently, the logic is split into per-engine pieces and encapsulated
> in is_applicable method of AuthEngines. In my understanding
> the goal is to introduce init-time preselection. However, we need
> to discuss dealing with run-time config changes (operator injecting
> new configuration without restart). Do we want to cover this use
> case at all?

Right, this was the requirement that motivated the work on preselection, 
so we would only try to authenticate against engines that are properly 
configured and relevant to the given handler.

With respect to changing the auth strategy (i.e. the list of engines 
configured for a given handler) at runtime, I'm not sure it's worth the 
complexity at this point, and we certainly don't want to add locking to 
do this safely. [note that we do have 'dynamic reconfiguration' which 
pauses the frontend while it reloads RGWRados, so we could use that 
mechanism to change auth strategy without needing new locks]

>
>> I'll add some of the other refactoring goals we've discussed, but I don't
>> think they place any strict requirements on the auth subsystem:
>>
>> - RGWHandler: being able to reuse handler instances, instead of allocating a
>> new one for each request
> At the moment RGWHandler is dynamically allocated on each
> request. Do we plan to remove only the allocations or go even
> further and make handlers entirely state-less?
>
>> - req_state: contains too many unrelated fields, some of which are
>> transformed in confusing ways over the lifetime of the request. needs to be
>> broken up into smaller, better encapsulated sub-objects
> I'm 100% behind that.
>
>> - concurrency: move away from a synchronous process_request() to build on
>> asio frontend work
> Sound really interesting.
>
>
> Let me propose another requirement:
>   - critical components should facilitate unit testing. In the future
>     they should be covered by reasonable set of unit tests.
>
> What do you think?
>
> Regards,
> Radek

