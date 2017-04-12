From: Yang Joseph <joseph.yang@xtaotech.com>
Subject: cephfs: Normal user of our fs can damage the whole system by writing
 huge xattr kv pairs
Date: Wed, 12 Apr 2017 10:46:50 +0800
Message-ID: <58ED951A.5090907@xtaotech.com>
References: <58AE75D9.4080209@xtaotech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mr213139.mail.yeah.net ([223.252.213.139]:53058 "EHLO
        mr213139.mail.yeah.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751608AbdDLCrQ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Apr 2017 22:47:16 -0400
In-Reply-To: <58AE75D9.4080209@xtaotech.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: john.spray@redhat.com, zyan@redhat.com
Cc: ceph-devel <ceph-devel@vger.kernel.org>

hello,

Normal user of our fs can damage the whole system by writing huge xattr 
kv pairs. I think this is a serious bug. Your quick reply can help me to 
fix this bug as soon as possible. Thank you for your time to review this 
patch.

- Yang Honggang

-------- Forwarded Message --------
Subject: 	cephfs: fix write_buf's _len overflow problem
Date: 	Thu, 23 Feb 2017 13:40:41 +0800
From: 	Yang Joseph <joseph.yang@xtaotech.com>
To: 	john.spray@redhat.com
CC: 	ceph-devel <ceph-devel@vger.kernel.org>, peng.hse 
<peng.hse@xtaotech.com>



Hello,

After I have set about 400 64KB xattr kv pairs to a file,
mds is crashed. Every time I try to start mds, it will crash again.
The root reason is write_buf._len overflowed when doing
Journaler::append_entry().

my suggestions:

|1. limit file/dir's xattr size 2. throttle journal entry append
operations 3. add bufferlist _len overflow checking|


*bug analysis*: http://tracker.ceph.com/issues/19033

*proposed fix*: https://github.com/ceph/ceph/pull/13587

Looking forward to your reply and comments.

Thx,

Yang Honggang

-------------- patch begin // master branch -----
diff --git a/src/common/buffer.cc b/src/common/buffer.cc
index 883e713..99b380d 100644
--- a/src/common/buffer.cc
+++ b/src/common/buffer.cc
@@ -984,6 +984,7 @@ static simple_spinlock_t buffer_debug_lock =
SIMPLE_SPINLOCK_INITIALIZER;
       char* ptr = _raw->data + _off + _len;
       *ptr = c;
_len++;
+    assert(_len != 0);
       return _len + _off;
}

@@ -994,6 +995,7 @@ static simple_spinlock_t buffer_debug_lock =
SIMPLE_SPINLOCK_INITIALIZER;
       char* c = _raw->data + _off + _len;
       maybe_inline_memcpy(c, p, l, 32);
       _len += l;
+    assert(_len >= l);
       return _len + _off;
     }

@@ -1707,6 +1709,7 @@ static simple_spinlock_t buffer_debug_lock =
SIMPLE_SPINLOCK_INITIALIZER;
     {
       // steal the other guy's buffers
       _len += bl._len;
+    assert(_len >= bl._len);
       if (!(flags & CLAIM_ALLOW_NONSHAREABLE))
         bl.make_shareable();
       _buffers.splice(_buffers.end(), bl._buffers );
@@ -1718,6 +1721,7 @@ static simple_spinlock_t buffer_debug_lock =
SIMPLE_SPINLOCK_INITIALIZER;
     {
       // steal the other guy's buffers
       _len += bl._len;
+    assert(_len >= bl._len);
       if (!(flags & CLAIM_ALLOW_NONSHAREABLE))
         bl.make_shareable();
       _buffers.splice(_buffers.begin(), bl._buffers );
@@ -1832,6 +1836,7 @@ static simple_spinlock_t buffer_debug_lock =
SIMPLE_SPINLOCK_INITIALIZER;
          // yay contiguous with tail bp!
          l.set_length(l.length()+len);
          _len += len;
+        assert(_len >= len);
          return;
         }
       }
@@ -1842,6 +1847,7 @@ static simple_spinlock_t buffer_debug_lock =
SIMPLE_SPINLOCK_INITIALIZER;
     void buffer::list::append(const list& bl)
     {
       _len += bl._len;
+    assert(_len >= bl._len);
       for (std::list<ptr>::const_iterator p = bl._buffers.begin();
           p != bl._buffers.end();
           ++p)
@@ -2038,6 +2044,7 @@ static simple_spinlock_t buffer_debug_lock =
SIMPLE_SPINLOCK_INITIALIZER;
         //cout << "keeping front " << off << " of " << *curbuf << std::endl;
         _buffers.insert( curbuf, ptr( *curbuf, 0, off ) );
         _len += off;
+      assert(_len >= off);
       }

       while (len > 0) {
diff --git a/src/common/config_opts.h b/src/common/config_opts.h
index 3a27dbe..01336e5 100644
--- a/src/common/config_opts.h
+++ b/src/common/config_opts.h
@@ -485,6 +485,7 @@ OPTION(journaler_batch_interval, OPT_DOUBLE, .001)
// seconds.. max add latenc
   OPTION(journaler_batch_max, OPT_U64, 0)  // max bytes we'll delay
flushing; disable, for now....
   OPTION(mds_data, OPT_STR, "/var/lib/ceph/mds/$cluster-$id")
   OPTION(mds_max_file_size, OPT_U64, 1ULL << 40) // Used when creating
new CephFS. Change with 'ceph mds set max_file_size <size>' afterwards
+OPTION(mds_max_xattr_pairs_size, OPT_U32, 1 << 16) // max xattr kv
pairs size for each dir/file
   OPTION(mds_cache_size, OPT_INT, 100000)
   OPTION(mds_cache_mid, OPT_FLOAT, .7)
   OPTION(mds_max_file_recover, OPT_U32, 32)
diff --git a/src/include/buffer.h b/src/include/buffer.h
index a016bab..a997b4e 100644
--- a/src/include/buffer.h
+++ b/src/include/buffer.h
@@ -729,12 +729,14 @@ namespace buffer CEPH_BUFFER_API {
          return;
         _buffers.push_front(bp);
         _len += bp.length();
+      assert(_len >= bp.length());
       }
       void push_front(ptr&& bp) {
         if (bp.length() == 0)
          return;
         _len += bp.length();
         _buffers.push_front(std::move(bp));
+      assert(_len >= bp.length());
       }
       void push_front(raw *r) {
         push_front(ptr(r));
@@ -744,11 +746,13 @@ namespace buffer CEPH_BUFFER_API {
          return;
         _buffers.push_back(bp);
         _len += bp.length();
+      assert(_len >= bp.length());
       }
       void push_back(ptr&& bp) {
         if (bp.length() == 0)
          return;
         _len += bp.length();
+      assert(_len >= bp.length());
         _buffers.push_back(std::move(bp));
       }
       void push_back(raw *r) {
diff --git a/src/mds/Server.cc b/src/mds/Server.cc
index 539b7a8..9ddf852 100644
--- a/src/mds/Server.cc
+++ b/src/mds/Server.cc
@@ -3416,7 +3416,7 @@ void Server::handle_client_readdir(MDRequestRef& mdr)
       max = dir->get_num_any();  // whatever, something big.
     unsigned max_bytes = req->head.args.readdir.max_bytes;
     if (!max_bytes)
-    max_bytes = 512 << 10;  // 512 KB?
+    max_bytes = (512 << 10) + g_conf->mds_max_xattr_pairs_size;  //
make sure at least one item can be encoded

     // start final blob
     bufferlist dirbl;
@@ -4535,6 +4535,25 @@ void Server::handle_client_setxattr(MDRequestRef&
mdr)
       return;

     map<string, bufferptr> *pxattrs = cur->get_projected_xattrs();
+  size_t len = req->get_data().length();
+  size_t inc = len + name.length();
+
+  // check xattrs kv pairs size
+  size_t cur_xattrs_size = 0;
+  for (map<string, bufferptr>::iterator p = pxattrs->begin();
+          p != pxattrs->end(); p++) {
+    if ((flags & CEPH_XATTR_REPLACE) && (name.compare(p->first) == 0)) {
+      continue;
+    }
+    cur_xattrs_size += p->first.length() + p->second.length();
+  }
+  if (((cur_xattrs_size + inc) > g_conf->mds_max_xattr_pairs_size)) {
+    dout(10) << "xattr kv pairs size too big. cur_xattrs_size " <<
cur_xattrs_size
+                << ", inc " << inc << dendl;
+    respond_to_request(mdr, -ENOSPC);
+    return;
+  }
+
     if ((flags & CEPH_XATTR_CREATE) && pxattrs->count(name)) {
       dout(10) << "setxattr '" << name << "' XATTR_CREATE and EEXIST on
" << *cur << dendl;
       respond_to_request(mdr, -EEXIST);
@@ -4546,7 +4565,6 @@ void Server::handle_client_setxattr(MDRequestRef& mdr)
       return;
     }

-  int len = req->get_data().length();
     dout(10) << "setxattr '" << name << "' len " << len << " on " <<
*cur << dendl;

     // project update
@@ -8025,7 +8043,7 @@ void Server::handle_client_lssnap(MDRequestRef& mdr)
       max_entries = infomap.size();
     int max_bytes = req->head.args.readdir.max_bytes;
     if (!max_bytes)
-    max_bytes = 512 << 10;
+    max_bytes = (512 << 10) + g_conf->mds_max_xattr_pairs_size;  //
make sure at least one item can be encoded

     __u64 last_snapid = 0;
     string offset_str = req->get_path2();
diff --git a/src/osdc/Journaler.cc b/src/osdc/Journaler.cc
index 8d2b33a..132d4cf 100644
--- a/src/osdc/Journaler.cc
+++ b/src/osdc/Journaler.cc
@@ -537,7 +537,7 @@ void Journaler::_finish_flush(int r, uint64_t start,
ceph::real_time stamp)

   uint64_t Journaler::append_entry(bufferlist& bl)
   {
-  lock_guard l(lock);
+  unique_lock l(lock);

     assert(!readonly);
     uint32_t s = bl.length();
@@ -556,6 +556,13 @@ uint64_t Journaler::append_entry(bufferlist& bl)
         bufferptr bp(write_pos - owp);
         bp.zero();
         assert(bp.length() >= 4);
+      if (!write_buf_throttle.get_or_fail(bp.length())) {
+        l.unlock();
+        ldout(cct, 10) << "write_buf_throttle wait, bp len " <<
bp.length() << dendl;
+        write_buf_throttle.get(bp.length());
+        l.lock();
+      }
+      ldout(cct, 20) << "write_buf_throttle get, bp len " <<
bp.length() << dendl;
         write_buf.push_back(bp);

         // now flush.
@@ -569,6 +576,14 @@ uint64_t Journaler::append_entry(bufferlist& bl)


     // append
+  size_t delta = bl.length() + journal_stream.get_envelope_size();
+  if (!write_buf_throttle.get_or_fail(delta)) { // write_buf space is
nearly full
+    l.unlock();
+    ldout(cct, 10) << "write_buf_throttle wait, delta " << delta << dendl;
+    write_buf_throttle.get(delta);
+    l.lock();
+  }
+  ldout(cct, 20) << "write_buf_throttle get, delta " << delta << dendl;
     size_t wrote = journal_stream.write(bl, &write_buf, write_pos);
     ldout(cct, 10) << "append_entry len " << s << " to " << write_pos << "~"
                   << wrote << dendl;
@@ -598,7 +613,7 @@ void Journaler::_do_flush(unsigned amount)
     assert(!readonly);

     // flush
-  unsigned len = write_pos - flush_pos;
+  uint64_t len = write_pos - flush_pos;
     assert(len == write_buf.length());
     if (amount && amount < len)
       len = amount;
@@ -654,7 +669,9 @@ void Journaler::_do_flush(unsigned amount)

     flush_pos += len;
     assert(write_buf.length() == write_pos - flush_pos);
-
+  write_buf_throttle.put(len);
+  ldout(cct, 20) << "write_buf_throttle put, len " << len << dendl;
+
     ldout(cct, 10)
       << "_do_flush (prezeroing/prezero)/write/flush/safe pointers now at "
       << "(" << prezeroing_pos << "/" << prezero_pos << ")/" << write_pos
diff --git a/src/osdc/Journaler.h b/src/osdc/Journaler.h
index 6c7e7cf..3831b86 100644
--- a/src/osdc/Journaler.h
+++ b/src/osdc/Journaler.h
@@ -64,7 +64,7 @@
   #include "Filer.h"

   #include "common/Timer.h"
-
+#include "common/Throttle.h"

   class CephContext;
   class Context;
@@ -113,6 +113,13 @@ class JournalStream
     bool readable(bufferlist &bl, uint64_t *need) const;
     size_t read(bufferlist &from, bufferlist *to, uint64_t *start_ptr);
     size_t write(bufferlist &entry, bufferlist *to, uint64_t const
&start_ptr);
+  size_t get_envelope_size() const {
+     if (format >= JOURNAL_FORMAT_RESILIENT) {
+       return JOURNAL_ENVELOPE_RESILIENT;
+     } else {
+       return JOURNAL_ENVELOPE_LEGACY;
+     }
+  }

     // A magic number for the start of journal entries, so that we can
     // identify them in damaged journals.
@@ -295,6 +302,8 @@ private:
     bufferlist write_buf; ///< write buffer.  flush_pos +
                          ///  write_buf.length() == write_pos.

+  Throttle write_buf_throttle; // protect write_buf from bufferlist
_len overflow
+
     bool waiting_for_zero;
     interval_set<uint64_t> pending_zero;  // non-contig bits we've zeroed
     std::set<uint64_t> pending_safe;
@@ -390,6 +399,7 @@ public:
       timer(tim), delay_flush_event(0),
       state(STATE_UNDEF), error(0),
       prezeroing_pos(0), prezero_pos(0), write_pos(0), flush_pos(0),
safe_pos(0),
+    write_buf_throttle(cct, "write_buf_throttle", UINT_MAX - (UINT_MAX
  >> 3)),
       waiting_for_zero(false),
       read_pos(0), requested_pos(0), received_pos(0),
       fetch_len(0), temp_fetch_len(0),
--------------- patch end ---------------------------



