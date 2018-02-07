From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: seastar and 'tame reactor'
Date: Wed, 7 Feb 2018 11:22:31 -0800
Message-ID: <CAJ4mKGa6XzhQmK3JkAL3FtnuXDMf2uy1oheQxEL8kcdukSKssw@mail.gmail.com>
References: <d0f50268-72bb-1196-7ce9-0b9e21808ffb@redhat.com>
 <5b32056c-c6f7-a1c4-d07a-ae04557b59cf@redhat.com> <CAJE9aOOq+HAWZOec0TnSqXFqUx7GD=XgCByh8HFV9Rb8L8qc2A@mail.gmail.com>
 <9e6bc174-c6b3-a37e-abd5-b96d572d1d1b@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f170.google.com ([209.85.223.170]:39664 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753995AbeBGTWd (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Feb 2018 14:22:33 -0500
Received: by mail-io0-f170.google.com with SMTP id b198so3194374iof.6
        for <ceph-devel@vger.kernel.org>; Wed, 07 Feb 2018 11:22:33 -0800 (PST)
In-Reply-To: <9e6bc174-c6b3-a37e-abd5-b96d572d1d1b@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Casey Bodley <cbodley@redhat.com>
Cc: kefu chai <tchaikov@gmail.com>, Josh Durgin <jdurgin@redhat.com>, Adam Emerson <aemerson@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Feb 7, 2018 at 9:11 AM, Casey Bodley <cbodley@redhat.com> wrote:
>
> On 02/07/2018 11:01 AM, kefu chai wrote:
>>
>> On Wed, Jan 31, 2018 at 6:32 AM, Josh Durgin <jdurgin@redhat.com> wrote:
>>>
>>> [adding ceph-devel]
>>>
>>> On 01/30/2018 01:56 PM, Casey Bodley wrote:
>>>>
>>>> Hey Josh,
>>>>
>>>> I heard you mention in the call yesterday that you're looking into this
>>>> part of seastar integration. I was just reading through the relevant
>>>> code
>>>> over the weekend, and wanted to compare notes:
>>>>
>>>>
>>>> in seastar, all cross-core communication goes through lockfree spsc
>>>> queues, which are encapsulated by 'class smp_message_queue' in
>>>> core/reactor.hh. all of these queues (smp::_qs) are allocated on startup
>>>> in
>>>> smp::configure(). early in reactor::run() (which is effectively each
>>>> seastar
>>>> thread's entrypoint), it registers a smp_poller to poll all of the
>>>> queues
>>>> directed at that cpu
>>>>
>>>> what we need is a way to inject messages into each seastar reactor from
>>>> arbitrary/external threads. our requirements are very similar to
>>
>> i think we will have a sharded<osd::PublicService> on each core. in
>> each instance of PublicService, we will be listening and serving
>> requests from external clients of cluster. the same applies to
>> sharded<osd::ClusterService>, which will be responsible for serving
>> the requests from its peers in the cluster. the control flow of a
>> typical OSD read request from a public RADOS client will look like:
>>
>> 1. the TCP connection is accepted by one of the listening
>> sharded<osd::PublicService>.
>> 2. decode the message
>> 3. osd encapsulates the request in the message as a future, and submit
>> it to another core after hashing the involved pg # to the core #.
>> something like (in pseudo code):
>>    engine().submit_to(osdmap_shard, [] {
>>      return get_newer_osdmap(m->epoch);
>>      // need to figure out how to reference a "osdmap service" in seastar.
>>    }).then([] (auto osdmap) {
>>      submit_to(pg_to_shard(m->ops.op.pg, [] {
>>        return pg.do_ops(m->ops);
>>      });
>>    });
>> 4. the core serving the involved pg (i.e. pg service) will dequeue
>> this request, and use read_dma() call to delegate the aio request to
>> the core maintaining the io queue.
>> 5. once the aio completes, the PublicService will continue on, with
>> the then() block. it will send the response back to client.
>>
>> so question is: why do we need a mpsc queue? the nr_core*nr_core spsc
>> is good enough for us, i think.
>>
>
> Hey Kefu,
>
> That sounds entirely reasonable, but assumes that everything will be running
> inside of seastar from the start. We've been looking for an incremental
> approach that would allow us to start with some subset running inside of
> seastar, with a mechanism for communication between that and the osd's
> existing threads. One suggestion was to start with just the messenger inside
> of seastar, and gradually move that seastar-to-external-thread boundary
> further down the io path as code is refactored to support it. It sounds
> unlikely that we'll ever get rocksdb running inside of seastar, so the
> objectstore will need its own threads until there's a viable alternative.
>
> So the mpsc queue and smp::external_submit_to() interface was a strategy for
> passing messages into seastar from arbitrary non-seastar threads.
> Communication in the other direction just needs to be non-blocking (my
> example just signaled a condition variable without holding its mutex).
>
> What are your thoughts on the incremental approach?
>
> Casey
>
> ps. I'd love to see more thought put into the design of the finished
> product, and your outline is a good start! Avi Kivity @scylladb shared one
> suggestion that I really liked, which was to give each shard of the osd a
> separate network endpoint, and add enough information to the osdmap so that
> clients could send their messages directly to the shard that would process
> them. That piece can come in later, but could eliminate some of the extra
> latency from your step 3.

This is something we've discussed but will want to think about very
carefully once we have more performance available. Increasing the
number of (very stateful) connections the OSDs and clients need to
maintain like that is not something to undertake lightly right now,
and in fact is the opposite of the multiplexing connections work going
on for msgr v2. ;)
-Greg
