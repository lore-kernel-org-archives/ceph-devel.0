From: Robert LeBlanc <robert@leblancnet.us>
Subject: Need help compiling 0.94.1 with jemalloc
Date: Mon, 18 May 2015 22:23:55 -0600
Message-ID: <CAANLjFq1xNGms4q811oJp7TtzLjqWRQO9t-gcNdkvr5vWHP5GQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:36606 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750722AbbESEX5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 May 2015 00:23:57 -0400
Received: by wizk4 with SMTP id k4so101843401wiz.1
        for <ceph-devel@vger.kernel.org>; Mon, 18 May 2015 21:23:55 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

I'm trying to build Ceph 0.94.1 with jemalloc and without tcmalloc.
I've downloaded rocksdb from their master branch (to get the jemalloc
option) and built rocksdb with the shared libraries. When I try and
build Ceph, it fails on:

os/RocksDBStore.cc: In member function 'int
RocksDBStore::do_open(std::ostream&, bool)':
os/RocksDBStore.cc:65:15: error: 'struct rocksdb::Options' has no
member named 'block_cache'
     ldoptions.block_cache = rocksdb::NewLRUCache(options.cache_size);
               ^
os/RocksDBStore.cc:68:15: error: 'struct rocksdb::Options' has no
member named 'block_size'
     ldoptions.block_size = options.block_size;
               ^
os/RocksDBStore.cc:72:15: error: 'struct rocksdb::Options' has no
member named 'filter_policy'
     ldoptions.filter_policy = _filterpolicy;
               ^
os/RocksDBStore.cc:86:15: error: 'struct rocksdb::Options' has no
member named 'block_restart_interval'
     ldoptions.block_restart_interval = options.block_restart_interval;
               ^

I can see in the config.log that it is finding the shared rockdb
libraries ok. I've configured with:

./configure $(for i in /usr/{lib64,lib}/jvm/java/include{,/linux}; do
[ -d $i ] && java_inc="$java_inc -I$i"; done) --prefix=/usr
--localstatedir=/var --sysconfdir=/etc --docdir=/usr/share/doc/ceph
--with-nss --without-cryptopp --with-rest-bench --with-debug
--enable-cephfs-java --with-librocksdb-static=no --with-radosgw
--with-jemalloc --without-tcmalloc --with-librocksdb

There is one warning in the config.log, but it seems to happily move
right along.

configure:21346: checking for LIBROCKSDB
configure:21353: $PKG_CONFIG --exists --print-errors "rocksdb"
Package rocksdb was not found in the pkg-config search path.
Perhaps you should add the directory containing `rocksdb.pc'
to the PKG_CONFIG_PATH environment variable
No package 'rocksdb' found
configure:21356: $? = 1
configure:21370: $PKG_CONFIG --exists --print-errors "rocksdb"
Package rocksdb was not found in the pkg-config search path.
Perhaps you should add the directory containing `rocksdb.pc'
to the PKG_CONFIG_PATH environment variable
No package 'rocksdb' found
configure:21373: $? = 1
configure:21387: result: no
No package 'rocksdb' found
configure:21417: checking for open in -lrocksdb
configure:21442: gcc -o conftest -g -O2   conftest.c -lrocksdb   >&5
configure:21442: $? = 0
configure:21451: result: yes
configure:21678: checking for io_submit in -laio
configure:21703: gcc -o conftest -g -O2   conftest.c -laio  -lrocksdb  >&5
configure:21703: $? = 0
configure:21712: result: yes

I don't have a rocksdb.pc from my build of it, so I'm not sure what
exactly it is talking about.

I've had some very interesting results from preloading different
memory allocators and I'd like to try a complete jemalloc install then
share my results. So any push in the right direction would be much
appreciated.

Thank you,

- ----------------
Robert LeBlanc
GPG Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
-----BEGIN PGP SIGNATURE-----
Version: Mailvelope v0.13.1
Comment: https://www.mailvelope.com

wsFcBAEBCAAQBQJVWrrJCRDmVDuy+mK58QAAB/wQALwcHp7ylok1aWTB1BxB
4lPXb6SJFd/NMPq3VIcz9/2u8l1uSzerNDT9LmZ0tlmAU7nUmZ5FyhB6jM1T
RsYro3kyuBgdMgimNnAYjqgvNs/t1s6DBhiG/pZuXPbSGyILNemgQf5IIXNH
CFgZL8bJzo/ZZlYD9tAt+Xn92WX/R6ZwIa2k0rqvhxDzRXqao5jDURDQUc93
KItckuhdVTg1ElzB/1Yuhu8AT0dUPiL0elijlh6ktvgc4N5+sI9Gjsj6VU4m
EpHz/w7Vgt75SIpetF5p7gb1fzaOqfc3VFmiJuPLM908/lhLMp7qNczPM3op
usjKbN3tQcH5l38kYBBEmhj+Duqn99efOrC91MsdHsCMLzuUp1TbhaIUSZ2g
Urel1wfp6vA0AFORA6QrPEecfG1Q7Mldt5l4TVl9nNMq7FvzrYJBDIbFerLI
bh/Y9m5fTqrtTmNb1GuDLBHNsBMl/0wuT1ZYrb/zKzhMBdwz4BINdBZYkeCJ
MmrSuoXh1R9BMTV4aeyBdqsmsb1LMRsnzbsk0MW5Tb2AFMRrm/MvFZo/0D2Q
Lzm+xp3jeKjj/NO5yMZWhnQHdRjKiVl5lraRo83CjD1OQVip17hwbv4oM1Bv
FT2QQPXFVQJvmnyf6rZIsox9JjI8StBJ3jcd9GrewMVuZuaPBcOnqqKAYsYt
i902
=EXv4
-----END PGP SIGNATURE-----
