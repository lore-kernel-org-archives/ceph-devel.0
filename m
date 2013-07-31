From: Sage Weil <sage@inktank.com>
Subject: Re: Blueprint:  Add LevelDB support to ceph cluster backend store
Date: Tue, 30 Jul 2013 23:01:41 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1307302251510.24945@cobra.newdream.net>
References: <C0D1D705-4B4F-4189-ACBF-4C39D80984DA@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45454 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751290Ab3GaGBl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 31 Jul 2013 02:01:41 -0400
In-Reply-To: <C0D1D705-4B4F-4189-ACBF-4C39D80984DA@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomaiwang@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Haomai,

On Wed, 31 Jul 2013, Haomai Wang wrote:
> Every node of ceph cluster has a backend filesystem such as btrfs,
> xfs and ext4 that provides storage for data objects, whose location
> are determined by CRUSH algorithm. There should exists an abstract
> interface sitting between osd and backend store, allowing different
> backend store implementation. Currently, we only have general 
> POSIX interface. LevelDB is a fast key-value storage library written at 
> Google that provides an ordered mapping from string keys to string 
> values. We could implement a LevelDB backend to support base 
> operations correspond to POSIX operations.  LevelDB driver enables 
> gateway to communicate with LevelDB to store objects on the node 
> basis.
> 
> 
> LevelDB driver is attractive by the folks who own a special use case 
> such as a write-heave system. If we can abstract a general interface, 
> we can choose other DBM if you find it more suitable, such as Kyoto 
> Cabinet, BDB. Futhermore, we can choose backen store for each OSD
> node. So we have different OSD type for special purpose.
> 
> Expected Results: Objects can be stored reliably to LevelDB. The IO 
> performance and recovery process can be comparable to original 
> stores. And for special case, LevelDB driver should have much better 
> performance than local filesystem backend driver. The snapshot and
> any features you think of are optional.

I added a comment in the wiki, but I'll reply here.

Much of what you're talking about is already in place:

 - There is an ObjectStore.h abstraction of the local storage.  The only 
   up to date implementation is FileStore, which uses a combination 
   of a local file system and leveldb, but other backends have been used 
   in the past, and new ones can we easily added in.

 - We currently use leveldb for the 'omap' component of rados objects.  
   That is, each rados object has a bytestream portion (like a file), 
   attr (like extended attributes), and an omap (keys/values).  All of 
   none of those interfaces can be used for any given object, although 
   most users only use one interface at a time.  The main limitation here 
   if you want to use leveldb only is that we still have an inode in the 
   file system to represent each object, even when it contains only 
   key/value pairs.

 - The use of leveldb itself is also well abstracted by a KeyValueDB 
   interface, so other key/value libraries could be swapped in in its 
   place.  The main other component is a middle layer that wraps the kv 
   store to provide copy-on-write type semantics for each object's set of 
   keys (to facilitate the snapshot functionality in rados/ceph).

If you have a workload that you want to be purgely key/value based, it 
would be possible to write a much simpler ObjectStore implementation that 
ignores or trivially implements the byte and attr portions of the object 
in leveldb (or the KeyValueDB abstraction).  It would have very different 
performance characteristics than what we're doing now, of course.  You 
might also be interested in looking at the HyperLevelDB project, which is 
a fork of leveldb that focuses on multithreading and compaction 
performance.

We've heard from other people who are interested in wiring different 
key/value backends into the OSD, so any work to make it easier to do that 
would be great!

sage
