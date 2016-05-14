From: Sage Weil <sage@newdream.net>
Subject: Re: Master build is failing
Date: Sat, 14 May 2016 08:09:26 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1605140809020.14730@cpach.fuggernut.com>
References: <BL2PR02MB2115B805EEA98B7D98B81913F4740@BL2PR02MB2115.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45269 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751848AbcENMJR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 14 May 2016 08:09:17 -0400
In-Reply-To: <BL2PR02MB2115B805EEA98B7D98B81913F4740@BL2PR02MB2115.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, 13 May 2016, Somnath Roy wrote:
> Hi,
> The current master is failing with the following error.
> 
> libkv.a(libkv_a-RocksDBStore.o): In function `RocksDBStore::_test_init(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const&)':
> /root/ceph-master/src/kv/RocksDBStore.cc:323: undefined reference to `rocksdb::DB::Open(rocksdb::Options const&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const&, rocksdb::DB**)'
> libkv.a(libkv_a-RocksDBStore.o): In function `RocksDBStore::check_omap_dir(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >&)':
> /root/ceph-master/src/kv/RocksDBStore.cc:625: undefined reference to `rocksdb::DB::Open(rocksdb::Options const&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const&, rocksdb::DB**)'
> libkv.a(libkv_a-RocksDBStore.o): In function `RocksDBStore::ParseOptionsFromString(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >, rocksdb::Options&)':
> /root/ceph-master/src/kv/RocksDBStore.cc:188: undefined reference to `rocksdb::GetOptionsFromString(rocksdb::Options const&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const&, rocksdb::Options*)'
> /root/ceph-master/src/kv/RocksDBStore.cc:193: undefined reference to `rocksdb::Status::ToString[abi:cxx11]() const'
> libkv.a(libkv_a-RocksDBStore.o): In function `RocksDBStore::do_open(std::ostream&, bool)':
> /root/ceph-master/src/kv/RocksDBStore.cc:291: undefined reference to `rocksdb::DB::Open(rocksdb::Options const&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const&, rocksdb::DB**)'
> /root/ceph-master/src/kv/RocksDBStore.cc:293: undefined reference to `rocksdb::Status::ToString[abi:cxx11]() const'
> libkv.a(libkv_a-RocksDBStore.o):(.data.rel.ro._ZTVN12RocksDBStore19MergeOperatorRouterE[_ZTVN12RocksDBStore19MergeOperatorRouterE]+0x20): undefined reference to `rocksdb::AssociativeMergeOperator::FullMerge(rocksdb::Slice const&, rocksdb::Slice const*, std::deque<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >, std::allocator<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > > > const&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >*, rocksdb::Logger*) const'
> libkv.a(libkv_a-RocksDBStore.o):(.data.rel.ro._ZTVN12RocksDBStore19MergeOperatorRouterE[_ZTVN12RocksDBStore19MergeOperatorRouterE]+0x28): undefined reference to `rocksdb::AssociativeMergeOperator::PartialMerge(rocksdb::Slice const&, rocksdb::Slice const&, rocksdb::Slice const&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >*, rocksdb::Logger*) const'
> libkv.a(libkv_a-RocksDBStore.o):(.data.rel.ro._ZTVN12RocksDBStore19MergeOperatorRouterE[_ZTVN12RocksDBStore19MergeOperatorRouterE]+0x30): undefined reference to `rocksdb::MergeOperator::PartialMergeMulti(rocksdb::Slice const&, std::deque<rocksdb::Slice, std::allocator<rocksdb::Slice> > const&, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >*, rocksdb::Logger*) const'
> collect2: error: ld returned 1 exit status
> Makefile:16425: recipe for target 'ceph_test_object_map' failed
> make[3]: *** [ceph_test_object_map] Error 1
> libos.a(libos_a-BlueRocksEnv.o):(.data.rel.ro._ZTV12BlueRocksEnv[_ZTV12BlueRocksEnv]+0x130): undefined reference to `rocksdb::Env::GenerateUniqueId[abi:cxx11]()'

My guess is that

 cd rocksdb ; make clean ; cd .. ; make

will clear it up.

sage
