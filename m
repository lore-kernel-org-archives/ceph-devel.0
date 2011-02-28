From: Hannu Valtonen <me@ormod.com>
Subject: A hacky try at supporting OS X (for archival purpose)
Date: Mon, 28 Feb 2011 22:02:56 +0200
Message-ID: <4D6BFF70.5000502@ormod.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050809030105050303030500"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:35994 "EHLO
	filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754535Ab1B1UC7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Feb 2011 15:02:59 -0500
Received: from localhost (localhost [127.0.0.1])
	by filtteri6.pp.htv.fi (Postfix) with ESMTP id 1A4B862A035
	for <ceph-devel@vger.kernel.org>; Mon, 28 Feb 2011 22:02:58 +0200 (EET)
Received: from smtp5.welho.com ([213.243.153.39])
	by localhost (filtteri6.pp.htv.fi [213.243.153.189]) (amavisd-new, port 10024)
	with ESMTP id Gg7a2JoDKot0 for <ceph-devel@vger.kernel.org>;
	Mon, 28 Feb 2011 22:02:56 +0200 (EET)
Received: from FSAPPLE12-2.local (cs181254100.pp.htv.fi [82.181.254.100])
	by smtp5.welho.com (Postfix) with ESMTP id B6DF45BC007
	for <ceph-devel@vger.kernel.org>; Mon, 28 Feb 2011 22:02:56 +0200 (EET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050809030105050303030500
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Spent a couple of hours on Sunday to try to get Ceph to work on OS X. 
(I'm mostly interested in the FUSE client but I thought I'd give it a 
whirl in general)

It still doesn't compile fully but this should get it to go a bit 
further. Current blocker is the fact that pthread_t is a pointer on OS X 
while the current code expects it to be unsigned long (like on Linux)

Many of the changes in this patch aren't directly suitable for going 
into the main tree without polishing but I'm sending this as is for 
archival purposes. (or in case somebody else wants to follow the same idea)

I may eventually get back to hacking this if I find some time and 
nobody's beat me to it.. *nudge*

Some notes I made during hacking
--clip--

./msg/SimpleMessenger.h: In member function 'void 
SimpleMessenger::DispatchQueue::local_delivery(Message*, int)':
./msg/SimpleMessenger.h:139: error: 'Connection* 
SimpleMessenger::Pipe::connection_state' is protected
./msg/SimpleMessenger.h:372: error: within this context
make[2]: *** [MonClient.o] Error 1
make[1]: *** [all-recursive] Error 1

Made the connection_state variable public.
--------------
osd/osd_types.h: In member function 'bool pg_t::parse(const char*)':
osd/osd_types.h:163: warning: passing negative value 
'-0x00000000000000001' for argument 1 to 'ceph_le16& 
ceph_le16::operator=(__u16)'
config.cc: At global scope:
config.cc:59: warning: passing negative value '-0x00000000000000001' for 
argument 1 to '__u32 swab32(__u32)'
config.cc:60: warning: passing negative value '-0x00000000000000001' for 
argument 1 to '__u32 swab32(__u32)'
mv -f .deps/config.Tpo .deps/config.Po

Didn't touch them but looked weird
--

g++ -DHAVE_CONFIG_H -I.   -I/opt/local/include/ -Wall -D__CEPH__ 
-D_FILE_OFFSET_BITS=64 -D_REENTRANT -D_THREAD_SAFE -rdynamic  -g -O2 -MT 
lockdep.o -MD -MP -MF .deps/lockdep.Tpo -c -o lockdep.o `test -f 
'common/lockdep.cc' || echo './'`common/lockdep.cc
/usr/include/c++/4.0.0/ext/hashtable.h: In member function 'size_t 
__gnu_cxx::hashtable<_Val, _Key, _HashFcn, _ExtractKey, _EqualKey, 
_Alloc>::_M_bkt_num_key(const _Key&, size_t) const [with _Val = 
std::pair<_opaque_pthread_t* const, std::map<int, ceph::BackTrace*, 
std::less<int>, std::allocator<std::pair<const int, ceph::BackTrace*> > 
 > >, _Key = _opaque_pthread_t*, _HashFcn = 
__gnu_cxx::hash<_opaque_pthread_t*>, _ExtractKey = 
std::_Select1st<std::pair<_opaque_pthread_t* const, std::map<int, 
ceph::BackTrace*, std::less<int>, std::allocator<std::pair<const int, 
ceph::BackTrace*> > > > >, _EqualKey = 
std::equal_to<_opaque_pthread_t*>, _Alloc = std::allocator<std::map<int, 
ceph::BackTrace*, std::less<int>, std::allocator<std::pair<const int, 
ceph::BackTrace*> > > >]':
/usr/include/c++/4.0.0/ext/hashtable.h:588:   instantiated from 'size_t 
__gnu_cxx::hashtable<_Val, _Key, _HashFcn, _ExtractKey, _EqualKey, 
_Alloc>::_M_bkt_num_key(const _Key&) const [with _Val = 
std::pair<_opaque_pthread_t* const, std::map<int, ceph::BackTrace*, 
std::less<int>, std::allocator<std::pair<const int, ceph::BackTrace*> > 
 > >, _Key = _opaque_pthread_t*, _HashFcn = 
__gnu_cxx::hash<_opaque_pthread_t*>, _ExtractKey = 
std::_Select1st<std::pair<_opaque_pthread_t* const, std::map<int, 
ceph::BackTrace*, std::less<int>, std::allocator<std::pair<const int, 
ceph::BackTrace*> > > > >, _EqualKey = 
std::equal_to<_opaque_pthread_t*>, _Alloc = std::allocator<std::map<int, 
ceph::BackTrace*, std::less<int>, std::allocator<std::pair<const int, 
ceph::BackTrace*> > > >]'
/usr/include/c++/4.0.0/ext/hashtable.h:592:   instantiated from 'size_t 
__gnu_cxx::hashtable<_Val, _Key, _HashFcn, _ExtractKey, _EqualKey, 
_Alloc>::_M_bkt_num(const _Val&) const [with _Val = 
std::pair<_opaque_pthread_t* const, std::map<int, ceph::BackTrace*, 
std::less<int>, std::allocator<std::pair<const int, ceph::BackTrace*> > 
 > >, _Key = _opaque_pthread_t*, _HashFcn = 
__gnu_cxx::hash<_opaque_pthread_t*>, _ExtractKey = 
std::_Select1st<std::pair<_opaque_pthread_t* const, std::map<int, 
ceph::BackTrace*, std::less<int>, std::allocator<std::pair<const int, 
ceph::BackTrace*> > > > >, _EqualKey = 
std::equal_to<_opaque_pthread_t*>, _Alloc = std::allocator<std::map<int, 
ceph::BackTrace*, std::less<int>, std::allocator<std::pair<const int, 
ceph::BackTrace*> > > >]'
/usr/include/c++/4.0.0/ext/hashtable.h:646:   instantiated from 
'__gnu_cxx::_Hashtable_iterator<_Val, _Key, _HashFcn, _ExtractKey, 
_EqualKey, _Alloc>& __gnu_cxx::_Hashtable_iterator<_Val, _Key, _HashFcn, 
_ExtractKey, _EqualKey, _Alloc>::operator++() [with _Val = 
std::pair<_opaque_pthread_t* const, std::map<int, ceph::BackTrace*, 
std::less<int>, std::allocator<std::pair<const int, ceph::BackTrace*> > 
 > >, _Key = _opaque_pthread_t*, _HashFcn = 
__gnu_cxx::hash<_opaque_pthread_t*>, _ExtractKey = 
std::_Select1st<std::pair<_opaque_pthread_t* const, std::map<int, 
ceph::BackTrace*, std::less<int>, std::allocator<std::pair<const int, 
ceph::BackTrace*> > > > >, _EqualKey = 
std::equal_to<_opaque_pthread_t*>, _Alloc = std::allocator<std::map<int, 
ceph::BackTrace*, std::less<int>, std::allocator<std::pair<const int, 
ceph::BackTrace*> > > >]'
/usr/include/c++/4.0.0/ext/hashtable.h:660:   instantiated from 
'__gnu_cxx::_Hashtable_iterator<_Val, _Key, _HashFcn, _ExtractKey, 
_EqualKey, _Alloc> __gnu_cxx::_Hashtable_iterator<_Val, _Key, _HashFcn, 
_ExtractKey, _EqualKey, _Alloc>::operator++(int) [with _Val = 
std::pair<_opaque_pthread_t* const, std::map<int, ceph::BackTrace*, 
std::less<int>, std::allocator<std::pair<const int, ceph::BackTrace*> > 
 > >, _Key = _opaque_pthread_t*, _HashFcn = 
__gnu_cxx::hash<_opaque_pthread_t*>, _ExtractKey = 
std::_Select1st<std::pair<_opaque_pthread_t* const, std::map<int, 
ceph::BackTrace*, std::less<int>, std::allocator<std::pair<const int, 
ceph::BackTrace*> > > > >, _EqualKey = 
std::equal_to<_opaque_pthread_t*>, _Alloc = std::allocator<std::map<int, 
ceph::BackTrace*, std::less<int>, std::allocator<std::pair<const int, 
ceph::BackTrace*> > > >]'
common/lockdep.cc:50:   instantiated from here
/usr/include/c++/4.0.0/ext/hashtable.h:596: error: no match for call to 
'(const __gnu_cxx::hash<_opaque_pthread_t*>) (_opaque_pthread_t* const&)'
make[2]: *** [lockdep.o] Error 1
make[1]: *** [all-recursive] Error 1

Probably related to pthread_t being a pointer on os x
---------
rbd_types.h if I use include/mac-compat.h __le32 etc designations will 
blow up.


--------------050809030105050303030500
Content-Type: text/plain; x-mac-type="0"; x-mac-creator="0";
 name="patch.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="patch.diff"

diff --git a/src/include/mac-compat.h b/src/include/mac-compat.h
new file mode 100644
index 0000000..85fc773
--- /dev/null
+++ b/src/include/mac-compat.h
@@ -0,0 +1,21 @@
+#ifndef TEMP_FAILURE_RETRY
+#define TEMP_FAILURE_RETRY(expr) \
+  ({ long int _res; \
+     do _res = (long int) (expr); \
+     while (_res == -1L && errno == EINTR); \
+     _res; })
+#endif
+
+typedef signed char __s8;
+typedef unsigned char __u8;
+typedef signed short __s16;
+typedef unsigned short __u16;
+typedef signed int __s32;
+typedef unsigned int __u32;
+typedef signed long __s64;
+typedef unsigned long __u64;
+
+typedef unsigned short __le16;
+typedef unsigned int __le32;
+typedef unsigned long __le64;
+
diff --git a/autogen.sh b/autogen.sh
index 0b28c8a..6b40c6d 100755
--- a/autogen.sh
+++ b/autogen.sh
@@ -1,4 +1,5 @@
 #!/bin/sh
+LIBTOOLIZE=$(which glibtoolize || which libtoolize)
 
 check_for_pkg_config() {
     which pkg-config >/dev/null && return
@@ -14,7 +15,7 @@ check_for_pkg_config() {
 rm -f config.cache
 aclocal #-I m4
 check_for_pkg_config
-libtoolize --force --copy
+$LIBTOOLIZE --force --copy
 autoconf
 autoheader
 automake -a --add-missing -Wall
diff --git a/src/auth/Crypto.h b/src/auth/Crypto.h
index 782f3bb..25b6f06 100644
--- a/src/auth/Crypto.h
+++ b/src/auth/Crypto.h
@@ -15,6 +15,13 @@
 #define CEPH_CRYPTO_H
 
 #include "include/types.h"
+#ifndef TEMP_FAILURE_RETRY
+#define TEMP_FAILURE_RETRY(expr) \
+  ({ long int _res; \
+     do _res = (long int) (expr); \
+     while (_res == -1L && errno == EINTR); \
+     _res; })
+#endif
 
 /*
  * match encoding of struct ceph_secret
diff --git a/src/client/ioctl.h b/src/client/ioctl.h
index 52e8fd7..c341d03 100644
--- a/src/client/ioctl.h
+++ b/src/client/ioctl.h
@@ -2,7 +2,12 @@
 #define FS_CEPH_IOCTL_H
 
 #include <linux/ioctl.h>
-#include <linux/types.h>
+
+#if defined(__APPLE__)
+    #include "include/mac-compat.h
+#else
+    #include <linux/types.h>
+#endif
 
 #define CEPH_IOCTL_MAGIC 0x97
 
diff --git a/src/common/MemoryModel.cc b/src/common/MemoryModel.cc
index 34abc22..f0a0225 100644
--- a/src/common/MemoryModel.cc
+++ b/src/common/MemoryModel.cc
@@ -4,6 +4,10 @@
 #include "config.h"
 #include "debug.h"
 
+#if defined(__APPLE__)
+#include <malloc/malloc.h>
+#endif
+
 #include <fstream>
 
 void MemoryModel::_sample(snap *psnap)
@@ -85,11 +89,14 @@ void MemoryModel::_sample(snap *psnap)
   psnap->heap = heap >> 10;
 
   // ...
+#if defined(__APPLE__)
+  struct mstats ms = mstats();
+  psnap->malloc = ms.bytes_used >> 10;
+  psnap->mmap = ms.chunks_used >> 10;
+#else
   struct mallinfo mi = mallinfo();
-  
   psnap->malloc = mi.uordblks >> 10;
   psnap->mmap = mi.hblks >> 10;
-  
 
   ofstream log("/tmp/memlog", ios::app);
   log << "heap " << heap
@@ -101,4 +108,6 @@ void MemoryModel::_sample(snap *psnap)
       << "\t" << mi.hblks 
       << "\t" << mi.hblkhd / 1024
       << std::endl;
+#endif
+
 }
diff --git a/src/common/armor.c b/src/common/armor.c
index dce1fed..e069c17 100644
--- a/src/common/armor.c
+++ b/src/common/armor.c
@@ -1,5 +1,8 @@
-
-#include <linux/errno.h>
+#if defined(__APPLE__)
+    #include <sys/errno.h>
+#else
+    #include <linux/errno.h>
+#endif
 
 /*
  * base64 encode/decode.
diff --git a/src/common/sctp_crc32.c b/src/common/sctp_crc32.c
index b10adf7..6c44f49 100644
--- a/src/common/sctp_crc32.c
+++ b/src/common/sctp_crc32.c
@@ -41,9 +41,12 @@ __FBSDID("$FreeBSD: src/sys/netinet/sctp_crc32.c,v 1.8 2007/05/08 17:01:10 rrs E
 #endif
 
 #include <stdint.h>
-#include <endian.h>
-
 
+#if defined(__APPLE__)
+    #include <architecture/byte_order.h>
+#else
+    #include <endian.h>
+#endif
 
 #ifndef SCTP_USE_ADLER32
 
diff --git a/src/crush/crush.h b/src/crush/crush.h
index 97e435b..d904430 100644
--- a/src/crush/crush.h
+++ b/src/crush/crush.h
@@ -1,8 +1,11 @@
 #ifndef CEPH_CRUSH_CRUSH_H
 #define CEPH_CRUSH_CRUSH_H
 
-#include <linux/types.h>
-
+#if defined(__APPLE__)
+    #include "include/mac-compat.h"
+#else
+    #include <linux/types.h>
+#endif
 /*
  * CRUSH is a pseudo-random data distribution algorithm that
  * efficiently distributes input values (typically, data objects)
diff --git a/src/crush/hash.c b/src/crush/hash.c
index 5873aed..5b7dab2 100644
--- a/src/crush/hash.c
+++ b/src/crush/hash.c
@@ -1,5 +1,8 @@
-
-#include <linux/types.h>
+#if defined(__APPLE__)
+    #include "include/mac-compat.h"
+#else
+    #include <linux/types.h>
+#endif
 #include "hash.h"
 
 /*
diff --git a/src/crush/types.h b/src/crush/types.h
index 61f50c2..c0945a0 100644
--- a/src/crush/types.h
+++ b/src/crush/types.h
@@ -7,8 +7,12 @@
 # include <stdlib.h>
 #endif
 
-
-#include <linux/types.h>  /* just for int types */
+/* just for int types */
+#if defined(__APPLE__)
+    #include "include/mac-compat.h"
+#else
+    #include <linux/types.h>
+#endif
 
 #ifndef BUG_ON
 # define BUG_ON(x) assert(!(x))
diff --git a/src/include/Spinlock.h b/src/include/Spinlock.h
index 690c87c..d077955 100644
--- a/src/include/Spinlock.h
+++ b/src/include/Spinlock.h
@@ -28,7 +28,8 @@ namespace ceph {
 
 class Spinlock {
 private:
-  pthread_spinlock_t _s;
+//  pthread_spinlock_t _s;
+  pthread_mutex_t _s;
   int nlock;
 
   // don't allow copying.
@@ -71,12 +72,14 @@ public:
     , name(n), id(-1), lockdep(ld), backtrace(bt)
 #endif
   {
-    pthread_spin_init(&_s, 0);
+//    pthread_spin_init(&_s, 0);
+    pthread_mutex_init(&_s, 0);
     _register();
   }
   ~Spinlock() {
     assert(nlock == 0);
-    pthread_spin_destroy(&_s); 
+//    pthread_spin_destroy(&_s); 
+    pthread_mutex_destroy(&_s);
   }
 
   bool is_locked() {
@@ -84,7 +87,7 @@ public:
   }
 
   bool try_lock() {
-    int r = pthread_spin_trylock(&_s);
+    int r = pthread_mutex_trylock(&_s);
     if (r == 0) {
       _locked();
       nlock++;
@@ -94,7 +97,7 @@ public:
 
   void lock() {
     _will_lock();
-    int r = pthread_spin_lock(&_s);
+    int r = pthread_mutex_lock(&_s);
     _locked();
     assert(r == 0);
     nlock++;
@@ -104,7 +107,7 @@ public:
     assert(nlock > 0);
     --nlock;
     _will_unlock();
-    int r = pthread_spin_unlock(&_s);
+    int r = pthread_mutex_unlock(&_s);
     assert(r == 0);
   }
 
diff --git a/src/include/assert.h b/src/include/assert.h
index 98199b8..95c7adb 100644
--- a/src/include/assert.h
+++ b/src/include/assert.h
@@ -1,7 +1,9 @@
 #ifndef CEPH_ASSERT_H
 #define CEPH_ASSERT_H
 
+#if !defined(__APPLE__)
 #include <features.h>
+#endif
 
 #ifdef __CEPH__
 # include "acconfig.h"
@@ -31,18 +33,20 @@ struct FailedAssertion {
 #endif
 
 
-#if defined __cplusplus && __GNUC_PREREQ (2,95)
-# define __CEPH_ASSERT_VOID_CAST static_cast<void>
-#else
-# define __CEPH_ASSERT_VOID_CAST (void)
-#endif
+//#if defined __cplusplus && __GNUC_PREREQ (2,95)
+//# define __CEPH_ASSERT_VOID_CAST static_cast<void>
+//#else
+#define __CEPH_ASSERT_VOID_CAST (void)
+//#endif
 
 /* Version 2.4 and later of GCC define a magical variable `__PRETTY_FUNCTION__'
    which contains the name of the function currently being defined.
    This is broken in G++ before version 2.6.
    C9x has a similar variable called __func__, but prefer the GCC one since
    it demangles C++ function names.  */
-# if defined __cplusplus ? __GNUC_PREREQ (2, 6) : __GNUC_PREREQ (2, 4)
+#   define __ASSERT_FUNCTION    __PRETTY_FUNCTION__
+
+/*# if defined __cplusplus ? __GNUC_PREREQ (2, 6) : __GNUC_PREREQ (2, 4)
 #   define __ASSERT_FUNCTION	__PRETTY_FUNCTION__
 # else
 #  if defined __STDC_VERSION__ && __STDC_VERSION__ >= 199901L
@@ -51,7 +55,7 @@ struct FailedAssertion {
 #   define __ASSERT_FUNCTION	((__const char *) 0)
 #  endif
 # endif
-
+*/
 extern void __ceph_assert_fail(const char *assertion, const char *file, int line, const char *function)
   __attribute__ ((__noreturn__));
 extern void __ceph_assert_warn(const char *assertion, const char *file, int line, const char *function);
diff --git a/src/include/buffer.h b/src/include/buffer.h
index 0905e11..ffb30bf 100644
--- a/src/include/buffer.h
+++ b/src/include/buffer.h
@@ -14,8 +14,11 @@
 
 #ifndef CEPH_BUFFER_H
 #define CEPH_BUFFER_H
-
-#include <linux/types.h>
+#if defined(__APPLE__)
+    #include "include/mac-compat.h"
+#else
+    #include <linux/types.h>
+#endif
 
 #ifndef _XOPEN_SOURCE
 # define _XOPEN_SOURCE 600
@@ -35,8 +38,11 @@ void	*valloc(size_t);
 
 
 #else
-
-#include <malloc.h>
+#if !defined(__APPLE__)
+    #include <malloc.h>
+#else
+    #include <malloc/malloc.h>
+#endif
 #endif
 #include <stdint.h>
 #include <string.h>
diff --git a/src/include/byteorder.h b/src/include/byteorder.h
index f49cb66..2cc5f83 100644
--- a/src/include/byteorder.h
+++ b/src/include/byteorder.h
@@ -6,8 +6,11 @@
 
 #ifndef CEPH_BYTEORDER_H
 #define CEPH_BYTEORDER_H
-
-#include <endian.h>
+#if defined(__APPLE__)
+    #include <architecture/byte_order.h>
+#else
+    #include <endian.h>
+#endif
 
 static __inline__ __u16 swab16(__u16 val) 
 {
diff --git a/src/include/inttypes.h b/src/include/inttypes.h
index 50ebd4e..ed0216f 100644
--- a/src/include/inttypes.h
+++ b/src/include/inttypes.h
@@ -2,6 +2,9 @@
 #define CEPH_INTTYPES_H
 
 #include <stdint.h>
-#include <linux/types.h>
-
+#if defined(__APPLE__)
+    #include "include/mac-compat.h"
+#else
+    #include <linux/types.h>
+#endif
 #endif
diff --git a/src/include/rados/librados.h b/src/include/rados/librados.h
index f73afd9..2732c11 100644
--- a/src/include/rados/librados.h
+++ b/src/include/rados/librados.h
@@ -6,7 +6,12 @@ extern "C" {
 #endif
 
 #include <netinet/in.h>
-#include <linux/types.h>
+
+#if defined(__APPLE__)
+    #include "include/mac-compat.h"
+#else
+    #include <linux/types.h>>
+#endif
 #include <string.h>
 
 #ifndef CEPH_OSD_TMAP_SET
diff --git a/src/include/rbd_types.h b/src/include/rbd_types.h
index 5b9c168..ff4d159 100644
--- a/src/include/rbd_types.h
+++ b/src/include/rbd_types.h
@@ -13,7 +13,18 @@
 #ifndef CEPH_RBD_TYPES_H
 #define CEPH_RBD_TYPES_H
 
-#include <linux/types.h>
+#if defined(__APPLE__)
+typedef signed char __s8;
+typedef unsigned char __u8;
+typedef signed short __s16;
+typedef unsigned short __u16;
+typedef signed int __s32;
+typedef unsigned int __u32;
+typedef signed long __s64;
+typedef unsigned long __u64;
+#else
+    #include <linux/types.h>
+#endif
 
 /*
  * rbd image 'foo' consists of objects
diff --git a/src/mds/locks.c b/src/mds/locks.c
index 8225eef..6277b98 100644
--- a/src/mds/locks.c
+++ b/src/mds/locks.c
@@ -5,7 +5,12 @@ typedef char bool;
 #define true  1
 
 #include <netinet/in.h>
-#include <linux/types.h>
+
+#if defined(__APPLE__)
+    #include "include/mac-compat.h"
+#else
+    #include <linux/types.h>
+#endif
 #include <string.h>
 #include <fcntl.h>
 
diff --git a/src/msg/SimpleMessenger.cc b/src/msg/SimpleMessenger.cc
index fd44fac..995288d 100644
--- a/src/msg/SimpleMessenger.cc
+++ b/src/msg/SimpleMessenger.cc
@@ -1990,8 +1990,11 @@ int SimpleMessenger::Pipe::do_sendmsg(int sd, struct msghdr *msg, int len, bool
 	l += msg->msg_iov[i].iov_len;
       assert(l == len);
     }
-
-    int r = ::sendmsg(sd, msg, more ? MSG_MORE : 0);
+    #if defined(__APPLE__)
+    int r = ::sendmsg(sd, msg, more ? 0 : 0);
+    #else
+     int r = ::sendmsg(sd, msg, more ? MSG_MORE : 0);
+    #endif
     if (r == 0) 
       dout(10) << "do_sendmsg hmm do_sendmsg got r==0!" << dendl;
     if (r < 0) { 
diff --git a/src/msg/SimpleMessenger.h b/src/msg/SimpleMessenger.h
index 4cb1457..97085ae 100644
--- a/src/msg/SimpleMessenger.h
+++ b/src/msg/SimpleMessenger.h
@@ -133,10 +133,10 @@ private:
     
     Mutex pipe_lock;
     int state;
+    Connection *connection_state;
 
   protected:
     friend class SimpleMessenger;
-    Connection *connection_state;
 
     utime_t backoff;         // backoff time
 
diff --git a/src/msg/tcp.cc b/src/msg/tcp.cc
index 71d85f1..e295fc8 100644
--- a/src/msg/tcp.cc
+++ b/src/msg/tcp.cc
@@ -1,4 +1,4 @@
-// -*- mode:C++; tab-width:8; c-basic-offset:2; indent-tabs-mode:t -*- 
+// -*- mode:C++; tab-width:8; c-basic-offset:2; indent-tabs-mode:t -*-
 // vim: ts=8 sw=2 smarttab
 
 #include <poll.h>
@@ -8,7 +8,7 @@
 /******************
  * tcp crap
  */
-int tcp_read(int sd, char *buf, int len, int timeout) 
+int tcp_read(int sd, char *buf, int len, int timeout)
 {
   if (sd < 0)
     return -1;
@@ -37,18 +37,26 @@ int tcp_read(int sd, char *buf, int len, int timeout)
   return len;
 }
 
-int tcp_read_wait(int sd, int timeout) 
+int tcp_read_wait(int sd, int timeout)
 {
   if (sd < 0)
     return -1;
   struct pollfd pfd;
   pfd.fd = sd;
+
+  #if defined(__APPLE__)
+  pfd.events = POLLIN; // figure out if we _really_ need POLLRDHUP equivalent
+  #else
   pfd.events = POLLIN | POLLRDHUP;
+  #endif
 
   if (poll(&pfd, 1, timeout) <= 0)
     return -1;
-
+  #if defined(__APPLE__)
+  if (pfd.revents & (POLLERR | POLLHUP | POLLNVAL))
+  #else
   if (pfd.revents & (POLLERR | POLLHUP | POLLRDHUP | POLLNVAL))
+  #endif
     return -1;
 
   if (!(pfd.revents & POLLIN))
@@ -90,7 +98,12 @@ int tcp_write(int sd, const char *buf, int len)
     return -1;
   struct pollfd pfd;
   pfd.fd = sd;
+  #if defined(__APPLE__)
+  pfd.events = POLLOUT | POLLHUP | POLLNVAL | POLLERR;
+  #else
   pfd.events = POLLOUT | POLLHUP | POLLRDHUP | POLLNVAL | POLLERR;
+  #endif
+
 
   if (g_conf.ms_inject_socket_failures && sd >= 0) {
     if (rand() % g_conf.ms_inject_socket_failures == 0) {
@@ -108,7 +121,11 @@ int tcp_write(int sd, const char *buf, int len)
   //generic_dout(DBL) << "tcp_write writing " << len << dendl;
   assert(len > 0);
   while (len > 0) {
+    #if defined(__APPLE__)
+    int did = ::send( sd, buf, len, SO_NOSIGPIPE  );
+    #else
     int did = ::send( sd, buf, len, MSG_NOSIGNAL );
+    #endif
     if (did < 0) {
       //generic_dout(1) << "tcp_write error did = " << did << "  errno " << errno << " " << strerror(errno) << dendl;
       //generic_derr(1) << "tcp_write error did = " << did << "  errno " << errno << " " << strerror(errno) << dendl;
diff --git a/wireshark/ceph/types.h b/wireshark/ceph/types.h
index 1bcc48d..0105681 100644
--- a/wireshark/ceph/types.h
+++ b/wireshark/ceph/types.h
@@ -25,7 +25,11 @@ typedef __u64				__le64;
 #include <winsock.h>
 #else
 #include <netinet/in.h>
-#include <linux/types.h>
+#if defined(__APPLE__)
+    #include "include/mac-compat.h"
+#else
+    #include <linux/types.h>
+#endif
 #endif
 typedef int bool;
 

--------------050809030105050303030500--
