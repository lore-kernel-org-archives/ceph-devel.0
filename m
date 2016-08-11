From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Re: Bluestore StoreTest.Synthetic is broken
Date: Thu, 11 Aug 2016 16:34:23 +0300
Message-ID: <97da0ab9-e9c7-0bf4-868e-702b9f391bb5@mirantis.com>
References: <cb5fdaad-fefe-f221-cbe1-00c487e19d20@mirantis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:36291 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751148AbcHKNe3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Aug 2016 09:34:29 -0400
Received: by mail-wm0-f50.google.com with SMTP id q128so795035wma.1
        for <ceph-devel@vger.kernel.org>; Thu, 11 Aug 2016 06:34:28 -0700 (PDT)
Received: from [127.0.0.1] ([91.218.144.129])
        by smtp.googlemail.com with ESMTPSA id q36sm126971lfi.26.2016.08.11.06.34.25
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Aug 2016 06:34:25 -0700 (PDT)
In-Reply-To: <cb5fdaad-fefe-f221-cbe1-00c487e19d20@mirantis.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Better output from GDB

Program received signal SIGSEGV, Segmentation fault.
append_out_escaped (in="", out=out@entry=0x7fffffffcb70) at 
/home/ifed/ceph/ceph_my4/src/common/hobject.cc:207
207        if (*i == '%' || *i == ':' || *i == '/' || *i < 32 || *i >= 
127) {
(gdb) bt
#0  append_out_escaped (in="", out=out@entry=0x7fffffffcb70) at 
/home/ifed/ceph/ceph_my4/src/common/hobject.cc:207
#1  0x00000000008cc2c9 in operator<< (out=..., o=...) at 
/home/ifed/ceph/ceph_my4/src/common/hobject.cc:258
#2  0x00000000008cc7f7 in operator<< (out=..., o=...) at 
/home/ifed/ceph/ceph_my4/src/common/hobject.cc:551
#3  0x000000000078b817 in BlueStore::collection_list 
(this=this@entry=0x92742f0, c_=..., start=..., end=..., 
sort_bitwise=sort_bitwise@entry=true,
     max=max@entry=10, ls=0x7fffffffd2a0, pnext=0x7fffffffcee0) at 
/home/ifed/ceph/ceph_my4/src/os/bluestore/BlueStore.cc:4219
#4  0x000000000079465b in BlueStore::collection_list (this=0x92742f0, 
cid=..., start=..., end=..., sort_bitwise=sort_bitwise@entry=true,
     max=max@entry=10, ls=0x7fffffffd2a0, pnext=0x0) at 
/home/ifed/ceph/ceph_my4/src/os/bluestore/BlueStore.cc:4088
#5  0x000000000069210b in SyntheticWorkloadState::shutdown 
(this=0x7fffffffd7f0) at 
/home/ifed/ceph/ceph_my4/src/test/objectstore/store_test.cc:3097
#6  0x0000000000657ac4 in doSyntheticTest (store=..., max_obj=<optimized 
out>, max_wr=<optimized out>, align=<optimized out>)
     at /home/ifed/ceph/ceph_my4/src/test/objectstore/store_test.cc:3761
#7  0x0000000000a07cb3 in 
HandleSehExceptionsInMethodIfSupported<testing::Test, void> 
(location=0xc09697 "the test body", method=<optimized out>,
     object=<optimized out>) at 
/home/ifed/ceph/ceph_my4/src/googletest/googletest/src/gtest.cc:2402
#8 testing::internal::HandleExceptionsInMethodIfSupported<testing::Test, 
void> (object=object@entry=0x9159ad0,
     method=(void (testing::Test::*)(testing::Test * const)) 0x6584e0 
<StoreTest_Synthetic_Test::TestBody()>,
     location=location@entry=0xc09697 "the test body") at 
/home/ifed/ceph/ceph_my4/src/googletest/googletest/src/gtest.cc:2438
#9  0x00000000009f74da in testing::Test::Run (this=0x9159ad0) at 
/home/ifed/ceph/ceph_my4/src/googletest/googletest/src/gtest.cc:2475

(gdb) f 2
#2  0x00000000008cc7f7 in operator<< (out=..., o=...) at 
/home/ifed/ceph/ceph_my4/src/common/hobject.cc:551
551      out << '#' << o.hobj << '#';
(gdb) p o.hobject
(gdb) p o
$8 = (const ghobject_t &) @0x7fffffffcee0: {hobj = {oid = {name = ""}, 
snap = {val = 18446744073709551614}, hash = 192, max = false,
     nibblewise_key_cache = 201326592, hash_reverse_bits = 50331648, 
static POOL_META = -1, static POOL_TEMP_START = -2, pool = 555, nspace = 
"",
     key = ""}, generation = 1, shard_id = {id = -1 '\377', static 
NO_SHARD = {id = -1 '\377',
       static NO_SHARD = <same as static member of an already seen 
type>}}, max = false, static NO_GEN = 18446744073709551615}
(gdb) p o.hobj
$9 = {oid = {name = ""}, snap = {val = 18446744073709551614}, hash = 
192, max = false, nibblewise_key_cache = 201326592,
   hash_reverse_bits = 50331648, static POOL_META = -1, static 
POOL_TEMP_START = -2, pool = 555, nspace = "", key = ""}
(gdb) p o.hobj.oid.name
$10 = ""
(gdb) p o.hobj.oid.name.size()
$11 = 140737309080040

logging immediately after the  assignement *pnext =  oid shows no 
corruption though...


On 11.08.2016 16:25, Igor Fedotov wrote:
> Hi All!
>
> I'm observing following crash when running Bluestore 
> StoreTest.Synthetic test casr( ceph_test_objectstore 
> --gtest_filter=ObjectStore/StoreTest.Synthetic/2 ):
>
>
>   -20> 2016-08-11 16:09:30.155436 7f6c1437b680 15 
> bluestore(store_test_temp_dir) collection_list 555.0_head start GHMIN 
> end GHMAX max 10
>    -19> 2016-08-11 16:09:30.155443 7f6c1437b680 20 
> bluestore(store_test_temp_dir) collection_list range 
> '--'0x7ffffffffffffdd300000000'.' to '--'0x7ff
> ffffffffffdd3ffffffff':' and '--'0x800000000000022b00000000'.' to 
> '--'0x800000000000022bffffffff':' start GHMIN
>    -18> 2016-08-11 16:09:30.155482 7f6c1437b680 20 
> bluestore(store_test_temp_dir) collection_list pend 
> '--'0x7ffffffffffffdd3ffffffff':'
>    -17> 2016-08-11 16:09:30.155509 7f6c1437b680 20 
> bluestore(store_test_temp_dir) collection_list key 
> '--'0x800000000000022b00000000'.!=OBJ_1049aaaaaa
> aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa 
>
> aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa!'0xff 
>
> fffffffffffffe0000000000000000 > GHMAX
>    -16> 2016-08-11 16:09:30.155515 7f6c1437b680 30 
> bluestore(store_test_temp_dir) collection_list switch to non-temp 
> namespace
>    -15> 2016-08-11 16:09:30.155521 7f6c1437b680 30 
> bluestore(store_test_temp_dir) collection_list pend 
> '--'0x800000000000022bffffffff':'
>    -14> 2016-08-11 16:09:30.155524 7f6c1437b680 20 
> bluestore(store_test_temp_dir) collection_list key 
> '--'0x800000000000022b00000000'.!=OBJ_1049aaaaaa
> aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa 
>
> aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa!'0xff 
>
> fffffffffffffe0000000000000000
>    -13> 2016-08-11 16:09:30.155536 7f6c1437b680 20 
> bluestore(store_test_temp_dir) collection_list key 
> '--'0x800000000000022b00000000'.!=OBJ_1105aaaaaa
> aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa 
>
> aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa!'0x00 
>
> 0000005df155b0ffffffffffffffff
>    -12> 2016-08-11 16:09:30.155544 7f6c1437b680 20 
> bluestore(store_test_temp_dir) collection_list key 
> '--'0x800000000000022b00000000'.!=OBJ_255aaaaaaa
> aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa 
>
> aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa!'0x000 
>
> 000007e448de90000000000000000
>    -11> 2016-08-11 16:09:30.155555 7f6c1437b680 20 
> bluestore(store_test_temp_dir) collection_list key 
> '--'0x800000000000022b00000000'.!=OBJ_511aaaaaaa
> aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa 
>
> aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa!'0xfff 
>
> ffffffffffffe0000000000000001
>    -10> 2016-08-11 16:09:30.155563 7f6c1437b680 20 
> bluestore(store_test_temp_dir) collection_list key 
> '--'0x800000000000022b00000000'.!=OBJ_767aaaaaaa
> aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa 
>
> aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa!'0x000 
>
> 000005cab38c60000000000000001
>     -9> 2016-08-11 16:09:30.155574 7f6c1437b680 20 
> bluestore(store_test_temp_dir) collection_list key 
> '--'0x800000000000022b01000000'.!=OBJ_127aaaaaaa
> aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa 
>
> aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa!'0x000 
>
> 0000026f324ba0000000000000000
>     -8> 2016-08-11 16:09:30.155584 7f6c1437b680 20 
> bluestore(store_test_temp_dir) collection_list key 
> '--'0x800000000000022b01000000'.!=OBJ_639aaaaaaa
> aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa 
>
> aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa!'0x000 
>
> 000007365f1ee0000000000000001
>     -7> 2016-08-11 16:09:30.155592 7f6c1437b680 20 
> bluestore(store_test_temp_dir) collection_list key 
> '--'0x800000000000022b02000000'.!=OBJ_575aaaaaaa
> aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa 
>
> aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa!'0x000 
>
> 00000060a14630000000000000000
>     -6> 2016-08-11 16:09:30.155601 7f6c1437b680 20 
> bluestore(store_test_temp_dir) collection_list key 
> '--'0x800000000000022b02000000'.!=OBJ_831aaaaaaa
> aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa 
>
> aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa!'0xfff 
>
> ffffffffffffe0000000000000000
>     -5> 2016-08-11 16:09:30.155612 7f6c1437b680 20 
> bluestore(store_test_temp_dir) collection_list key 
> '--'0x800000000000022b03000000 (bnode, skipping)
>     -4> 2016-08-11 16:09:30.155617 7f6c1437b680 20 
> bluestore(store_test_temp_dir) collection_list key 
> '--'0x800000000000022b03000000'.!=OBJ_1013aaaaaa
> aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa 
>
> aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa!'0xff 
>
> fffffffffffffe0000000000000002
>     -3> 2016-08-11 16:09:30.155626 7f6c1437b680 20 
> bluestore(store_test_temp_dir) collection_list key 
> '--'0x800000000000022b03000000'.!=OBJ_1243aaaaaa
> aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa 
>
> aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa!'0x00 
>
> 0000000c94deb00000000000000000
>     -2> 2016-08-11 16:09:30.155631 7f6c1437b680 20 
> bluestore(store_test_temp_dir) collection_list reached max 10
>     -1> 2016-08-11 16:09:30.155636 7f6c1437b680 20 
> bluestore.2QCache(0xa282410) trim onodes 500 / 500 buffers 1978368 / 
> 2000000
>      0> 2016-08-11 16:09:56.642872 7f6c1437b680 -1 *** Caught signal 
> (Segmentation fault) **
>  in thread 7f6c1437b680 thread_name:ceph_test_objec
>
>  ceph version v11.0.0-1434-gc6e561a 
> (c6e561a5385105dfbd70f642bcd5732fac0bca89)
>  1: bin/ceph_test_objectstore() [0xa1f207]
>  2: (()+0xfc90) [0x7f6c13f7bc90]
>  3: bin/ceph_test_objectstore() [0x8cadab]
>  4: (operator<<(std::ostream&, hobject_t const&)+0x229) [0x8d1709]
>  5: (operator<<(std::ostream&, ghobject_t const&)+0x107) [0x8d1c37]
>  6: 
> (BlueStore::collection_list(boost::intrusive_ptr<ObjectStore::CollectionImpl>&, 
> ghobject_t, ghobject_t, bool, int, std::vector<ghobject_t, std::al
> locator<ghobject_t> >*, ghobject_t*)+0xb6d) [0x78680d]
>  7: (BlueStore::collection_list(coll_t const&, ghobject_t, ghobject_t, 
> bool, int, std::vector<ghobject_t, std::allocator<ghobject_t> >*, 
> ghobject_t*)+
> 0x1eb) [0x79d64b]
>  8: (SyntheticWorkloadState::shutdown()+0x2ab) [0x68b88b]
>  9: (doSyntheticTest(boost::scoped_ptr<ObjectStore>&, unsigned long, 
> unsigned long, unsigned long)+0x471) [0x651741]
>
>
> It looks like it was introduced by the recent PR #10410 merge 
> (https://github.com/ceph/ceph/pull/10410). I don't observe the issue 
> prior to this patch.
>
> Brief analysis under GDB shows that ghobject_t instance pointed by 
> pnext passed to operator<< at Bluestore.cc:4167 is broken - oid.name 
> field has huge size..
>
> The issue is 100% reproducible.
>
>
> Thanks,
>
> Igor
>
>
>

