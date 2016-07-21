From: Mark Nelson <mnelson@redhat.com>
Subject: Re: Bluestore Bitmap allocator crash
Date: Wed, 20 Jul 2016 22:53:38 -0500
Message-ID: <a81bf0ea-84f7-d1c7-116b-bd04f12dfa1c@redhat.com>
References: <BL2PR02MB211503A698A90F23CC6BF383F4090@BL2PR02MB2115.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36417 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751964AbcGUDxm (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 20 Jul 2016 23:53:42 -0400
In-Reply-To: <BL2PR02MB211503A698A90F23CC6BF383F4090@BL2PR02MB2115.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>, Ramesh Chander <Ramesh.Chander@sandisk.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Somnath & Ramesh,

Speaking of allocator failures, dmick noticed tonight that we are 
failing make check specifically in unittest_bit_alloc.  We both did 
bisects and came to the same conclusion that it first appeared with the 
merge this morning of:

https://github.com/ceph/ceph/pull/10257

Ultimately the assert we are failing is here:

https://github.com/ceph/ceph/blob/c98ced1d5ae3d3709d0cd38c5b075b1b2c458a74/src/os/bluestore/BitAllocator.cc#L1518

I've been digging in tonight with gdb.  Here's the relevant parts of the bt:

#2  0x00007ffff3712566 in __assert_fail_base (fmt=0x7ffff3862288 
"%s%s%s:%u: %s%sAssertion `%s' failed.\n%n", 
assertion=assertion@entry=0x60ffe0 "start_block + num_blocks <= size()",
     file=file@entry=0x60fea8 
"/home/ubuntu/src/markhpc/ceph/src/os/bluestore/BitAllocator.cc", 
line=line@entry=1518,
     function=function@entry=0x610300 
<BitAllocator::set_blocks_used(long, long)::__PRETTY_FUNCTION__> 
"virtual void BitAllocator::set_blocks_used(int64_t, int64_t)") at 
assert.c:92
#3  0x00007ffff3712612 in __GI___assert_fail (assertion=0x60ffe0 
"start_block + num_blocks <= size()", file=0x60fea8 
"/home/ubuntu/src/markhpc/ceph/src/os/bluestore/BitAllocator.cc", 
line=1518,
     function=0x610300 <BitAllocator::set_blocks_used(long, 
long)::__PRETTY_FUNCTION__> "virtual void 
BitAllocator::set_blocks_used(int64_t, int64_t)") at assert.c:101
#4  0x000000000051d328 in BitAllocator::set_blocks_used (this=0x8b0e8a0, 
start_block=1035, num_blocks=501) at 
/home/ubuntu/src/markhpc/ceph/src/os/bluestore/BitAllocator.cc:1518
#5  0x000000000051d0a1 in BitAllocator::BitAllocator (this=0x8b0e8a0, 
total_blocks=1035, zone_size_block=512, mode=CONCURRENT) at 
/home/ubuntu/src/markhpc/ceph/src/os/bluestore/BitAllocator.cc:1223
#6  0x00000000004edbcd in BitAllocator_test_bmap_alloc_Test::TestBody 
(this=<optimized out>) at 
/home/ubuntu/src/markhpc/ceph/src/test/objectstore/BitAllocator_test.cc:448

We can see that in frame 5 the total_blocks is 1035 and zone_size_block 
is 512:

#5  0x000000000051d0a1 in BitAllocator::BitAllocator (this=0x8b0e8a0, 
total_blocks=1035, zone_size_block=512, mode=CONCURRENT) at 
/home/ubuntu/src/markhpc/ceph/src/os/bluestore/BitAllocator.cc:1223
1223	  init_check(total_blocks, zone_size_block, mode, false, false);

While in frame 4 the start_block is 1035 and the num_blocks is 501, and 
size() is 1035, which is why the assert is failing.

(gdb) frame 4
#4  0x000000000051d328 in BitAllocator::set_blocks_used (this=0x8b0e8a0, 
start_block=1035, num_blocks=501) at 
/home/ubuntu/src/markhpc/ceph/src/os/bluestore/BitAllocator.cc:1518
1518	  debug_assert(start_block + num_blocks <= size());
(gdb) print size()
$19 = 1035

Ultimately the code in BitAllocator::init_check seems like it might be 
relevant.  I haven't dug in enough to understand what's going on in 
there, but it seems like we must be hitting a corner case given that the 
start_block is the same as size().

Mark

On 07/20/2016 08:44 PM, Somnath Roy wrote:
> Ramesh,
> I am hitting the following crash during IO path the moment I started io.
>
> os/bluestore/BitMapAllocator.cc: 76: FAILED assert(!(off % m_block_size))
>
>  ceph version 11.0.0-696-ga3438ba (a3438bac71a54cb43e5feb93ad09228bf69942ae)
>  1: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*)+0x80) [0x55804242de40]
>  2: (BitMapAllocator::insert_free(unsigned long, unsigned long)+0x2e3) [0x558042132813]
>  3: (BitMapAllocator::commit_finish()+0x2a5) [0x558042132e55]
>  4: (BlueStore::_kv_sync_thread()+0x142d) [0x558041fff61d]
>  5: (BlueStore::KVSyncThread::entry()+0xd) [0x558042028c2d]
>  6: (Thread::entry_wrapper()+0x75) [0x55804240d755]
>  7: (()+0x76fa) [0x7f36699076fa]
>  8: (clone()+0x6d) [0x7f3667767b5d]
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.
>
>
> What I did :
> ------------
>
> 1. I have a separate wal partition to a nvram device
>
> 2. change min_alloc_size to 16K
>
> 3. ran 4k rw.
>
> Let me know if you need further details.
>
> Thanks & Regards
> Somnath
>
>
>
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
