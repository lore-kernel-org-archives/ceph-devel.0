From: Yaron Haviv <yaronh@mellanox.com>
Subject: RE: Ceph Messaging on Accelio (libxio) RDMA
Date: Wed, 8 Jan 2014 17:31:32 +0000
Message-ID: <DD06A08C9A04024C8B0D8A63110C7E14A28A059A@MTRDAG01.mtl.com>
References: <1902512897.238.1386812020862.JavaMail.root@thunderbeast.private.linuxbox.com>
 <1D2558BD-5FB5-455B-A8BF-87D9A634698C@ornl.gov>
 <DD06A08C9A04024C8B0D8A63110C7E14A289D5CA@MTRDAG01.mtl.com>
 <758124F7-93AE-4AE0-8F69-84FDF5B1F2F7@ornl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from eu1sys200aog117.obsmtp.com ([207.126.144.143]:42335 "EHLO
	eu1sys200aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932068AbaAHRbl convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 8 Jan 2014 12:31:41 -0500
In-Reply-To: <758124F7-93AE-4AE0-8F69-84FDF5B1F2F7@ornl.gov>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Atchley, Scott" <atchleyes@ornl.gov>
Cc: "Matt W. Benjamin" <matt@cohortfs.com>, Sage Weil <sage@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>, Eyal Salomon <esalomon@mellanox.com>

> -----Original Message-----
> From: Atchley, Scott [mailto:atchleyes@ornl.gov]
> Sent: Wednesday, January 08, 2014 5:54 PM
> To: Yaron Haviv
> Cc: Matt W. Benjamin; Sage Weil; ceph-devel; Eyal Salomon
> Subject: Re: Ceph Messaging on Accelio (libxio) RDMA
> 
> On Jan 7, 2014, at 2:52 PM, Yaron Haviv <yaronh@mellanox.com> wrote:
> 
> > Scott, See below
> >
> >> -----Original Message-----
> >> From: Atchley, Scott [mailto:atchleyes@ornl.gov]
> >> Sent: Monday, January 06, 2014 5:55 PM
> >> To: Matt W. Benjamin
> >> Cc: Sage Weil; ceph-devel; Yaron Haviv; Eyal Salomon
> >> Subject: Re: Ceph Messaging on Accelio (libxio) RDMA
> >>
> >> On Dec 11, 2013, at 8:33 PM, Matt W. Benjamin <matt@cohortfs.com>
> >> wrote:
> >>> HI Sage,
> >>>
> >>> inline
> >>>
> >>> ----- "Sage Weil" <sage@inktank.com> wrote:
> >>>
> >>>> Hi Matt,
> >>>>
> >>>> Thanks for posting this!  Some comments and questions below.
> >>>>
> >>>>
> >>>> I was originally thinking that xio was going to be more
> >>>> mellanox-specific, but it looks like it runs over multiple
> >>>> transports (even tcp!).  (I'm sure I've been told this before but
> >>>> it apparently didn't sink in.)  Is there also a mellanox-specific
> >>>> backend (that is not ibverbs) that takes any
> >>>>
> >>>> special advantage of mellanox hw capabilities?
> >>>
> >>> The actual situation is that xio is currently ibverbs specific,
> >>> though there is interest with Mellanox and some partners in building
> >>> a TCP transport for it.
> >>>
> >>> What is true is that xio makes very advanced use of ibverbs
> >>> interfaces, lock free/wait-free allocators, rdtsc, but hides a lot
> >>> of details from upper layers.  The xio designers knew how to get the
> >>> most from infiniband/ RDMA, and it shows.
> >>>
> >>> Also, ibverbs is a first-class interface to iWARP and esp.
> >>> ROCE hardware, as well as ib.  I've been doing most of my
> >>> development on a tweaked version of the softiwarp ib provider, which
> >>> amounts to a full RDMA simulator that runs on anything.  (Apparently
> >>> it can run over TCP, but I just use it on one vm host.)
> >>>
> >>> I haven't worked with cci, but just glancing at it, I'd say xio
> >>> stacks up very well on ibverbs, but won't solve the TCP transport
> >>> problem immediately.
> >>
> >> The efforts seem similar, but with slightly different goals.
> >>
> >> With CCI, our goal is to provide a vendor-neutral and fabric-neutral,
> >> generic communication abstraction layer for any interconnect that we
> >> use. Each generation of large HPC machine seems to get a new
> >> interface. The various MPI implementations have their own network
> >> abstract layers (NAL) so that MPI users do not need to worry about
> >> the low-level network interface. MPI, however, is limited to jobs
> >> within a single machine and, typically, to within a single job on
> >> that single machine. A researcher wanting to develop alternative
> >> programming models or services that connect multiple jobs or extend
> >> off the compute system have a hard, if not impossible, time using
> >> MPI. We currently support Sockets (UDP and TCP), Verbs (IB and ROCE,
> >> but probably not iWarp because we use SRQs), Cray GNI (Gemini and
> >> Aries), and slightly out-of-date Cray Portals3 (SeaStar). We are
> >> working on adding shared memory as well as transparent routing
> between fabrics so that a compute node on one fabric can route to a storage
> system on another fabric.
> >>
> > [[YH]]
> >
> > Accelio is an open source, vendor and transport neutral, works over
> > any RDMA device, and the TCP transport is progress It has different focus
> than CCI, CCI seems similar to our MXM library used for
> MPI/SHMEM/PGAS/..
> 
> I thought MXM was a tag matching interface more similar to PSM or MX, no?
> 
[YH] 
MXM stands for Mellanox Messaging Service, and is integrated into things like OpenMPI and OFED
 
> > While Accelio is Enterprise messaging and RPC focused, its goal is to
> > maximize performance in a noisy event driven environment And have end
> to end transaction reliability, including dealing with extreme failure cases,
> task cancelation and retransmission, multipath, data-integrity ..
> 
> Interesting.
> 
> > It has C/C++/Java bindings, and Python in progress
> >
> > We have noticed that most of our partners and OpenSource efforts
> > repeat the same mistakes, duplicate a lot of code, and end up with
> > partial functionality So we decided to write a common layer that deal
> > with all the new age transport challenges, and taking into account our
> > experience Can read the details in:
> > http://www.accelio.org/wp-
> content/themes/pyramid_child/pdf/WP_Accelio_
> > OpenSource_IO_Message_and_RPC_Acceleration_Library.pdf
> 
> Nice overview. Like many white papers, it oversells what is available today
> (e.g. includes shmem and TCP). ;-)
> 
[YH]
the paper is very much aligned with the current functionality, with exception of extra transports  
TCP is already under development and I hope will be uploaded in few weeks, for more functionality we are seeking help from the community as any other OpenSource project  
You can download the code and try out the examples, it's pretty stable (runs daily regression, and used by a bunch of vendors), V1 GA is 3 weeks from now 
e.g. with the R-AIO file I/O example and standard fio benchmark you will get 2-2.5M IOPs, and <10us access-time to a remote /dev/ram   (i.e. 10x faster than anything else I know)
interestingly the Java version gets 99% of the C performance, i.e. Millions of TP/s, main reason is the fact the CPU cores don't wonder around or lock and the transport is in HW  

> The Send/Receive interface seems very much like CCI. I can see where
> building Request/Response on top is trivial. 
[YH] 
Note sure reliable and Async Req/Rep with all the associated task management and races is trivial :) 
We spend quite a bit of time on that, old transports like ZMQ still didn't get there (e.g. no Async Rep, don't deal w Multi-path, ..) 

One big difference I can see if
> the XIO session/connection versus CCI's endpoint/connection. XIO allows
> polling per connection while CCI only allows polling per endpoint (by one or
> more threads).
> 
[YH] 
Accelio is lockless, and allocate dedicated resources per CPU thread (context), even mem allocations are done smart from the nearest Numa banks to avoid coherency overhead  
By default you don't need to poll and batch, you get call-backs with optional hints, we decide the strategy based on various aspects automagically 
You can poll explicitly either per I/O (e.g. in case u want to wait for result, just pass the time as argument in the call) or per context/event-loop (e.g. tell the context that  it can poll x us before arming the interrupts to avoid hysteresis)  
Polling is done per context/thread (not per connection), and aggregate all the connections in that thread, we work on extension to poll on other resources as well in the same context (e.g. libaio for disk) 
It has automatic mechanism to avoid starvation and serialization issues, and amortize OS/HW calls whenever possible 
  
> XIO claims to provide multi-pathing. Does XIO allow for reliable, but out-of-
> order delivery of messages that can happen with multi-pathing? If not, how
> does it guarantee order? Buffering on the receiver?
> 
[YH] 
Accelio tag each message with a seq/tid number, and server side re-order the messages (just move pointers, no copy) 
In case of failures Accelio will re-send from the last accepted ID, client free mem buffer only when response arrives (or Ack in case of sends) 
Accelio support resource load-balancing and session/connection redirect (e.g. like iSCSI redirect) which allow distributing client sessions across multiple ports, threads, local or cluster end-points, and its  transparent to the client operation
for single connection we have initial version of Active/Passive, Active/Active will be addressed in next ver

> > Accelio is now used by Tier1/2 storage and database vendors, and
> > integrate into few OpenSource Storage/DB/NoSQL/NewSQL projects One
> > open example is Hadoop
> >
> >
> >> I would imagine Mellanox's goal with XIO is to provide a simpler
> >> programming model that masks native Verbs and RDMACM for Verbs
> >> compatible fabrics (IB, RoCE, and possibly iWarp if they do not use
> >> SRQs). It adds an active message-like model as well as access to the
> >> underlying messaging layer. The addition of TCP and shared memory
> makes sense.
> >>
> > [[YH]]
> > As I mentioned the goal is to provide the best fast/reliable messaging
> > layer It provide many integrated services that are not part of the
> > common Verbs API
> >
> >> Both provide an event-driven model and include the ability to provide
> >> notification via traditional OS methods such as epoll() and others.
> >>
> >> I am unclear if XIO provides for background progress or if the
> >> application must periodically call into XIO to ensure progress.
> >>
> > [[YH]]
> > Accelio support interrupts and polling, it works well with both and
> > automatically toggles between those when needed to max performance
> and
> > min CPU overhead It's a bit different than the MPI models which make
> > heavy use of polling, given MPI does computation/communication
> > intervals and CPU can allow itself to busy wait
> 
> If an application is using the soon-to-be written TCP transport, does XIO
> progress the server side automatically or does the application have to call
> into XIO calls to ensure progress? I imagine when using Verbs-supported
> hardware, the answer is that it is automatic. I would expect that with TCP
> that the application must call into XIO or that XIO uses a background thread
> for TCP. Or is the design still being hashed out?
> 
> Same question for shared memory.
> 
[YH] 
Application doesn't change if you change transport 
It just registers a call-back, that will get notified once req or rep message arrived and/or got accepted by the peer (we have an optional barrier/ack)
The App model is simple send a bunch or requests, and get called back when the answer arrived, call-back provide all the message details/context so you can process it asynchronously 
Its explained in the WP in more details (and it all works in reality :) )  

> >>>> Similarly, are there other projects or vendors that are looking at
> >>>> xio at this point?
> >>>
> >>> Mellanox partners are working with it mainly, I believe.
> >>>
> >>>> I've seen similar attempts to create this sort of library
> >>>>
> >>>> (CCI comes to mind: https://github.com/CCI/cci).  Have these
> >>>> previous
> >>>>
> >>>> attempts influenced the design of xio at all?
> >>>
> > [[YH]]
> >
> > The major influence on Accelio design came from storage and DB based
> > RDMA protocols, and lessons we learned (e.g. Accelio is lockless
> > unlike the current ones) we obviously did quite a bit of review with
> > our MPI and MXM experts
> >
> > we would be happy to share with you more details and examples
> 
> Absolutely. I would appreciate more information and we can take it offline. I
> am interested in knowing what is needed to add a transport to XIO. I need
> more details about internal resource usage and scaling issues.
[YH] 
Sure, we can arrange a call and explain the details, would be happy to see people writing more transports and add features
Can start with the transport h file  
e.g. one of our partners is planning to do a PCIe transport, we have discussions with some KVM Guru's on doing a dedicated Virtio transport to max perf in para-virtualized mode, .. 

Yaron
