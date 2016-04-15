From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Ann Arbor Team's Flexible I/O Proposals (Ceph Next)
Date: Fri, 15 Apr 2016 15:09:57 -0700
Message-ID: <CAJ4mKGbhPrFbMKJi_hKAP1rKzjnX8GqQGMP+m7C_io-m1VDquA@mail.gmail.com>
References: <20160415210536.GA16458@ultraspiritum.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f49.google.com ([209.85.213.49]:36532 "EHLO
	mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751844AbcDOWJ6 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Apr 2016 18:09:58 -0400
Received: by mail-vk0-f49.google.com with SMTP id c4so163191018vkb.3
        for <ceph-devel@vger.kernel.org>; Fri, 15 Apr 2016 15:09:58 -0700 (PDT)
In-Reply-To: <20160415210536.GA16458@ultraspiritum.redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On Fri, Apr 15, 2016 at 2:05 PM, Adam C. Emerson <aemerson@redhat.com> =
wrote:
> Ceph Developers,
>
> We've put together a few of the main ideas from our previous work in =
a
> brief form that we hope people will be able to digest, consider, and
> debate. We'd also like to discuss them with you at Ceph Next this
> Tuesday.
>
> Thank you.
>
>
> ---8<---
>
>
> We have been looking at improvements to Ceph, particularly RADOS,
> while focusing on flexibility (allowing users to do more things)
> and performance. We have come up with a few proposals with these two
> things in mind. Sessions and read-write transactions aim to allow
> clients to batch up multiple operations in a way that is safe and
> correct, while allowing clients to gain the advantages of atomic
> read-write operations without having to lock. Sessions also provide
> a foundation for flow-control which ultimately improves performance
> by preventing an OSD from being ground into uselessness under a
> storm of impossible requests. The CLS proposal is a logical follow-on
> from the read-write proposal, as we attempt to address some problems
> of correctness that exist now and consider how to integrate the
> facility into an asynchronous world.
>
> Flexible Placement, as you would expect from the name, is about
> allowing users more control, as are Flexible Semantics. They both
> have profound performance implications, as tuning placement to better
> match a workload can increase throughput, and relaxed consistency can
> decrease latency. The proposed Interfaces are meant to support both a=
s
> well as work currently being done to allow an asynchronous OSD and to
> hide details like locking and thread pools so that backends can be
> written with different forms of concurrency and load-balancing
> across processors.
>
> Finally, Map Partitioning is not directly related to code paths withi=
n
> the OSD itself, but does affect everything that can be done with Ceph=
=2E
> People are beginning to run into limits on how large a Ceph cluster c=
an
> grow and how many ways they can be partitioned, and both these proble=
ms
> fundamentally derive from the way the OSD map is handled by the monit=
ors.
>
> There are also some notes at the end. They are not critical, but if y=
ou
> find yourself asking "What were they thinking?" the notes might help.
>
> # Sessions and Read-Write #
>
> From `ReplicatedPG.cc`.
>
> ```c++
> // Write operations aren't allowed to return a data payload because
> // we can't do so reliably. If the client has to resend the request
> // and it has already been applied, we will return 0 with no
> // payload.  Non-deterministic behavior is no good.  However, it is
> // possible to construct an operation that does a read, does a guard
> // check (e.g., CMPXATTR), and then a write.  Then we either succeed
> // with the write, or return a CMPXATTR and the read value.
> =E2=80=A6
> if (ctx->op_t->empty() || result < 0) {
>   =E2=80=A6
>   if (ctx->pending_async_reads.empty()) {
>     complete_read_ctx(result, ctx);
>   } else {
>     in_progress_async_reads.push_back(make_pair(op, ctx));
>     ctx->start_async_reads(this);
>   }
>   return;
> }
> =E2=80=A6
> // issue replica writes
> ceph_tid_t rep_tid =3D osd->get_tid();
>
> RepGather *repop =3D new_repop(ctx, obc, rep_tid);
>
> issue_repop(repop, ctx);
> eval_repop(repop);
> ```
>
> As you can see, if we have any writes (all mutations end up in the
> `op_t` transaction), we just flat out don't do the requested read
> operations. If we don't have any writes, we perform the read
> operations and return.  This is justified in the comment above becaus=
e
> of the non-deterministic behavior of resent read-write operations.
>
> This is not an unsolved problem and we can bootstrap a solution on ou=
r
> existing `Session` infrastructure.
>
> ## An upgraded session ##
>
> Behold, `OSDSession`:
> ```c++
> struct Session : public RefCountedObject {
>   EntityName entity_name;
>   OSDCap caps;
>   int64_t auid;
>   ConnectionRef con;
>   WatchConState wstate;
>   =E2=80=A6
> };
> ```
>
> This structure exists once for every connection to the OSD. Where the=
y
> are created depends on who is doing the creation. In the case of
> clients (what we're interested in) it occurs in `ms_handle_authorizer=
i`
> ```c++
> =E2=80=A6
> isvalid =3D authorize_handler->verify_authorizer(cct, monc->rotating_=
secrets,
>                                                authorizer_data, autho=
rizer_reply, name, global_id, caps_info, session_key, &auid);
>
> if (isvalid) {
>   Session *s =3D static_cast<Session *>(con->get_priv());
>   if (!s) {
>     s =3D new Session(cct);
>     con->set_priv(s->get());
>     s->con =3D con;
>     dout(10) << " new session " << s << " con=3D" << s->con << " addr=
=3D" << s->con->get_peer_addr() << dendl;
>   }
>
>   s->entity_name =3D name;
>   if (caps_info.allow_all)
>     s->caps.set_allow_all();
>   s->auid =3D auid;
>   =E2=80=A6
> }
> ```
>
> In order to solve this problem, we propose a new data structure,
> modelled on NFSv4.1
> ```c++
> struct OpSlot {
>   uint64_t seq;
>   int r;
>   MOSDOpReplyRef cached; // Nullable
>   bool completed;
> };
> ```
>
> We do not want to give the OSD an unbounded obligation to hang on to
> old message replies: that way lies madness. So, the additions to
> `Session` we might make are:
>
> ```c++
> struct Session : public RefCountedObject {
>   =E2=80=A6
>   uint32_t maxslots; // The maximum number of operations this client
>                      // may have in flight at once;
>   std::vector<OpSlot> slots // The vector of in-progress operations
>   ceph::timespan slots_expire; // How long we wait to hear from a
>                                // client before the OSD is free to
>                                // drop session resources
>   cepu::coarse_mono_time last_contact; // When (by our measure) we
>                                        // last received an operation
>                                        // from the client.
> };
> ```
>
> ## Message Additions ##
>
> The OSD needs to communicate this information to the client. The most
> useful way to do this is with an addition to `MOSDOpReply`.
>
> ```c++
> class MOSDOpReply : public Message {
>   =E2=80=A6
>   uint32_t this_slot;
>   uint64_t this_seq;
>   uint32_t max_slot;
>   ceph::timespan timeout;
>   =E2=80=A6
> };
> ```
>
> This overlaps with the function of the transaction ID, since the
> slot/sequence/OSD triple uniquely identifies an operation. Unlike the
> transaction ID, this provides consistent semantics and a measure of
> flow control.
>
> To match our reply, the `MOSDOp` would need to be amended.
> ```c++
> class MOSDOp : public Message {
>   =E2=80=A6
>   uint32_t this_slot;
>   uint64_t this_seq;
>   bool please_cache;
>   =E2=80=A6
> };
> ```
>
> ## Operations ##
>
> ### Connecting ###
>
> A client, upon connecting to an OSD for the first time should send a
> `this_slot` of 0 and a `this_seq` of 0. If it reconnects to an OSD it
> should use the `this_slot` and `this_seq` values from before it lost
> its connection. If an OSD has state for a client and receives a
> `(slot,seq) =3D (0,0)` then it should feel free to free any saved sta=
te
> and start anew.
>
> ### OSD Feedback ###
>
> In every `MOSDOpReply` the OSD should send `this_slot` and `this_seq`=
 to
> the value from the `MOSDOp` to which we're replying.
>
> More usefully, the OSD can inform the client how many operations it i=
s
> allowed to send concurrently with `max_slot`. The client must **not**
> send a slot value higher than `max_slot`. (The OSD should error if it
> does.)
>
> The OSD may increase the number of operations allowed in-flight
> if it has capacity by increasing `max_slot`. If it finds itself
> lacking capacity, it may decrease `max_slot`. If it does, the client
> should respect the new bound. (The OSD should feel free to free the
> rescinded slots as soon as the client sends another `MOSDOp` with a
> slot value equal to one on which the new `max_slot` has been sent.)
>
> If the client sends a `this_seq` lower than the one held for a slot b=
y
> the OSD, the OSD should error. If it is more than one greater than th=
e
> current `this_seq`, the OSD should error.
>
> ### Caching ###
>
> The client is in an excellent position to know whether it **requires*=
*
> the output of a previous operation of mixed reads and writes on
> resend, or whether it merely needs the status on resend. Thus, we let
> the client set `please_cache` to request that the OSD store a
> reference to the sent message in the appropriate `OpSlot`.
>
> The OSD is in an excellent position to know how loaded it is. It can
> calculate a bound on how large a given reply will be before executing
> it. Thus, the OSD can send an error if the client has requested it
> cache something larger than it feels comfortable caching.
>
> Assuming no errors, the behavior, for any slot, is this: If the clien=
t
> sends an `MOSDOp` with a `this_seq` one greater than the current valu=
e
> of `OpSlot::seq`, that represents a new operation. Increment
> `OpSlot::seq`, clear `OpSlot::completed` and begin the operation. Whe=
n
> the operation finishes, set `OpSlot::completed`. If `please_cache` ha=
s been
> set, store the `MOSDOpReply` in `OpSlot::cached`. Otherwise simply st=
ore the
> result code in `OpSlot::r`.
>
> If the client sends an `MOSDOp` with a `this_seq` equal to
> `OpSlot::seq` and `OpSlot::completed` is false, drop the request. (We
> will reply when it completes.) If it has completed, send the stored
> `OpSlot::MOSDOpReply` if there is one, otherwise send just a replay
> with just `OpSlot::r`.
>
> ### Reconnection ###
>
> Currently the `Session` is destroyed on reset and a new one is create=
d
> on authorization. In our proposed system the `Session` will not be
> destroyed on reset, it will be moved to a structure where it can be
> looked up and destroyed after `timeout` since the last message
> received.
>
> On connection, the OSD should first look up a `Session` keyed
> on the entity name and create one if that fails.

So the most common time we really get replay operations is when one of
the OSDs crash or a PG's acting set changes for some other reason.
Which means these "cached" operation results need to be persisted to
disk and then cleaned up, a la the pglog.
I don't see anything in these data structures that explains how we do
that efficiently, which is the biggest problem and the reason we don't
already do reply caching. Am I missing something?

And do you think maybe you could split this up into a thread for each
topic? I'm having trouble digesting it as such a wall of text. :)
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
