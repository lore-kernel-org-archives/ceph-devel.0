From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: Ann Arbor Team's Flexible I/O Proposals (Ceph Next)
Date: Mon, 18 Apr 2016 12:00:01 +0800
Message-ID: <CACJqLyZGxd_ydDV0gsaWOoe54yWXvUhyQdH+4scQLjuDOWmreg@mail.gmail.com>
References: <20160415210536.GA16458@ultraspiritum.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f66.google.com ([209.85.213.66]:34173 "EHLO
	mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751485AbcDREAC convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Apr 2016 00:00:02 -0400
Received: by mail-vk0-f66.google.com with SMTP id a6so21224111vkh.1
        for <ceph-devel@vger.kernel.org>; Sun, 17 Apr 2016 21:00:02 -0700 (PDT)
In-Reply-To: <20160415210536.GA16458@ultraspiritum.redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

Awesome .... I'm surprised that I have read the whole thing...

On Sat, Apr 16, 2016 at 5:05 AM, Adam C. Emerson <aemerson@redhat.com> =
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

Hmm, I can imagine the complexity from this idea... Agree with sage's
point, if we think current read/write isn't fast enough, and why the
solution is introduce read/write transaction.. Could we target to make
read/write message more lightweight? If we want to own some atomic
composed ops, we may introduce some helper interface just like CAS. I
don't think the rados client really need a complete transaction
interface..

plz correct me if I'm missing something else.

I think we could normal osd op faster and faster, a complete different
OSDOp from current impl? Except the performance refactor for io path,
we need to consider to reduce osd/pg preprocess jobs.

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
>
> # Read as a part of Transaction #
>
> We don't have code examples here since most of the obvious interface
> changes are obvious. Codes and parameters would be added to
> `PGBackend::Transaction` and executing a transaction would have to
> return data.
>
> ## Motivation ##
>
> -   Mixed reads and writes are an efficiency win, since a client can
>     save round trips by batching up operations in a single request.
>     Current Ceph does not allow them for reasons which are quoted and
>     addressed in the preceding section.
> -   Mixed reads and writes are a semantic win. If an `MOSDOp` is
>     atomic (it is in current Ceph), read-after-write can often remove
>     the need for explicit locking.
> -   Transactional reads may seem complicated, but the Erasure Coding
>     backend already has to execute complex read transactions to
>     reassemble or recover data. We want an asynchronous read capabili=
ty
>     in the Store anyway and there's no reason not to have it be share=
d
>     with our asynchronous write path.
> -   While it might seem that separating reads and writes, as we do
>     now, allows us to simplify code and rule out edge cases, we would
>     like to point out the existence of CLS, which can have problems i=
f
>     two method calls occur in the same `MOSDOp`.
>
> ## Sketch ##
>
> The main problem with mixed read-write transactions is that replicas
> need to write but not read. The key to handling this is dependency
> checking. Outside CLS (which will be discussed below) it is very easy
> to see whether reads and writes are independent. (Simply go down the
> ops and see if their ranges overlap and whether getattrs and setattrs
> have keys in common.) Reads coming after overlapping writes depend on
> the previous writes. Then:
> -   If an op that's all reads, simply do all the reads. We don't have
>     to get write locks or anything.
> -   If an op is all writes, it's no different than a replicated
>     operation now.
> -   For mixed reads and writes, if the reads aren't dependent on the
>     writes, dispatch the writes and do the reads before, after, or
>     concurrently with the writes on the primary.  (So long as we
>     prevent writes from other transactions from intervening.)
> -   Dependent reads are the difficult case. For erasure coding it
>     shouldn't any difference since we'd have to dispatch reads and
>     writes to all stripes anyway. For replication, we would want to
>     execute the mixed read-write transaction on the local store in
>     strict order and dispatch one consisting of only writes to the
>     remotes.
>
> # CLS #
>
> ## Current Problem ##
>
> The CLS API works by making an ops vector and handing it to
> `do_osd_ops`.
>
> ```c++
> int cls_cxx_getxattr(cls_method_context_t hctx, const char *name,
>                      bufferlist *outbl)
> {
>   ReplicatedPG::OpContext **pctx =3D (ReplicatedPG::OpContext **)hctx=
;
>   bufferlist name_data;
>   vector<OSDOp> nops(1);
>   OSDOp& op =3D nops[0];
>   int r;
>
>   op.op.op =3D CEPH_OSD_OP_GETXATTR;
>   op.indata.append(name);
>   op.op.xattr.name_len =3D strlen(name);
>   r =3D (*pctx)->pg->do_osd_ops(*pctx, nops);
>   if (r < 0)
>     return r;
>
>   outbl->claim(op.outdata);
>   return outbl->length();
> }
>
> int cls_cxx_setxattr(cls_method_context_t hctx, const char *name,
>                      bufferlist *inbl)
> {
>   ReplicatedPG::OpContext **pctx =3D (ReplicatedPG::OpContext **)hctx=
;
>   bufferlist name_data;
>   vector<OSDOp> nops(1);
>   OSDOp& op =3D nops[0];
>   int r;
>
>   op.op.op =3D CEPH_OSD_OP_SETXATTR;
>   op.indata.append(name);
>   op.indata.append(*inbl);
>   op.op.xattr.name_len =3D strlen(name);
>   op.op.xattr.value_len =3D inbl->length();
>   r =3D (*pctx)->pg->do_osd_ops(*pctx, nops);
>
>   return r;
> }
> ```
>
> The `do_osd_ops` function performs reads inline, synchronously, right
> then and there for replicated pools. (Erasure coded pools are more
> limited.) Writes are batched up and added to the transaction
> associated with the current `OpContext`.
>
> This is bad. If one has a CLS method that performs a read-modify-writ=
e
> and one calls it twice in the same `MOSDOp`, it becomes a
> read-modify-read-modify-write-write which may produce incorrect
> results.
>
> ## Desiderata ##
>
> -   CLS operations should be composable. We should be able to have ma=
ny
>     of them in a single operation.
> -   They should remain transactional. If a CLS operation does some
>     reads and hits an error, it stops and nothing is written to the
>     store. We should not allow situations where a CLS method can writ=
e
>     a partial result to the store then error.
> -   They should be capable. We should not put too many restrictions o=
n
>     what an operation is allowed to do. It should be possible to run
>     them on Erasure Coded Pools once ECOverwrite is in place. (At
>     least some subset of them).
> -   They should be consistent. A CLS operation should be able to call
>     rand or generate a UUID without each replica holding a different
>     value. (This rules out solutions like calling the method on each
>     replica.)
> -   They should be efficient and optimizable.
> -   They should work in an asynchronous framework.
>
> There are several ways we could change their implementation to addres=
s
> these.
>
> ## Futures ##
>
> This is an attractive way to think about CLS. It allows things to
> proceed asynchronously and would solve the RMRMWW problem. One would
> simply make every I/O operation in the CLS API a call returning a
> future and write each method in continuation passing style. Executing
> the transaction in the primary OSD (on a replicated pool) would creat=
e
> a write-only that could then be sent to replicas. (Having the
> execution of a CLS method also compile a write-only transaction is a
> propery of any composable design.)
> -   Tracking dependencies before the operation is executed would be
>     problematic. There would be no way to know whether later reads
>     overlapped with previous writes before doing them. This could lea=
d
>     to an unbounded obligation on the OSD to maintain state to
>     evaluate OSDOp, including potentially large writes, before
>     actually committing in order for CLS methods to remain
>     transactional.
>
> Futures are, on their own, insufficient to provide everything we need
> from CLS, largely because they are opaque to the OSD. They could be
> combined with=E2=80=A6
>
> ## Pre-declaration ##
>
> We could remove some of the generality. A simple way of doing so woul=
d
> be to have methods declare, as a part of their signature, everything
> that they may ever read or write, with the expectation that methods
> will name the fewest resources required. This doesn't mean that every
> method will always write to and read from everything it mentions,
> merely that we have a known bound of the maximum it will ever use.
>
> This makes analysis easier for the OSD, and in the composition case,
> it could go in two passes. In the first, it would execute CLS calls
> and pre-stage results and in the second it would pass its compiled
> write transaction into the store.
>
> This is the most attractive solution, but depends on pre-declaration
> being done well on the resources used in pre-staging.
>
> One could make things easier by being even more restrictive and
> imposing ordering:
> 1.  The method declares in advance all read operations it might ever
>     perform.
> 2.  The method declares in advance all write operations it might ever
>     perform.
> 3.  The method examines the parameters passed by the client and
>     indicates which subset of the named inputs and outputs it will
>     use.
> 4.  The method performs its read operations and denotes exactly which
>     output operations it will perform. (not the data to be output, bu=
t
>     ranges and names.)
> 5.  The method performs write operations.
>
> The most restrictive form of this would operate in two phases. First,
> the CLS method would be presented with its parameters and all of the
> things it plans to read or write (objects with ranges and attribute
> keys.) In the second it would be called with the contents of all the
> reads it requested and supply the data for all the writes it requeste=
d.
>
> This would obviate the need for futures or other asynchronous I/O,
> and make evaluation very easy. This approach would disallow some
> operations, like indirecting through an attribute key to read another=
,
> but is very appealing.
>
> ## Be Transactional ##
>
> Our transactions are pre-checked and must succeed. If we want the mos=
t
> expressive version of CLS consistent with our other goals, then we
> should add commit and rollback. EC Overwrite will already require som=
e
> form of commit and rollback, so it's not beyond the realm of thought.
>
> It could also be a foundation for some future multi-object-transactio=
n
> supporting backend.
>
> This idea might have appeal on its own, but the concerns of CLS are
> not sufficient to motivate it.
>
> ## Domain Specific Language ##
>
> One could make a domain specific language, based on something simple,
> that the OSD can execute to perform CLS methods. The OSD could then
> analyze each method to see what I/O operations a method calls and try
> to track them
> -   Dependency tracking for compilers is a major area of research. It
>     would be a whole lot of fun, but as a short term solution it is
>     not really practical.
> -   We still wouldn't be able to rule out problems in the general
>     case.
>
> This approach would be interesting as a long term academic research
> project, but is not suitable for a short-range improvement.
>
> # Flexible Placement #
>
> This is a large topic which should be discussed on its own, but it
> motivates the interface designs below, so we shall briefly mention wh=
y
> it's interesting.
>
> CRUSH/PG is a fine placement system for several workloads, but it has
> two well-known limitations.
>
> ## Motivation ##
>
> -   Data distribution can be much less uniform than one might like,
>     giving uneven use of disks. This has caused some Ceph developers
>     to experiment with Monte Carlo based placement algorithms.
> -   Data distribution can be much more uniform than one would
>     like. This is the fundamental cause of Ceph's slow sequential rea=
d
>     performance. More generally, unrelated workloads contend
>     with each other due to a lack of affinity for related data. The e=
ffects are
>     especially pronounced on spinning disk (due to seek times), but
>     still exist on Flash (due to bus/network contention.)  This is a
>     tension between competing goods. CRUSH gains wide dispersion and
>     uniformity to defend against correlated failures but this imposes
>     a tradeoff.
>
> ## Goal ##
>
> Ceph should support placement methods other than CRUSH/PG. Currently,
> the OSD dispatches operations based on placement group ID, which will
> need to be varied,
>
> We also need some way to get new types of functions into the cluster.
>
> ## Proposal ##
>
> Our proposal is, in a way, CRUSH taken to its logical
> conclusion. Instead of distributing CRUSH rules, we propose to
> distribute general computable functions from (oid, volume/dataset) pa=
irs to
> sequences of OSDs with their supporting data structures.  One of our
> ongoing research projects has been an in-process executor for these
> functions based on Google's NaCl. The benefits are:
> -   Administrators can fine-tune placement functions to fit their
>     workloads well.
> -   They can also experiment easily without having to recompile all o=
f
>     Ceph and make heavy architectural changes.
> -   Entirely new placement strategies can be deployed without having
>     to upgrade every machine in the cluster. Or any machine in the
>     cluster, once they've been upgraded to a Flexible Placement
>     capable version.
> -   Possibilities for annealing and machine learning to gradually
>     adapt placement in response to load data become available
> -   NaCl builds on LLVM which has a rich set of tools for optimizatio=
ns
>     like partial evaluation.
> -   NaCl is fast.
>
> # Flexible Semantics #
>
> Another motivating example. Originally, Ceph did replication and only
> replication under a very specific consistency model. There has been
> desire for more flexibility.
> -   Erasure Coding. it still follows the Ceph consistency model
>     (though leaves out many operations) but is very different in
>     back-end dispatch, enough so that it inspired a major rewrite of
>     the OSD's bottom half.
> -   Append-only immutable objects have been discussed.
> -   Many people have asked for relaxed consistency to improve
>     performance. This is not be suitable for all workloads, but peopl=
e
>     have repeatedly asked for the ability to set up low-latency,
>     relaxed-consistency volumes that still provide Ceph's ability to
>     easily use new storage and scale well.
> -   Transactional storage. As mentioned above, cross-object
>     transactional semantics are a thing people may have desired.
>
> # Interfaces #
>
> Right now our class hierarchy is a bit of a mess. Eventually we'll do
> something about `PG` and `ReplicatedPG`, refactor, support
> asynchronous I/O, reduce lock contention, support in core affinity,
> and build Jerusalem here in England's green and pleasant land.
>
> While we're stringing up our bows of burning gold, we should support
> non-PG based placement and flexible semantics. Right now, parts of th=
e
> PG and the OSD (since the OSD manages the collection of PGs, spins
> them up, and manages thread pools shared by sets of PGs) are
> intertwined. Thus, we need to abstract out both pieces.
>
> As we also want to support having multiple "logical" OSDs running in =
a
> single `ceph-osd` process, this would be a natural time to add that
> capability.
>
> Both these are sketches and should be considered a work in progress.
>
> ## `DataSetInterface` ##
>
> Here is a sketch of what a flexible abstraction based on PG could loo=
k
> like, at least parts of one. Not being informed about Scrub,
> Recovery, or Cache Tiering, having only focused on the object
> operation path, we won't include those details here.
>
> We also leave out functions called from the PG itself or other object=
s
> invoked from ownstack.
>
> ```c++
> class DataSetInterface {
> protected:
>   LogicalOSD& losd; // LogicalOSD is a means to have different
>                     // stores/semantics run in the same process.
>
>   MapPartRef curmap; // Subset of map relevant to this DSI
> public:
>   // The OSD (things Up the Stack, generally) should not call 'lock'
>   // on us. If we have locking of some sort things down the stack tha=
t
>   // we have some relationship with (friend or whatever) could lock o=
r
>   // unlock us, but that should not be baked in as part of the interf=
ace.
>
>   // Things like the info struct and details about loading the Place
>   // wouldn't actually be here. As there is an intimate relation
>   // between the LogicalOSD and an implementation of DataSetInterface=
 (it
>   // holds all those loaded in memory and controls dispatch), they
>   // would not need to be part of the generic interface.
>
>   const coll_t coll; // The subdivision of the Store we control
>
>   // In the PG case we always know we're the primary or not for
>   // anything within the same pgid. That is not expected to be the
>   // case generally.
>   bool is_primary(const OpRequest&) =3D 0;
>   // No 'is_replica' since 'replica' may not be applicable
>   // generally. It's a bit off even in the erasure coded case.
>   bool is_acting(const OpRequest&) =3D 0;
>   bool is_inactive() =3D 0;
>
>  public:
>   // No identifier. The descendent will take that.
>   DataSetInterface(LogicalOSD& o, OSDMapRef curmap);
>   virtual ~DataSetInterface();
>
>   DataSetInterface(const DataSetInterface&) =3D delete;
>   DataSetInterface& operator =3D(const DataSetInterface&) =3D delete;
>   DataSetInterface(DataSetInterface&&) =3D delete;
>   DataSetInterface& operator =3D(DataSetInterface&&) =3D delete;
>
>   virtual void on_removal(ObjectStore::Transaction *t) =3D 0;
>
>   // Yes, there's no 'queue' and no 'do_op' or any of
>   // that. This is intentional. There's no dequeue or do_op because
>   // those functions are either called only by the PG currently OR
>   // they're called in OSD functions called by the PG as part of the
>   // thread switch. They should not be part of the public interface.
>
>   // There's no queue because we can either put queue here or we can
>   // put queue in LogicalOSD. (We could do both, but that seems bad t=
o
>   // me.) If there is some combination of locking and checking that
>   // must be done before queueing an operation, it seems that it's
>   // better to do it in LogicalOSD so that it doesn't leak out and
>   // become part of the abstraction for other implementations.
> };
> ```
>
> ## `LogicalOSD` ##
>
> The OSD class itself (representing the single OSD process) should hav=
e
> a map (*perhaps* a Boost.Intrusive.Set?) mapping OSD IDs to to
> `LogicalOSD` instances.
>
> ```c++
> class LogicalOSD {
>   OSD& osd;
>   ObjectStore& store;
>
>   // Look up the DataSetInterface instance appropriate to the given
>   // OpRequest.
>   virtual future<DataSetInterface,int> get_place_for(const OpRequest&=
) =3D 0;
>
>   // Every logical OSD will have its own watchers as well as slot
>   // cache. Someone familiar with flow control should check this
>   // idea. Since LogicalOSDs will, ideally, share messengers we might
>   // want them to share the same slot cache. In that case we should
>   // just re-dimension watchers within Session
>   SessionRef session_for(const entity_name_t& name);
>
>   void queue(DataSetInterfaceRef&& pi, OpRequestRef&& to_queue);
>   void queue_front(DataSetInterfaceRef&& pi, OpRequestRef&& to_queue)=
;
>
>   // Dequeue and the like are currently called in the PG itself and s=
o
>   // have no place in the interface presented to the OSD.
>
>   void pause();
>   void resume();
>   void drain();
> };
> ```
>
> ## Library ##
>
> Both these interfaces are quite thin and intentionally so. Scrubbing
> and recovery have not been addressed at all, as mentioned, so those
> parts will be expanded.  Asynchrony should allow us simpler interface=
s
> since some complexity of requeing will be handled by futures and
> continuations.
>
> We obviously do not want to rewrite all our existing code. Instead
> most of the existing work on `PG` and `ReplicatedPG` should be
> refactored into a templated library from which implementations of
> `LogicalOSD` and `DataSetInterface` can be constructed.
>
> # Map Partitioning #
>
> There are two huge problems with scalability in Ceph.
> 1.  The OSDMap knows too many things
> 2.  A single monitor manages all updates of everything and replicates=
 them to
>     other monitors.
>
> ## Too Big to Not Fail ##
>
> The monitor map and MDS maps are fine. Each holds data needed to
> locate servers and that's it. It would be very hard to put enough dat=
a
> in them to cause problems. The OSD map however contains a trove of da=
ta that
> must be updated serially in Paxos and propagated to every OSD,
> monitor, MDS, and client in the cluster.
>
> Pools are a notorious example. We can't create as many pools as users
> would like. Pools are heavyweight, and while they depend on other
> items in the OSD map (like erasure code profiles), it would be nice i=
f
> we divide them between several monitor clusters, each of which would
> hold a subset of pools. We would need to make sure that clients had u=
p
> to date versions of whatever pools they are using along with the
> status of the OSDs they're speaking to, but that's not
> impossible. Likewise, we should split placement rules out of the OSD
> map, especially once we get into larger numbers of potentially larger
> Flexible Placement style functions.
>
> Nodes should then only need to subscribe to the set of pools and
> placement functions they need to access their data. Changes like thes=
e
> should allow users to create the number of pools they want without
> causing the cluster difficulty.
>
> ### Consistency ###
>
> Partitioning makes consistency harder. A simple remedy might be to
> stop referring to data by name or integer. An erasure code profile
> should be specified by UUID and version. So should pools and placemen=
t
> functions. When sending a request to the OSD, a client should send th=
e
> versions of the pool, the ruleset, and the OSDMap it used and the OSD
> should check that all three are current.
>
> ## The OSD Set ##
>
> The complicating case here is the OSD status set.  Running this
> through a single Paxos limits the number of OSDs that can coexist in =
a
> cluster.  We ought split the set of OSDs between multiple masters to
> distribute the load. Each 'Up' or 'Down' event is independent of
> others, so all we require is that events get propagated into the
> correct OSDs and primaries and followers act as they're supposed to.
>
> Versioning is a bigger problem here. We might have all masters
> increment their version when one increments its version if that could
> be managed without inefficiency. We might send a compound version wit=
h
> `MOSDOp`s, but combining that with the compound version above might b=
e
> unwieldly. (Feedback on this issue would be greatly appreciated.)
>
> ### Subscription ###
>
> For a large number of OSDs, it would be nice if not everyone were
> notified of all state changes.
>
> For a pool whose placement rule spans only a subset of all OSDs,
> clients using that pool should be able to subscribe to a subset of th=
e
> OSD set corresponding to that pool. This should be fairly easy so lon=
g
> as the subset is explicit.
>
> In the case of pools not providing an explicit subset, a monitor (or
> perhaps a proxy in front of a set of monitors) could look at common
> patterns of subscription requests and merge those with significant
> overlap together, so as to give clients a subset without being
> destroyed by the irresistible force of combinatorial explosion.
>
> # Notes #
>
> These are notes taken when reviewing the code and thinking out
> ideas. You don't have to read them, but they are provided as a
> supplement in case you wanted to know what we were thinking and why.
>
> ## ShardedOpWQ ##
>
> -   What is the purpose of `sdata_op_ordering_lock`? A shard is not a
>     PG, so why do things need to be ordered within shards as well as
>     within PGs?
> -   `sdata_lock` pairs up with the condition variable
>
> ## OSD Upper Half ##
>
> ### Regular Dispatch ###
>
> -   Does not overlap with `fast_dispatch`. Operations in
>     `ms_can_fast_dispatch` are not handled in `_dispatch` and vice ve=
rsa.
> -   Lock the entire OSD
> -   If another dispatch is executing, go to sleep and wait for it to
>     finish. What the heck?
> -   Do Waiters
>     * Waiters are a list of `OpRequestRef`s called `finished` for som=
e
>           reason
>     * Whenever we activate an `OSDMap` the requests waiting for the
>       map get put onto 'finished'
> -   Call `_dispatch`
> -   Do some more waiters
> -   Wake up other dispatch threads
> -   Unlock the entire OSD
>
> #### `_dispatch`? ####
>
> A giant case statement that does a bunch of things.
>
> In the case of `OSDOp`, if we have an `OSDMap`, create an `OpRequest`=
 and
> pass it to `dispatch_op`. This is for things like PG commands, not
> actual object operations.
>
> #### `dispatch_op` ####
>
> Another giant case statement.
>
> ### Fast Dispatch ###
>
> #### `ms_fast_preprocess` ####
>
> Update the map epoch if an OSD sends us an OSDMap.
>
> #### `ms_fast_dispatch` ####
>
> -   Make an `OpRequest`
> -   A bit weird and convoluted, it looks like we use the 'op waiting
>     for map' stuff to queue up an op on a reserved map and remove the
>     reservation preventing it from running before we return.
> -   Specifically we mark the op as waiting for its PG in the `Session=
`
>     and then mark the `Session` as waiting for the new map.
> -   Ultimately things end up in `dispatch_op_fast`
>
> #### `dispatch_op_fast` ####
>
> Shovels operations into type specific calls like=E2=80=A6
>
> #### `handle_op` ####
>
> -   Set up map share (if needed)
> -   Calculate the True PGID and Pool (sanity check against the client=
?)
> -   Either get the pointer to the PG (a base class) or, if it hasn't
>     been loaded in, queue the session to wait for it
> -   If we have the PG, `enqueue_op` (which just calls `PG::queue_op`)
>
> ## OSD Lower Half (Currently PG) ##
>
> `ReplicatedPG` and `PG` are separate for historical reasons and actua=
l
> differentiation occurs in choice of backend according to Word of Sam.
>
> PGs with different consistency properties are explicitly a goal
> now. The idea of a `PGInterface` has been floated to facilitate their
> creation and `ReplicatedPG` would become a child of that.
>
> ### `PG::queue_op` ###
>
> -   Delay if other people are waiting for maps (to preserve the PG Or=
dering)
> -   Enqueue in `op_wq` (owned by the OSD)
> -   (Why call into the PG then? Just to enforce the map ordering?)
> -   The work queue gathers operations which, during `_process` are la=
ter
>     reassembled into a list of work to be done.
> -   `_process` is called by a worker thread in the thread pool, so th=
e
>     call to `dequeue_op` is in worker thread. Since it's sharded, we
>     get multiple groups of threads each serving some subset of PGs.
>
> ### `OSD::dequeue_op` ###
>
> -   After a bit of fiddling about sharing maps, call `PG::do_op`
>
> ### `PG::do_op` ###
>
> -   Sam says he plans to rewrite this to allow read asynchrony
> -   We want to see reads and writes share the same transaction
>     structure and similar semantics.
> -   We also want to allow reads and writes in the same operation and
>     to use a session mechanism to allow that.
> -   We'll need transaction transforms to, for example, filter out
>     reads before sending an operation to a replicating OSD. This
>     shouldn't be too hard, since the output of read operations can't
>     be the input for write operations. (Except in CLS?)
> -   `do_op` is a virtual function, but the only implementation is in
>     ReplicatedPG.
> -   Here looks to be where we apply ordering to Writes
> -   `execute_ctx` actually performs the operations after `do_op` has =
set
>     everything up
>
> ### `execute_ctx` ###
>
> -   May be called multiple times on the same `OpContext`
> -   In the case of clone operations (that's the only thing that takes
>     `src_obc`?), get a read-lock for the object context
> -   it's called `ondisk` but I'm not sure why, it doesn't look like t=
hey get serialized
> -   Then we have a brief detour into `prepare_transatcion`
> -   Here's the read-write restriction. ReplicatedPG.cc:2975. Later we=
 can
>     create a better session abstraction to fix that.
> -   For reads
>     *   `do_osd_op_effects`!
>     *   If all our reads were synchronous (or there were none)
>         `complete_read_ctx`, which creates and sends the reply
>     -   Otherwise, `start_async_reads`, which passes the pending read=
s off
>         to `objects_read_async`
>     -   Once the backend completes, we go to `finish_read`, which cal=
ls
>         `complete_read_ctx`
> -   Trim the PG Log
> -   Hey, cool, there's a lambda! Register an `onack` closure that sen=
ds a reply
> -   And `oncommit`. And `onsuccess`. And `finish`.
> -   Package up the `OpContext` and its transaction and whatnot into a
>     `RepOp`. This is where all the mutations get done.
> -   Call `issue_repop`
> -   Call `eval_repop`
> -   Adam really wishes we would use `boost::intrusive_ptr` everywhere
>     and stop using explicit gets and puts.
>
> ### `prepare_transaction` ###
>
> -   `do_osd_ops`!
> -   If we're not full, `finish_ctx`.
>
> ### `do_osd_ops` ###
>
> -   Loop over the ops in a gigantic case statement
> -   If we hit any modification ops set the `user_modify` flag. This i=
s
>     used to update the object version as part of the transaction
> -   On EC pools, do reads asynchronously, pushing them onto a list of
>     reads to complete.
> -   Otherwise do the reads synchronously
> -   CLS calls can be tricky since they read or write depending on the
>     method invoked
> -   It looks like operations performed by CLS are done by calling eac=
h
>     operation individually with `do_osd_ops` with reads being done
>     immediately and writes being queued up as part of the transaction
> -   Making the CLS API futures-based interface may be a good thing to=
 do.
> -   Cache ops like flushing seem to be about shovelling triggers to d=
o
>     perform actions into the `onack`/`oncomplete` lists.
> -   For write operations, stuff them into the Transaction
> -   In the case of CLS operations which do both reads and writes
>     (which some of them do), it appears that putting two CLS operatio=
ns
>     in the same OSDOp might lead to weird results since all the reads
>     will happen then all the writes.
>
> ### `finish_ctx` ###
>
> -   Fiddle with object state and logs to update snapshot foo and to m=
ake
>     sure the object exists in the form we need it
> -   Update user version if we modified the object
> -   Save the updated `object_info_t`
> -   Append the updated object info to the `PGLog`
> -   Apply context stats
>
> ### `do_osd_op_effects`
>
> -   Add watches if we need to add watches
> -   If there's notifies, notify the watchers
> -   Why do we ack notifies?
>
> ### `issue_repop` ###
>
> -   Acquire locks (I'm still not clear why they're called `ondisk`. I=
s
>     it a lock acquired to use the store and thus it locks the on-disk
>     representation?)
> -   Apply built up attributes (likely verions and things that had bee=
n
>     stuck in the PGLog before.)
> -   Submit transaction to the PG Backend. Which is where it gets
>     divided up for Erasure Coding or sent out for replication. I'll
>     count that as Bottom End for the moment alongside the Store,
>     Changes to the backend will be for new consistency models.
>
>     We might be able to get a separation of concerns by varying what
>     is now ReplicatedPG to support differnet 'gridding' of objects on
>     the OSD and rejigger things so the consistency model is purely a
>     property of the backend. That's appealing from a maintenance
>     perspective, but breaks down if we want things like explicitly
>     marked transactions across multiple for some volumes while not
>     paying for them on others. It might not be workable in the genera=
l
>     case.
> -   That's also where local application takes place.
>
> ### `eval_repop` ###
>
> -   This function just sends notifications and cleans up when we fini=
sh.
> -   Its name is not very appropriate for what it does.
> -   If we're already done, return.
>     *   This isn't bad, but it's specifically necessary because `eval=
_repop`
>         gets called from several places including the handlers for ou=
r
>         subservient OSDs completing an operation.
> -   If everyone's ack'd, fire off our ack handlers. If everyone's
>     completed, fire off our completion handlers.
> -   Notify anyone waiting for the version we've committed=E2=80=A6
> -   And for those waiting on the one we've applied
> -   If we've done everything, update usage stats
>     *   Fire off `on_success` callbacks
>     *   Remove ourselves
>
> ## Flex Points ##
>
> ### PlacementGroup/FlexiblePlacement/OtherConsistencyStrategy ###
>
> -   Fast Dispatch currently shoves requests into a PG.
> -   `handle_op` calculates a pgid and actually gets the pointer to or
>     queues the session to wait on the associated PG
> -   If we implement `queue_op` in FlexiblePlacement we can do whateve=
r we
>     want with it. We can ignore the WorkQueue.
> -   Much of the code in `ReplicatedPG` is useful even with other
>     semantic models than PG-ordered replication
> -   We might want to make `ReplicatedPG` a template and
>     supply the `PG` specific parts as a class instantiation. Then we
>     could create more classes for other partition/dispatch models.
> -   We will want a consitency/semantic variation orthogonal to the
>     partition/dispatch model.
>         * In this divide dividing objects into PGs where every all
>           operations are dispatched into the PG for whatever objet th=
ey
>       effect would be partition/gridding
>     * Whereas the total ordering on PG operations and constraints on
>           when a request blocks versus being served are the
>           consistency/semantics
>
> ### Allocation/Locking/Dispatch ###
>
> -   `OpRequest` (currently allocated in `do_op` and other structures
>     might be allocated at various points. IN our earlier prototype we
>     allocated OpRequest and another structure alongside the MOSDOp an=
d
>     reused MOSDOps rather than deallocating them to cut down on
>     allocator use in the fast path.
>
>         That might fight with also promising designs using core-affin=
e
>     memory management, unless we can determine core affinity quickly
>     before allocating the message. (Maybe peeking into the undecoded
>     bytes?)
> -   Lock freedom should be orthogonal to flexible placement. There ma=
y
>     be situations where we want lockful systems in flexible placement
>     (since flexible placement can have a variety of sync behaviors.)
>     and we know that Sam and others are interested in pursuing
>     lock-free designs in in PG-placement.
> -   In a lock-free design, if PGs are core-affine,
>     `enqueue_op` could just submit a message to a core without lockin=
g
>     or some of the thread/worker complexity.
> -   For Volumes, where the volume itself may be partitioned across co=
res
>     `enqueue_op` would have to look at the object name to find its ta=
rget.
> -   Thus, we would want to pull that logic into a separate function
>     giving our dispatch target.
>
> ### Read-Write Symmetry ###
>
> -   Thankfully, `init_op_flags` is happy to set both read and write
> -   CLS in particular falls afoul of this. Futures might be the best
>     way to deal with it.
>
> ### Things we know we had to do anyway from previous work ###
>
> -   Use `std::map` less as a parameter/return type, same for std::set
> -   Objecter improvements
>     *   Less allocation, change data structures. A dual to some of th=
e
>         work we want to do to make the EC interface less memory
>         intensive.
>     -   If we have zero copy there should be a way to materialize tha=
t
>         at the level of the client.
> -   See about bootstrapping client-side EC from EC overwrite
> -   Librados4 should be more like Objecter than it is like librados3
>
> ## Sam and `do_op` (=E2=99=AA Doo-Wop? =E2=99=AA) ##
>
> ### Discussion ###
>
> Notes taken during a BlueJeans call between Adam Emerson and Sam
> Just. (Sorry for any mistakes, recording a conversation while having
> it is tricky.)
>
> -   We should never have to block for I/O
> -   It's not `do_op` per se, though we are rewriting that to put it i=
nto a
>     continuation passing style with trampolines
> -   Various bits should be allowed to block, but whether they do or
>     don't should not effect the caller's code-flow.
> -   Once we've got to that point, everything after is easier
> -   We have to make sure we don't introduce so much overhead that it'=
s measurable
> -   Eventually plans to go to a lock-free/sharded/partitioned style l=
ike Seastar
> -   We are not using Seastar's system because, when you fulfil a
>     promise you don't want to have the promise fulfilled in that
>     thread, it should be easy to fulfill it in a different thread.
> -   Also adapting an existing codebase to Seastar is much harder than
>     writing one from scratch to use it.
> -   It should also allow us to run all the OSDs in the same process
> -   We might want to have one messenger per logical OSD and have thos=
e share
>     threads (loses some efficiency gains but is backwards compatible.=
)
> -   These sorts of changes will also make EC overwrites much easier.
> -   Any refactors in the code should move us in this direction as a s=
ide effect
> -   The sooner the better, so if it does cause performance problems w=
e
>     can find out soon
> -   Branch is wip-do-op in athanatos

The part is align with my struggling job.

>
> ### Brief Exploration of the code ###
>
> Adam Emerson looked briefly through the `wip-do-op` branch in
> `https://github.com/athanatos/ceph.git` to see what the general desig=
n
> looked like and how it matched up with our goals.
>
> -   Getting rid of the 'ondisk lock' looks good, someone good at
>     scheduling (Matt?) should review the queue. It should not use
>     `std::list`, though.
> -   The `do_replica_safe_reads` refactor isn't bad but doesn't seem t=
o
>     have an immediate effect. Sam described it as providing safety
>     shunting things replicas could do into their own function, so
>     should make future development and refactor easier.
> -   It reinforces the idea that reads inhabit a separate magisterium
>     with its own law and dispensation from writes and is the oposite
>     direction from the read/write transactions we want. At least
>     potentially, we could use it as a fast/safe path and have it do a
>     more specialized transaction dispatch for reads, maybe.
> -   The `do_op`/`do_replica_op` split seems reasonable for the
>     replicated case, since in that one we want to transform the
>     transaction before sending it to the replicas. If we want to allo=
w
>     CLS methods on EC pools (which we do, in principle) or mixed
>     read-write, then the distinction between primary and replica migh=
t
>     break down.
> -   Not sure if the error channel is better pe se, but since we
>     currently have a bunch of functions that return `int` to indicate
>     errors, it might be easier to integrate.
> -   C++ should have a `void` type a bit more like unit so you could
>     explicitly return `void()` from void functions. You'd think they
>     could put *that* in C++17 since their list of things to add to th=
e
>     standard now consists entirely of "3 to the version number".
> -   The `future` implementation looks promising. I'll need to review
>     how it's put together in more detail later, how it's used is more
>     pertinent at the moment.
> -   Things make sense from a gradualist position. Given the desire fo=
r
>     a progression from from here to _A Really Fast OSD_ where we have
>     _A Working OSD_ at every point along the way, this approach makes
>     sense. Restructuring everything around a blocking-agnostic future=
s
>     design then opens the way to introducing asynchronous, lock-free =
code.
> -   This is also compatible with flexing, since we can have multiple
>     `LogicalOSD` implementations with different locking strategies or
>     core affinity.
> -   `aio_read` looks to be less aio than the name would suggest. This
>     isn't bad, it's reasonable to do a transform by having things cal=
l
>     blocking procedures in a way that will work if they become non-bl=
ocking.
> -   Reimplementing the blocking calls in terms of nonblocking calls i=
s
>     smart.
> -   `OSDReactor` looks like it could be adapted, at least the public
>     interface, into LogicalOSD once we made it less PG specific.
> -   In principle it's a good idea. A LogicalOSD would have to be boun=
d
>     closely to the DataSetInterface it worked with since they're two
>     halves of a queueing mechanism.
> -   The futures stuff definitely isn't na=C3=AFve. We need to underst=
and
>     the blockers and other details.  The idea of having a future yiel=
d
>     when it needs to wait for something is a good one.
> -   It uses `std::list` though.
>
> ## Why librados is not wonderful ##
>
> Not that we hate RADOS, we just like Objecter way more
> -   Does not support read and write in same op. Neither does RADOS, t=
o
>     be fair, but we plan to fix that.
> -   Takes a giant lock with every operation. Yuck.
> -   Has its own 'callback' interface
> -   Its handing of asynchronous operations seems very heavyweight and
>     not natural.
> -   Hides the internal structure of RADOS operations
> -   Does not expose object locator in a useful way
> -   Does way too many allocations
> -   The dimensioning of the interface is weird, like binding the IoCt=
x
>     to a pool
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Best Regards,

Wheat
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
