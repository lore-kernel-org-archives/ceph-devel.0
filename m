From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: Master build is failing
Date: Fri, 13 May 2016 23:31:21 +0000
Message-ID: <BL2PR02MB2115B805EEA98B7D98B81913F4740@BL2PR02MB2115.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-by2on0062.outbound.protection.outlook.com ([207.46.100.62]:30992
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753601AbcEMXbZ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 13 May 2016 19:31:25 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,
The current master is failing with the following error.

libkv.a(libkv_a-RocksDBStore.o): In function `RocksDBStore::_test_init(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const&)':
/root/ceph-master/src/kv/RocksDBStore.cc:323: undefined reference to `rocksdb::DB::Open(rocksdb::Options const&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const&, rocksdb::DB**)'
libkv.a(libkv_a-RocksDBStore.o): In function `RocksDBStore::check_omap_dir(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&)':
/root/ceph-master/src/kv/RocksDBStore.cc:625: undefined reference to `rocksdb::DB::Open(rocksdb::Options const&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const&, rocksdb::DB**)'
libkv.a(libkv_a-RocksDBStore.o): In function `RocksDBStore::ParseOptionsFromString(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >, rocksdb::Options&)':
/root/ceph-master/src/kv/RocksDBStore.cc:188: undefined reference to `rocksdb::GetOptionsFromString(rocksdb::Options const&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const&, rocksdb::Options*)'
/root/ceph-master/src/kv/RocksDBStore.cc:193: undefined reference to `rocksdb::Status::ToString[abi:cxx11]() const'
libkv.a(libkv_a-RocksDBStore.o): In function `RocksDBStore::do_open(std::ostream&, bool)':
/root/ceph-master/src/kv/RocksDBStore.cc:291: undefined reference to `rocksdb::DB::Open(rocksdb::Options const&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const&, rocksdb::DB**)'
/root/ceph-master/src/kv/RocksDBStore.cc:293: undefined reference to `rocksdb::Status::ToString[abi:cxx11]() const'
libkv.a(libkv_a-RocksDBStore.o):(.data.rel.ro._ZTVN12RocksDBStore19MergeOperatorRouterE[_ZTVN12RocksDBStore19MergeOperatorRouterE]+0x20): undefined reference to `rocksdb::AssociativeMergeOperator::FullMerge(rocksdb::Slice const&, rocksdb::Slice const*, std::deque<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >, std::allocator<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > > > const&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >*, rocksdb::Logger*) const'
libkv.a(libkv_a-RocksDBStore.o):(.data.rel.ro._ZTVN12RocksDBStore19MergeOperatorRouterE[_ZTVN12RocksDBStore19MergeOperatorRouterE]+0x28): undefined reference to `rocksdb::AssociativeMergeOperator::PartialMerge(rocksdb::Slice const&, rocksdb::Slice const&, rocksdb::Slice const&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >*, rocksdb::Logger*) const'
libkv.a(libkv_a-RocksDBStore.o):(.data.rel.ro._ZTVN12RocksDBStore19MergeOperatorRouterE[_ZTVN12RocksDBStore19MergeOperatorRouterE]+0x30): undefined reference to `rocksdb::MergeOperator::PartialMergeMulti(rocksdb::Slice const&, std::deque<rocksdb::Slice, std::allocator<rocksdb::Slice> > const&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >*, rocksdb::Logger*) const'
collect2: error: ld returned 1 exit status
Makefile:16425: recipe for target 'ceph_test_object_map' failed
make[3]: *** [ceph_test_object_map] Error 1
libos.a(libos_a-BlueRocksEnv.o):(.data.rel.ro._ZTV12BlueRocksEnv[_ZTV12BlueRocksEnv]+0x130): undefined reference to `rocksdb::Env::GenerateUniqueId[abi:cxx11]()'

Thanks & Regards
Somnath
PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
