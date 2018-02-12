From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: seastar and 'tame reactor'
Date: Mon, 12 Feb 2018 07:57:47 -0800
Message-ID: <CAJ4mKGaiJDjXrnpi24CM2QUW+m04GmeFBk9-POz9H0-3md_+bA@mail.gmail.com>
References: <d0f50268-72bb-1196-7ce9-0b9e21808ffb@redhat.com>
 <5b32056c-c6f7-a1c4-d07a-ae04557b59cf@redhat.com> <CAJE9aOOq+HAWZOec0TnSqXFqUx7GD=XgCByh8HFV9Rb8L8qc2A@mail.gmail.com>
 <9e6bc174-c6b3-a37e-abd5-b96d572d1d1b@redhat.com> <CAJ4mKGa6XzhQmK3JkAL3FtnuXDMf2uy1oheQxEL8kcdukSKssw@mail.gmail.com>
 <CAJE9aOO0=VKuqH=7x4M-uNJcK2j4VhTG+-=KAqZn7OkNZGLvfA@mail.gmail.com> <CAKOnar=HjUfq5WDZtqjKC=Wyj1oK0454wszpukSmFf0L46gZsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f49.google.com ([209.85.214.49]:39419 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932945AbeBLP5t (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Feb 2018 10:57:49 -0500
Received: by mail-it0-f49.google.com with SMTP id c80so7036401itb.4
        for <ceph-devel@vger.kernel.org>; Mon, 12 Feb 2018 07:57:48 -0800 (PST)
In-Reply-To: <CAKOnar=HjUfq5WDZtqjKC=Wyj1oK0454wszpukSmFf0L46gZsw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matt Benjamin <mbenjami@redhat.com>
Cc: kefu chai <tchaikov@gmail.com>, Casey Bodley <cbodley@redhat.com>, Josh Durgin <jdurgin@redhat.com>, Adam Emerson <aemerson@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

> On Mon, Feb 12, 2018 at 10:45 AM, kefu chai <tchaikov@gmail.com> wrote:
>> On Thu, Feb 8, 2018 at 3:22 AM, Gregory Farnum <gfarnum@redhat.com> wrote:
>>> On Wed, Feb 7, 2018 at 9:11 AM, Casey Bodley <cbodley@redhat.com> wrote:
>>>>
>>>> On 02/07/2018 11:01 AM, kefu chai wrote:
>>>>>
>>>>> On Wed, Jan 31, 2018 at 6:32 AM, Josh Durgin <jdurgin@redhat.com> wrote:
>>>>>>
>>>>>> [adding ceph-devel]
>>>>>>
>>>>>> On 01/30/2018 01:56 PM, Casey Bodley wrote:
>>>>>>>
>>>>>>> Hey Josh,
>>>>>>>
>>>>>>> I heard you mention in the call yesterday that you're looking into this
>>>>>>> part of seastar integration. I was just reading through the relevant
>>>>>>> code
>>>>>>> over the weekend, and wanted to compare notes:
>>>>>>>
>>>>>>>
>>>>>>> in seastar, all cross-core communication goes through lockfree spsc
>>>>>>> queues, which are encapsulated by 'class smp_message_queue' in
>>>>>>> core/reactor.hh. all of these queues (smp::_qs) are allocated on startup
>>>>>>> in
>>>>>>> smp::configure(). early in reactor::run() (which is effectively each
>>>>>>> seastar
>>>>>>> thread's entrypoint), it registers a smp_poller to poll all of the
>>>>>>> queues
>>>>>>> directed at that cpu
>>>>>>>
>>>>>>> what we need is a way to inject messages into each seastar reactor from
>>>>>>> arbitrary/external threads. our requirements are very similar to
>>>>>
>>>>> i think we will have a sharded<osd::PublicService> on each core. in
>>>>> each instance of PublicService, we will be listening and serving
>>>>> requests from external clients of cluster. the same applies to
>>>>> sharded<osd::ClusterService>, which will be responsible for serving
>>>>> the requests from its peers in the cluster. the control flow of a
>>>>> typical OSD read request from a public RADOS client will look like:
>>>>>
>>>>> 1. the TCP connection is accepted by one of the listening
>>>>> sharded<osd::PublicService>.
>>>>> 2. decode the message
>>>>> 3. osd encapsulates the request in the message as a future, and submit
>>>>> it to another core after hashing the involved pg # to the core #.
>>>>> something like (in pseudo code):
>>>>>    engine().submit_to(osdmap_shard, [] {
>>>>>      return get_newer_osdmap(m->epoch);
>>>>>      // need to figure out how to reference a "osdmap service" in seastar.
>>>>>    }).then([] (auto osdmap) {
>>>>>      submit_to(pg_to_shard(m->ops.op.pg, [] {
>>>>>        return pg.do_ops(m->ops);
>>>>>      });
>>>>>    });
>>>>> 4. the core serving the involved pg (i.e. pg service) will dequeue
>>>>> this request, and use read_dma() call to delegate the aio request to
>>>>> the core maintaining the io queue.
>>>>> 5. once the aio completes, the PublicService will continue on, with
>>>>> the then() block. it will send the response back to client.
>>>>>
>>>>> so question is: why do we need a mpsc queue? the nr_core*nr_core spsc
>>>>> is good enough for us, i think.
>>>>>
>>>>
>>>> Hey Kefu,
>>>>
>>>> That sounds entirely reasonable, but assumes that everything will be running
>>>> inside of seastar from the start. We've been looking for an incremental
>>>> approach that would allow us to start with some subset running inside of
>>>> seastar, with a mechanism for communication between that and the osd's
>>>> existing threads. One suggestion was to start with just the messenger inside
>>>> of seastar, and gradually move that seastar-to-external-thread boundary
>>>> further down the io path as code is refactored to support it. It sounds
>>>> unlikely that we'll ever get rocksdb running inside of seastar, so the
>>>> objectstore will need its own threads until there's a viable alternative.
>>>>
>>>> So the mpsc queue and smp::external_submit_to() interface was a strategy for
>>>> passing messages into seastar from arbitrary non-seastar threads.
>>>> Communication in the other direction just needs to be non-blocking (my
>>>> example just signaled a condition variable without holding its mutex).
>>>>
>>>> What are your thoughts on the incremental approach?
>>
>> yes. if we need send from a thread running a random core, we do need
>> the mpsc queue, and an smp::external_submit_to() interface, as we
>> don't have the access to the TLS "local_engine". but this hybrid
>> approach makes me nervous. as i think seastar is an intrusive
>> framework. we either embrace it or go with our own work queue model.
>> let me give it a try to see if we can have a firewall between the
>> seastar world and the non-seastar world.

We've talked about this pretty extensively and a whole-code-base
transition is just not going to be feasible to do in one go, so we
need an interoperations layer. Hopefully we won't have to cross it
very often (although it will be at least once per op, given BlueStore,
as Casey mentioned).

We haven't thought through all the consequences of that, but it should
be doable since most of the data structures will not cross very often.
Those that might need to be operated on in both sides are probably
already covered by fine-grained locking, and I'm hopeful we can build
a pretty thin hybrid lock that consists of a mutex (used by
non-seastar, and for seastar to claim it from the old world) and a
seastar lock (used by seastar the rest of the time). Things like that
ought to go pretty far.



On Mon, Feb 12, 2018 at 7:55 AM, Matt Benjamin <mbenjami@redhat.com> wrote:
> How does tame reactor induce more OSD sessions (@greg);  @kefu, in't
> the hybrid model another way of saying, tame reactor?  The intuition
> I've had to this point is that the interfacing here is essentially
> similar to making seastar interact with anything else, including
> frameworks (disks, memory devices) that it absolutely wants to and
> must.

That was just if we try to make clients direct all IO to the correct
core immediately, instead of going through a crossbar.
