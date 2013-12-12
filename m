From: "Matt W. Benjamin" <matt@cohortfs.com>
Subject: Re: Ceph Messaging on Accelio (libxio) RDMA
Date: Wed, 11 Dec 2013 20:13:58 -0500 (EST)
Message-ID: <184417606.236.1386810838124.JavaMail.root@thunderbeast.private.linuxbox.com>
References: <CAPYLRzisuLNgx9hU5FPMLDCg+L5vC9m=XVMREs6Ss4aNNViD5Q@mail.gmail.com>
Reply-To: "Matt W. Benjamin" <matt@cohortfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aa.linuxbox.com ([69.128.83.226]:4071 "EHLO aa.linuxbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751438Ab3LLBOH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 11 Dec 2013 20:14:07 -0500
In-Reply-To: <CAPYLRzisuLNgx9hU5FPMLDCg+L5vC9m=XVMREs6Ss4aNNViD5Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>, Yaron Haviv <yaronh@mellanox.com>, Eyal Salomon <esalomon@mellanox.com>

Hi Greg,

I haven't fixed the decision to reify replies in the Messenger at this
point, but it is what the current prototype code tries to do.

The request/response model is more general than my language implied, and
also is not the only one available.  However, it is the richest model in
Accelio, and I'm currently exploring how best to exploit it.

The most general model available sends one-way messages in both directions,
and obviously looks the most like current Messenger model.  Under the covers,
both Accelio models are built on the same primitives.  The one-way model
is not incompatible with zero-copy RDMA operations, though I believe it's
at least trivially true that the one-way model uses only send/recv and
read operations.  Behind the scenes, the underlying Accelio framework
requires a more or less exchange of state between the endpoints to maintain
a balance of RDMA resources in each direction, and to complete RDMA read
and write transactions (which use registered memory at the sender/receiver,
respectively).  This isn't of course something the Messenger consumer needs
to be aware of, except precisely so as to permit the framework to know when
the upper layer operations on registered memory have completed.

As for the higher level semantics, the first thing to note is that all the
Accelio primitives provide for delivery receipts, and one of my goals is to
unify Message acks completely with recepts.  A second key point is that the
primary property of the current reply hook is not it's ability to reply, but
it's completion semantics, and these can be articulated on any of the Accelio
models.  It's possible that's all that's desired.

I'm still exploring is whether the request/response model provides additional
value to the caller that one-way would not.  The third available model would
would use xio response messages to deliver any message available at sthe
responder, so perhaps permitting greater application utilization of the
underlying resources in some circumstances.  I think a lot of this will be
clearer as I connect the XioMessenger to Ceph callers.  As we've worked on the
prototype we've found a number of places where we could tweak the Accelio APIs
to good effect, and I think we'll find more places as continue work.

Matt

----- "Gregory Farnum" <greg@inktank.com> wrote:

> On Wed, Dec 11, 2013 at 2:32 PM, Matt W. Benjamin <matt@cohortfs.com>
> wrote:
> > Hi Ceph devs,
> >
> > For the last several weeks, we've been working with engineers at
> > Mellanox on a prototype Ceph messaging implementation that runs on
> > the Accelio RDMA messaging service (libxio).
> 
> Very cool! An RDMA Messenger has been a cool-sounding project for
> which we haven't been able to get time for several years; I'm glad
> somebody is getting the chance to explore it seriously.
> 
> > Accelio is a rather new effort to build a high-performance,
> high-throughput
> > message passing framework atop openfabrics ibverbs and rdmacm
> primitives.
> >
> > It's early days, but the implementation has started to take shape,
> and
> > gives a feel for what the Accelio architecture looks like when using
> the
> > request-response model, as well as for our prototype mapping of the
> > xio framework concepts to the Ceph ones.
> >
> > The current classes and responsibility breakdown somewhat as
> follows.
> > The key classes in the TCP messaging implementation are:
> >
> > Messenger (abstract, represents a set of bidirectional communication
> endpoints)
> > SimpleMessenger (concrete TCP messenger)
> >
> > Message (abstract, models a message between endpoints, all Ceph
> protocol messages
> > derive from Message, obviously)
> >
> > Connection (concrete, though it -feels- abstract;  Connection models
> a communication
> > endpoint identifiable by address, but has -some- coupling with the
> internals of
> > SimpleMessenger, in particular, with its Pipe, below).
> >
> > Pipe (concrete, an active (threaded) object that encapsulates
> various operations on
> > one side (send or recv) of a TCP connection.  The Pipe is really
> where a -lot- of
> > the heavy lifting of SimpleMessenger is localized, and not just in
> the obvious
> > ways--eg, Pipe drives the dispatch queue in SimpleMessenger, so a
> lot of it's
> > visible semantics are built in cooperation with Pipe).
> >
> > Dispatcher (abstract, models the application processing messages and
> sending replies--ie, the upper edge of Messenger).
> 
> Good summary. You've left me feeling a little embarrassed about the
> Connection class with that description. ;)
> 
> > The approach I took in incorporating Accelio was to build on the key
> abstractions
> > of Messenger, Connection, and Dispatcher, and Message, and build a
> corresponding
> > family of concrete classes:
> >
> > XioMessenger (concrete, implements Messenger, encapsulates xio
> endpoints, aggregates
> > dispatchers as normal).
> >
> > XioConnection (concrete, implements Connection)
> >
> > XioPortal (concrete, a new class that represents worker thread
> contexts for all XioConnections in a given XioMessenger)
> >
> > XioMsg (concrete, a "transfer" class linking a sequence of low-level
> Accelio datagrams with a Message being sent)
> >
> > XioReplyHook (concrete, derived from Ceph::Context [indirectly via
> Message::ReplyHook], links a sequence of low-level Accelio datagrams
> for a Message that has been received-- that is, part of a new "reply"
> abstraction exposed to Message and Messenger).
> >
> > As noted above, there is some leakage of SimpleMessenger primitives
> into classes that are intended to be abstract, and some refactoring
> was needed to fit XioMessenger into the framework.  The main changes I
> prototyped are as follows:
> >
> > All traces of Pipe are removed from Connection, which is made
> abstract.  A new
> > PipeConnection is introduced, that knows about Pipes. 
> SimpleMessenger now uses
> > instances of PipeConnection as its concrete connection type.
> 
> This all makes sense.
> 
> > The most interesting changes I introduced are driven by the need to
> support
> > Accelio's request/response model, which exists mainly to support
> RDMA memory
> > registration primitives, and needs a concrete realization in the
> Messenger
> > framework.
> >
> > To accomodate it, I've introduced two concepts.  First, callers
> replying to a Message use a new Messenger::send_reply(Message *msg,
> Message *reply) method.  In SimpleMessenger, this just maps to a call
> to send_message(Message *, Connection*), but in XioMessenger, the
> reply is delivered through a new Message::reply_hook completion
> functor that XioConnection sets when a message is being dispatched. 
> This is a general mechanism, new Messenger implementations can derive
> from Message::ReplyHook to define their own reply behavior, as
> needed.
> 
> Can you talk more about the request/response model in the
> communication layer and why you're explicitly specifying what
> messages
> are replies to others? I'm not sure what makes that useful, or how a
> model where it is deals with stuff like
> 1) the two "ack/commit" responses to write requests, or
> 2) some of the requests in which there is not an explicit response
> message (especially OSD->monitor stuff like failure reports), or
> 3) where a request does not get a direct response message, but
> triggers a special indirect response of some kind (like the monitor
> not acking a change request explicitly, but making sure to send new
> maps to the person who requested the map change).
> -Greg
> Software Engineer #42 @ http://inktank.com | http://ceph.com

-- 
Matt Benjamin
CohortFS, LLC.
206 South Fifth Ave. Suite 150
Ann Arbor, MI  48104

http://cohortfs.com

tel.  734-761-4689 
fax.  734-769-8938 
cel.  734-216-5309 
