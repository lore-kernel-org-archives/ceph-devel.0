From: Sage Weil <sage@newdream.net>
Subject: Re: fallocate issue on CentOS 5
Date: Sat, 7 Apr 2012 08:48:08 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1204070846510.1309@cobra.newdream.net>
References: <4F7FFB6602000099000DE9D4@collaborate.seakr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58904 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753260Ab2DGPsJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 7 Apr 2012 11:48:09 -0400
In-Reply-To: <4F7FFB6602000099000DE9D4@collaborate.seakr.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nick Couchman <Nick.Couchman@seakr.com>
Cc: ceph-devel@vger.kernel.org

On Sat, 7 Apr 2012, Nick Couchman wrote:
> I'm trying to compile 0.44.1 on CentOS 5, and am running into the following compile-time error:
> 
>  g++ -DHAVE_CONFIG_H -I. -I. -I. -I/usr/include/nss3 -I/usr/include/nspr4 -Wall -D__CEPH__ -D_FILE_OFFSET_BITS=64 -D_REENTRANT -D_THREAD_SAFE -D__STDC_FORMAT_MACROS -D_GNU_SOURCE -rdynamic -Winit-self -Wpointer-arith -fno-strict-aliasing -DCEPH_LIBDIR=\"/usr/lib64\" -Wnon-virtual-dtor -Wno-invalid-offsetof -Wstrict-null-sentinel -I../src/leveldb/include -O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -m64 -mtune=generic -MT libos_la-FileStore.lo -MD -MP -MF .deps/libos_la-FileStore.Tpo -c os/FileStore.cc  -fPIC -DPIC -o .libs/libos_la-FileStore.o
> os/FileStore.cc: In member function 'int FileStore::_zero(coll_t, const hobject_t&, uint64_t, size_t)':
> os/FileStore.cc:3013: error: 'fallocate' was not declared in this scope
> os/FileStore.cc: In member function 'void FileStore::sync_entry()':
> os/FileStore.cc:3385: warning: passing 'float' for argument 1 to 'SyncEntryTimeout::SyncEntryTimeout(int)'
> make[3]: *** [libos_la-FileStore.lo] Error 1
> make[3]: *** Waiting for unfinished jobs....
> 
> Interestingly, if I go to that block of code, there's an "#ifdef HAVE_FALLOCATE" block there, and this is inside that block.  So, I go and look at the output of configure and I see:
> 
> checking for utime.h... yes
> checking for sync_file_range... no
> checking for fallocate... no
> checking for a Python interpreter with version >= 2.4... python
> checking for python... /usr/bin/python
> 
> Configure script believes fallocate is not available.  And, indeed, from config.log:
> 
> configure:18309: checking for fallocate
> configure:18309: gcc -o conftest -g -O2 conftest.c >&5
> /tmp/ccybZzwg.o: In function `main':
> /root/ceph-0.44.1/conftest.c:81: undefined referenece to `fallocate'
> 
> Okay, so compiler cannot find it, then why is this block of code being evaluated??  I poked around a bit more, and found that HAVE_FALLOCATE is defined in /usr/include/linux/fs.h, which appears to be included in FileStore.cc.  So, even though the configure script fails to detect fallocate correctly, it's still pulling it in because it is defined in the linux/fs.h file, even though it doesn't work.  What's the best way to fix this build issue and have it correctly disable HAVE_FALLOCATE if fallocate() doesn't really work?

That's annoying.  You could modify configure.ac so that it defines 
something other than HAVE_FALLOCATE (CEPH_HAVE_FALLOCATE, perhaps) and 
adjust the #ifdefs accordingly...

sage
