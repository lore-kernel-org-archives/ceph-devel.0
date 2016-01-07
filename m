From: Sage Weil <sweil@redhat.com>
Subject: Re: Is BlueFS an alternative of BlueStore?
Date: Thu, 7 Jan 2016 10:10:31 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1601071003140.26051@cpach.fuggernut.com>
References: <568DE333.7070206@xtaotech.com> <alpine.DEB.2.11.1601070813000.26051@cpach.fuggernut.com> <568E781B.4030803@xtaotech.com> <568E78D8.8080401@xtaotech.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-971473358-1452179433=:26051"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38238 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750722AbcAGPKb (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 7 Jan 2016 10:10:31 -0500
In-Reply-To: <568E78D8.8080401@xtaotech.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Javen Wu <javen.wu@xtaotech.com>
Cc: "peng.hse" <peng.hse@xtaotech.com>, ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-971473358-1452179433=:26051
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Thu, 7 Jan 2016, Javen Wu wrote:
> Thanks Sage for your reply.
> 
> I am not sure I understand the challenges you mentioned about backfill/scrub.
> I will investigate from the code and let you know if we can conquer the
> challenge by easy means.
> Our rough idea for ZFSStore are:
> 1. encapsulate dnode object as onode and add onode attributes.
> 2. uses ZAP object as collection. (ZFS directory uses ZAP object)
> 3. enumerating entries in ZAP object is list objects in collection.

This is the key piece that will determine whether rocksdb (or something 
similar) is required.  POSIX doesn't give you sorted enumeration of 
files.  In order to provide that with FileStore, we used a horrible 
hashing scheme that dynamically broke directories into 
smaller subdirectories once they got big, and organized things by a hash 
prefix (enumeration is in hash order).  That meant a mess of directories 
with bounded size (so that there were a bounded number of entries to read 
and then sort in memory before returning a sorted result), which was 
inefficient, and it meant that as the number of objects grew you'd have 
this periodic rehash work that had to be done that further slowed things 
down.  This, combined with the inability to group an arbitrary 
number of file operations (writes, unlinks, renames, setxattrs, etc.) into 
an atomic transaction was FileStore's downfall.  I think the zfs libs give 
you the transactions you need, but you *also* need to get sorted 
enumeration (with a sort order you define) or else you'll have all the 
ugliness of the FileStore indexes.

> 4. create a new metaslab class to store CEPH journal.
> 5. align CEPH journal and ZFS transcation.
> 
> Actually we've talked about the possibility of building RocksDB::Env on top
> of the zfs libraries. It must align ZIL(ZFS intent log) and RocksDB WAL.
> Otherwise, there is still same problem as XFS and RocksDB.
> 
> ZFS is tree style log structure-like file system, once a leaf block updates,
> the modification would be propagated from the leaf to the root of tree.
> To batch writes and reduce times of disk write, ZFS persist modification to
> disk
> in 5 seconds transaction. Only when Fsync/sync write arrives in the middle of
> the 5 seconds, ZFS would persist the journal to ZIL.
> I remembered RocksDB would do a sync after log record adding, so it means if
> we can not align ZIL and WAL, the log write would be write to ZIL firstly and
> then apply ZIL to log file, finally Rockdb update sst file. It's almost the
> same problem as XFS if my understanding is correct.

If you implement rocksdb::Env, you'll see the rocksdb WAL writes and the 
fsync calls come down.  You can store those however you'd like... as 
"files" or perhaps directly in the ZIL.

The way we do this in BlueFS is that for an initial warm-up period, we 
append to a WAL log file, and have to do both the log write *and* a 
journal write to update the file size.  Once we've written out enough 
logs, though, we start recycling the same logs (and disk blocks) and just 
overwrite the previously allocated space.  The rocksdb log replay is now 
smart enough to determine when it's reached the end of the new content and 
is now seeing (old) garbage and stop.

Whether it makes sense to do something similar in zfs-land I'm not sure.  
Presumably the ZIL itself is doing something similar (sequence nubmers and 
crcs on log entries in a circular buffer) but the rocksdb log 
lifecycle probably doesn't match the ZIL...

sage

> In my mind, aligning ZIL and WAL need more modifications in RocksDB.
> 
> Thanks
> Javen
> 
> 
> On 2016年01月07日 22:37, peng.hse wrote:
> > Hi Sage,
> > 
> > thanks for your quick response. Javen and I  once the zfs developer,are
> > currently focusing on how to
> > leverage some of the zfs ideas to improve the ceph backend performance in
> > userspace.
> > 
> > 
> > Based on your encouraging reply, we come up with 2 schemes to continue our
> > future work
> > 
> > 1. the scheme one: using the entire new FS to replace rocksdb+bluefs, the FS
> > itself handles the mapping of
> >     oid->fs-object(kind of zfs dnode) and the according attrs used by ceph.
> >    Despite the implemention challenges you mentioned about the in-order
> > enumeration of objects during backfill, scrub, etc (the
> >     same situation we also confronted in zfs, the ZAP features help us a
> > lot).
> >     From performance or architecture point of view, it looks more clear and
> > clean, would you suggest us to give a try ?
> > 
> > 2. the scheme two: As your last suspect, we just temporarily implemented the
> > simple version of the FS
> >      which leverage libzpool ideas to plug into rocksdb underneath as your
> > bluefs did
> > 
> > precious your insightful reply.
> > 
> > Thanks
> > 
> > 
> > 
> > On 2016年01月07日 21:19, Sage Weil wrote:
> > > On Thu, 7 Jan 2016, Javen Wu wrote:
> > > > Hi Sage,
> > > > 
> > > > Sorry to bother you. I am not sure if it is appropriate to send email to
> > > > you
> > > > directly, but I cannot find any useful information to address my
> > > > confusion
> > > > from Internet. Hope you can help me.
> > > > 
> > > > Occasionally, I heard that you are going to start BlueFS to eliminate
> > > > the
> > > > redudancy between XFS journal and RocksDB WAL. I am a little confused.
> > > > Is the Bluefs only to host RocksDB for BlueStore or it's an
> > > > alternative of BlueStore?
> > > > 
> > > > I am a new comer to CEPH, I am not sure my understanding is correct
> > > > about
> > > > BlueStore. BlueStore in my mind is as below.
> > > > 
> > > >               BlueStore
> > > >               =========
> > > >     RocksDB
> > > > +-----------+          +-----------+
> > > > |   onode   |          |           |
> > > > |    WAL    |          |           |
> > > > |   omap    |          |           |
> > > > +-----------+          |   bdev    |
> > > > |           |          |           |
> > > > |   XFS     |          |           |
> > > > |           |          |           |
> > > > +-----------+          +-----------+
> > > This is the picture before BlueFS enters the picture.
> > > 
> > > > I am curious if BlueFS is able to host RocksDB, actually it's already a
> > > > "filesystem" which have to maintain blockmap kind of metadata by its own
> > > > WITHOUT the help of RocksDB.
> > > Right.  BlueFS is a really simple "file system" that is *just* complicated
> > > enough to implement the rocksdb::Env interface, which is what rocksdb
> > > needs to store its log and sst files.  The after picture looks like
> > > 
> > >   +--------------------+
> > >   |     bluestore      |
> > >   +----------+         |
> > >   | rocksdb  |         |
> > >   +----------+         |
> > >   |  bluefs  |         |
> > >   +----------+---------+
> > >   |    block device    |
> > >   +--------------------+
> > > 
> > > > The reason we care the intention and the design target of BlueFS is that
> > > > I had
> > > > discussion with my partner Peng.Hse about an idea to introduce a new
> > > > ObjectStore using ZFS library. I know CEPH supports ZFS as FileStore
> > > > backend
> > > > already, but we had a different immature idea to use libzpool to
> > > > implement a
> > > > new
> > > > ObjectStore for CEPH totally in userspace without SPL and ZOL kernel
> > > > module.
> > > > So that we can align CEPH transaction and zfs transaction in order to
> > > > avoid
> > > > double write for CEPH journal.
> > > > ZFS core part libzpool (DMU, metaslab etc) offers a dnode object store
> > > > and
> > > > it's platform kernel/user independent. Another benefit for the idea is
> > > > we
> > > > can extend our metadata without bothering any DBStore.
> > > > 
> > > > Frankly, we are not sure if our idea is realistic so far, but when I
> > > > heard of
> > > > BlueFS, I think we need to know the BlueFS design goal.
> > > I think it makes a lot of sense, but there are a few challenges.  One
> > > reason we use rocksdb (or a similar kv store) is that we need in-order
> > > enumeration of objects in order to do collection listing (needed for
> > > backfill, scrub, and omap).  You'll need something similar on top of zfs.
> > > 
> > > I suspect the simplest path would be to also implement the rocksdb::Env
> > > interface on top of the zfs libraries.  See BlueRocksEnv.{cc,h} to see the
> > > interface that has to be implemented...
> > > 
> > > sage
> > > 
> > 
> > 
> 
> 
--8323329-971473358-1452179433=:26051--
