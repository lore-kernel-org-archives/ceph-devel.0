From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: Bluestore assert
Date: Wed, 10 Aug 2016 21:42:37 +0000
Message-ID: <BL2PR02MB21152DD264ED98729D233851F41D0@BL2PR02MB2115.namprd02.prod.outlook.com>
References: <BL2PR02MB2115443F5ACA3459E2CEBFBAF41D0@BL2PR02MB2115.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1608102121090.17770@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-co1nam03on0063.outbound.protection.outlook.com ([104.47.40.63]:54552
	"EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750796AbcHJVml convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Aug 2016 17:42:41 -0400
In-Reply-To: <alpine.DEB.2.11.1608102121090.17770@piezo.us.to>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Sage,
I can't go for full log (20/20) as this is happening after long run (1 hour or so).
Yes, I will add some code to print that if I hit next time. Basically, I would suggest to print all relevant values before we asserting in the log. That will be helpful most of the cases. I will try to create a pull request around that for Bluestore.

Thanks & Regards
Somnath

-----Original Message-----
From: Sage Weil [mailto:sweil@redhat.com]
Sent: Wednesday, August 10, 2016 2:22 PM
To: Somnath Roy
Cc: ceph-devel
Subject: Re: Bluestore assert

On Wed, 10 Aug 2016, Somnath Roy wrote:
> Sage,
> FYI, this is another assert I am hitting quite frequently during longer runs..
>
> os/bluestore/BlueStore.cc: 5029: FAILED assert(r == 0)
>
>  ceph version 11.0.0-1229-g729c852
> (729c8523c12f95d2309388f7c619032cb3ea13cc)
>  1: (ceph::__ceph_assert_fail(char const*, char const*, int, char
> const*)+0x80) [0x55d1c95315a0]
>  2: (BlueStore::_kv_sync_thread()+0x1fae) [0x55d1c910a27e]
>  3: (BlueStore::KVSyncThread::entry()+0xd) [0x55d1c912bf3d]
>  4: (Thread::entry_wrapper()+0x75) [0x55d1c9510eb5]
>  5: (()+0x76fa) [0x7fbade56c6fa]
>  6: (clone()+0x6d) [0x7fbadc3ccb5d]
>
> The following db sync transaction is failing in kv_sync_thread
>
>       int r = db->submit_transaction_sync(t);
>       assert(r == 0);

Do you have a full log? Can you see what r is in this case?  I'm not sure why it would be returning an error there... it's probably coming from rocksdb?

> And I hit the following BlueFS corruption again during replay.
>
> 2016-08-10 16:08:14.012853 7f3098c158c0  0 pidfile_write: ignore empty
> --pid-file
> 2016-08-10 16:08:14.014544 7f3098c158c0 -1 WARNING: the following
> dangerous and experimental features are enabled: bluestore,rocksdb
> 2016-08-10 16:08:14.020994 7f3098c158c0  1 bdev create path
> /var/lib/ceph/osd/ceph-8/block type kernel
> 2016-08-10 16:08:14.021496 7f3098c158c0  1
> bdev(/var/lib/ceph/osd/ceph-8/block) open path
> /var/lib/ceph/osd/ceph-8/block
> 2016-08-10 16:08:14.021675 7f3098c158c0  1
> bdev(/var/lib/ceph/osd/ceph-8/block) open size 7558019747840
> (0x6dfbd151000, 7038 GB) block_size 4096 (4096 B) non-rotational
> 2016-08-10 16:08:14.022135 7f3098c158c0  1 bdev create path
> /var/lib/ceph/osd/ceph-8/block.db type kernel
> 2016-08-10 16:08:14.022703 7f3098c158c0  1
> bdev(/var/lib/ceph/osd/ceph-8/block.db) open path
> /var/lib/ceph/osd/ceph-8/block.db
> 2016-08-10 16:08:14.022822 7f3098c158c0  1
> bdev(/var/lib/ceph/osd/ceph-8/block.db) open size 111669149696
> (0x1a00000000, 104 GB) block_size 4096 (4096 B) non-rotational
> 2016-08-10 16:08:14.023231 7f3098c158c0  1 bdev create path
> /var/lib/ceph/osd/ceph-8/block type kernel
> 2016-08-10 16:08:14.023782 7f3098c158c0  1
> bdev(/var/lib/ceph/osd/ceph-8/block) open path
> /var/lib/ceph/osd/ceph-8/block
> 2016-08-10 16:08:14.023894 7f3098c158c0  1
> bdev(/var/lib/ceph/osd/ceph-8/block) open size 7558019747840
> (0x6dfbd151000, 7038 GB) block_size 4096 (4096 B) non-rotational
> 2016-08-10 16:08:14.023908 7f3098c158c0  1 bdev create path
> /var/lib/ceph/osd/ceph-8/block.wal type kernel
> 2016-08-10 16:08:14.024366 7f3098c158c0  1
> bdev(/var/lib/ceph/osd/ceph-8/block.wal) open path
> /var/lib/ceph/osd/ceph-8/block.wal
> 2016-08-10 16:08:14.024471 7f3098c158c0  1
> bdev(/var/lib/ceph/osd/ceph-8/block.wal) open size 1073741824
> (0x40000000, 1024 MB) block_size 4096 (4096 B) non-rotational
> 2016-08-10 16:08:14.072497 7f3098c158c0 -1 bluefs _replay file with
> link count 0: file(ino 16 size 67544250 mtime 2016-08-09
> 20:06:51.480916 bdev 0 extents
> [^@:5242880+4194304,^@:13631488+2097152,^@:19922944+5242880,^@:2936012
> 8+5242880,^@:38797312+6291456,^@:49283072+6291456,^@:59768832+5242880,
> ^@:69206016+6291456,^@:79691776+5242880,^@:89128960+6291456,^@:9961472
> 0+6291456,^@:110100480+5242880,^@:119537664+4194304,^@:125829120+31457
> 28])
> 2016-08-10 16:08:14.072518 7f3098c158c0 -1 bluefs mount failed to
> replay log: (5) Input/output error
> 2016-08-10 16:08:14.072539 7f3098c158c0 -1
> bluestore(/var/lib/ceph/osd/ceph-8) _open_db failed bluefs mount: (5)
> Input/output error
> 2016-08-10 16:08:14.072544 7f3098c158c0  1
> bdev(/var/lib/ceph/osd/ceph-8/block.wal) close
> 2016-08-10 16:08:14.291953 7f3098c158c0  1
> bdev(/var/lib/ceph/osd/ceph-8/block.db) close
> 2016-08-10 16:08:14.539823 7f3098c158c0  1
> bdev(/var/lib/ceph/osd/ceph-8/block) close
> 2016-08-10 16:08:14.791829 7f3098c158c0  1
> bdev(/var/lib/ceph/osd/ceph-8/block) close
> 2016-08-10 16:08:15.051855 7f3098c158c0 -1 osd.8 0 OSD:init: unable to
> mount object store
> 2016-08-10 16:08:15.051869 7f3098c158c0 -1 ^[[0;31m ** ERROR: osd init
> failed: (5) Input/output error^[[0m

Do you have a full log?

Thanks!
sage
PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
