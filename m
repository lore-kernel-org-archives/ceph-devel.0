From: Varada Kari <Varada.Kari@sandisk.com>
Subject: RE: Generalizing ceph-disk for various osd backends
Date: Fri, 21 Aug 2015 17:44:45 +0000
Message-ID: <C226B0AB34511445928D9882AA519F601C47388B@SACMBXIP03.sdcorp.global.sandisk.com>
References: <C226B0AB34511445928D9882AA519F601C471C3E@SACMBXIP03.sdcorp.global.sandisk.com>
 <alpine.DEB.2.00.1508210757240.13116@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1bon0077.outbound.protection.outlook.com ([157.56.111.77]:27072
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752110AbbHURou convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 21 Aug 2015 13:44:50 -0400
In-Reply-To: <alpine.DEB.2.00.1508210757240.13116@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Something like erasure code plugins would suffice here? Each plugin has a default parameters, which can be overridden with ceph.conf options.

Varada

-----Original Message-----
From: Sage Weil [mailto:sage@newdream.net]
Sent: Friday, August 21, 2015 8:37 PM
To: Varada Kari <Varada.Kari@sandisk.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>
Subject: Re: Generalizing ceph-disk for various osd backends

On Wed, 19 Aug 2015, Varada Kari wrote:
> Hi all,
>
> This is regarding generalizing the ceph-disk to work with different osd backends like FileStore, KeyValueStore and NewStore etc...
> All these object store implementations has different needs on the disk being used for holding data and Meta data.
> Sage suggest in the one of the pull requests for the requirements what ceph-disk should satisfy to generalize the ceph-disk to handle all the backends optimally. From the current implementation of supported object store backends below are requirements ceph-disk is expected to perform.
>
> FileStore:
> 1. Needs a partition/disk for the FileSystem 2. Needs a partition/disk
> for the Journal 3. Additionally if we can make the
> omap(Leveldb/RocksDB to be on separate partition depending on the backend medium being used HDD or SSD.
>
> NewStore:
> 1. Needs a File System on a disk/partition 2. Optionally needs a file
> system depending on backend DB used(LevelDB/RocksDB ...) for the
> journal 3. Optionally needs a file system on a faster medium for the warm levels to hold the data.
>
> KeyValueStore:
> 1. Needs a small partition to hold metadata of the OSD on a file system.
> 2. Needs a partition/disk to hold data. Some backends need a file system, some can work of a raw partition/disk.
> 3. Optionally may need a partition to hold the cache or journal
>
> Please add any of the details if I had missed.
>
> Ideally, ceph-disk should make a decision depending on the input given by the user through conf file or some options to ceph-disk in a manual deployment.  Inputs from user can be what kind of file system need to be created, file system size, device to be created on etc...  in case of a file store.
> Similarly for KeyValueStore, backend can work on raw partition or a disk else if would need a file system to work.
>
> Quoting Sage again here.
> Alternatively, we could say that it's the admin's job to express to
> ceph-disk what kind of OSD it should create (backend type, secondary
> fs's or partitions, etc.) instead of inferring that from the
> environment. In that case, we'd could
> * make a generic way to specify which backend to use in the osd_data
> dir
> * make sure all secondary devices or file systems are symlinked from the osd_data dir, the way the journal is today. This could be in a backend-specific way. e.g., FileStore wants the journal (to bdev) link, NewStore wants a db_wal link (to small + fast fs) link, etc.
> * we could create uuid types for each secondary device type. A raw block dev would work just like ceph-disk activate-journal. A new uuid would be for secondary fs's, which would mount and then trigger ceph-disk activate-slave-fs DEV or similar.
> * ceph-disk activate[-] can ensure that *all symlinks in the data dir resolve to real things (all devices or secondary fs's are mounted) before starting ceph-osd.
>
> Will be making the changes once we agree on requirements and
> implementation specifics. Please correct me if I had understood wrong.

I think the trick here is to figure out how to describe these requirements.  I think it ought to be some structured thing ceph-osd can spit out for a given backend that says what it needs.  For example, for filestore,

{
  "data": {
     "type": "fs",
     "min_size": 10485760,
     "max_size": 1000000000000000, # whatever
     "preferred_size": 100000000000000000,
     "required": true
  },
  "journal": {
     "type": "block",
     "min_size": 10485760,
     "max_size": 104857600,
     "preferred_size": 40960000,
     "required": false,
     "preferred": true
  },
}

Then ceph-disk can be fed the devices to use based on those names. e.g.,

 ceph-disk prepare objectstore=filestore data=/dev/sda journal=/dev/sdb

Or for your KV backend,

{
  "data": {
     "type": "fs",
     "min_size": 10485760,
     "max_size": 10485760,
     "preferred_size": 10485760,
     "required": true
  },
  "kvdata": {
     "type": "block",
     "min_size": 10485760,
     "max_size": 1000000000000000, # whatever
     "preferred_size": 100000000000000000,
     "required": true
  },
  "journal": {
     "type": "block",
     "min_size": 10485760,
     "max_size": 104857600,
     "preferred_size": 40960000,
     "required": false,
     "preferred": false
  },
}

 ceph-disk prepare objectstore=keyvaluestore data=/dev/sda kvdata=/dev/sda journal=/dev/sdb

The ceph-disk logic would create partitions on the given devices as needed, trying for preferred size but doing what it needs to to make it fit.  If something is required/preferred but not specified (e.g., with filestore's journal) it'll use the same device as the other stuff, so that the filestore case coudl simplify to

 ceph-disk prepare objectstore=filestore data=/dev/sda

or whatever.

Would something like this be general enough to capture the possibilities and still do everything we need it to?

sage


________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).

