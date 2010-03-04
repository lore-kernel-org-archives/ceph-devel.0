From: Thomas Mueller <thomas@chaschperli.ch>
Subject: build fails on centos 5
Date: Thu, 4 Mar 2010 12:18:10 +0000 (UTC)
Message-ID: <hmo8e2$lnv$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: ceph-devel@lists.sourceforge.net
List-Id: ceph-devel.vger.kernel.org

hi 

downloaded 0.19.1 and tried to compile on centos 5.

compilation fails with this:


g++ -DHAVE_CONFIG_H -I.    -Wall -D_FILE_OFFSET_BITS=64 -D_REENTRANT -D_THREAD_SAFE -rdynamic -g -O2 -MT class_debug.o -MD -MP -MF .deps/class_debug.Tpo -c -o class_debug.o `test -f 'objclass/class_debug.cc' || echo './'`objclass/class_debug.cc
mv -f .deps/class_debug.Tpo .deps/class_debug.Po
g++ -DHAVE_CONFIG_H -I.    -Wall -D_FILE_OFFSET_BITS=64 -D_REENTRANT -D_THREAD_SAFE -rdynamic -g -O2 -MT class_api.o -MD -MP -MF .deps/class_api.Tpo -c -o class_api.o `test -f 'objclass/class_api.cc' || echo './'`objclass/class_api.cc
mv -f .deps/class_api.Tpo .deps/class_api.Po
/bin/sh ../libtool --tag=CXX   --mode=link g++ -Wall -D_FILE_OFFSET_BITS=64 -D_REENTRANT -D_THREAD_SAFE -rdynamic -g -O2   -o cosd cosd.o SimpleMessenger.o class_debug.o class_api.o libosd.a libos.a libcrush.a libcommon.a -ldl -lpthread -lm -lcrypto 
g++ -Wall -D_FILE_OFFSET_BITS=64 -D_REENTRANT -D_THREAD_SAFE -rdynamic -g -O2 -o cosd cosd.o SimpleMessenger.o class_debug.o class_api.o  libosd.a libos.a libcrush.a libcommon.a -ldl -lpthread -lm -lcrypto  
libos.a(FileStore.o): In function `FileStore::_write(coll_t, sobject_t const&, unsigned long, unsigned long, buffer::list const&)':
/usr/src/ceph-0.19.1/src/os/FileStore.cc:928: undefined reference to `sync_file_range'
libos.a(FileStore.o): In function `FileStore::flusher_entry()':
/usr/src/ceph-0.19.1/src/os/FileStore.cc:1108: undefined reference to `sync_file_range'
libos.a(FileJournal.o): In function `FileJournal::do_write(buffer::list&)':
/usr/src/ceph-0.19.1/src/os/FileJournal.cc:533: undefined reference to `sync_file_range'
/usr/src/ceph-0.19.1/src/os/FileJournal.cc:534: undefined reference to `sync_file_range'
/usr/src/ceph-0.19.1/src/os/FileJournal.cc:535: undefined reference to `sync_file_range'
libos.a(FileJournal.o):/usr/src/ceph-0.19.1/src/os/FileJournal.cc:536: more undefined references to `sync_file_range' follow
collect2: ld returned 1 exit status
make[1]: *** [cosd] Error 1
make[1]: Leaving directory `/usr/src/ceph-0.19.1/src'
make: *** [all] Error 2

could not find any hints with google on this error. 

centos package versions (maybe relevant, just guessing):
* gcc: 4.1.2
* glibc: 2.5
* fuse: 2.7.4
* boost: 1.33.1
* libedit: 2.11
* kernel (custom built, vanilla): 2.6.32.7

- Thomas



------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
