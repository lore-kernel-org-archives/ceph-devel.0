From: Gregory Farnum <greg@inktank.com>
Subject: Re: mds: first stab at lookup-by-ino problem/soln description
Date: Thu, 17 Jan 2013 14:18:40 -0800
Message-ID: <CAPYLRzh92EsF7+Of=DK9t_FnZys9bOt8CV0iHp=cJTSFs2c7eQ@mail.gmail.com>
References: <alpine.DEB.2.00.1301142231260.12153@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170]:58988 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752037Ab3AQWSl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Jan 2013 17:18:41 -0500
Received: by mail-qc0-f170.google.com with SMTP id d42so648800qca.1
        for <ceph-devel@vger.kernel.org>; Thu, 17 Jan 2013 14:18:40 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1301142231260.12153@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

We discussed this internally at Inktank today and came up with a
solution that we're happy about. The basic idea is the same, but it
differs from the one Sage originally described in several ways of
varying importance.

First, we determined how to make it work with multiple data pools.
Simply enough, we require every lookup to include both the inode
number and the pool that its data lives in. This works for most
things, the exception being some narrow cases involving files seen by
NFS before having their layout changed, or which are left alone after
creation for a long time (dropping out of MDS cache) and then getting
their layout changed. To deal with these cases, we add "sentinel
objects". By default, we write a backtrace when the file is first
written to, and to the correct location. If for some reason the file
is not written to before the inode drops out of MDS cache, then the
MDS creates an empty object, named and located the same as the first
inode object would be, but containing no data except for the
backtrace. If the next access to the file is a write, great! We don't
need to do anything else.
If users instead change the layout of the file and then write data to
it, the MDS changes the sentinel object to be marked as such and to
point to the pool the data is actually located in. Then lookups from
handles (or hard links, etc) which encode the original pool encounter
this sentinel object and are re-directed to the new pool (and internal
Ceph objects can, as an optimization, be updated to point to the new
correct pool).
Our thought was that this would only need to happen for files which
drop out of cache, although it occurs to me as I write this that we
don't have a good way of knowing if files were seen by NFS, so we
might need to do it for any file which gets its data pool changed
following create. :/ Alternatives are letting NFS get ESTALE if they
run into this narrow race (bummer), or creating them and then cleaning
them up if we can figure out that all the clients which were alive at
create time have shut down (complicated, not necessarily possible).
Thoughts?

In order to deal with the narrow race in cross-MDS renames which Sage
described "ghost entries" for, we've instead decided on a simpler
solution: if an MDS which is expected to be authoritative for an inode
can't find it, the MDS broadcasts a request for that inode to every
other MDS in the cluster. Presumably the destination MDS still has the
inode in cache and can respond in the affirmative for the search; if
it can't then that means the backtrace on the file data has to have
been updated and so a re-query will find the auth MDS. This is much
simpler, will perform at least as efficiently for small clusters, and
isn't likely to be a problem people encounter in practice.

We added a brief future optimization, which is that hard links should
contain a full (lazily-updated) backtrace for faster lookups in the
common case.

--------------------

One implication of this entire scheme which we didn't discuss
explicitly is that it requires the MDS to be able to access all the
data pools, which it presently doesn't. This might have implications
on Ceph's usability for certain regulated industries, and although we
have some thoughts on how to make that unnecessary (make clients
responsible for updating the backtraces, etc) we won't be implementing
that initially. Is this going to cause problems for any current users?

--------------------

Regarding the use of a distributed hash table: we really didn't want
to add that kind of extra complexity and load to the system. Our
current proposal is a way of reducing the work involved in tracking
inodes; a distributed hash table would be going the other direction
and extending the AnchorTable to be scalable. Not implausible but not
what we're after, either.

Please let us know if you have any input!
-Greg

On Tue, Jan 15, 2013 at 3:35 PM, Sage Weil <sage@inktank.com> wrote:
> One of the first things we need to fix in the MDS is how we support
> lookup-by-ino.  It's important for fsck, NFS reexport, and (insofar as
> there are limitations to the current anchor table design) hard links and
> snapshots.
>
> Below is a description of the problem and a rough sketch of my proposed
> solution.  This is the first time I thought about the lookup algorithm in
> any detail, so I've probably missed something, and the 'ghost entries' bit
> is what came to mind on the plane.  Hopefully we can think of something a
> bit lighter weight.
>
> Anyway, poke holes if anything isn't clear, if you have any better ideas,
> or if it's time to refine further.  This is just a starting point for the
> conversation.
>
>
> The problem
> -----------
>
> The MDS stores all fs metadata (files, inodes) in a hierarchy,
> allowing it to distribute responsibility among ceph-mds daemons by
> partitioning the namespace hierarchically.  This is also a huge win
> for inode prefetching: loading the directory gets you both the names
> and the inodes in a single IO.
>
> One consequence of this is that we do not have a flat "inode table"
> that let's us look up files by inode number.  We *can* find
> directories by ino simply because they are stored in an object named
> after the ino.  However, we can't populate the cache this way because
> the metadata in cache must be fully attached to the root to avoid
> various forms of MDS anarchy.
>
> Lookup-by-ino is currently needed for hard links.  The first link to a
> file is deemed the "primary" link, and that is where the inode is
> stored.  Any additional links are internally "remote" links, and
> reference the inode by ino.  However, there are other uses for
> lookup-by-ino, including NFS reexport and fsck.
>
> Anchor table
> ------------
>
> The anchor table is currently used to locate inodes that have hard
> links.  Inodes in the anchor table are said to be "anchored," and can
> be found by ino alone with no knowledge of their path.  Normally, only
> inodes that have hard links need to be anchored.  There are a few
> other cases, but they are not relevant here.
>
> The anchor table is a flat table of records like:
>
>  ino -> (parent ino, hash(name), refcount)
>
> All parent ino's referenced in the table also have records.  The
> refcount includes both other records listing a given ino as parent and
> the anchor itself (i.e., the inode).  To anchor an inode, we insert
> records for the ino and all ancestors (if they are not already present).
>
> An anchor removal means decrementing the ino record.  Once a refcount
> hits 0 it can be removed, and the parent ino's refcount can be
> decremented.
>
> A directory rename involves changing the parent ino value for an
> existing record, populating the new ancestors into the table (as
> needed), and decrementing the old parent's refcount.
>
> This all works great if there are a small number of anchors, but does
> not scale.  The entire table is managed by a single MDS, and is
> currently kept in memory.  We do not want to anchor every inode in the
> system or this is impractical.
>
> But, be want lookup-by-ino for NFS reexport, and something
> similar/related for fsck.
>
>
> Current lookup by ino procedure
> -------------------------------
>
> ::
>
>  lookup_ino(ino)
>    send message mds.N -> mds.0
>      "anchor lookup $ino"
>    get reply message mds.0 -> mds.N
>      reply contains record for $ino and all ancestors (an "anchor trace")
>    parent = depest ancestor in trace that we have in our cache
>    while parent != ino
>      child = parent.lookup(hash(name))
>      if not found
>        restart from the top
>      parent = child
>
>
> Directory backpointers
> ----------------------
>
> There is partial infrastructure for supporting fsck that is already maintained
> for directories.  Each directory object (the first object for the directory,
> if there are multiple fragments) has an attr that provides a snapshot of ancestors
> called a "backtrace".::
>
>  struct inode_backtrace_t {
>    inodeno_t ino;       // my ino
>    vector<inode_backpointer_t> ancestors;
>  }
>
>  struct inode_backpointer_t {
>    inodeno_t dirino;    // containing directory ino
>    string dname;        // linking dentry name
>    version_t version;   // child's version at time of backpointer creation
>  };
>
> The backpointer version field is there to establish *when* this
> particular pointer was valid.  For a large directory /a/b/c, every
> item in c would have an attr that describes the ancestors /a/b/c.  If
> c were renamed to /c, we only update c's backtrace and not it's
> children, so any future observer needs to be able to tell that the /c
> forward pointer is newer than the backtrace's backpointer.
>
> We already maintain backtraces for all directories in the system for
> use by a future fsck tool.  They are updated asynchronously after
> directory renames.
>
>
> Proposal: file backtraces
> -------------------------
>
> Extend the current backtrace infrastructure to include files as well
> as directories.  Attach the backtrace to the first object for the file
> (normally named something like $ino.00000000000).
>
> Initially have the MDS set that attr sometime after the file is
> created but before it drops out of the journal.  On rename, the MDS
> would similarly adjust the attr before the rename operation is trimmed
> from the journal.  The lets us wait a while before setting the op to
> the OSD object, combining the cumulative effects of any sequence of
> renames over a reasonable period of time into a single update.  This
> should work well given typical workloads (many updates, then file goes
> idle).
>
> Later, optimize so that the initial attr is set by the client on first
> write, avoiding an extra MDS -> OSD message (unless, say, the client
> doesn't write to that first block).
>
>
> Proposal: use backtraces for lookup by ino
> ------------------------------------------
>
> Use a process similar to current anchor lookups: get the backtrace
> from the file object, and then use that information to traverse
> forward through the hierarchy to find the given inode.  The process is
> more "racy" than the anchor table approach, however: the anchor table
> reply always has an up-to-date snapshot of the ancestors.  The
> backtrace, however, is an ancestor trace that may be out of date.
>
> The lookup algorithm, in procedural pseudocode::
>
>  lookup_ino(ino) {
>    get backtrace for ino's first data object
>    parent = deepest nested ancestor in our cache
>    while parent != ino,
>      child = child of parent (in backtrace)
>      if parent auth is not us,
>        forward lookup request to auth mds
>      attempt a forward lookup from parent -> child
>        this may involve fetching directory content into the cache, etc.
>      if not found,
>        lookup_ino(child)
>      parent = child
>    end
>  }
>
> Each MDS will have the root inode open, so this will always have
> somewhere to start.
>
> Note that forwarding the request to the auth MDS means both that the
> auth can actually *do* the lookup (by loading any missing directory
> content) and also moving the request to the MDS that is most likely
> to have the child in its cache (because it owns that part of the
> hierarchy).
>
> If an item was renamed sometime after our backtrace was generated, the
> lookup step will fail.  If the rename was recent, we will have the
> nested child still in our cache (as a consequence of processing the
> rename operaton itself).  If it was a rename from a long time ago, the
> recursive lookup_ino(child) will find the new backtrace and all will
> be well.
>
> However: if the rename was in the middle (after the local MDS trimmed
> the removal of the old dentry, but before the new MDS updated the
> backtrace) we have a problem.  The old parent needs to maintain enough
> information to be able to send a forward lookup on to the new child's
> auth MDS until we know the child's backtrace has been updated.
> However, we cannot easily pin the child in the old MDS's memory
> because the MDS may restart and it would complicate rejoin to ensure
> that that replica is restored.  It also is probably not a good idea to
> make the backtrace update a synchronous part of the already-expensive
> two-phase commit that is required for committing the rename itself.
>
> My best idea so far is to have a sort of "ghost reference" indicating
> that a recent rename of ino X in this dir sent it to new parent Y.  In
> the general case, there was no crash, and X is actually in our cache,
> and we consequently know exacty who Y is.  If for some reason we
> don't, we can do a lookup_ino(Y) to continue.  The "ghost refernces"
> would be persistently recorded with the dir, pinned by any child who
> has not yet updated its backtrace.  Once the backtrace is updated, a
> message would be sent to remove the ghost entry.
>
>
> Optimization: bump temperature for forward lookups
> --------------------------------------------------
>
> Consider /a/b/c, with a million files in it, each with a backtrace
> attr.  c is renamed to /c, and then we do a random lookup by ino on
> the files in c.
>
> On a small cluster, the first such lookup will traverse /a and then b,
> find that c is not present, and recursively look up c by ino to find
> the inode in its new home (/c).  Subsequent lookups for files inside c
> will then find the immediate parent c in cache and have only a single
> forward lookup to do.
>
> On a large cluster, the request will usually hit an MDS that is not
> auth for c and will not have it in cache.  This will again incur the
> expensive forward lookup that fails and has to recursively find c by
> ino.
>
> Once we eventually *do* find c, we can make the forward lookups
> increase the temperature for c (perhaps more than we normally would
> for lookups) such that c is replicated to other MDS caches.  Once this
> happens, subsequent backtraces will immediately identify the correct
> parent and forward to requests to the c auth without the expensive
> traversal and recursion.
>
> Specifically, we want to (significantly) bump temperature for forward
> lookups that happen after we had to recursively lookup by ino, since
> that is the part of the process we want to avoid in future requests.
> (We may need to do some minor tweaking to the opportunistic
> replication of hot metadata to do this.)
>
>
> Ghost entries
> -------------
>
> Each directory can have 0 or more "ghost entries" that look something
> like::
>
>   (hash(old name), ino)
>
> The entry is a persistent part of the dirfrag, recorded either in the
> journal or in the dirfrag object.  Each entry is "owned" by the ino it
> references.
>
> Each inode thus has a list of ghost records it owns::
>
>   (parent ino, hash(old name))
>
> These are similarly part of the inode_t, recorded in the journal or
> with the inode in its current parent dirfrag.
>
> When a rename commits, these records are added to the old parent and
> do the renamed item's inode.
>
> After the inode's new backtrace is written and the DIRTYPARENT flag is
> cleared, we are at liberty to remove these records.  If the old parent
> and the inode are on the same MDS, this can be done in a single
> EUpdate.
>
> If the old parent and the new inode are on different nodes, we need a
> multiphase process:
>
> 1. update the inode, moving the ghost record to a 'pending_removal' list.
> 2. send a request to the directory mds to remove the ghost record.
> 3. update the inode to remove the pending_removal item.
>
> If there is an intervening failure, we will discover on replay that
> the inode has something on the pending_removal list and will restart
> the process to remove the dirfrag record.
>
>
> Misc notes
> ----------
>
> There is a DIRTYPARENT flag that is used to record that the inode
> backtrace needs to be updated.  This is not persistent: if we restart
> the MDS and replay the journal (and the rename operation), we don't
> re-flag it as DIRTYPARENT and the backtrace update is lost.  The fix
> should work similarly to how the existing LogSegment list items behave
> (and how the "ghost entries" described above would behave).
>
> If all goes well, we can eventually drop the anchor table and use this
> instead.  That is probably tricky for existing file systems; handling
> those seamlessly may or may not be worth the effort.
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
