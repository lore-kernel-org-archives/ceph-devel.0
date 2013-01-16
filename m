From: Gregory Farnum <greg@inktank.com>
Subject: Re: mds: first stab at lookup-by-ino problem/soln description
Date: Wed, 16 Jan 2013 13:52:24 -0800
Message-ID: <CAPYLRzg8j02fgMBC1cgUnot4XH4y--BR=PnbLo+J-RUkPBVpGQ@mail.gmail.com>
References: <alpine.DEB.2.00.1301142231260.12153@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:45711 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756323Ab3APVw0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Jan 2013 16:52:26 -0500
Received: by mail-qa0-f46.google.com with SMTP id r4so3768314qaq.5
        for <ceph-devel@vger.kernel.org>; Wed, 16 Jan 2013 13:52:25 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1301142231260.12153@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

My biggest concern with this was how it worked on cluster with
multiple data pools, and Sage's initial response was to either
1) create an object for each inode that lives in the metadata pool,
and holds the backtraces (rather than putting them as attributes on
the first object in the file), or
2) use a more sophisticated data structure, perhaps built on Eleanor's
b-tree project from last summer
(http://ceph.com/community/summer-adventures-with-ceph-building-a-b-tree/)

I had thought that we could just query each data pool for the object,
but Sage points out that 100-pool clusters aren't exactly unreasonable
and that would take quite a lot of query time. And having the
backtraces in the data pools significantly complicates things with our
rules about setting layouts on new files.

So this is going to need some kind of revision, please suggest alternatives!
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
