From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: Master build is failing
Date: Sat, 14 May 2016 17:57:21 +0000
Message-ID: <BL2PR02MB2115602A6170EDB521BFA0DEF4750@BL2PR02MB2115.namprd02.prod.outlook.com>
References: <BL2PR02MB2115B805EEA98B7D98B81913F4740@BL2PR02MB2115.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1605140809020.14730@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bl2on0068.outbound.protection.outlook.com ([65.55.169.68]:42741
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753830AbcENR5Y convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 14 May 2016 13:57:24 -0400
In-Reply-To: <alpine.DEB.2.11.1605140809020.14730@cpach.fuggernut.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Thanks Sage , it worked !

Regards
Somnath

-----Original Message-----
From: Sage Weil [mailto:sage@newdream.net]
Sent: Saturday, May 14, 2016 5:09 AM
To: Somnath Roy
Cc: ceph-devel@vger.kernel.org
Subject: Re: Master build is failing

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
PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
