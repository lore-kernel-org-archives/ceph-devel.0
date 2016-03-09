From: Allen Samuels <Allen.Samuels@sandisk.com>
Subject: BlueStore Performance issue
Date: Wed, 9 Mar 2016 01:38:31 +0000
Message-ID: <CY1PR0201MB189788B82C09E5D1DF7BDEE2E8B30@CY1PR0201MB1897.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bl2on0055.outbound.protection.outlook.com ([65.55.169.55]:37813
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750787AbcCIBie convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Mar 2016 20:38:34 -0500
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

We are in the process of evaluating the performance of the BlueStore when using ZetaScale in place of RocksDB. Currently, we see one major performance bottleneck that is dictated by the current implementation of BlueStore. We believe that this bottleneck is artificial and can be easily removed. Further, we believe that this will provide a performance improvement for both the BlueStore/ZetaScale as well as the BlueStore/RocksDB combinations.

We are currently implementing a revision of this area of the code and are looking for community comments and constructive criticism. It's also possible that we don't properly understand this code -- in which case an early course correction would be beneficial.

For this discussion, we consider the write-path of BlueStore to consist of 4 steps:

1. Preparation and asynchronous initiation of data writes.
2. Detection of asynchronous write completions
3. KV transaction commit.
4. WAL stuff.

Currently, stage 2 is performed by a single "aio_thread" for data block device, essentially one global thread. This thread waits for each I/O to complete. Once an I/O has completed, it checks to see if the associated transaction has any remaining I/O operations and if not, moves that transaction into the global kv_sync queue, waking up the kv_sync thread if needed.

Stage 3 is a single system-wide thread that removes transactions from the kv_sync queue and submits them to the KeyValueDB one at a time (synchronously).

Stage 3 is serious bottleneck in that it guarantees that you will never exceed QD=1 for your logging device. We believe there is no need to serialize the KV commit operations.

We propose to modify this mechanism as follows:

Stage 2 will be performed by a separate pool of threads (each with an associated io completion context). During Stage 1, one thread is allocated from the pool for each transaction. The asynchronous data writes that are created for that transaction point to the newly allocated io completion context/thread.

Each of these I/O completion threads will now wait for all of the data writes associated with their individual transactions to be completed and then will synchronously commit to the KeyValueDB. Once the KV commit is completed, the completion handlers are invoked (possibly eliminating an extra thread switch for the synchronous completion callbacks) and then the transaction is destroyed or passed off to the existing WAL logic (which we believe can be eliminated -- but that's a discussion for another day :)).

This new mechanism has the effect of allowing 'N' simultaneous KV commit operations to be outstanding (N is the size of the completion thread pool). We believe that both ZetaScale and RocksDB will support much higher transaction rates in this situation, which should lead to significant performance improvement for small transactions.

There are two major changes that we are nervous about.

(1) Having multiple KV commits outstanding. We're certain that the underlying KV implementations will properly handle this but we're concerned that there might be hidden dependencies in the upper level OSD code that aren't apparent to us.

(2) Similar to (1), the handling of the completion callbacks is now parallelized -- with the same concerns.

Comments please?

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
