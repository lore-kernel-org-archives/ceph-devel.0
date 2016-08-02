From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: Another BlueFS corruption
Date: Tue, 2 Aug 2016 22:59:13 +0000
Message-ID: <BL2PR02MB21159A24C7A61A47077F539AF4050@BL2PR02MB2115.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-dm3nam03on0083.outbound.protection.outlook.com ([104.47.41.83]:60480
	"EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754164AbcHBW7Q convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Aug 2016 18:59:16 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,
Got another corruption within BlueFS during replay.

Thread 1 "ceph-osd" received signal SIGSEGV, Segmentation fault.
0x0000555555d33bfc in BlueFS::_read (this=this@entry=0x7ffff34fca80, h=h@entry=0x7fffe8472300, buf=buf@entry=0x7fffe8472308, off=0, len=4096,
    outbl=outbl@entry=0x7fffffff58a0, out=0x0) at os/bluestore/BlueFS.cc:839
839           uint64_t l = MIN(p->length - x_off, want);
(gdb) bt
#0  0x0000555555d33bfc in BlueFS::_read (this=this@entry=0x7ffff34fca80, h=h@entry=0x7fffe8472300, buf=buf@entry=0x7fffe8472308, off=0, len=4096,
    outbl=outbl@entry=0x7fffffff58a0, out=0x0) at os/bluestore/BlueFS.cc:839
#1  0x0000555555d43abf in BlueFS::_replay (this=this@entry=0x7ffff34fca80) at os/bluestore/BlueFS.cc:475
#2  0x0000555555d46f2f in BlueFS::mount (this=0x7ffff34fca80) at os/bluestore/BlueFS.cc:343
#3  0x0000555555c2cb8d in BlueStore::_open_db (this=this@entry=0x7ffff3549c00, create=create@entry=false) at os/bluestore/BlueStore.cc:2096
#4  0x0000555555c50ded in BlueStore::mount (this=0x7ffff3549c00) at os/bluestore/BlueStore.cc:2739
#5  0x00005555559113f6 in OSD::init (this=0x7ffff35ff000) at osd/OSD.cc:2025
#6  0x0000555555874680 in main (argc=<optimized out>, argv=<optimized out>) at ceph_osd.cc:609

I got now total of 3 BlueFS replay bug and created the following tracker adding all crashes..

http://tracker.ceph.com/issues/16897

Thanks & Regards
Somnath
PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
