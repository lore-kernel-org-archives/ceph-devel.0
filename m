From: kefu chai <tchaikov@gmail.com>
Subject: Re: seastar and 'tame reactor'
Date: Thu, 8 Feb 2018 00:01:06 +0800
Message-ID: <CAJE9aOOq+HAWZOec0TnSqXFqUx7GD=XgCByh8HFV9Rb8L8qc2A@mail.gmail.com>
References: <d0f50268-72bb-1196-7ce9-0b9e21808ffb@redhat.com> <5b32056c-c6f7-a1c4-d07a-ae04557b59cf@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f180.google.com ([209.85.220.180]:39729 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932101AbeBGQBI (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Feb 2018 11:01:08 -0500
Received: by mail-qk0-f180.google.com with SMTP id d72so1691745qkc.6
        for <ceph-devel@vger.kernel.org>; Wed, 07 Feb 2018 08:01:08 -0800 (PST)
In-Reply-To: <5b32056c-c6f7-a1c4-d07a-ae04557b59cf@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <jdurgin@redhat.com>
Cc: Casey Bodley <cbodley@redhat.com>, Adam Emerson <aemerson@redhat.com>, Gregory Farnum <gfarnum@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Jan 31, 2018 at 6:32 AM, Josh Durgin <jdurgin@redhat.com> wrote:
> [adding ceph-devel]
>
> On 01/30/2018 01:56 PM, Casey Bodley wrote:
>>
>> Hey Josh,
>>
>> I heard you mention in the call yesterday that you're looking into this
>> part of seastar integration. I was just reading through the relevant code
>> over the weekend, and wanted to compare notes:
>>
>>
>> in seastar, all cross-core communication goes through lockfree spsc
>> queues, which are encapsulated by 'class smp_message_queue' in
>> core/reactor.hh. all of these queues (smp::_qs) are allocated on startup in
>> smp::configure(). early in reactor::run() (which is effectively each seastar
>> thread's entrypoint), it registers a smp_poller to poll all of the queues
>> directed at that cpu
>>
>> what we need is a way to inject messages into each seastar reactor from
>> arbitrary/external threads. our requirements are very similar to

i think we will have a sharded<osd::PublicService> on each core. in
each instance of PublicService, we will be listening and serving
requests from external clients of cluster. the same applies to
sharded<osd::ClusterService>, which will be responsible for serving
the requests from its peers in the cluster. the control flow of a
typical OSD read request from a public RADOS client will look like:

1. the TCP connection is accepted by one of the listening
sharded<osd::PublicService>.
2. decode the message
3. osd encapsulates the request in the message as a future, and submit
it to another core after hashing the involved pg # to the core #.
something like (in pseudo code):
  engine().submit_to(osdmap_shard, [] {
    return get_newer_osdmap(m->epoch);
    // need to figure out how to reference a "osdmap service" in seastar.
  }).then([] (auto osdmap) {
    submit_to(pg_to_shard(m->ops.op.pg, [] {
      return pg.do_ops(m->ops);
    });
  });
4. the core serving the involved pg (i.e. pg service) will dequeue
this request, and use read_dma() call to delegate the aio request to
the core maintaining the io queue.
5. once the aio completes, the PublicService will continue on, with
the then() block. it will send the response back to client.

so question is: why do we need a mpsc queue? the nr_core*nr_core spsc
is good enough for us, i think.

>> smp_message_queue's, with a few exceptions:
>>
>> -each seastar reactor should be the single consumer of a multi-producer
>> queue, and poll on that as well
>
>
> Yes, this is what I was thinking too, maybe a boost::lockfree::queue
>
>> -the submit() function would return void instead of a future (which
>> removes the need for a lot of other stuff, like the _completions queue,
>> async_work_item::_promise, etc)
>>
>> figuring out how to factor this stuff out of smp_message_queue cleanly is
>> the hard part i guess
>
>
> I was thinking it could start off as a separate implementation, but
> hadn't looked too closely at sharing pieces of it.
>
>> in terms of startup, it could be allocated as a static array similar to
>> smp::_qs (except it would be dimensioned by [smp::count] instead of
>> [smp::count][smp::count]). then a new function could be added alongside
>> smp::submit_to() that submits to the given cpu's external queue (and also
>> returns void). this stuff should probably be disabled by default, and only
>> turned on if enabled in configuration
>
>
> ++
>
>> for a super simple unit test, you could spawn an external thread that does
>> something like this:
>>
>> std::mutex mutex;
>> std::condition_variable cond;
>> std::atomic<int> completions = 0;
>> // submit a message to each reactor
>> for (int i = 0; i < smp::count; i++) {
>>    smp::external_submit_to(i, [&] { ++completions; cond.notify_one(); });
>> }
>> // wait for all completions
>> std::unique_lock lock(mutex);
>> cond.wait(lock, [&] { return completions == smp::count; });
>
>
> Yeah, this looks like a nice example.
>
>> Sorry that I've been slow to help with this - keep me posted?
>
>
> No worries, I've been slow about this too - I've asked Kefu to look at
> it this morning, so I'm sure he'll have some more thoughts soon.
>
> Josh



-- 
Regards
Kefu Chai
