From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: Bluestore crash
Date: Fri, 24 Jun 2016 01:17:42 +0000
Message-ID: <BL2PR02MB211545DA824FBF43E1C7ADDAF42E0@BL2PR02MB2115.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1bon0060.outbound.protection.outlook.com ([157.56.111.60]:54752
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750838AbcFXBRs convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Jun 2016 21:17:48 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Sage Weil (sage@newdream.net)" <sage@newdream.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Sage,
Getting the following crash while running io on a fresh image. Managed to get a gdb trace.


     0> 2016-06-23 21:09:09.924186 7f2d9b084700 -1 *** Caught signal (Segmentation fault) **
in thread 7f2d9b084700 thread_name:bstore_aio

ceph version 10.2.0-2765-g798c18b (798c18be1a5fd0e2f5fe5b06e08af460d4aadedf)
1: (()+0x9d436e) [0x55b9b709736e]
2: (()+0x113d0) [0x7f2da6cd33d0]
3: (BlueStore::_txc_state_proc(BlueStore::TransContext*)+0x634) [0x55b9b6d9c6d4]
4: (BlueStore::_txc_finish_io(BlueStore::TransContext*)+0x1bf) [0x55b9b6d9cb8f]
5: (BlueStore::_txc_state_proc(BlueStore::TransContext*)+0x25b) [0x55b9b6d9c2fb]
6: (KernelDevice::_aio_thread()+0x912) [0x55b9b6ebf572]
7: (KernelDevice::AioCompletionThread::entry()+0xd) [0x55b9b6ec37bd]
8: (Thread::entry_wrapper()+0x75) [0x55b9b718b705]
9: (()+0x76fa) [0x7f2da6cc96fa]
10: (clone()+0x6d) [0x7f2da4b29b5d]
NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.

GDB Trace :
--------------
Thread 15 "bstore_aio" received signal SIGSEGV, Segmentation fault.
[Switching to Thread 0x7fffeae40700 (LWP 634170)]
boost::intrusive::bstree_algorithms_base<boost::intrusive::rbtree_node_traits<void*, false> >::next_node (node=<synthetic pointer>)
    at /usr/include/boost/intrusive/detail/bstree_algorithms_base.hpp:54
54               while(n == NodeTraits::get_right(p)){
(gdb) bt
#0  boost::intrusive::bstree_algorithms_base<boost::intrusive::rbtree_node_traits<void*, false> >::next_node (node=<synthetic pointer>)
    at /usr/include/boost/intrusive/detail/bstree_algorithms_base.hpp:54
#1  boost::intrusive::tree_iterator<boost::intrusive::bhtraits<BlueStore::Blob, boost::intrusive::rbtree_node_traits<void*, false>, (boost::intrusive::link_mode_type)1, boost::intrusive::dft_tag, 3u>, false>::operator++ (this=<synthetic pointer>) at /usr/include/boost/intrusive/detail/tree_iterator.hpp:87
#2  BlueStore::_txc_state_proc (this=this@entry=0x7ffff354fc00, txc=0x7fff8750f000) at os/bluestore/BlueStore.cc:4437
#3  0x0000555555c1ebbf in BlueStore::_txc_finish_io (this=this@entry=0x7ffff354fc00, txc=<optimized out>) at os/bluestore/BlueStore.cc:4538
#4  0x0000555555c1e336 in BlueStore::_txc_state_proc (this=0x7ffff354fc00, txc=0x7fff8750f000) at os/bluestore/BlueStore.cc:4428
#5  0x0000555555d4c872 in KernelDevice::_aio_thread (this=0x7ffff34fc800) at os/bluestore/KernelDevice.cc:270
#6  0x0000555555d50abd in KernelDevice::AioCompletionThread::entry (this=<optimized out>) at os/bluestore/KernelDevice.h:49
#7  0x000055555601d495 in Thread::entry_wrapper (this=0x7ffff34fc9f0) at common/Thread.cc:89
#8  0x00007ffff6aa86fa in start_thread (arg=0x7fffeae40700) at pthread_create.c:333
#9  0x00007ffff4908b5d in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:109
(gdb) f 2
#2  BlueStore::_txc_state_proc (this=this@entry=0x7ffff354fc00, txc=0x7fff8750f000) at os/bluestore/BlueStore.cc:4437
4437            for (auto& p : o->blob_map.blob_map) {


Steps to reproduce :

1. Create a new rbd image.

2. Run 4K seq write (with multiple numjob it will reproduce faster).

Thanks & Regards
Somnath
PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
