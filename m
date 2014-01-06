From: "Atchley, Scott" <atchleyes@ornl.gov>
Subject: Re: Ceph Messaging on Accelio (libxio) RDMA
Date: Mon, 6 Jan 2014 10:55:13 -0500
Message-ID: <1D2558BD-5FB5-455B-A8BF-87D9A634698C@ornl.gov>
References: <1902512897.238.1386812020862.JavaMail.root@thunderbeast.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mta02.ornl.gov ([128.219.177.12]:9293 "EHLO mta02.ornl.gov"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754551AbaAFQFD convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Jan 2014 11:05:03 -0500
In-Reply-To: <1902512897.238.1386812020862.JavaMail.root@thunderbeast.private.linuxbox.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Matt W. Benjamin" <matt@cohortfs.com>
Cc: Sage Weil <sage@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>, Yaron Haviv <yaronh@mellanox.com>, Eyal Salomon <esalomon@mellanox.com>

On Dec 11, 2013, at 8:33 PM, Matt W. Benjamin <matt@cohortfs.com> wrote:

> HI Sage,
> 
> inline
> 
> ----- "Sage Weil" <sage@inktank.com> wrote:
> 
>> Hi Matt,
>> 
>> Thanks for posting this!  Some comments and questions below.
>> 
>> 
>> I was originally thinking that xio was going to be more
>> mellanox-specific, 
>> but it looks like it runs over multiple transports (even tcp!).  (I'm
>> sure 
>> I've been told this before but it apparently didn't sink in.)  Is
>> there 
>> also a mellanox-specific backend (that is not ibverbs) that takes any
>> 
>> special advantage of mellanox hw capabilities?
> 
> The actual situation is that xio is currently ibverbs specific, though
> there is interest with Mellanox and some partners in building a TCP
> transport for it.
> 
> What is true is that xio makes very advanced use of ibverbs interfaces,
> lock free/wait-free allocators, rdtsc, but hides a lot of details from
> upper layers.  The xio designers knew how to get the most from infiniband/
> RDMA, and it shows.
> 
> Also, ibverbs is a first-class interface to iWARP and esp.
> ROCE hardware, as well as ib.  I've been doing most of my development on
> a tweaked version of the softiwarp ib provider, which amounts to a full
> RDMA simulator that runs on anything.  (Apparently it can run over TCP,
> but I just use it on one vm host.)
> 
> I haven't worked with cci, but just glancing at it, I'd say xio stacks
> up very well on ibverbs, but won't solve the TCP transport problem
> immediately.

The efforts seem similar, but with slightly different goals.

With CCI, our goal is to provide a vendor-neutral and fabric-neutral, generic communication abstraction layer for any interconnect that we use. Each generation of large HPC machine seems to get a new interface. The various MPI implementations have their own network abstract layers (NAL) so that MPI users do not need to worry about the low-level network interface. MPI, however, is limited to jobs within a single machine and, typically, to within a single job on that single machine. A researcher wanting to develop alternative programming models or services that connect multiple jobs or extend off the compute system have a hard, if not impossible, time using MPI. We currently support Sockets (UDP and TCP), Verbs (IB and ROCE, but probably not iWarp because we use SRQs), Cray GNI (Gemini and A
 ries), and slightly out-of-date Cray Portals3 (SeaStar). We are working on adding shared memory as well as transparent routing between fabrics so that a compute node on one fabric can route to a storage system on another fabric.

I would imagine Mellanox's goal with XIO is to provide a simpler programming model that masks native Verbs and RDMACM for Verbs compatible fabrics (IB, RoCE, and possibly iWarp if they do not use SRQs). It adds an active message-like model as well as access to the underlying messaging layer. The addition of TCP and shared memory makes sense.

Both provide an event-driven model and include the ability to provide notification via traditional OS methods such as epoll() and others.

I am unclear if XIO provides for background progress or if the application must periodically call into XIO to ensure progress.

> 
>> 
>> Similarly, are there other projects or vendors that are looking at xio
>> at 
>> this point?
> 
> Mellanox partners are working with it mainly, I believe.
> 
>> I've seen similar attempts to create this sort of library
>> 
>> (CCI comes to mind: https://github.com/CCI/cci).  Have these previous
>> 
>> attempts influenced the design of xio at all?
> 
>>> 
>>> The approach I took in incorporating Accelio was to build on the key
>> abstractions
>>> of Messenger, Connection, and Dispatcher, and Message, and build a
>> corresponding
>>> family of concrete classes:
>> 
>> This sounds like the right approach.  And we definitely want to clean
>> up 
>> the separation of the abstract interfaces (Message, Connection,
>> Messenger) 
>> from the implementations.  I'm happy to pull that stuff into the tree
>> 
>> quickly once the interfaces appear stable (although it looks like your
>> 
>> branch is based off lots of other linuxbox bits, so it probably isn't
>> 
>> important until this gets closer to ready).
> 
> Ok, cool.
> 
>> 
>> Also, it would be great to build out the simple_* test endpoints as
>> this 
>> effort progresses; hopefully that can eventually form the basis of a
>> test 
>> suite for the messenger and can be expanded to include various stress
>> 
>> tests that don't require a full running cluster.
> 
> I agree.  I intend to have it at least running more Message types
> RSN.
> 
>> 
>>> XioMessenger (concrete, implements Messenger, encapsulates xio
>> endpoints, aggregates
> 
> Agreed, I respond to this point in more detail in my reply to Greg's
> message.
> 
>> 
>> This worries me a bit; see Greg's questions.  There are several 
>> request/reply patterns, but many (most?) of the message exchanges are
>> 
>> asymmetrical.  I wonder if the low-level request/reply model really
>> maps 
>> more closely the 'ack' stuff in SimpleMessenger (as it's about 
>> deallocating the sender's memory and cleaning up rdma state).
>> 
>>> A lot of low level details of the mapping from Message to Accelio 
>>> messaging are currently in flux, but the basic idea is to re-use the
>> 
>>> current encode/decode primitives as far as possible, while eliding
>> the 
>>> acks, sequence # and tids, and timestamp behaviors of Pipe, or
>> rather, 
>>> replacing them with mappings to Accelio primitives.  I have some
>> wrapper 
>>> classes that help with this.  For the moment, the existing Ceph
>> message 
>>> headers and footers are still there, but are now encoded/decoded,
>> rather 
>>> than hand-marshalled.  This means that checksumming is probably
>> mostly 
>>> intact.  Message signatures are not implemented.
>>> 
>>> What works.  The current prototype isn't integrated with the main
>> server daemons
>>> (e.g., OSD) but experimental work on that is in progress.  I've
>> created a pair of
>>> simple standalone client/server applications
>> simple_server/simple_client and
>>> a matching xio_server/xio_client, that provide a minimal message
>> dispatch loop with
>>> a new SimpleDispatcher class and some other helpers, as a way to
>> work with both
>>> messengers side-by-side.  These are currently very primitive, but
>> will probably
>>> do more things soon.  The current prototype sends messages over
>> Accelio, but has some issue
>>> with replies, that should be fixed shortly.  It leaks lots of
>> memory, etc.
>>> 
>>> We've pushed a work-in-progress branch "xio-messenger" to our
>> external github
>>> repository, for community review.  Find it here:
>>> 
>>> https://github.com/linuxbox2/linuxbox-ceph
>> 
>> Looking through this, it occurs to me that there are some other 
>> foundational pieces that we'll need to get in place soon:
>> 
>> - The XioMessenger is a completely different wire protocol that needs
>> to 
>> be distinct from the legacy protocol.  Probably we can use the 
>> entity_addr_t::type field for this.
>> - We'll want the various *Map structures to allow multiple 
>> entity_addr_t's per entity.  We already could use this to support both
>> 
>> IPv4 and IPv6.  In the future, though, we'll probably want clusters
>> that 
>> can speak both the legacy TCP protocol (via SimpleMessenger or some 
>> improved implementation) and the xio one (and whatever else we dream
>> up in 
>> the future).
> 
> Ack.
> 
>> 
>> Also, as has been mentioned previously,
>> 
>> - We need to continue to migrate stuff over to the Connection-based 
>> Messenger interface and off the original methods that take
>> entity_inst_t.  
>> The sticky bit here is the peer-to-peer mode that is used inside the
>> OSD 
>> and MDS clusters: those need to handle racing connection attempts,
>> which 
>> either requires the internal entity name -> connection map to resolve
>> 
>> races (as we have now) or a new approach that pushes the
>> race-resolution 
>> up into the calling code (meh).  No need to address it now, but
>> eventually 
>> we'll need to tackle it before this can be used on the osd back-side 
>> network.
>> 
>> sage
> 
> -- 
> Matt Benjamin
> CohortFS, LLC.
> 206 South Fifth Ave. Suite 150
> Ann Arbor, MI  48104
> 
> http://cohortfs.com
> 
> tel.  734-761-4689 
> fax.  734-769-8938 
> cel.  734-216-5309 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

