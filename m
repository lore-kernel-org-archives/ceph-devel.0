From: Josh Durgin <jdurgin@redhat.com>
Subject: Re: seastar and 'tame reactor'
Date: Tue, 30 Jan 2018 14:32:47 -0800
Message-ID: <5b32056c-c6f7-a1c4-d07a-ae04557b59cf@redhat.com>
References: <d0f50268-72bb-1196-7ce9-0b9e21808ffb@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50998 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752572AbeA3Wcs (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 30 Jan 2018 17:32:48 -0500
In-Reply-To: <d0f50268-72bb-1196-7ce9-0b9e21808ffb@redhat.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Casey Bodley <cbodley@redhat.com>
Cc: Adam Emerson <aemerson@redhat.com>, Gregory Farnum <gfarnum@redhat.com>, kefu chai <tchaikov@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

[adding ceph-devel]

On 01/30/2018 01:56 PM, Casey Bodley wrote:
> Hey Josh,
> 
> I heard you mention in the call yesterday that you're looking into this 
> part of seastar integration. I was just reading through the relevant 
> code over the weekend, and wanted to compare notes:
> 
> 
> in seastar, all cross-core communication goes through lockfree spsc 
> queues, which are encapsulated by 'class smp_message_queue' in 
> core/reactor.hh. all of these queues (smp::_qs) are allocated on startup 
> in smp::configure(). early in reactor::run() (which is effectively each 
> seastar thread's entrypoint), it registers a smp_poller to poll all of 
> the queues directed at that cpu
> 
> what we need is a way to inject messages into each seastar reactor from 
> arbitrary/external threads. our requirements are very similar to 
> smp_message_queue's, with a few exceptions:
> 
> -each seastar reactor should be the single consumer of a multi-producer 
> queue, and poll on that as well

Yes, this is what I was thinking too, maybe a boost::lockfree::queue

> -the submit() function would return void instead of a future (which 
> removes the need for a lot of other stuff, like the _completions queue, 
> async_work_item::_promise, etc)
> 
> figuring out how to factor this stuff out of smp_message_queue cleanly 
> is the hard part i guess

I was thinking it could start off as a separate implementation, but
hadn't looked too closely at sharing pieces of it.

> in terms of startup, it could be allocated as a static array similar to 
> smp::_qs (except it would be dimensioned by [smp::count] instead of 
> [smp::count][smp::count]). then a new function could be added alongside 
> smp::submit_to() that submits to the given cpu's external queue (and 
> also returns void). this stuff should probably be disabled by default, 
> and only turned on if enabled in configuration

++

> for a super simple unit test, you could spawn an external thread that 
> does something like this:
> 
> std::mutex mutex;
> std::condition_variable cond;
> std::atomic<int> completions = 0;
> // submit a message to each reactor
> for (int i = 0; i < smp::count; i++) {
>    smp::external_submit_to(i, [&] { ++completions; cond.notify_one(); });
> }
> // wait for all completions
> std::unique_lock lock(mutex);
> cond.wait(lock, [&] { return completions == smp::count; });

Yeah, this looks like a nice example.

> Sorry that I've been slow to help with this - keep me posted?

No worries, I've been slow about this too - I've asked Kefu to look at
it this morning, so I'm sure he'll have some more thoughts soon.

Josh
