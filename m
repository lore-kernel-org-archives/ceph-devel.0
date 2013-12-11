From: Gregory Farnum <greg@inktank.com>
Subject: Re: Ceph Messaging on Accelio (libxio) RDMA
Date: Wed, 11 Dec 2013 14:58:01 -0800
Message-ID: <CAPYLRzisuLNgx9hU5FPMLDCg+L5vC9m=XVMREs6Ss4aNNViD5Q@mail.gmail.com>
References: <893765832.216.1386801148967.JavaMail.root@thunderbeast.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qe0-f50.google.com ([209.85.128.50]:61483 "EHLO
	mail-qe0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751502Ab3LKW6D convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Dec 2013 17:58:03 -0500
Received: by mail-qe0-f50.google.com with SMTP id 1so5933164qec.37
        for <ceph-devel@vger.kernel.org>; Wed, 11 Dec 2013 14:58:01 -0800 (PST)
In-Reply-To: <893765832.216.1386801148967.JavaMail.root@thunderbeast.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Matt W. Benjamin" <matt@cohortfs.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>, Yaron Haviv <yaronh@mellanox.com>, Eyal Salomon <esalomon@mellanox.com>

On Wed, Dec 11, 2013 at 2:32 PM, Matt W. Benjamin <matt@cohortfs.com> wrote:
> Hi Ceph devs,
>
> For the last several weeks, we've been working with engineers at
> Mellanox on a prototype Ceph messaging implementation that runs on
> the Accelio RDMA messaging service (libxio).

Very cool! An RDMA Messenger has been a cool-sounding project for
which we haven't been able to get time for several years; I'm glad
somebody is getting the chance to explore it seriously.

> Accelio is a rather new effort to build a high-performance, high-throughput
> message passing framework atop openfabrics ibverbs and rdmacm primitives.
>
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

Good summary. You've left me feeling a little embarrassed about the
Connection class with that description. ;)

> The approach I took in incorporating Accelio was to build on the key abstractions
> of Messenger, Connection, and Dispatcher, and Message, and build a corresponding
> family of concrete classes:
>
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

This all makes sense.

> The most interesting changes I introduced are driven by the need to support
> Accelio's request/response model, which exists mainly to support RDMA memory
> registration primitives, and needs a concrete realization in the Messenger
> framework.
>
> To accomodate it, I've introduced two concepts.  First, callers replying to a Message use a new Messenger::send_reply(Message *msg, Message *reply) method.  In SimpleMessenger, this just maps to a call to send_message(Message *, Connection*), but in XioMessenger, the reply is delivered through a new Message::reply_hook completion functor that XioConnection sets when a message is being dispatched.  This is a general mechanism, new Messenger implementations can derive from Message::ReplyHook to define their own reply behavior, as needed.

Can you talk more about the request/response model in the
communication layer and why you're explicitly specifying what messages
are replies to others? I'm not sure what makes that useful, or how a
model where it is deals with stuff like
1) the two "ack/commit" responses to write requests, or
2) some of the requests in which there is not an explicit response
message (especially OSD->monitor stuff like failure reports), or
3) where a request does not get a direct response message, but
triggers a special indirect response of some kind (like the monitor
not acking a change request explicitly, but making sure to send new
maps to the person who requested the map change).
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
