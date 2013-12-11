From: "Matt W. Benjamin" <matt@cohortfs.com>
Subject: Ceph Messaging on Accelio (libxio) RDMA
Date: Wed, 11 Dec 2013 17:32:28 -0500 (EST)
Message-ID: <893765832.216.1386801148967.JavaMail.root@thunderbeast.private.linuxbox.com>
Reply-To: "Matt W. Benjamin" <matt@cohortfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aa.linuxbox.com ([69.128.83.226]:1178 "EHLO aa.linuxbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751084Ab3LKWck (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 11 Dec 2013 17:32:40 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>
Cc: Sage Weil <sage@inktank.com>, Yaron Haviv <yaronh@mellanox.com>, Eyal Salomon <esalomon@mellanox.com>

Hi Ceph devs,

For the last several weeks, we've been working with engineers at
Mellanox on a prototype Ceph messaging implementation that runs on
the Accelio RDMA messaging service (libxio).

Accelio is a rather new effort to build a high-performance, high-throughput
message passing framework atop openfabrics ibverbs and rdmacm primitives.

It's early days, but the implementation has started to take shape, and
gives a feel for what the Accelio architecture looks like when using the
request-response model, as well as for our prototype mapping of the
xio framework concepts to the Ceph ones.

The current classes and responsibility breakdown somewhat as follows.
The key classes in the TCP messaging implementation are:

Messenger (abstract, represents a set of bidirectional communication endpoints)
SimpleMessenger (concrete TCP messenger)

Message (abstract, models a message between endpoints, all Ceph protocol messages
derive from Message, obviously)

Connection (concrete, though it -feels- abstract;  Connection models a communication
endpoint identifiable by address, but has -some- coupling with the internals of
SimpleMessenger, in particular, with its Pipe, below).

Pipe (concrete, an active (threaded) object that encapsulates various operations on
one side (send or recv) of a TCP connection.  The Pipe is really where a -lot- of
the heavy lifting of SimpleMessenger is localized, and not just in the obvious
ways--eg, Pipe drives the dispatch queue in SimpleMessenger, so a lot of it's
visible semantics are built in cooperation with Pipe).

Dispatcher (abstract, models the application processing messages and sending replies--ie, the upper edge of Messenger).

The approach I took in incorporating Accelio was to build on the key abstractions
of Messenger, Connection, and Dispatcher, and Message, and build a corresponding
family of concrete classes:

XioMessenger (concrete, implements Messenger, encapsulates xio endpoints, aggregates
dispatchers as normal).

XioConnection (concrete, implements Connection)

XioPortal (concrete, a new class that represents worker thread contexts for all XioConnections in a given XioMessenger)

XioMsg (concrete, a "transfer" class linking a sequence of low-level Accelio datagrams with a Message being sent)

XioReplyHook (concrete, derived from Ceph::Context [indirectly via Message::ReplyHook], links a sequence of low-level Accelio datagrams for a Message that has been received-- that is, part of a new "reply" abstraction exposed to Message and Messenger).

As noted above, there is some leakage of SimpleMessenger primitives into classes that are intended to be abstract, and some refactoring was needed to fit XioMessenger into the framework.  The main changes I prototyped are as follows:

All traces of Pipe are removed from Connection, which is made abstract.  A new
PipeConnection is introduced, that knows about Pipes.  SimpleMessenger now uses
instances of PipeConnection as its concrete connection type.

The most interesting changes I introduced are driven by the need to support
Accelio's request/response model, which exists mainly to support RDMA memory
registration primitives, and needs a concrete realization in the Messenger
framework.

To accomodate it, I've introduced two concepts.  First, callers replying to a Message use a new Messenger::send_reply(Message *msg, Message *reply) method.  In SimpleMessenger, this just maps to a call to send_message(Message *, Connection*), but in XioMessenger, the reply is delivered through a new Message::reply_hook completion functor that XioConnection sets when a message is being dispatched.  This is a general mechanism, new Messenger implementations can derive from Message::ReplyHook to define their own reply behavior, as needed.

A lot of low level details of the mapping from Message to Accelio messaging are
currently in flux, but the basic idea is to re-use the current encode/decode primitives as far as possible, while eliding the acks, sequence # and tids, and timestamp behaviors of Pipe, or rather, replacing them with mappings to Accelio primitives.  I have some wrapper classes that help with this.  For the moment, the existing Ceph message headers and footers are still there, but are now encoded/decoded, rather than hand-marshalled.  This means that checksumming 
is probably mostly intact.  Message signatures are not implemented.

What works.  The current prototype isn't integrated with the main server daemons
(e.g., OSD) but experimental work on that is in progress.  I've created a pair of
simple standalone client/server applications simple_server/simple_client and
a matching xio_server/xio_client, that provide a minimal message dispatch loop with
a new SimpleDispatcher class and some other helpers, as a way to work with both
messengers side-by-side.  These are currently very primitive, but will probably
do more things soon.  The current prototype sends messages over Accelio, but has some issue
with replies, that should be fixed shortly.  It leaks lots of memory, etc.

We've pushed a work-in-progress branch "xio-messenger" to our external github
repository, for community review.  Find it here:

https://github.com/linuxbox2/linuxbox-ceph

Thanks!

Matt

-- 
Matt Benjamin
CohortFS, LLC.
206 South Fifth Ave. Suite 150
Ann Arbor, MI  48104

http://cohortfs.com

tel.  734-761-4689 
fax.  734-769-8938 
cel.  734-216-5309 
