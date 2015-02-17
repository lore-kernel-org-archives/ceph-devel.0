From: Sage Weil <sage@newdream.net>
Subject: Re: Having issues trying to get the OSD up on a MIPS64!!!
Date: Tue, 17 Feb 2015 06:06:45 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1502170603410.22050@cobra.newdream.net>
References: <loom.20141023T030922-990@post.gmane.org> <alpine.DEB.2.00.1410231749420.13498@cobra.newdream.net> <BC9BE980F12C4446A1CB0380E1C97DCD3390D99A@EXMAIL1.taec.toshiba.com> <alpine.DEB.2.00.1410241743490.13498@cobra.newdream.net>
 <71E1B92E73606A4ABC3D0EC55B2BF09834221AED@EXMAIL1.taec.toshiba.com> <alpine.DEB.2.00.1410241810300.13498@cobra.newdream.net> <BC9BE980F12C4446A1CB0380E1C97DCD3390DAEC@EXMAIL1.taec.toshiba.com> <loom.20150217T085627-77@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43166 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756663AbbBQOGq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 Feb 2015 09:06:46 -0500
In-Reply-To: <loom.20150217T085627-77@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Bao Vu <vu_bao@sbcglobal.net>
Cc: ceph-devel@vger.kernel.org

> When I run the link command manually, with additional "-ldl". I hit 
> different errors:
> 
> /bin/sh ../libtool  --tag=CXX   --mode=link /usr/local/buildroot-2015.02-
> rc1/output/host/usr/bin/mips64-linux-g++ -I/usr/local/buildroot-2015.02-
> rc1/output/host/usr/mips64-buildroot-linux-gnu/sysroot/usr/include/nss 
> -I/usr/local/buildroot-2015.02-rc1/output/host/usr/mips64-buildroot-linux-
> gnu/sysroot/usr/include/nspr    -Wall -Wtype-limits -Wignored-qualifiers 
> -Winit-self -Wpointer-arith -Werror=format-security -fno-strict-aliasing 
> -fsigned-char -rdynamic -ftemplate-depth-1024 -Wnon-virtual-dtor -Wno-
> invalid-offsetof    -Wstrict-null-sentinel -mxgot -mlong-calls 
> -I/usr/local/buildroot-2015.02-rc1/output/host/usr/include 
> -I/usr/local/mips64/include  -latomic_ops -L/usr/local/mips64/lib 
> -L/usr/local/buildroot-2015.02-rc1/output/host/usr/lib 
> -L/usr/local/buildroot-2015.02-rc1/output/host/usr/lib64 -o 
> ceph_objectstore_tool tools/ceph_objectstore_tool.o libosd.la libosdc.la 
> libos.la -laio   -lleveldb -lsnappy libperfglue.la  libos.la -laio   
> -lleveldb -lsnappy libglobal.la libcommon.la -lpthread -lm -lnss3 
> -lnssutil3 -lsmime3 -lssl3 -L/usr/local/buildroot-2015.02-
> rc1/output/host/usr/mips64-buildroot-linux-gnu/sysroot/usr/lib -lplds4 
> -lplc4 -lnspr4   -luuid -lm     -lboost_program_options  librados.la  
> -lboost_system -ldl 
> libtool: warning: library '/usr/local/buildroot-2015.02-
> rc1/output/host/usr/mips64-buildroot-linux-
> gnu/sysroot/usr/lib/../lib64/libsnappy.la' was moved.
> libtool: warning: library '/usr/local/buildroot-2015.02-
> rc1/output/host/usr/mips64-buildroot-linux-
> gnu/sysroot/usr/lib/libsnappy.la' was moved.
> libtool: warning: library '/usr/local/buildroot-2015.02-
> rc1/output/host/usr/mips64-buildroot-linux-
> gnu/sysroot/usr/lib/libatomic_ops.la' was moved.
> libtool: warning: library '/usr/local/buildroot-2015.02-
> rc1/output/host/usr/mips64-buildroot-linux-
> gnu/sysroot/usr/lib/../lib64/libatomic_ops.la' was moved.
> libtool: warning: library '/usr/local/buildroot-2015.02-
> rc1/output/host/usr/lib/gcc/mips64-buildroot-linux-
> gnu/4.9.2/../../../../mips64-buildroot-linux-gnu/lib/../lib64/libstdc++.la' 
> was moved.
> libtool: warning: library '/usr/local/mips64/lib/libuuid.la' was moved.
> libtool: warning: library '/usr/local/buildroot-2015.02-
> rc1/output/host/usr/mips64-buildroot-linux-
> gnu/sysroot/usr/lib/../lib64/libsnappy.la' was moved.
> libtool: warning: library '/usr/local/buildroot-2015.02-
> rc1/output/host/usr/mips64-buildroot-linux-
> gnu/sysroot/usr/lib/libsnappy.la' was moved.
> libtool: warning: library '/usr/local/buildroot-2015.02-
> rc1/output/host/usr/mips64-buildroot-linux-
> gnu/sysroot/usr/lib/libatomic_ops.la' was moved.
> libtool: warning: library '/usr/local/buildroot-2015.02-
> rc1/output/host/usr/mips64-buildroot-linux-
> gnu/sysroot/usr/lib/../lib64/libatomic_ops.la' was moved.
> libtool: warning: library '/usr/local/buildroot-2015.02-
> rc1/output/host/usr/lib/gcc/mips64-buildroot-linux-
> gnu/4.9.2/../../../../mips64-buildroot-linux-gnu/lib/../lib64/libstdc++.la' 
> was moved.
> libtool: warning: library '/usr/local/mips64/lib/libuuid.la' was moved.
> libtool: link: /usr/local/buildroot-2015.02-rc1/output/host/usr/bin/mips64-
> linux-g++ -I/usr/local/buildroot-2015.02-rc1/output/host/usr/mips64-
> buildroot-linux-gnu/sysroot/usr/include/nss -I/usr/local/buildroot-2015.02-
> rc1/output/host/usr/mips64-buildroot-linux-gnu/sysroot/usr/include/nspr 
> -Wall -Wtype-limits -Wignored-qualifiers -Winit-self -Wpointer-arith 
> -Werror=format-security -fno-strict-aliasing -fsigned-char -rdynamic 
> -ftemplate-depth-1024 -Wnon-virtual-dtor -Wno-invalid-offsetof -Wstrict-
> null-sentinel -mxgot -mlong-calls -I/usr/local/buildroot-2015.02-
> rc1/output/host/usr/include -I/usr/local/mips64/include -o 
> ceph_objectstore_tool tools/ceph_objectstore_tool.o  
> -L/usr/local/mips64/lib -L/usr/local/buildroot-2015.02-
> rc1/output/host/usr/lib -L/usr/local/buildroot-2015.02-
> rc1/output/host/usr/lib64 ./.libs/libosd.a /usr/local/buildroot-2015.02-
> rc1/output/host/usr/mips64-buildroot-linux-
> gnu/sysroot/usr/lib/../lib64/libsnappy.so ./.libs/libosdc.a ./.libs/libperfg
> lue.a ./.libs/libos.a -laio -lleveldb /usr/local/buildroot-2015.02-
> rc1/output/host/usr/mips64-buildroot-linux-
> gnu/sysroot/usr/lib/libsnappy.so ./.libs/libglobal.a ./.libs/libcommon.a 
> -L/usr/local/buildroot-2015.02-rc1/output/host/usr/mips64-buildroot-linux-
> gnu/sysroot/usr/lib 
> -lboost_program_options ./.libs/librados.a /usr/local/buildroot-2015.02-
> rc1/output/host/usr/mips64-buildroot-linux-
> gnu/sysroot/usr/lib/libatomic_ops.so -lboost_thread /usr/local/buildroot-
> 2015.02-rc1/output/host/usr/mips64-buildroot-linux-
> gnu/sysroot/usr/lib/../lib64/libatomic_ops.so /usr/local/buildroot-2015.02-
> rc1/output/host/usr/lib/gcc/mips64-buildroot-linux-
> gnu/4.9.2/../../../../mips64-buildroot-linux-gnu/lib/../lib64/libstdc++.so 
> -lm -lpthread -lnss3 -lnssutil3 -lsmime3 -lssl3 -lplds4 -lplc4 
> -lnspr4 /usr/local/mips64/lib/libuuid.a -lboost_system -ldl -Wl,-rpath 
> -Wl,/usr/local/buildroot-2015.02-rc1/output/host/usr/mips64-buildroot-linux-
> gnu/sysroot/usr/lib/../lib64 -Wl,-rpath -Wl,/usr/local/buildroot-2015.02-
> rc1/output/host/usr/mips64-buildroot-linux-gnu/sysroot/usr/lib -Wl,-rpath 
> -Wl,/usr/local/buildroot-2015.02-rc1/output/host/usr/lib/gcc/mips64-
> buildroot-linux-gnu/4.9.2/../../../../mips64-buildroot-linux-
> gnu/lib/../lib64 -Wl,-rpath -Wl,/usr/local/buildroot-2015.02-
> rc1/output/host/usr/mips64-buildroot-linux-gnu/sysroot/usr/lib/../lib64 
> -Wl,-rpath -Wl,/usr/local/buildroot-2015.02-rc1/output/host/usr/mips64-
> buildroot-linux-gnu/sysroot/usr/lib -Wl,-rpath -Wl,/usr/local/buildroot-
> 2015.02-rc1/output/host/usr/lib/gcc/mips64-buildroot-linux-
> gnu/4.9.2/../../../../mips64-buildroot-linux-gnu/lib/../lib64
> ./.libs/libosd.a(libosd_la-ReplicatedPG.o): In function `std::ostream& 
> operator<< <boost::optional<unsigned long>, unsigned long>(std::ostream&, 
> std::pair<boost::optional<unsigned long>, unsigned long> const&)':
> ReplicatedPG.cc:(.text._ZlsIN5boost8optionalImEEmERSoS3_RKSt4pairIT_T0_E
> [_ZlsIN5boost8optionalImEEmERSoS3_RKSt4pairIT_T0_E]+0x34): undefined 
> reference to `std::basic_ostream<char, std::char_traits<char> >& 
> boost::operator<< <char, std::char_traits<char>, unsigned long>
> (std::basic_ostream<char, std::char_traits<char> >&, 
> boost::optional<unsigned long> const&)'
> ReplicatedPG.cc:(.text._ZlsIN5boost8optionalImEEmERSoS3_RKSt4pairIT_T0_E
> [_ZlsIN5boost8optionalImEEmERSoS3_RKSt4pairIT_T0_E]+0x3c): undefined 
> reference to `std::basic_ostream<char, std::char_traits<char> >& 
> boost::operator<< <char, std::char_traits<char>, unsigned long>
> (std::basic_ostream<char, std::char_traits<char> >&, 
> boost::optional<unsigned long> const&)'
> ReplicatedPG.cc:(.text._ZlsIN5boost8optionalImEEmERSoS3_RKSt4pairIT_T0_E
> [_ZlsIN5boost8optionalImEEmERSoS3_RKSt4pairIT_T0_E]+0x44): undefined 
> reference to `std::basic_ostream<char, std::char_traits<char> >& 
> boost::operator<< <char, std::char_traits<char>, unsigned long>
> (std::basic_ostream<char, std::char_traits<char> >&, 
> boost::optional<unsigned long> const&)'
> ./.libs/libosd.a(libosd_la-ECBackend.o): In function `operator<<
> (std::ostream&, ECBackend::read_result_t const&)':
> ECBackend.cc:(.text+0x10f0): undefined reference to 
> `std::basic_ostream<char, std::char_traits<char> >& boost::operator<< 
> <char, std::char_traits<char>, std::map<std::string, ceph::buffer::list, 
> std::less<std::string>, std::allocator<std::pair<std::string const, 
> ceph::buffer::list> > > >(std::basic_ostream<char, std::char_traits<char> 
> >&, boost::optional<std::map<std::string, ceph::buffer::list, 
> std::less<std::string>, std::allocator<std::pair<std::string const, 
> ceph::buffer::list> > > > const&)'
> ECBackend.cc:(.text+0x10f8): undefined reference to 
> `std::basic_ostream<char, std::char_traits<char> >& boost::operator<< 
> <char, std::char_traits<char>, std::map<std::string, ceph::buffer::list, 
> std::less<std::string>, std::allocator<std::pair<std::string const, 
> ceph::buffer::list> > > >(std::basic_ostream<char, std::char_traits<char> 
> >&, boost::optional<std::map<std::string, ceph::buffer::list, 
> std::less<std::string>, std::allocator<std::pair<std::string const, 
> ceph::buffer::list> > > > const&)'
> ECBackend.cc:(.text+0x1100): undefined reference to 
> `std::basic_ostream<char, std::char_traits<char> >& boost::operator<< 
> <char, std::char_traits<char>, std::map<std::string, ceph::buffer::list, 
> std::less<std::string>, std::allocator<std::pair<std::string const, 
> ceph::buffer::list> > > >(std::basic_ostream<char, std::char_traits<char> 
> >&, boost::optional<std::map<std::string, ceph::buffer::list, 
> std::less<std::string>, std::allocator<std::pair<std::string const, 
> ceph::buffer::list> > > > const&)'
> ./.libs/libosd.a(libos_la-FileStore.o): In function 
> `FileStoreBackend::create(long, FileStore*)':
> FileStore.cc:(.text+0x8f1c): undefined reference to 
> `BtrfsFileStoreBackend::BtrfsFileStoreBackend(FileStore*)'
> FileStore.cc:(.text+0x8f24): undefined reference to 
> `BtrfsFileStoreBackend::BtrfsFileStoreBackend(FileStore*)'
> FileStore.cc:(.text+0x8f2c): undefined reference to 
> `BtrfsFileStoreBackend::BtrfsFileStoreBackend(FileStore*)'
> collect2: error: ld returned 1 exit status

It looks like maybe the BtrfsFileStoreBackend is not being linked in?  
Perhaps there is some Makefile magic going on?  Which version/commit are 
you on, and have you made any Makefile modifications?

Unfortunately we don't have a MPIS64 box in the community lab to play 
with.

sage
