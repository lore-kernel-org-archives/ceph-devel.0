From: Brad Hubbard <bhubbard@redhat.com>
Subject: Re: Linking error with rocksdb
Date: Wed, 21 Sep 2016 19:11:19 +1000
Message-ID: <CAF-wwdG=RCdgXZmh1qnoxthFpairjD-i1rg2_Q26Or8oLNuzVQ@mail.gmail.com>
References: <17b328e5-93d0-2004-f928-3331a645fc1f@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f44.google.com ([209.85.215.44]:33453 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751167AbcIUJLW (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Sep 2016 05:11:22 -0400
Received: by mail-lf0-f44.google.com with SMTP id b71so8370645lfg.0
        for <ceph-devel@vger.kernel.org>; Wed, 21 Sep 2016 02:11:20 -0700 (PDT)
In-Reply-To: <17b328e5-93d0-2004-f928-3331a645fc1f@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: kefu chai <tchaikov@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Sep 21, 2016 at 6:51 PM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> Hi,
>
> I think I had something like this before, but cannot find it in my Email
> archive...
>
> I'm trying to build head, which works for a long way, but it gets into
> trouble when linking ceph-mon. Errors out on not being able to find some
> of the references in librocksdb...
>
> librocksdb.a is recent:
>> ll src/rocksdb/librocksdb.a

rocksdb can be problematic, try this...

$ git submodule update --force --init --recursive
$ git submodule foreach --recursive git clean -fdx

and try building again.


-- 
HTH,
Brad

> 80012 -rw-rw-r--  1 wjw  tegenbosch  305720086 Sep 21 10:40
> src/rocksdb/librocksdb.a
> And it seems defined:
>> nm -e src/rocksdb/librocksdb.a | grep NewLRU
>                  U _ZN7rocksdb11NewLRUCacheEmibd
>                  U _ZN7rocksdb11NewLRUCacheEmibd
>                  U _ZN7rocksdb11NewLRUCacheEmibd
>                  U _ZN7rocksdb11NewLRUCacheEmibd
>                  U _ZN7rocksdb11NewLRUCacheEmibd
> 0000000000001fd0 T _ZN7rocksdb11NewLRUCacheEmibd
>                  U _ZN7rocksdb11NewLRUCacheEmibd
>                  U _ZN7rocksdb11NewLRUCacheEmibd
>                  U _ZN7rocksdb11NewLRUCacheEmibd
>                  U _ZN7rocksdb11NewLRUCacheEmibd
>                  U _ZN7rocksdb11NewLRUCacheEmibd
>                  U _ZN7rocksdb11NewLRUCacheEmibd
>
>
> Strange thing that this is a routine that is only added recently. Which
> suggests that it tries to bind against an older librocksdb ..??
> Then I checkout a completely fresh head in a nes directory, still the
> same error.
> So I've deleted anything in /usr/local/ that looks like a
> librocksdb-library. But still it hits error.
>
> Any suggestions where to look further.
>
> --WjW
>
> /usr/bin/CC    -Wall -Wtype-limits -Wignored-qualifiers -Winit-self
> -Wpointer-arith -Werror=format-security -fno-strict-aliasing
> -fsigned-char -Wno-inconsistent-missing-override -Wno-mismatched-tags
> -Wno-unused-function -Wno-unused-local-typedef
> -Wno-inconsistent-missing-override -Wno-unused-private-field
> -Wno-varargs -Wno-gnu-designator -Wno-mismatched-tags
> -Wno-missing-braces -Wno-parentheses -Wno-deprecated-register
> -ftemplate-depth-1024 -Wno-invalid-offsetof -Wnon-virtual-dtor
> -fdiagnostics-color=auto -I/usr/local/include/nss/nss
> -I/usr/local/include/nspr -fno-builtin-malloc -fno-builtin-calloc
> -fno-builtin-realloc -fno-builtin-free -O0  -Wl,-export-dynamic
> CMakeFiles/ceph-mon.dir/ceph_mon.cc.o
> CMakeFiles/common_texttable_obj.dir/common/TextTable.cc.o  -o
> ../bin/ceph-mon  -L/usr/local/lib ../lib/libmon.a ../lib/libcommon.a
> ../lib/libos.a ../lib/libglobal.a -lrt /usr/local/lib/libatomic_ops.a
> /usr/local/lib/libtcmalloc.so ../lib/libkv.a
> /usr/local/lib/libleveldb.so ../../src/rocksdb/librocksdb.a -lsnappy -lz
> -lbz2 /usr/local/lib/liblz4.so ../lib/libcommon.a
> ../lib/libjson_spirit.a ../lib/libcommon_utf8.a ../lib/liberasure_code.a
> /usr/local/lib/libboost_thread.so /usr/local/lib/libboost_system.so
> /usr/local/lib/libboost_regex.so /usr/local/lib/libboost_random.so
> /usr/local/lib/libboost_program_options.so
> /usr/local/lib/libboost_date_time.so
> /usr/local/lib/libboost_iostreams.so /usr/local/lib/libboost_chrono.so
> /usr/local/lib/libboost_atomic.so -lexecinfo
> /usr/local/lib/nss/libssl3.so /usr/local/lib/nss/libsmime3.so
> /usr/local/lib/nss/libnss3.so /usr/local/lib/nss/libnssutil3.so
> /usr/local/lib/libplds4.so /usr/local/lib/libplc4.so
> /usr/local/lib/libnspr4.so -lpthread -lrt
> -Wl,-rpath,/usr/local/lib:/usr/local/lib/nss:
> ../lib/libmon.a(RocksDBStore.cc.o): In function
> `RocksDBStore::do_open(std::__1::basic_ostream<char,
> std::__1::char_traits<char> >&, bool)':
> /home/wjw/Ceph/master/ceph/src/kv/RocksDBStore.cc:(.text+0x5253):
> undefined reference to `rocksdb::NewLRUCache(unsigned long, int)'
> ../lib/libmon.a(RocksDBStore.cc.o): In function
> `rocksdb::Status::InvalidArgument(rocksdb::Slice const&, rocksdb::Slice
> const&)':
> /home/wjw/Ceph/master/ceph/src/kv/RocksDBStore.cc:(.text._ZN7rocksdb6Status15InvalidArgumentERKNS_5SliceES3_[_ZN7rocksdb6Status15InvalidArgumentERKNS_5SliceES3_]+0x2f):
> undefined reference to `rocksdb::Status::Status(rocksdb::Status::Code,
> rocksdb::Slice const&, rocksdb::Slice const&)'
> ../lib/libmon.a(RocksDBStore.cc.o):(.data.rel.ro._ZTVN12RocksDBStore19MergeOperatorRouterE[_ZTVN12RocksDBStore19MergeOperatorRouterE]+0x20):
> undefined reference to
> `rocksdb::AssociativeMergeOperator::FullMerge(rocksdb::Slice const&,
> rocksdb::Slice const*, std::__1::deque<std::__1::basic_string<char,
> std::__1::char_traits<char>, std::__1::allocator<char> >,
> std::__1::allocator<std::__1::basic_string<char,
> std::__1::char_traits<char>, std::__1::allocator<char> > > > const&,
> std::__1::basic_string<char, std::__1::char_traits<char>,
> std::__1::allocator<char> >*, rocksdb::Logger*) const'
> c++: error: linker command failed with exit code 1 (use -v to see
> invocation)
> gmake[3]: *** [src/CMakeFiles/ceph-mon.dir/build.make:129: bin/ceph-mon]
> Error 1
> gmake[3]: Leaving directory '/usr/srcs/Ceph/master/ceph/build'
> gmake[2]: *** [CMakeFiles/Makefile2:569:
> src/CMakeFiles/ceph-mon.dir/all] Error 2
> gmake[2]: Leaving directory '/usr/srcs/Ceph/master/ceph/build'
> gmake[1]: *** [CMakeFiles/Makefile2:581:
> src/CMakeFiles/ceph-mon.dir/rule] Error 2
> gmake[1]: Leaving directory '/usr/srcs/Ceph/master/ceph/build'
> gmake: *** [Makefile:264: ceph-mon] Error 2
> 12.527u 6.015s 0:18.51 100.1%   2902+225k 2141+53502io 1pf+0w
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
