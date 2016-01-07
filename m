From: Sage Weil <sweil@redhat.com>
Subject: Re: Is BlueFS an alternative of BlueStore?
Date: Thu, 7 Jan 2016 08:19:06 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1601070813000.26051@cpach.fuggernut.com>
References: <568DE333.7070206@xtaotech.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34393 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752079AbcAGNTG (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 7 Jan 2016 08:19:06 -0500
In-Reply-To: <568DE333.7070206@xtaotech.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Javen Wu <javen.wu@xtaotech.com>
Cc: Peng Xie <peng.hse@xtaotech.com>, ceph-devel@vger.kernel.org

On Thu, 7 Jan 2016, Javen Wu wrote:
> Hi Sage,
> 
> Sorry to bother you. I am not sure if it is appropriate to send email to you
> directly, but I cannot find any useful information to address my confusion
> from Internet. Hope you can help me.
> 
> Occasionally, I heard that you are going to start BlueFS to eliminate the
> redudancy between XFS journal and RocksDB WAL. I am a little confused.
> Is the Bluefs only to host RocksDB for BlueStore or it's an
> alternative of BlueStore?
> 
> I am a new comer to CEPH, I am not sure my understanding is correct about
> BlueStore. BlueStore in my mind is as below.
> 
>              BlueStore
>              =========
>    RocksDB
> +-----------+          +-----------+
> |   onode   |          |           |
> |    WAL    |          |           |
> |   omap    |          |           |
> +-----------+          |   bdev    |
> |           |          |           |
> |   XFS     |          |           |
> |           |          |           |
> +-----------+          +-----------+

This is the picture before BlueFS enters the picture.

> I am curious if BlueFS is able to host RocksDB, actually it's already a
> "filesystem" which have to maintain blockmap kind of metadata by its own
> WITHOUT the help of RocksDB. 

Right.  BlueFS is a really simple "file system" that is *just* complicated 
enough to implement the rocksdb::Env interface, which is what rocksdb 
needs to store its log and sst files.  The after picture looks like

 +--------------------+
 |     bluestore      |
 +----------+         |
 | rocksdb  |         |
 +----------+         |
 |  bluefs  |         |
 +----------+---------+
 |    block device    |
 +--------------------+

> The reason we care the intention and the design target of BlueFS is that I had
> discussion with my partner Peng.Hse about an idea to introduce a new
> ObjectStore using ZFS library. I know CEPH supports ZFS as FileStore backend
> already, but we had a different immature idea to use libzpool to implement a
> new
> ObjectStore for CEPH totally in userspace without SPL and ZOL kernel module.
> So that we can align CEPH transaction and zfs transaction in order to  avoid
> double write for CEPH journal.
> ZFS core part libzpool (DMU, metaslab etc) offers a dnode object store and
> it's platform kernel/user independent. Another benefit for the idea is we
> can extend our metadata without bothering any DBStore.
> 
> Frankly, we are not sure if our idea is realistic so far, but when I heard of
> BlueFS, I think we need to know the BlueFS design goal.

I think it makes a lot of sense, but there are a few challenges.  One 
reason we use rocksdb (or a similar kv store) is that we need in-order 
enumeration of objects in order to do collection listing (needed for 
backfill, scrub, and omap).  You'll need something similar on top of zfs.  

I suspect the simplest path would be to also implement the rocksdb::Env 
interface on top of the zfs libraries.  See BlueRocksEnv.{cc,h} to see the 
interface that has to be implemented...

sage
