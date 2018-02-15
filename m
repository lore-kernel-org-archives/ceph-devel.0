From: Josh Durgin <jdurgin@redhat.com>
Subject: Re: seastar and 'tame reactor'
Date: Thu, 15 Feb 2018 15:04:09 -0500 (EST)
Message-ID: <436191308.2816757.1518725049269.JavaMail.zimbra@redhat.com>
References: <d0f50268-72bb-1196-7ce9-0b9e21808ffb@redhat.com> <5b32056c-c6f7-a1c4-d07a-ae04557b59cf@redhat.com> <CAJE9aOOq+HAWZOec0TnSqXFqUx7GD=XgCByh8HFV9Rb8L8qc2A@mail.gmail.com> <9e6bc174-c6b3-a37e-abd5-b96d572d1d1b@redhat.com> <BN6PR04MB021259DB8517A45C39427D62F1F70@BN6PR04MB0212.namprd04.prod.outlook.com> <766c2ea4-93a0-3c8c-038a-67c4b4bda9b9@redhat.com> <CACKY0b-U=1AgzWaUPze_Wvt2rXYt+Uk+Cg3_Dv2H5-hyq9ykdw@mail.gmail.com> <BN6PR04MB0212DDBED5C85B62F2078A94F1F50@BN6PR04MB0212.namprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52554 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1162374AbeBOUEK (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 15 Feb 2018 15:04:10 -0500
In-Reply-To: <BN6PR04MB0212DDBED5C85B62F2078A94F1F50@BN6PR04MB0212.namprd04.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Allen Samuels <Allen.Samuels@wdc.com>
Cc: liuchang0812 <liuchang0812@gmail.com>, Casey Bodley <cbodley@redhat.com>, kefu chai <tchaikov@gmail.com>, Adam Emerson <aemerson@redhat.com>, Gregory Farnum <gfarnum@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

That's a good description of adapting traditional threaded code to
cooperative threading.  I agree it wouldn't be that much more work to
make a seastar <-> cooperative threading interface - in fact, seastar
already implements one via its own thread primitive, using
setcontext/longjmp etc. under the hood.

The difficulty of this approach lies in making this work across
cores. For rocksdb in particular, making use of multiple cores is
necessary for compaction to keep up under heavy write and delete
workloads. This implies creating an M:N scheduler, which is quite a
bit of extra complexity.

The purpose of the tame reactor approach is to keep the existing
threaded code running while parts of it have been converted to seastar
native interfaces, so we can adapt the osd incrementally. Keeping the
threaded portion using kernel threads using the kernel scheduler
avoids significant complexity here.

Keeping the interface between seastar + threaded code explicit is an
advantage as well, since it makes it clear just from reading the code
which context it is running in.

Josh


----- Original Message -----
> From: "Allen Samuels" <Allen.Samuels@wdc.com>
> To: "liuchang0812" <liuchang0812@gmail.com>, "Casey Bodley" <cbodley@redhat.com>
> Cc: "kefu chai" <tchaikov@gmail.com>, "Josh Durgin" <jdurgin@redhat.com>, "Adam Emerson" <aemerson@redhat.com>,
> "Gregory Farnum" <gfarnum@redhat.com>, "ceph-devel" <ceph-devel@vger.kernel.org>
> Sent: Tuesday, February 13, 2018 7:16:26 PM
> Subject: RE: seastar and 'tame reactor'
> 
> I'm not a RocksDB expert, but I did peak at the code. There really seems to
> be two different isolation strategies at play here, one strategy is
> associated with the "env" structure which seems to use a classic
> abstract-base-class and virtual functions to provide environment dependent
> implementations at run-time (mostly of the file-oriented operations). The
> second strategy (embodied in the ".../port/port_xxx.h" directory and
> assorted files) is a compile-time capability.
> 
> We could have a long discussion on the desirability of one scheme over the
> other (which have different advantages/disadvantages) and the appropriate
> places to use one or the other, but for my purposes, I'm going to leave that
> for a later day. I'm simply going to assume that we have the ability to
> replace each of the objects and APIs that might cause context switches with
> our own implementation of same and ignore all of the difficulty and
> negatives associated with having that capability (they are legion !), we can
> return to that discussion later if there is a belief in the merits of this
> proposal.
> 
> I'm also going to say that I have only a cursory understanding of seastar, so
> no doubt, there will be inaccuracies stemming from that too....
> 
> The essential problem confronting us is how to convert the "synchronous"
> RocksDB interface (i.e., subroutine calls with threads that block as
> required) into  the "asynchronous" seastar-style interface (promises,
> futures, etc.) without re-writing all of the code.
> 
> The problem with the Rocks interface is that when a client calls a Rocks API,
> that API runs on the caller's stack and might invoke an operation that would
> block -- thereby freezing the entire seastar machine. Without loss of
> generality, I'll model all blocking operations as a combination of three
> events: (1) transmission of a "request" message to a recipient, (2)
> suspension of the calling activity [blocking], and (3) resumption of the
> blocking activity by the recipient or his agent [unblocking]. The purpose of
> (1) is to inform the recipient of of the responsibility of unblocking this
> requestor in the future. This easily models synchronous I/O operations,
> synchronization primitives, timers and other implicitly blocking operations
> (like calling the kernel to allocate some pages).
> 
> The solution is simple user-space stack switching, which is supported by the
> standard C library routines makecontext, setcontext, swapcontext, and
> getcontext. If you're not familiar with those, go read up on 'em.
> 
> In the proposed solution we intercept each Rocks call BEFORE it goes into
> Rocks code (again, I'll assume the appropriate compatibility/interceptor
> layer to exist with detailed implementation discussion deferred), create a
> NEW stack (getcontext, makecontext, swapcontext/setcontext) that's different
> from the seastar thread stack and to invoke the actual Rocks API code using
> the new stack. If the Rocks code completes without blocking all is well and
> good, you return back to seastar (setcontext/swapcontext) and exercise the
> fast-path case of satisfying your future/promise immediately. However, if
> the Rocks code needs to block, our new compatibility layer will perform
> operations (1) and (2)  and then switch BACK to the calling seastar stack
> indicating that the work is still in progress. Now the seastar machiner is
> fully operational (even though one call is suspending -- blocked ).
> Eventually, (3) happens at which point the recipient cases a switch to the
> suspended stack (swapcontext/setcontext) resuming the previously suspended
> Rocks code (yes, some magic is required, see below). If that API call now
> completes you switch back to seastar and satisfy the original invoking
> promise/future and all is good (yea, recover the stack, blah blah). Of
> course the API call could block again, which is fine you just go back and do
> it again :).
> 
> Internal Rocks threads aren't really much different, the thread-start proxy
> just treats them as an external call as described above. Once they're
> started -- their associated stack never goes away (until the equivalent of
> join at shutdown).
> 
> Basically, we've simply built a small operating system except it's using
> non-preemptive scheduling.
> 
> Careful readers will notice that steps (2) and (3) really have two sub-cases.
> In one sub-case, the message recipient is another seastar promise/future
> (this happens with sync primitives) and is relatively easy to implement
> without any external locks (since it's all being done within the realm of a
> single seastar thread, no locking is required). The other sub-case is the
> more interesting case of when the message recipient is NOT within the
> seastar framework -- think I/O operation, etc. This is where my lack of
> detailed knowledge of seastar will show, it's relatively easy to do (2),
> since this ought not invoke anything worse than putting a message on a queue
> (which can be lockless) and then setting a condition variable to wake up the
> external entity that's going to do the actual processing (which shouldn't
> block). This might even be short-circuited in say the case of an SPDK I/O
> operation where seastar could actually queue the request and simply assume
> that some other agent will eventually detect the I/O completion (in essence
> the NVMe queue becomes of the recipient of the message). Doing (3) is the
> tricky part, seastar is going to have to poll some kind of message queue
> that contains unblocking messages from the external world, again this could
> be lockless, but it will need to be polled with the appropriate frequency to
> make sure that nothing gets starved out (indeed the interceptor layer
> described above is likely required to perform this polling as well as other
> places in seastar land).
> 
> That's it in a nutshell. The mini-operating system isn't that difficult to
> write. Almost all of the basic Rocks API operations are easily handled with
> some simple macros and templated classes. The basic internal stack switching
> isn't very difficult either -- though it can be a bit of bi**ch to debug if
> you're not used to have stacks switching out from underneath of you :)
> 
> Allen Samuels
> R&D Engineering Fellow
> 
> Western Digital®
> Email:  allen.samuels@wdc.com
> Office:  +1-408-801-7030
> Mobile: +1-408-780-6416
> 
> -----Original Message-----
> From: liuchang0812 [mailto:liuchang0812@gmail.com]
> Sent: Tuesday, February 13, 2018 8:17 AM
> To: Casey Bodley <cbodley@redhat.com>
> Cc: Allen Samuels <Allen.Samuels@wdc.com>; kefu chai <tchaikov@gmail.com>;
> Josh Durgin <jdurgin@redhat.com>; Adam Emerson <aemerson@redhat.com>;
> Gregory Farnum <gfarnum@redhat.com>; ceph-devel <ceph-devel@vger.kernel.org>
> Subject: Re: seastar and 'tame reactor'
> 
> rocksdb abstracts those synchronization primitives in
> https://github.com/facebook/rocksdb/blob/master/port/port.h. and here is a
> example port:
> https://github.com/facebook/rocksdb/blob/master/port/port_example.h
> 
> 2018-02-13 23:46 GMT+08:00, Casey Bodley <cbodley@redhat.com>:
> >
> >
> > On 02/12/2018 02:40 PM, Allen Samuels wrote:
> >> I would think that it ought to be reasonably straightforward to get
> >> RocksDB (or other thread-based foreign code) to run under the seastar
> >> framework provided that you're able to locate all os-invoking
> >> primitives within the foreign code and convert those into calls into
> >> your compatibility layer. That layer would have to simulate context
> >> switching (relatively easy) as well as provide an implementation of
> >> that kernel call. In the case of RocksDB, some of that work has
> >> already been done (generally, the file and I/O operations are done
> >> through a compatibility layer that's provided as a parameter. I'm not
> >> as sure about the synchronization primitives, but it ought to be
> >> relatively easy to extend to cover those).
> >>
> >> Has this been discussed?
> >
> > I don't think it has, no. I'm not familiar with these rocksdb env
> > interfaces, but this sounds promising.
> >
> >>
> >> Allen Samuels
> >> R&D Engineering Fellow
> >>
> >> Western Digital®
> >> Email:  allen.samuels@wdc.com
> >> Office:  +1-408-801-7030
> >> Mobile: +1-408-780-6416
> >>
> >>
> >>> -----Original Message-----
> >>> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> >>> owner@vger.kernel.org] On Behalf Of Casey Bodley
> >>> Sent: Wednesday, February 07, 2018 9:11 AM
> >>> To: kefu chai <tchaikov@gmail.com>; Josh Durgin <jdurgin@redhat.com>
> >>> Cc: Adam Emerson <aemerson@redhat.com>; Gregory Farnum
> >>> <gfarnum@redhat.com>; ceph-devel <ceph-devel@vger.kernel.org>
> >>> Subject: Re: seastar and 'tame reactor'
> >>>
> >>>
> >>> On 02/07/2018 11:01 AM, kefu chai wrote:
> >>>> On Wed, Jan 31, 2018 at 6:32 AM, Josh Durgin <jdurgin@redhat.com>
> >>> wrote:
> >>>>> [adding ceph-devel]
> >>>>>
> >>>>> On 01/30/2018 01:56 PM, Casey Bodley wrote:
> >>>>>> Hey Josh,
> >>>>>>
> >>>>>> I heard you mention in the call yesterday that you're looking
> >>>>>> into this part of seastar integration. I was just reading through
> >>>>>> the relevant code over the weekend, and wanted to compare notes:
> >>>>>>
> >>>>>>
> >>>>>> in seastar, all cross-core communication goes through lockfree
> >>>>>> spsc queues, which are encapsulated by 'class smp_message_queue'
> >>>>>> in core/reactor.hh. all of these queues (smp::_qs) are allocated
> >>>>>> on startup in smp::configure(). early in reactor::run() (which is
> >>>>>> effectively each seastar thread's entrypoint), it registers a
> >>>>>> smp_poller to poll all of the queues directed at that cpu
> >>>>>>
> >>>>>> what we need is a way to inject messages into each seastar
> >>>>>> reactor from arbitrary/external threads. our requirements are
> >>>>>> very similar to
> >>>> i think we will have a sharded<osd::PublicService> on each core. in
> >>>> each instance of PublicService, we will be listening and serving
> >>>> requests from external clients of cluster. the same applies to
> >>>> sharded<osd::ClusterService>, which will be responsible for serving
> >>>> the requests from its peers in the cluster. the control flow of a
> >>>> typical OSD read request from a public RADOS client will look like:
> >>>>
> >>>> 1. the TCP connection is accepted by one of the listening
> >>>> sharded<osd::PublicService>.
> >>>> 2. decode the message
> >>>> 3. osd encapsulates the request in the message as a future, and
> >>>> submit it to another core after hashing the involved pg # to the core #.
> >>>> something like (in pseudo code):
> >>>>     engine().submit_to(osdmap_shard, [] {
> >>>>       return get_newer_osdmap(m->epoch);
> >>>>       // need to figure out how to reference a "osdmap service" in
> >>>> seastar.
> >>>>     }).then([] (auto osdmap) {
> >>>>       submit_to(pg_to_shard(m->ops.op.pg, [] {
> >>>>         return pg.do_ops(m->ops);
> >>>>       });
> >>>>     });
> >>>> 4. the core serving the involved pg (i.e. pg service) will dequeue
> >>>> this request, and use read_dma() call to delegate the aio request
> >>>> to the core maintaining the io queue.
> >>>> 5. once the aio completes, the PublicService will continue on, with
> >>>> the then() block. it will send the response back to client.
> >>>>
> >>>> so question is: why do we need a mpsc queue? the nr_core*nr_core
> >>>> spsc is good enough for us, i think.
> >>>>
> >>> Hey Kefu,
> >>>
> >>> That sounds entirely reasonable, but assumes that everything will be
> >>> running inside of seastar from the start. We've been looking for an
> >>> incremental approach that would allow us to start with some subset
> >>> running inside of seastar, with a mechanism for communication
> >>> between that and the osd's existing threads. One suggestion was to
> >>> start with just the messenger inside of seastar, and gradually move
> >>> that seastar-to-external-thread boundary further down the io path as
> >>> code is refactored to support it. It sounds unlikely that we'll ever
> >>> get rocksdb running inside of seastar, so the objectstore will need
> >>> its own threads until there's a viable alternative.
> >>>
> >>> So the mpsc queue and smp::external_submit_to() interface was a
> >>> strategy for passing messages into seastar from arbitrary non-seastar
> >>> threads.
> >>> Communication in the other direction just needs to be non-blocking
> >>> (my example just signaled a condition variable without holding its
> >>> mutex).
> >>>
> >>> What are your thoughts on the incremental approach?
> >>>
> >>> Casey
> >>>
> >>> ps. I'd love to see more thought put into the design of the finished
> >>> product, and your outline is a good start! Avi Kivity @scylladb
> >>> shared one suggestion that I really liked, which was to give each
> >>> shard of the osd a separate network endpoint, and add enough
> >>> information to the osdmap so that clients could send their messages
> >>> directly to the shard that would process them. That piece can come
> >>> in later, but could eliminate some of the extra latency from your
> >>> step 3.
> >>> --
> >>> To unsubscribe from this list: send the line "unsubscribe
> >>> ceph-devel" in the body of a message to majordomo@vger.kernel.org
> >>> More majordomo info at http://vger.kernel.org/majordomo-info.html
> >> N     r  y   b X  ǧv ^ )޺{.n +   z ]z   {ay  ʇڙ ,j   f   h   z   w
>    j:+v   w j m         zZ+     ݢj"  !tml=
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> > in the body of a message to majordomo@vger.kernel.org More majordomo
> > info at  http://vger.kernel.org/majordomo-info.html
> >
> N�����r��y���b�X��ǧv�^�)޺{.n�+���z�]z���{ay�ʇڙ�,j��f���h���z��w������j:+v���w�j�m��������zZ+��ݢj"��
