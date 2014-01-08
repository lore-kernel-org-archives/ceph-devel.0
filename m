From: "Atchley, Scott" <atchleyes@ornl.gov>
Subject: Re: Ceph Messaging on Accelio (libxio) RDMA
Date: Wed, 8 Jan 2014 10:54:09 -0500
Message-ID: <758124F7-93AE-4AE0-8F69-84FDF5B1F2F7@ornl.gov>
References: <1902512897.238.1386812020862.JavaMail.root@thunderbeast.private.linuxbox.com>
 <1D2558BD-5FB5-455B-A8BF-87D9A634698C@ornl.gov>
 <DD06A08C9A04024C8B0D8A63110C7E14A289D5CA@MTRDAG01.mtl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mta01.ornl.gov ([128.219.177.14]:60991 "EHLO mta01.ornl.gov"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755224AbaAHPyM convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Jan 2014 10:54:12 -0500
In-Reply-To: <DD06A08C9A04024C8B0D8A63110C7E14A289D5CA@MTRDAG01.mtl.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yaron Haviv <yaronh@mellanox.com>
Cc: "Matt W. Benjamin" <matt@cohortfs.com>, Sage Weil <sage@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>, Eyal Salomon <esalomon@mellanox.com>

On Jan 7, 2014, at 2:52 PM, Yaron Haviv <yaronh@mellanox.com> wrote:

> Scott, See below
> 
>> -----Original Message-----
>> From: Atchley, Scott [mailto:atchleyes@ornl.gov]
>> Sent: Monday, January 06, 2014 5:55 PM
>> To: Matt W. Benjamin
>> Cc: Sage Weil; ceph-devel; Yaron Haviv; Eyal Salomon
>> Subject: Re: Ceph Messaging on Accelio (libxio) RDMA
>> 
>> On Dec 11, 2013, at 8:33 PM, Matt W. Benjamin <matt@cohortfs.com>
>> wrote:
>>> HI Sage,
>>> 
>>> inline
>>> 
>>> ----- "Sage Weil" <sage@inktank.com> wrote:
>>> 
>>>> Hi Matt,
>>>> 
>>>> Thanks for posting this!  Some comments and questions below.
>>>> 
>>>> 
>>>> I was originally thinking that xio was going to be more
>>>> mellanox-specific, but it looks like it runs over multiple transports
>>>> (even tcp!).  (I'm sure I've been told this before but it apparently
>>>> didn't sink in.)  Is there also a mellanox-specific backend (that is
>>>> not ibverbs) that takes any
>>>> 
>>>> special advantage of mellanox hw capabilities?
>>> 
>>> The actual situation is that xio is currently ibverbs specific, though
>>> there is interest with Mellanox and some partners in building a TCP
>>> transport for it.
>>> 
>>> What is true is that xio makes very advanced use of ibverbs
>>> interfaces, lock free/wait-free allocators, rdtsc, but hides a lot of
>>> details from upper layers.  The xio designers knew how to get the most
>>> from infiniband/ RDMA, and it shows.
>>> 
>>> Also, ibverbs is a first-class interface to iWARP and esp.
>>> ROCE hardware, as well as ib.  I've been doing most of my development
>>> on a tweaked version of the softiwarp ib provider, which amounts to a
>>> full RDMA simulator that runs on anything.  (Apparently it can run
>>> over TCP, but I just use it on one vm host.)
>>> 
>>> I haven't worked with cci, but just glancing at it, I'd say xio stacks
>>> up very well on ibverbs, but won't solve the TCP transport problem
>>> immediately.
>> 
>> The efforts seem similar, but with slightly different goals.
>> 
>> With CCI, our goal is to provide a vendor-neutral and fabric-neutral, generic
>> communication abstraction layer for any interconnect that we use. Each
>> generation of large HPC machine seems to get a new interface. The various
>> MPI implementations have their own network abstract layers (NAL) so that
>> MPI users do not need to worry about the low-level network interface. MPI,
>> however, is limited to jobs within a single machine and, typically, to within a
>> single job on that single machine. A researcher wanting to develop
>> alternative programming models or services that connect multiple jobs or
>> extend off the compute system have a hard, if not impossible, time using
>> MPI. We currently support Sockets (UDP and TCP), Verbs (IB and ROCE, but
>> probably not iWarp because we use SRQs), Cray GNI (Gemini and Aries), and
>> slightly out-of-date Cray Portals3 (SeaStar). We are working on adding shared
>> memory as well as transparent routing between fabrics so that a compute
>> node on one fabric can route to a storage system on another fabric.
>> 
> [[YH]]
> 
> Accelio is an open source, vendor and transport neutral, works over any RDMA device, and the TCP transport is progress
> It has different focus than CCI, CCI seems similar to our MXM library used for MPI/SHMEM/PGAS/..

I thought MXM was a tag matching interface more similar to PSM or MX, no?

> While Accelio is Enterprise messaging and RPC focused, its goal is to maximize performance in a noisy event driven environment
> And have end to end transaction reliability, including dealing with extreme failure cases, task cancelation and retransmission, multipath, data-integrity ..

Interesting.

> It has C/C++/Java bindings, and Python in progress
> 
> We have noticed that most of our partners and OpenSource efforts repeat the same mistakes, duplicate a lot of code, and end up with partial functionality
> So we decided to write a common layer that deal with all the new age transport challenges, and taking into account our experience
> Can read the details in: http://www.accelio.org/wp-content/themes/pyramid_child/pdf/WP_Accelio_OpenSource_IO_Message_and_RPC_Acceleration_Library.pdf

Nice overview. Like many white papers, it oversells what is available today (e.g. includes shmem and TCP). ;-)

The Send/Receive interface seems very much like CCI. I can see where building Request/Response on top is trivial. One big difference I can see if the XIO session/connection versus CCI's endpoint/connection. XIO allows polling per connection while CCI only allows polling per endpoint (by one or more threads).

XIO claims to provide multi-pathing. Does XIO allow for reliable, but out-of-order delivery of messages that can happen with multi-pathing? If not, how does it guarantee order? Buffering on the receiver?

> Accelio is now used by Tier1/2 storage and database vendors, and integrate into few OpenSource Storage/DB/NoSQL/NewSQL projects
> One open example is Hadoop
> 
> 
>> I would imagine Mellanox's goal with XIO is to provide a simpler programming
>> model that masks native Verbs and RDMACM for Verbs compatible fabrics
>> (IB, RoCE, and possibly iWarp if they do not use SRQs). It adds an active
>> message-like model as well as access to the underlying messaging layer. The
>> addition of TCP and shared memory makes sense.
>> 
> [[YH]]
> As I mentioned the goal is to provide the best fast/reliable messaging layer
> It provide many integrated services that are not part of the common Verbs API
> 
>> Both provide an event-driven model and include the ability to provide
>> notification via traditional OS methods such as epoll() and others.
>> 
>> I am unclear if XIO provides for background progress or if the application
>> must periodically call into XIO to ensure progress.
>> 
> [[YH]]
> Accelio support interrupts and polling, it works well with both and automatically toggles between those when needed to max performance and min CPU overhead
> It's a bit different than the MPI models which make heavy use of polling, given MPI does computation/communication intervals and CPU can allow itself to busy wait

If an application is using the soon-to-be written TCP transport, does XIO progress the server side automatically or does the application have to call into XIO calls to ensure progress? I imagine when using Verbs-supported hardware, the answer is that it is automatic. I would expect that with TCP that the application must call into XIO or that XIO uses a background thread for TCP. Or is the design still being hashed out?

Same question for shared memory.

>>>> Similarly, are there other projects or vendors that are looking at
>>>> xio at this point?
>>> 
>>> Mellanox partners are working with it mainly, I believe.
>>> 
>>>> I've seen similar attempts to create this sort of library
>>>> 
>>>> (CCI comes to mind: https://github.com/CCI/cci).  Have these previous
>>>> 
>>>> attempts influenced the design of xio at all?
>>> 
> [[YH]]
> 
> The major influence on Accelio design came from storage and DB based RDMA protocols, and lessons we learned (e.g. Accelio is lockless unlike the current ones)
> we obviously did quite a bit of review with our MPI and MXM experts
> 
> we would be happy to share with you more details and examples

Absolutely. I would appreciate more information and we can take it offline. I am interested in knowing what is needed to add a transport to XIO. I need more details about internal resource usage and scaling issues.