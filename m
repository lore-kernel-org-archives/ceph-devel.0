From: Janne Grunau <j@jannau.net>
Subject: [PATCH 1/3] buffer: add an aligned buffer with less alignment than a page
Date: Mon, 15 Sep 2014 17:55:06 +0200
Message-ID: <1410796508-28711-1-git-send-email-j@jannau.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from soltyk.jannau.net ([185.27.253.110]:60148 "EHLO
	soltyk.jannau.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753920AbaIOQBS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Sep 2014 12:01:18 -0400
Received: from coburn.home.jannau.net (55d46944.access.ecotel.net [85.212.105.68])
	by soltyk.jannau.net (Postfix) with ESMTPSA id 391453E18D6
	for <ceph-devel@vger.kernel.org>; Mon, 15 Sep 2014 17:55:11 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

SIMD optimized erasure code computation needs aligned memory. Buffers
aligned to a page boundary are wasted on it though. The buffers used
for the erasure code computation are typical smaller than a page.

Currently an alignement of 16 bytes is enough for the used
SIMD instruction sets (SSE4 and NEON).

Signed-off-by: Janne Grunau <j@jannau.net>
---
 configure.ac         |   9 +++++
 src/common/buffer.cc | 100 +++++++++++++++++++++++++++++++++++++++++++++++++++
 src/include/buffer.h |  10 ++++++
 3 files changed, 119 insertions(+)

diff --git a/configure.ac b/configure.ac
index cccf2d9..1bb27c4 100644
--- a/configure.ac
+++ b/configure.ac
@@ -793,6 +793,15 @@ AC_MSG_RESULT([no])
 ])
 
 #
+# Check for functions to provide aligned memory
+#
+AC_CHECK_HEADERS([malloc.h])
+AC_CHECK_FUNCS([posix_memalign _aligned_malloc memalign aligned_malloc],
+               [found_memalign=yes; break])
+
+AS_IF([test "x$found_memalign" != "xyes"], [AC_MSG_WARN([No function for aligned memory allocation found])])
+
+#
 # Check for pthread spinlock (depends on ACX_PTHREAD)
 #
 saved_LIBS="$LIBS"
diff --git a/src/common/buffer.cc b/src/common/buffer.cc
index b141759..acc221f 100644
--- a/src/common/buffer.cc
+++ b/src/common/buffer.cc
@@ -30,6 +30,10 @@
 #include <sys/uio.h>
 #include <limits.h>
 
+#ifdef HAVE_MALLOC_H
+#include <malloc.h>
+#endif
+
 namespace ceph {
 
 #ifdef BUFFER_DEBUG
@@ -155,9 +159,15 @@ static simple_spinlock_t buffer_debug_lock = SIMPLE_SPINLOCK_INITIALIZER;
     virtual int zero_copy_to_fd(int fd, loff_t *offset) {
       return -ENOTSUP;
     }
+    virtual bool is_aligned() {
+      return ((long)data & ~CEPH_ALIGN_MASK) == 0;
+    }
     virtual bool is_page_aligned() {
       return ((long)data & ~CEPH_PAGE_MASK) == 0;
     }
+    bool is_n_align_sized() {
+      return (len & ~CEPH_ALIGN_MASK) == 0;
+    }
     bool is_n_page_sized() {
       return (len & ~CEPH_PAGE_MASK) == 0;
     }
@@ -209,6 +219,41 @@ static simple_spinlock_t buffer_debug_lock = SIMPLE_SPINLOCK_INITIALIZER;
     }
   };
 
+  class buffer::raw_aligned : public buffer::raw {
+  public:
+    raw_aligned(unsigned l) : raw(l) {
+      if (len) {
+#if HAVE_POSIX_MEMALIGN
+        if (posix_memalign((void **) &data, CEPH_ALIGN, len))
+          data = 0;
+#elif HAVE__ALIGNED_MALLOC
+        data = _aligned_malloc(len, CEPH_ALIGN);
+#elif HAVE_MEMALIGN
+        data = memalign(CEPH_ALIGN, len);
+#elif HAVE_ALIGNED_MALLOC
+        data = aligned_malloc((len + CEPH_ALIGN - 1) & ~CEPH_ALIGN_MASK,
+                              CEPH_ALIGN);
+#else
+        data = malloc(len);
+#endif
+        if (!data)
+          throw bad_alloc();
+      } else {
+        data = 0;
+      }
+      inc_total_alloc(len);
+      bdout << "raw_aligned " << this << " alloc " << (void *)data << " " << l << " " << buffer::get_total_alloc() << bendl;
+    }
+    ~raw_aligned() {
+      free(data);
+      dec_total_alloc(len);
+      bdout << "raw_aligned " << this << " free " << (void *)data << " " << buffer::get_total_alloc() << bendl;
+    }
+    raw* clone_empty() {
+      return new raw_aligned(len);
+    }
+  };
+
 #ifndef __CYGWIN__
   class buffer::raw_mmap_pages : public buffer::raw {
   public:
@@ -334,6 +379,10 @@ static simple_spinlock_t buffer_debug_lock = SIMPLE_SPINLOCK_INITIALIZER;
       return true;
     }
 
+    bool is_aligned() {
+      return false;
+    }
+
     bool is_page_aligned() {
       return false;
     }
@@ -520,6 +569,9 @@ static simple_spinlock_t buffer_debug_lock = SIMPLE_SPINLOCK_INITIALIZER;
   buffer::raw* buffer::create_static(unsigned len, char *buf) {
     return new raw_static(buf, len);
   }
+  buffer::raw* buffer::create_aligned(unsigned len) {
+    return new raw_aligned(len);
+  }
   buffer::raw* buffer::create_page_aligned(unsigned len) {
 #ifndef __CYGWIN__
     //return new raw_mmap_pages(len);
@@ -1013,6 +1065,16 @@ static simple_spinlock_t buffer_debug_lock = SIMPLE_SPINLOCK_INITIALIZER;
     return true;
   }
 
+  bool buffer::list::is_aligned() const
+  {
+    for (std::list<ptr>::const_iterator it = _buffers.begin();
+         it != _buffers.end();
+         ++it)
+      if (!it->is_aligned())
+        return false;
+    return true;
+  }
+
   bool buffer::list::is_page_aligned() const
   {
     for (std::list<ptr>::const_iterator it = _buffers.begin();
@@ -1101,6 +1163,44 @@ static simple_spinlock_t buffer_debug_lock = SIMPLE_SPINLOCK_INITIALIZER;
     _buffers.push_back(nb);
   }
 
+void buffer::list::rebuild_aligned()
+{
+  std::list<ptr>::iterator p = _buffers.begin();
+  while (p != _buffers.end()) {
+    // keep anything that's already page sized+aligned
+    if (p->is_aligned() && p->is_n_align_sized()) {
+      /*cout << " segment " << (void*)p->c_str()
+             << " offset " << ((unsigned long)p->c_str() & ~CEPH_ALIGN_MASK)
+             << " length " << p->length()
+             << " " << (p->length() & ~CEPH_ALIGN_MASK) << " ok" << std::endl;
+      */
+      ++p;
+      continue;
+    }
+
+    // consolidate unaligned items, until we get something that is sized+aligned
+    list unaligned;
+    unsigned offset = 0;
+    do {
+      /*cout << " segment " << (void*)p->c_str()
+             << " offset " << ((unsigned long)p->c_str() & ~CEPH_ALIGN_MASK)
+             << " length " << p->length() << " " << (p->length() & ~CEPH_ALIGN_MASK)
+             << " overall offset " << offset << " " << (offset & ~CEPH_ALIGN_MASK)
+             << " not ok" << std::endl;
+      */
+      offset += p->length();
+      unaligned.push_back(*p);
+      _buffers.erase(p++);
+    } while (p != _buffers.end() &&
+	     (!p->is_aligned() ||
+	      !p->is_n_align_sized() ||
+	      (offset & ~CEPH_ALIGN_MASK)));
+    ptr nb(buffer::create_aligned(unaligned._len));
+    unaligned.rebuild(nb);
+    _buffers.insert(p, unaligned._buffers.front());
+  }
+}
+
 void buffer::list::rebuild_page_aligned()
 {
   std::list<ptr>::iterator p = _buffers.begin();
diff --git a/src/include/buffer.h b/src/include/buffer.h
index e5c1b50..ea362e7 100644
--- a/src/include/buffer.h
+++ b/src/include/buffer.h
@@ -56,6 +56,9 @@
 # include <assert.h>
 #endif
 
+#define CEPH_ALIGN 16
+#define CEPH_ALIGN_MASK (~(CEPH_ALIGN - 1LLU))
+
 namespace ceph {
 
 class buffer {
@@ -124,6 +127,7 @@ private:
    */
   class raw;
   class raw_malloc;
+  class raw_aligned;
   class raw_static;
   class raw_mmap_pages;
   class raw_posix_aligned;
@@ -144,6 +148,7 @@ public:
   static raw* create_malloc(unsigned len);
   static raw* claim_malloc(unsigned len, char *buf);
   static raw* create_static(unsigned len, char *buf);
+  static raw* create_aligned(unsigned len);
   static raw* create_page_aligned(unsigned len);
   static raw* create_zero_copy(unsigned len, int fd, int64_t *offset);
 
@@ -177,7 +182,9 @@ public:
     bool at_buffer_head() const { return _off == 0; }
     bool at_buffer_tail() const;
 
+    bool is_aligned() const { return ((long)c_str() & ~CEPH_ALIGN_MASK) == 0; }
     bool is_page_aligned() const { return ((long)c_str() & ~CEPH_PAGE_MASK) == 0; }
+    bool is_n_align_sized() const { return (length() & ~CEPH_ALIGN_MASK) == 0; }
     bool is_n_page_sized() const { return (length() & ~CEPH_PAGE_MASK) == 0; }
 
     // accessors
@@ -344,7 +351,9 @@ public:
     bool contents_equal(buffer::list& other);
 
     bool can_zero_copy() const;
+    bool is_aligned() const;
     bool is_page_aligned() const;
+    bool is_n_align_sized() const;
     bool is_n_page_sized() const;
 
     bool is_zero() const;
@@ -382,6 +391,7 @@ public:
     bool is_contiguous();
     void rebuild();
     void rebuild(ptr& nb);
+    void rebuild_aligned();
     void rebuild_page_aligned();
 
     // sort-of-like-assignment-op
-- 
2.1.0

