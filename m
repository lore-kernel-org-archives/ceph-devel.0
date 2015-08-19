From: Varada Kari <Varada.Kari@sandisk.com>
Subject: Generalizing ceph-disk for various osd backends
Date: Wed, 19 Aug 2015 08:13:26 +0000
Message-ID: <C226B0AB34511445928D9882AA519F601C471C3E@SACMBXIP03.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1on0081.outbound.protection.outlook.com ([157.56.110.81]:14555
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753098AbbHSINa convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Aug 2015 04:13:30 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>
Cc: Sage Weil <sweil@redhat.com>

Hi all,

This is regarding generalizing the ceph-disk to work with different osd backends like FileStore, KeyValueStore and NewStore etc...
All these object store implementations has different needs on the disk being used for holding data and Meta data.
Sage suggest in the one of the pull requests for the requirements what ceph-disk should satisfy to generalize the ceph-disk to handle all the backends optimally. From the current implementation of supported object store backends below are requirements ceph-disk is expected to perform.

FileStore:
1. Needs a partition/disk for the FileSystem
2. Needs a partition/disk for the Journal
3. Additionally if we can make the omap(Leveldb/RocksDB to be on separate partition depending on the backend medium being used HDD or SSD.

NewStore:
1. Needs a File System on a disk/partition
2. Optionally needs a file system depending on backend DB used(LevelDB/RocksDB ...) for the journal
3. Optionally needs a file system on a faster medium for the warm levels to hold the data.

KeyValueStore:
1. Needs a small partition to hold metadata of the OSD on a file system.
2. Needs a partition/disk to hold data. Some backends need a file system, some can work of a raw partition/disk.
3. Optionally may need a partition to hold the cache or journal

Please add any of the details if I had missed.

Ideally, ceph-disk should make a decision depending on the input given by the user through conf file or some options to ceph-disk in a manual deployment.  Inputs from user can be what kind of file system need to be created, file system size, device to be created on etc...  in case of a file store.
Similarly for KeyValueStore, backend can work on raw partition or a disk else if would need a file system to work.

Quoting Sage again here.
Alternatively, we could say that it's the admin's job to express to ceph-disk what kind of OSD it should create (backend type, secondary fs's or partitions, etc.) instead of inferring that from the environment. In that case, we'd could
* make a generic way to specify which backend to use in the osd_data dir
* make sure all secondary devices or file systems are symlinked from the osd_data dir, the way the journal is today. This could be in a backend-specific way. e.g., FileStore wants the journal (to bdev) link, NewStore wants a db_wal link (to small + fast fs) link, etc.
* we could create uuid types for each secondary device type. A raw block dev would work just like ceph-disk activate-journal. A new uuid would be for secondary fs's, which would mount and then trigger ceph-disk activate-slave-fs DEV or similar.
* ceph-disk activate[-] can ensure that *all symlinks in the data dir resolve to real things (all devices or secondary fs's are mounted) before starting ceph-osd.

Will be making the changes once we agree on requirements and implementation specifics. Please correct me if I had understood wrong.

Thanks,
Varada


________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).

