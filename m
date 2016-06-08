From: Manavalan Krishnan <Manavalan.Krishnan@sandisk.com>
Subject: RocksDB tuning
Date: Wed, 8 Jun 2016 22:09:46 +0000
Message-ID: <D37DE46C.5743E%manavalan.krishnan@sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bl2on0076.outbound.protection.outlook.com ([65.55.169.76]:5138
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1161205AbcFHWJt convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Jun 2016 18:09:49 -0400
Content-Language: en-US
Content-ID: <72882B63901A714B9C3A89D6C672E3D6@namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

Hi Mark

Here are the tunings that we used to avoid the IOPs choppiness caused by
rocksdb compaction.

We need to add the following options in src/kv/RocksDBStore.cc before
rocksdb::DB::Open in RocksDBStore::do_open
opt.IncreaseParallelism(16);
  opt.OptimizeLevelStyleCompaction(512 * 1024 * 1024);



Thanks
Mana


>

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
