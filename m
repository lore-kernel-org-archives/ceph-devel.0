From: Janne Grunau <j@jannau.net>
Subject: [PATCH v3 1/4] buffer: add an aligned buffer with less alignment than a page
Date: Mon, 29 Sep 2014 14:34:29 +0200
Message-ID: <1411994072-18850-2-git-send-email-j@jannau.net>
References: <1410796508-28711-1-git-send-email-j@jannau.net>
 <1411994072-18850-1-git-send-email-j@jannau.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from soltyk.jannau.net ([185.27.253.110]:42035 "EHLO
	soltyk.jannau.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753247AbaI2Mej (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Sep 2014 08:34:39 -0400
Received: from coburn.home.jannau.net (55d46691.access.ecotel.net [85.212.102.145])
	by soltyk.jannau.net (Postfix) with ESMTPSA id E86923E1A18
	for <ceph-devel@vger.kernel.org>; Mon, 29 Sep 2014 14:34:37 +0200 (CEST)
In-Reply-To: <1411994072-18850-1-git-send-email-j@jannau.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

SIMD optimized erasure code computation needs aligned memory. Buffers
aligned to a page boundary are not needed though. The buffers used
for the erasure code computation are typical smaller than a page.

The typical alignment requirements SIMD operations are 16 bytes for
SSE2 and NEON and 32 bytes for AVX/AVX2.

Signed-off-by: Janne Grunau <j@jannau.net>
---
 configure.ac         |   9 +++++
 src/common/buffer.cc | 106 +++++++++++++++++++++++++++++++++++++++++++++++++++
 src/include/buffer.h |  15 ++++++++
 3 files changed, 130 insertions(+)

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
index af298ac..dfe887e 100644
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
@@ -155,9 +159,17 @@ static simple_spinlock_t buffer_debug_lock = SIMPLE_SPINLOCK_INITIALIZER;
     virtual int zero_copy_to_fd(int fd, loff_t *offset) {
       return -ENOTSUP;
     }
+    virtual bool is_aligned(unsigned align) {
+      assert((align >= sizeof(void *)) && (align & (align - 1)) == 0);
+      return ((intptr_t)data & (align - 1)) == 0;
+    }
     virtual bool is_page_aligned() {
       return ((long)data & ~CEPH_PAGE_MASK) == 0;
     }
+    bool is_n_align_sized(unsigned align) {
+      assert((align >= sizeof(void *)) && (align & (align - 1)) == 0);
+      return (len % align) == 0;
+    }
     bool is_n_page_sized() {
       return (len & ~CEPH_PAGE_MASK) == 0;
     }
@@ -209,6 +221,43 @@ static simple_spinlock_t buffer_debug_lock = SIMPLE_SPINLOCK_INITIALIZER;
     }
   };
 
+  class buffer::raw_aligned : public buffer::raw {
+    unsigned _align;
+  public:
+    raw_aligned(unsigned l, unsigned align) : raw(l) {
+      _align = align;
+      assert((align >= sizeof(void *)) && (align & (align - 1)) == 0);
+      if (len) {
+#if HAVE_POSIX_MEMALIGN
+        if (posix_memalign((void **) &data, align, len))
+          data = 0;
+#elif HAVE__ALIGNED_MALLOC
+        data = _aligned_malloc(len, align);
+#elif HAVE_MEMALIGN
+        data = memalign(align, len);
+#elif HAVE_ALIGNED_MALLOC
+        data = aligned_malloc((len + align - 1) & (align - 1), align);
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
+      return new raw_aligned(len, _align);
+    }
+  };
+
 #ifndef __CYGWIN__
   class buffer::raw_mmap_pages : public buffer::raw {
   public:
@@ -334,6 +383,10 @@ static simple_spinlock_t buffer_debug_lock = SIMPLE_SPINLOCK_INITIALIZER;
       return true;
     }
 
+    bool is_aligned() {
+      return false;
+    }
+
     bool is_page_aligned() {
       return false;
     }
@@ -520,6 +573,9 @@ static simple_spinlock_t buffer_debug_lock = SIMPLE_SPINLOCK_INITIALIZER;
   buffer::raw* buffer::create_static(unsigned len, char *buf) {
     return new raw_static(buf, len);
   }
+  buffer::raw* buffer::create_aligned(unsigned len, unsigned align) {
+    return new raw_aligned(len, align);
+  }
   buffer::raw* buffer::create_page_aligned(unsigned len) {
 #ifndef __CYGWIN__
     //return new raw_mmap_pages(len);
@@ -1013,6 +1069,17 @@ static simple_spinlock_t buffer_debug_lock = SIMPLE_SPINLOCK_INITIALIZER;
     return true;
   }
 
+  bool buffer::list::is_aligned(unsigned align) const
+  {
+    assert((align >= sizeof(void *)) && (align & (align - 1)) == 0);
+    for (std::list<ptr>::const_iterator it = _buffers.begin();
+         it != _buffers.end();
+         ++it)
+      if (!it->is_aligned(align))
+        return false;
+    return true;
+  }
+
   bool buffer::list::is_page_aligned() const
   {
     for (std::list<ptr>::const_iterator it = _buffers.begin();
@@ -1101,6 +1168,45 @@ static simple_spinlock_t buffer_debug_lock = SIMPLE_SPINLOCK_INITIALIZER;
     _buffers.push_back(nb);
   }
 
+void buffer::list::rebuild_aligned(unsigned align)
+{
+  std::list<ptr>::iterator p = _buffers.begin();
+  assert((align >= sizeof(void *)) && (align & (align - 1)) == 0);
+  while (p != _buffers.end()) {
+    // keep anything that's already align sized+aligned
+    if (p->is_aligned(align) && p->is_n_align_sized(align)) {
+      /*cout << " segment " << (void*)p->c_str()
+             << " offset " << ((unsigned long)p->c_str() & (align - 1))
+             << " length " << p->length()
+             << " " << (p->length() & (align - 1)) << " ok" << std::endl;
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
+             << " offset " << ((unsigned long)p->c_str() & (align - 1))
+             << " length " << p->length() << " " << (p->length() & (align - 1))
+             << " overall offset " << offset << " " << (offset & (align - 1))
+             << " not ok" << std::endl;
+      */
+      offset += p->length();
+      unaligned.push_back(*p);
+      _buffers.erase(p++);
+    } while (p != _buffers.end() &&
+	     (!p->is_aligned(align) ||
+	      !p->is_n_align_sized(align) ||
+	      (offset % align)));
+    ptr nb(buffer::create_aligned(unaligned._len, align));
+    unaligned.rebuild(nb);
+    _buffers.insert(p, unaligned._buffers.front());
+  }
+}
+
 void buffer::list::rebuild_page_aligned()
 {
   std::list<ptr>::iterator p = _buffers.begin();
diff --git a/src/include/buffer.h b/src/include/buffer.h
index e5c1b50..2a32cf4 100644
--- a/src/include/buffer.h
+++ b/src/include/buffer.h
@@ -124,6 +124,7 @@ private:
    */
   class raw;
   class raw_malloc;
+  class raw_aligned;
   class raw_static;
   class raw_mmap_pages;
   class raw_posix_aligned;
@@ -144,6 +145,7 @@ public:
   static raw* create_malloc(unsigned len);
   static raw* claim_malloc(unsigned len, char *buf);
   static raw* create_static(unsigned len, char *buf);
+  static raw* create_aligned(unsigned len, unsigned align);
   static raw* create_page_aligned(unsigned len);
   static raw* create_zero_copy(unsigned len, int fd, int64_t *offset);
 
@@ -177,7 +179,17 @@ public:
     bool at_buffer_head() const { return _off == 0; }
     bool at_buffer_tail() const;
 
+    bool is_aligned(unsigned align) const
+    {
+      assert((align >= sizeof(void *)) && (align & (align - 1)) == 0);
+      return ((intptr_t)c_str() & (align - 1)) == 0;
+    }
     bool is_page_aligned() const { return ((long)c_str() & ~CEPH_PAGE_MASK) == 0; }
+    bool is_n_align_sized(unsigned align) const
+    {
+      assert((align >= sizeof(void *)) && (align & (align - 1)) == 0);
+      return (length() % align) == 0;
+    }
     bool is_n_page_sized() const { return (length() & ~CEPH_PAGE_MASK) == 0; }
 
     // accessors
@@ -344,7 +356,9 @@ public:
     bool contents_equal(buffer::list& other);
 
     bool can_zero_copy() const;
+    bool is_aligned(unsigned align) const;
     bool is_page_aligned() const;
+    bool is_n_align_sized(unsigned align) const;
     bool is_n_page_sized() const;
 
     bool is_zero() const;
@@ -382,6 +396,7 @@ public:
     bool is_contiguous();
     void rebuild();
     void rebuild(ptr& nb);
+    void rebuild_aligned(unsigned align);
     void rebuild_page_aligned();
 
     // sort-of-like-assignment-op
-- 
2.1.1

