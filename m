From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: Rocksdb tuning on Bluestore
Date: Mon, 11 Jul 2016 15:03:57 +0000
Message-ID: <BL2PR02MB211505A57EE2D7DDE6A96DB5F43F0@BL2PR02MB2115.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn3nam01on0050.outbound.protection.outlook.com ([104.47.33.50]:41704
	"EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1030495AbcGKPD7 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Jul 2016 11:03:59 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Mark Nelson (mnelson@redhat.com)" <mnelson@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Mark,
With the following tuning it seems rocksdb is performing better in my environment. Basically, doing aggressive compaction to reduce the write stalls.

bluestore_rocksdb_options = "max_write_buffer_number=16,min_write_buffer_number_to_merge=16,recycle_log_file_num=16,compaction_threads=32,flusher_threads=4,max_background_compactions=32,max_background_flushes=8,max_bytes_for_level_base=5368709120,write_buffer_size=83886080,level0_file_num_compaction_trigger=4,level0_slowdown_writes_trigger=400,level0_stop_writes_trigger=800"


BTW, I am not able to run BlueStore more than 2 hour at a stretch due to memory issues. It is filling up my system memory (2 node of 64 G memory , running 8 OSDS on each) fast.
The following operation I did and it started swapping.

1. Created a 4TB image and did 1M sequential preconditioning (took ~1 hour)

2. Followed by two 30 min 4k RW with QD 128 (numjob = 10) and in the 2nd run memory started swapping.

Let me know how this rocksdb option works for you.

Thanks & Regards
Somnath

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
