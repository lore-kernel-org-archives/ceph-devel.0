From: Sage Weil <sage@inktank.com>
Subject: Re: Ceph Messaging on Accelio (libxio) RDMA
Date: Wed, 11 Dec 2013 16:59:48 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1312111640550.28299@cobra.newdream.net>
References: <893765832.216.1386801148967.JavaMail.root@thunderbeast.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42947 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076Ab3LLA7s (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Dec 2013 19:59:48 -0500
In-Reply-To: <893765832.216.1386801148967.JavaMail.root@thunderbeast.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Matt W. Benjamin" <matt@cohortfs.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Yaron Haviv <yaronh@mellanox.com>, Eyal Salomon <esalomon@mellanox.com>

Hi Matt,

Thanks for posting this!  Some comments and questions below.

On Wed, 11 Dec 2013, Matt W. Benjamin wrote:
> Hi Ceph devs,
> 
> For the last several weeks, we've been working with engineers at
> Mellanox on a prototype Ceph messaging implementation that runs on
> the Accelio RDMA messaging service (libxio).
> 
> Accelio is a rather new effort to build a high-performance, high-throughput
> message passing framework atop openfabrics ibverbs and rdmacm primitives.

I was originally thinking that xio was going to be more mellanox-specific, 
but it looks like it runs over multiple transports (even tcp!).  (I'm sure 
I've been told this before but it apparently didn't sink in.)  Is there 
also a mellanox-specific backend (that is not ibverbs) that takes any 
special advantage of mellanox hw capabilities?

Similarly, are there other projects or vendors that are looking at xio at 
this point?  I've seen similar attempts to create this sort of library 
(CCI comes to mind: https://github.com/CCI/cci).  Have these previous 
attempts influenced the design of xio at all?

> It's early days, but the implementation has started to take shape, and
> gives a feel for what the Accelio architecture looks like when using the
> request-response model, as well as for our prototype mapping of the
> xio framework concepts to the Ceph ones.
> 
> The current classes and responsibility breakdown somewhat as follows.
> The key classes in the TCP messaging implementation are:
> 
> Messenger (abstract, represents a set of bidirectional communication endpoints)
> SimpleMessenger (concrete TCP messenger)
> 
> Message (abstract, models a message between endpoints, all Ceph protocol messages
> derive from Message, obviously)
> 
> Connection (concrete, though it -feels- abstract;  Connection models a communication
> endpoint identifiable by address, but has -some- coupling with the internals of
> SimpleMessenger, in particular, with its Pipe, below).
> 
> Pipe (concrete, an active (threaded) object that encapsulates various operations on
> one side (send or recv) of a TCP connection.  The Pipe is really where a -lot- of
> the heavy lifting of SimpleMessenger is localized, and not just in the obvious
> ways--eg, Pipe drives the dispatch queue in SimpleMessenger, so a lot of it's
> visible semantics are built in cooperation with Pipe).
> 
> Dispatcher (abstract, models the application processing messages and sending replies--ie, the upper edge of Messenger).
> 
> The approach I took in incorporating Accelio was to build on the key abstractions
> of Messenger, Connection, and Dispatcher, and Message, and build a corresponding
> family of concrete classes:

This sounds like the right approach.  And we definitely want to clean up 
the separation of the abstract interfaces (Message, Connection, Messenger) 
from the implementations.  I'm happy to pull that stuff into the tree 
quickly once the interfaces appear stable (although it looks like your 
branch is based off lots of other linuxbox bits, so it probably isn't 
important until this gets closer to ready).

Also, it would be great to build out the simple_* test endpoints as this 
effort progresses; hopefully that can eventually form the basis of a test 
suite for the messenger and can be expanded to include various stress 
tests that don't require a full running cluster.

> XioMessenger (concrete, implements Messenger, encapsulates xio endpoints, aggregates
> dispatchers as normal).
> 
> XioConnection (concrete, implements Connection)
> 
> XioPortal (concrete, a new class that represents worker thread contexts for all XioConnections in a given XioMessenger)
> 
> XioMsg (concrete, a "transfer" class linking a sequence of low-level Accelio datagrams with a Message being sent)
> 
> XioReplyHook (concrete, derived from Ceph::Context [indirectly via Message::ReplyHook], links a sequence of low-level Accelio datagrams for a Message that has been received-- that is, part of a new "reply" abstraction exposed to Message and Messenger).
> 
> As noted above, there is some leakage of SimpleMessenger primitives into classes that are intended to be abstract, and some refactoring was needed to fit XioMessenger into the framework.  The main changes I prototyped are as follows:
> 
> All traces of Pipe are removed from Connection, which is made abstract.  A new
> PipeConnection is introduced, that knows about Pipes.  SimpleMessenger now uses
> instances of PipeConnection as its concrete connection type.
> 
> The most interesting changes I introduced are driven by the need to support
> Accelio's request/response model, which exists mainly to support RDMA memory
> registration primitives, and needs a concrete realization in the Messenger
> framework.
> 
> To accomodate it, I've introduced two concepts.  First, callers replying 
> to a Message use a new Messenger::send_reply(Message *msg, Message 
> *reply) method.  In SimpleMessenger, this just maps to a call to 
> send_message(Message *, Connection*), but in XioMessenger, the reply is 
> delivered through a new Message::reply_hook completion functor that 
> XioConnection sets when a message is being dispatched.  This is a 
> general mechanism, new Messenger implementations can derive from 
> Message::ReplyHook to define their own reply behavior, as needed.

This worries me a bit; see Greg's questions.  There are several 
request/reply patterns, but many (most?) of the message exchanges are 
asymmetrical.  I wonder if the low-level request/reply model really maps 
more closely the 'ack' stuff in SimpleMessenger (as it's about 
deallocating the sender's memory and cleaning up rdma state).

> A lot of low level details of the mapping from Message to Accelio 
> messaging are currently in flux, but the basic idea is to re-use the 
> current encode/decode primitives as far as possible, while eliding the 
> acks, sequence # and tids, and timestamp behaviors of Pipe, or rather, 
> replacing them with mappings to Accelio primitives.  I have some wrapper 
> classes that help with this.  For the moment, the existing Ceph message 
> headers and footers are still there, but are now encoded/decoded, rather 
> than hand-marshalled.  This means that checksumming is probably mostly 
> intact.  Message signatures are not implemented.
> 
> What works.  The current prototype isn't integrated with the main server daemons
> (e.g., OSD) but experimental work on that is in progress.  I've created a pair of
> simple standalone client/server applications simple_server/simple_client and
> a matching xio_server/xio_client, that provide a minimal message dispatch loop with
> a new SimpleDispatcher class and some other helpers, as a way to work with both
> messengers side-by-side.  These are currently very primitive, but will probably
> do more things soon.  The current prototype sends messages over Accelio, but has some issue
> with replies, that should be fixed shortly.  It leaks lots of memory, etc.
> 
> We've pushed a work-in-progress branch "xio-messenger" to our external github
> repository, for community review.  Find it here:
> 
> https://github.com/linuxbox2/linuxbox-ceph

Looking through this, it occurs to me that there are some other 
foundational pieces that we'll need to get in place soon:

 - The XioMessenger is a completely different wire protocol that needs to 
be distinct from the legacy protocol.  Probably we can use the 
entity_addr_t::type field for this.
 - We'll want the various *Map structures to allow multiple 
entity_addr_t's per entity.  We already could use this to support both 
IPv4 and IPv6.  In the future, though, we'll probably want clusters that 
can speak both the legacy TCP protocol (via SimpleMessenger or some 
improved implementation) and the xio one (and whatever else we dream up in 
the future).

Also, as has been mentioned previously,

 - We need to continue to migrate stuff over to the Connection-based 
Messenger interface and off the original methods that take entity_inst_t.  
The sticky bit here is the peer-to-peer mode that is used inside the OSD 
and MDS clusters: those need to handle racing connection attempts, which 
either requires the internal entity name -> connection map to resolve 
races (as we have now) or a new approach that pushes the race-resolution 
up into the calling code (meh).  No need to address it now, but eventually 
we'll need to tackle it before this can be used on the osd back-side 
network.

sage
