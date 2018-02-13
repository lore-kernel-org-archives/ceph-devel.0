From: liuchang0812 <liuchang0812@gmail.com>
Subject: Re: seastar and 'tame reactor'
Date: Wed, 14 Feb 2018 00:17:18 +0800
Message-ID: <CACKY0b-U=1AgzWaUPze_Wvt2rXYt+Uk+Cg3_Dv2H5-hyq9ykdw@mail.gmail.com>
References: <d0f50268-72bb-1196-7ce9-0b9e21808ffb@redhat.com>
 <5b32056c-c6f7-a1c4-d07a-ae04557b59cf@redhat.com> <CAJE9aOOq+HAWZOec0TnSqXFqUx7GD=XgCByh8HFV9Rb8L8qc2A@mail.gmail.com>
 <9e6bc174-c6b3-a37e-abd5-b96d572d1d1b@redhat.com> <BN6PR04MB021259DB8517A45C39427D62F1F70@BN6PR04MB0212.namprd04.prod.outlook.com>
 <766c2ea4-93a0-3c8c-038a-67c4b4bda9b9@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f46.google.com ([209.85.215.46]:46584 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934454AbeBMQRV (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Feb 2018 11:17:21 -0500
Received: by mail-lf0-f46.google.com with SMTP id q194so25773229lfe.13
        for <ceph-devel@vger.kernel.org>; Tue, 13 Feb 2018 08:17:20 -0800 (PST)
In-Reply-To: <766c2ea4-93a0-3c8c-038a-67c4b4bda9b9@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Casey Bodley <cbodley@redhat.com>
Cc: Allen Samuels <Allen.Samuels@wdc.com>, kefu chai <tchaikov@gmail.com>, Josh Durgin <jdurgin@redhat.com>, Adam Emerson <aemerson@redhat.com>, Gregory Farnum <gfarnum@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

rocksdb abstracts those synchronization primitives in
https://github.com/facebook/rocksdb/blob/master/port/port.h. and here
is a example port:
https://github.com/facebook/rocksdb/blob/master/port/port_example.h

2018-02-13 23:46 GMT+08:00, Casey Bodley <cbodley@redhat.com>:
>
>
> On 02/12/2018 02:40 PM, Allen Samuels wrote:
>> I would think that it ought to be reasonably straightforward to get
>> RocksDB (or other thread-based foreign code) to run under the seastar
>> framework provided that you're able to locate all os-invoking primitives
>> within the foreign code and convert those into calls into your
>> compatibility layer. That layer would have to simulate context switching
>> (relatively easy) as well as provide an implementation of that kernel
>> call. In the case of RocksDB, some of that work has already been done
>> (generally, the file and I/O operations are done through a compatibility
>> layer that's provided as a parameter. I'm not as sure about the
>> synchronization primitives, but it ought to be relatively easy to extend
>> to cover those).
>>
>> Has this been discussed?
>
> I don't think it has, no. I'm not familiar with these rocksdb env
> interfaces, but this sounds promising.
>
>>
>> Allen Samuels
>> R&D Engineering Fellow
>>
>> Western Digital=C2=AE
>> Email:  allen.samuels@wdc.com
>> Office:  +1-408-801-7030
>> Mobile: +1-408-780-6416
>>
>>
>>> -----Original Message-----
>>> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
>>> owner@vger.kernel.org] On Behalf Of Casey Bodley
>>> Sent: Wednesday, February 07, 2018 9:11 AM
>>> To: kefu chai <tchaikov@gmail.com>; Josh Durgin <jdurgin@redhat.com>
>>> Cc: Adam Emerson <aemerson@redhat.com>; Gregory Farnum
>>> <gfarnum@redhat.com>; ceph-devel <ceph-devel@vger.kernel.org>
>>> Subject: Re: seastar and 'tame reactor'
>>>
>>>
>>> On 02/07/2018 11:01 AM, kefu chai wrote:
>>>> On Wed, Jan 31, 2018 at 6:32 AM, Josh Durgin <jdurgin@redhat.com>
>>> wrote:
>>>>> [adding ceph-devel]
>>>>>
>>>>> On 01/30/2018 01:56 PM, Casey Bodley wrote:
>>>>>> Hey Josh,
>>>>>>
>>>>>> I heard you mention in the call yesterday that you're looking into
>>>>>> this part of seastar integration. I was just reading through the
>>>>>> relevant code over the weekend, and wanted to compare notes:
>>>>>>
>>>>>>
>>>>>> in seastar, all cross-core communication goes through lockfree spsc
>>>>>> queues, which are encapsulated by 'class smp_message_queue' in
>>>>>> core/reactor.hh. all of these queues (smp::_qs) are allocated on
>>>>>> startup in smp::configure(). early in reactor::run() (which is
>>>>>> effectively each seastar thread's entrypoint), it registers a
>>>>>> smp_poller to poll all of the queues directed at that cpu
>>>>>>
>>>>>> what we need is a way to inject messages into each seastar reactor
>>>>>> from arbitrary/external threads. our requirements are very similar
>>>>>> to
>>>> i think we will have a sharded<osd::PublicService> on each core. in
>>>> each instance of PublicService, we will be listening and serving
>>>> requests from external clients of cluster. the same applies to
>>>> sharded<osd::ClusterService>, which will be responsible for serving
>>>> the requests from its peers in the cluster. the control flow of a
>>>> typical OSD read request from a public RADOS client will look like:
>>>>
>>>> 1. the TCP connection is accepted by one of the listening
>>>> sharded<osd::PublicService>.
>>>> 2. decode the message
>>>> 3. osd encapsulates the request in the message as a future, and submit
>>>> it to another core after hashing the involved pg # to the core #.
>>>> something like (in pseudo code):
>>>>     engine().submit_to(osdmap_shard, [] {
>>>>       return get_newer_osdmap(m->epoch);
>>>>       // need to figure out how to reference a "osdmap service" in
>>>> seastar.
>>>>     }).then([] (auto osdmap) {
>>>>       submit_to(pg_to_shard(m->ops.op.pg, [] {
>>>>         return pg.do_ops(m->ops);
>>>>       });
>>>>     });
>>>> 4. the core serving the involved pg (i.e. pg service) will dequeue
>>>> this request, and use read_dma() call to delegate the aio request to
>>>> the core maintaining the io queue.
>>>> 5. once the aio completes, the PublicService will continue on, with
>>>> the then() block. it will send the response back to client.
>>>>
>>>> so question is: why do we need a mpsc queue? the nr_core*nr_core spsc
>>>> is good enough for us, i think.
>>>>
>>> Hey Kefu,
>>>
>>> That sounds entirely reasonable, but assumes that everything will be
>>> running
>>> inside of seastar from the start. We've been looking for an incremental
>>> approach that would allow us to start with some subset running inside o=
f
>>> seastar, with a mechanism for communication between that and the osd's
>>> existing threads. One suggestion was to start with just the messenger
>>> inside
>>> of seastar, and gradually move that seastar-to-external-thread boundary
>>> further down the io path as code is refactored to support it. It sounds
>>> unlikely that we'll ever get rocksdb running inside of seastar, so the
>>> objectstore will need its own threads until there's a viable
>>> alternative.
>>>
>>> So the mpsc queue and smp::external_submit_to() interface was a strateg=
y
>>> for passing messages into seastar from arbitrary non-seastar threads.
>>> Communication in the other direction just needs to be non-blocking (my
>>> example just signaled a condition variable without holding its mutex).
>>>
>>> What are your thoughts on the incremental approach?
>>>
>>> Casey
>>>
>>> ps. I'd love to see more thought put into the design of the finished
>>> product,
>>> and your outline is a good start! Avi Kivity @scylladb shared one
>>> suggestion
>>> that I really liked, which was to give each shard of the osd a separate
>>> network
>>> endpoint, and add enough information to the osdmap so that clients coul=
d
>>> send their messages directly to the shard that would process them. That
>>> piece can come in later, but could eliminate some of the extra latency
>>> from
>>> your step 3.
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
>>> the
>>> body of a message to majordomo@vger.kernel.org More majordomo info at
>>> http://vger.kernel.org/majordomo-info.html
>> N=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDr=EF=BF=BD=EF=BF=BDy=EF=BF=
=BD=EF=BF=BD=EF=BF=BDb=EF=BF=BDX=EF=BF=BD=EF=BF=BD=C7=A7v=EF=BF=BD^=EF=BF=
=BD)=DE=BA{.n=EF=BF=BD+=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD]z=EF=BF=BD=EF=
=BF=BD=EF=BF=BD{ay=EF=BF=BD =CA=87=DA=99=EF=BF=BD,j =EF=BF=BD=EF=BF=BDf=EF=
=BF=BD=EF=BF=BD=EF=BF=BDh=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD
>> =EF=BF=BDw=EF=BF=BD=EF=BF=BD=EF=BF=BD=0C=EF=BF=BD=EF=BF=BD=EF=BF=BDj:+v=
=EF=BF=BD=EF=BF=BD=EF=BF=BDw=EF=BF=BDj=EF=BF=BDm=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDzZ+=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=DD=A2j"=EF=BF=BD=EF=BF=BD!tml=3D
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
