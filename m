From: Andrew Shewmaker <agshew@gmail.com>
Subject: [PATCH V6 2/5] Initial support for blkin (LTTng + Zipkin) tracing
Date: Tue, 10 Mar 2015 19:43:27 -0700
Message-ID: <1426041810-3942-3-git-send-email-agshew@gmail.com>
References: <1426041810-3942-1-git-send-email-agshew@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:37887 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750920AbbCKCoH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Mar 2015 22:44:07 -0400
Received: by paceu11 with SMTP id eu11so7390400pac.4
        for <ceph-devel@vger.kernel.org>; Tue, 10 Mar 2015 19:44:06 -0700 (PDT)
In-Reply-To: <1426041810-3942-1-git-send-email-agshew@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: agshew@gmail.com, marioskogias@gmail.com, chendi.xue@intel.com

 * Adds conditional build support.
 * Adds BLKIN_* macro wrappers to reduce need for ifdef WITH_BLKIN.
 * Adds blkin header include.
 * Adds message infrastructure for blkin tracing.
 * Adds blkin trace events and keyvals to OpTracker.
 * Adds osd, pg, journal, and filestore blkin traces to OpTracker/OpRequest.

These changes are Marios', with the following exceptions:
 * split out initial support for Marios' additional tracing changes
 * conditional build and BLKIN_* macro wrappers
 * blkin include path is "blkin/ztracer.hpp"
 * only Message.h includes blkin, as others include Message.h
 * commented code has been removed
 * unused lname var/code in SimpleMessenger has been removed
 * excluded messenger_trace because it appears not to be used
 * braces added to conditionals to match recommended coding style
   note: did not change member variable names to use m_ prefix
         since member vars in same class did not
 * Ref suffix added to TrackedOp shared_ptr vars to be consistent
   note: did not add -Ref suffix to ZTrace*Ref vars in Message
 * TrackedOp trace creation methods are virtual, implemented in OpRequest
 * avoid faults due to non-existent traces
   Check if osd_trace exists when creating a pg_trace, etc.
   Return true only if trace creation was successful.
   Use dout() if trace_osd, trace_pg, etc. fail, in order to ease debugging.

Signed-off-by: Marios-Evaggelos Kogias <marioskogias@gmail.com>
Signed-off-by: Filippos Giannakos <philipgian@grnet.gr>
Signed-off-by: Andrew Shewmaker <agshew@gmail.com>
Signed-off-by: Chendi.Xue <chendi.xue@intel.com>
---
 src/common/TrackedOp.cc           |  82 ++++++++++++++++++
 src/common/TrackedOp.h            |  26 ++++++
 src/common/blkin_wrapper.h        | 171 ++++++++++++++++++++++++++++++++++++++
 src/msg/Message.cc                |  76 +++++++++++++++++
 src/msg/Message.h                 |  25 ++++++
 src/msg/msg_types.cc              |  23 ++++-
 src/msg/msg_types.h               |   1 +
 src/msg/simple/Pipe.cc            |  31 +++++++
 src/msg/simple/Pipe.h             |   4 +
 src/msg/simple/SimpleMessenger.cc |   1 +
 10 files changed, 437 insertions(+), 3 deletions(-)
 create mode 100644 src/common/blkin_wrapper.h

diff --git a/src/common/TrackedOp.cc b/src/common/TrackedOp.cc
index 32dbc53..611911f 100644
--- a/src/common/TrackedOp.cc
+++ b/src/common/TrackedOp.cc
@@ -293,8 +293,22 @@ void OpTracker::_mark_event(TrackedOp *op, const string &evt,
      
 }
 
+#ifdef WITH_BLKIN
+void OpTracker::trace_event(TrackedOp *op, TrackedOpTraceRef t, const string &evt, TrackedOpEndpointRef ep)
+{
+  t->event(evt, ep);
+}
+
+void OpTracker::trace_keyval(TrackedOp *op, TrackedOpTraceRef t, const string &key,
+			     const string &val, TrackedOpEndpointRef ep)
+{
+  t->keyval(key, val, ep);
+}
+#endif
+
 void OpTracker::RemoveOnDelete::operator()(TrackedOp *op) {
   op->mark_event("done");
+  BLKIN_OP_TRACE_EVENT(op, osd, "span_ended");
   if (!tracker->tracking_enabled) {
     op->_unregistered();
     delete op;
@@ -332,3 +346,71 @@ void TrackedOp::dump(utime_t now, Formatter *f) const
     f->close_section();
   }
 }
+
+#ifdef WITH_BLKIN
+void TrackedOp::trace_osd(string event)
+{
+  if (!osd_trace) {
+    dout(5) << "trace_osd failed, osd_trace doesn't exist, event: " << event << dendl;
+    return;
+  }
+
+  tracker->trace_event(this, osd_trace, event, osd_trace->get_endpoint());
+}
+
+void TrackedOp::trace_osd(string key, string val)
+{
+  if (!osd_trace) {
+    dout(5) << "trace_osd failed, osd_trace doesn't exist, key: " << key << " val: " << val << dendl;
+    return;
+  }
+
+  tracker->trace_keyval(this, osd_trace, key, val, osd_trace->get_endpoint());
+}
+
+void TrackedOp::trace_pg(string event)
+{
+  if (!pg_trace) {
+    dout(5) << "trace_pg failed, pg_trace doesn't exist, event: " << event << dendl;
+    return;
+  } else if (!osd_trace) {
+    dout(5) << "trace_pg failed, osd_trace doesn't exist, event: " << event << dendl;
+    return;
+  }
+
+  tracker->trace_event(this, osd_trace, event, pg_trace->get_endpoint());
+}
+
+void TrackedOp::get_pg_trace_info(struct blkin_trace_info *info)
+{
+  if (!pg_trace) {
+    dout(5) << "get_pg_trace failed, pg_trace doesn't exist" << dendl;
+    return;
+  } else if (!osd_trace) {
+    dout(5) << "get_pg_trace failed, osd_trace doesn't exist" << dendl;
+    return;
+  }
+
+  osd_trace->get_trace_info(info);
+}
+
+void TrackedOp::trace_journal(string event)
+{
+  if (!journal_trace) {
+    dout(5) << "trace_journal failed, journal_trace doesn't exist, event: " << event << dendl;
+    return;
+  }
+
+  tracker->trace_event(this, journal_trace, event, journal_trace->get_endpoint());
+}
+
+void TrackedOp::trace_filestore(string event)
+{
+  if (!filestore_trace) {
+    dout(5) << "trace_filestore failed, filestore_trace doesn't exist, event: " << event << dendl;
+    return;
+  }
+
+  tracker->trace_event(this, filestore_trace, event, filestore_trace->get_endpoint());
+}
+#endif // WITH_BLKIN
diff --git a/src/common/TrackedOp.h b/src/common/TrackedOp.h
index 42d1eaf..fc861f7 100644
--- a/src/common/TrackedOp.h
+++ b/src/common/TrackedOp.h
@@ -116,6 +116,11 @@ public:
   void mark_event(TrackedOp *op, const string &evt,
                           utime_t time = ceph_clock_now(g_ceph_context));
 
+#ifdef WITH_BLKIN
+  void trace_event(TrackedOp *op, TrackedOpTraceRef t, const string &evt, TrackedOpEndpointRef ep);
+  void trace_keyval(TrackedOp *op, TrackedOpTraceRef t, const string &key,
+		    const string &val, TrackedOpEndpointRef ep);
+#endif
   void on_shutdown() {
     history.on_shutdown();
   }
@@ -150,6 +155,13 @@ protected:
   string current; /// the current state the event is in
   uint64_t seq; /// a unique value set by the OpTracker
 
+#ifdef WITH_BLKIN
+  TrackedOpTraceRef osd_trace;
+  TrackedOpTraceRef pg_trace;
+  TrackedOpTraceRef journal_trace;
+  TrackedOpTraceRef filestore_trace;
+#endif
+
   uint32_t warn_interval_multiplier; // limits output of a given op warning
 
   TrackedOp(OpTracker *_tracker, const utime_t& initiated) :
@@ -191,6 +203,20 @@ public:
     return events.rbegin()->second.c_str();
   }
   void dump(utime_t now, Formatter *f) const;
+
+#ifdef WITH_BLKIN
+  virtual bool create_osd_trace(TrackedOpEndpointRef ep) { return false; }
+  virtual bool create_pg_trace(TrackedOpEndpointRef ep) { return false; }
+  virtual bool create_journal_trace(TrackedOpEndpointRef ep) { return false; }
+  virtual bool create_filestore_trace(TrackedOpEndpointRef ep) { return false; }
+  void trace_osd(string event);
+  void trace_osd(string key, string val);
+  void trace_pg(string event);
+  void get_pg_trace_info(struct blkin_trace_info *info);
+  void trace_journal(string event);
+  void trace_filestore(string event);
+  TrackedOpTraceRef get_osd_trace() { return osd_trace; };
+#endif // WITH_BLKIN
 };
 
 #endif
diff --git a/src/common/blkin_wrapper.h b/src/common/blkin_wrapper.h
new file mode 100644
index 0000000..04b8ced
--- /dev/null
+++ b/src/common/blkin_wrapper.h
@@ -0,0 +1,171 @@
+// -*- mode:C++; tab-width:8; c-basic-offset:2; indent-tabs-mode:t -*-
+// vim: ts=8 sw=2 smarttab
+#ifdef WITH_BLKIN
+
+// string helper
+#define BLKIN_OSS(OSS, A) \
+  ostringstream OSS; \
+  OSS << A;
+
+// src/msg/Message.h
+#define BLKIN_GET_MASTER(MT) \
+  ZTracer::ZTraceRef MT = get_master_trace();
+
+#define BLKIN_MSG_GET_MASTER(MT, MSG) \
+  ZTracer::ZTraceRef MT = (MSG)->get_master_trace();
+
+#define BLKIN_ZTRACE_INIT() do { ZTracer::ztrace_init(); } while(0)
+
+#define BLKIN_INIT_TRACE(T) do { init_trace_info(T); } while(0)
+
+#define BLKIN_MSG_INIT_TRACE(M, T) do { (M)->init_trace_info(T); } while(0)
+
+#define BLKIN_MSG_INIT_TRACE_IF(C, M, T) \
+  do { if (C) (M)->init_trace_info(T); } while(0)
+
+#define BLKIN_MSG_DO_INIT_TRACE() \
+  struct blkin_trace_info tinfo; \
+  tinfo.trace_id = 0; \
+  tinfo.span_id = 0; \
+  tinfo.parent_span_id = 0;
+
+#define BLKIN_MSG_ENCODE_TRACE() \
+  do { \
+    if (mt) { \
+      struct blkin_trace_info tinfo; \
+      mt->get_trace_info(&tinfo); \
+      ::encode(tinfo.trace_id, payload); \
+      ::encode(tinfo.span_id, payload); \
+      ::encode(tinfo.parent_span_id, payload); \
+    } else { \
+      int64_t zero = 0; \
+      ::encode(zero, payload); \
+      ::encode(zero, payload); \
+      ::encode(zero, payload); \
+    }; \
+  } while(0)
+
+#define BLKIN_MSG_DECODE_TRACE(V) \
+  do { \
+    if (header.version >= V) { \
+      ::decode(tinfo.trace_id, p); \
+      ::decode(tinfo.span_id, p); \
+      ::decode(tinfo.parent_span_id, p); \
+    }; \
+    init_trace_info(&tinfo); \
+  } while(0)
+
+#define BLKIN_MSG_CHECK_SPAN() \
+  do { \
+    struct blkin_trace_info tinfo; \
+    ZTracer::ZTraceRef mt = req->get_master_trace(); \
+    assert(mt != NULL); \
+    mt->get_trace_info(&tinfo); \
+  } while(0)
+
+#define BLKIN_MSG_INFO_DECL(TYPE) \
+  void trace_msg_info() \
+  { \
+    assert(master_trace != NULL); \
+    ostringstream oss; \
+    oss << get_reqid(); \
+    master_trace->keyval("Type", TYPE); \
+    master_trace->keyval("Reqid", oss.str()); \
+  }
+
+#define BLKIN_MSG_END_DECL(TYPE) \
+  bool create_message_endpoint() \
+  { \
+    message_endpoint = ZTracer::create_ZTraceEndpoint("0.0.0.0", 0, TYPE); \
+    assert(message_endpoint != NULL); \
+    return true; \
+  }
+
+#define BLKIN_MSG_END(EP, IP, PORT, NAME) \
+  do { \
+    EP = ZTracer::create_ZTraceEndpoint(IP, PORT, NAME); \
+  } while(0)
+
+#define BLKIN_MSG_TRACE_EVENT(M, E) do { (M)->trace(E); } while(0)
+
+#define BLKIN_MSG_TRACE_EVENT_IF(C, M, E) do { if (C) (M)->trace(E); } while(0)
+
+#define BLKIN_MSG_TRACE_KEYVAL(M, K, V) do { (M)->trace(K, V); } while(0)
+
+// src/msg/Pipe.h
+#define BLKIN_PIPE_ENDPOINT() do { set_endpoint(); } while(0)
+
+// src/common/TrackedOp.h
+typedef ZTracer::ZTraceEndpointRef TrackedOpEndpointRef;
+typedef ZTracer::ZTraceRef TrackedOpTraceRef;
+
+#define BLKIN_END_REF(X) TrackedOpEndpointRef X;
+#define BLKIN_TRACE_REF(X) TrackedOpTraceRef X;
+
+#define BLKIN_CREATE_TRACE(REF, ...) \
+  do { REF = ZTracer::create_ZTrace(__VA_ARGS__); } while(0)
+
+#define BLKIN_OP_CREATE_TRACE(OP, TYPE, EP) \
+  do { (OP)->create_ ## TYPE ## _trace(EP); } while(0)
+
+#define BLKIN_OP_TRACE_EVENT(OP, TYPE, E) \
+  do { (OP)->trace_ ## TYPE (E); } while(0)
+
+#define BLKIN_TYPE_TRACE_EVENT(TYPE, E) \
+  do { trace_ ## TYPE (E); } while(0)
+
+#define BLKIN_OP_TRACE_KEYVAL(OP, TYPE, K, V) \
+  do { (OP)->trace_ ## TYPE (K, V); } while(0)
+
+#define BLKIN_OP_EVENT(O, E) do { (O)->event(E); } while(0)
+
+#define BLKIN_OP_EVENT_IF(C, O, E) do { if (C) (O)->event(E); } while(0)
+
+#define BLKIN_OP_SET_TRACE_DECL() \
+  void set_trace(TrackedOpTraceRef t) \
+  { \
+    trace = t; \
+  }
+
+#define BLKIN_OP_SET_TRACE(O, T) do { (O)->set_trace(T); } while(0)
+
+#else // Not WITH_BLKIN
+
+// string helper
+#define BLKIN_OSS(OSS, A) do { } while(0)
+
+// src/msg/Message.h
+#define BLKIN_GET_MASTER(MT) do { } while(0)
+#define BLKIN_MSG_GET_MASTER(MT, MSG) do { } while(0)
+#define BLKIN_ZTRACE_INIT() do { } while(0)
+#define BLKIN_INIT_TRACE(T) do { } while(0)
+#define BLKIN_MSG_INIT_TRACE(M, T) do { } while(0)
+#define BLKIN_MSG_INIT_TRACE_IF(C, M, T) do { } while(0)
+#define BLKIN_MSG_DO_INIT_TRACE() do { } while(0)
+#define BLKIN_MSG_ENCODE_TRACE() do { } while(0)
+#define BLKIN_MSG_DECODE_TRACE(V) do { } while(0)
+#define BLKIN_MSG_CHECK_SPAN() do { } while(0)
+#define BLKIN_MSG_INFO_DECL(TYPE)
+#define BLKIN_MSG_END_DECL(TYPE)
+#define BLKIN_MSG_END(EP, IP, PORT, NAME) do { } while(0)
+#define BLKIN_MSG_TRACE_EVENT(M, E) do { } while(0)
+#define BLKIN_MSG_TRACE_EVENT_IF(C, M, E) do { } while(0)
+#define BLKIN_MSG_TRACE_KEYVAL(M, K, V) do { } while(0)
+
+// src/msg/Pipe.h
+#define BLKIN_PIPE_ENDPOINT() do { } while(0)
+
+// src/common/TrackedOp.h
+#define BLKIN_END_REF(X)
+#define BLKIN_TRACE_REF(X)
+#define BLKIN_CREATE_TRACE(REF, ...) do { } while(0)
+#define BLKIN_OP_CREATE_TRACE(OP, TYPE, EP) do { } while(0)
+#define BLKIN_OP_TRACE_EVENT(OP, TYPE, E) do { } while(0)
+#define BLKIN_TYPE_TRACE_EVENT(TYPE, E) do { } while(0)
+#define BLKIN_OP_TRACE_KEYVAL(OP, TYPE, K, V) do { } while(0)
+#define BLKIN_OP_EVENT(O, E) do { } while(0)
+#define BLKIN_OP_EVENT_IF(C, O, E) do { } while(0)
+#define BLKIN_OP_SET_TRACE_DECL()
+#define BLKIN_OP_SET_TRACE(O, T) do { } while(0)
+
+#endif // WITH_BLKIN
diff --git a/src/msg/Message.cc b/src/msg/Message.cc
index 23f5179..968d368 100644
--- a/src/msg/Message.cc
+++ b/src/msg/Message.cc
@@ -817,3 +817,79 @@ Message *decode_message(CephContext *cct, int crcflags, bufferlist::iterator& p)
   return decode_message(cct, crcflags, h, f, fr, mi, da);
 }
 
+#ifdef WITH_BLKIN
+int Message::trace_basic_info()
+{
+  if (!master_trace) {
+    return 0;
+  }
+
+  master_trace->event("Message allocated");
+  trace_msg_info();
+  return 0;
+}
+
+int Message::init_trace_info()
+{
+  create_message_endpoint();
+  master_trace = ZTracer::create_ZTrace("Main", message_endpoint);
+  if (!master_trace) {
+    return -ENOMEM;
+  }
+
+  return trace_basic_info();
+}
+
+int Message::init_trace_info(ZTracer::ZTraceRef t)
+{
+  if (!t) {
+    return -EINVAL;
+  }
+
+  create_message_endpoint();
+  master_trace = ZTracer::create_ZTrace("Main", t, message_endpoint);
+  if (!master_trace) {
+    return -ENOMEM;
+  }
+
+  return trace_basic_info();
+}
+
+int Message::init_trace_info(struct blkin_trace_info *tinfo)
+{
+  if (!(tinfo->trace_id == 0 && tinfo->span_id == 0 && tinfo->parent_span_id == 0)) {
+    create_message_endpoint();
+    master_trace = ZTracer::create_ZTrace("Main", message_endpoint, tinfo);
+    return trace_basic_info();
+  }
+  return init_trace_info();
+}
+
+void Message::trace(string event)
+{
+  if (!master_trace) {
+    return;
+  }
+
+  master_trace->event(event);
+}
+
+void Message::trace(string key, string val)
+{
+  if (!master_trace) {
+    return;
+  }
+
+  master_trace->keyval(key, val);
+}
+
+bool Message::create_message_endpoint()
+{
+  message_endpoint = ZTracer::create_ZTraceEndpoint("0.0.0.0", 0, "NaN");
+  if (!message_endpoint) {
+    return false;
+  }
+
+  return true;
+}
+#endif // WITH_BLKIN
diff --git a/src/msg/Message.h b/src/msg/Message.h
index ddba0e5..a7c1e54 100644
--- a/src/msg/Message.h
+++ b/src/msg/Message.h
@@ -18,6 +18,11 @@
 #include <stdlib.h>
 #include <ostream>
 
+#ifdef WITH_BLKIN
+#include <ztracer.hpp>
+#endif
+#include "common/blkin_wrapper.h"
+
 #include <boost/intrusive_ptr.hpp>
 #include <boost/intrusive/list.hpp>
 // Because intusive_ptr clobbers our assert...
@@ -257,6 +262,10 @@ protected:
   // currently throttled.
   uint64_t dispatch_throttle_size;
 
+#ifdef WITH_BLKIN
+  ZTracer::ZTraceEndpointRef message_endpoint;
+  ZTracer::ZTraceRef master_trace;
+#endif
   friend class Messenger;
 
 public:
@@ -270,6 +279,7 @@ public:
     memset(&header, 0, sizeof(header));
     memset(&footer, 0, sizeof(footer));
   }
+
   Message(int t, int version=1, int compat_version=0)
     : connection(NULL),
       magic(0),
@@ -326,6 +336,10 @@ public:
   uint32_t get_magic() const { return magic; }
   void set_magic(int _magic) { magic = _magic; }
 
+#ifdef WITH_BLKIN
+  ZTracer::ZTraceRef get_master_trace() { return master_trace; }
+#endif // WITH_BLKIN
+
   /*
    * If you use get_[data, middle, payload] you shouldn't
    * use it to change those bufferlists unless you KNOW
@@ -457,6 +471,17 @@ public:
   virtual void dump(Formatter *f) const;
 
   void encode(uint64_t features, int crcflags);
+
+#ifdef WITH_BLKIN
+  int init_trace_info();
+  int init_trace_info(struct blkin_trace_info *tinfo);
+  int init_trace_info(ZTracer::ZTraceRef t);
+  void trace(string event);
+  void trace(string key, string val);
+  int trace_basic_info();
+  virtual void trace_msg_info() { };
+  virtual bool create_message_endpoint();
+#endif // WITH_BLKIN
 };
 typedef boost::intrusive_ptr<Message> MessageRef;
 
diff --git a/src/msg/msg_types.cc b/src/msg/msg_types.cc
index b02db76..ba36b8d 100644
--- a/src/msg/msg_types.cc
+++ b/src/msg/msg_types.cc
@@ -132,7 +132,7 @@ bool entity_addr_t::parse(const char *s, const char **end)
 
 
 
-ostream& operator<<(ostream& out, const sockaddr_storage &ss)
+int ss_to_string(const sockaddr_storage &ss, string &host, int &port)
 {
   char buf[NI_MAXHOST] = { 0 };
   char serv[NI_MAXSERV] = { 0 };
@@ -147,8 +147,25 @@ ostream& operator<<(ostream& out, const sockaddr_storage &ss)
   getnameinfo((struct sockaddr *)&ss, hostlen, buf, sizeof(buf),
 	      serv, sizeof(serv),
 	      NI_NUMERICHOST | NI_NUMERICSERV);
+  host = buf;
+  port = atoi(serv);
+  return 0;
+}
+
+int entity_addr_t::to_string(string &host, int &port)
+{
+  return ss_to_string(addr, host, port);
+}
+
+
+ostream& operator<<(ostream& out, const sockaddr_storage &ss)
+{
+  string host;
+  int port;
+
+  ss_to_string(ss, host, port);
   if (ss.ss_family == AF_INET6)
-    return out << '[' << buf << "]:" << serv;
+    return out << '[' << host << "]:" << port;
   return out //<< ss.ss_family << ":"
-	     << buf << ':' << serv;
+	     << host << ':' << port;
 }
diff --git a/src/msg/msg_types.h b/src/msg/msg_types.h
index 9c0f266..ac32c85 100644
--- a/src/msg/msg_types.h
+++ b/src/msg/msg_types.h
@@ -336,6 +336,7 @@ struct entity_addr_t {
   }
 
   void dump(Formatter *f) const;
+  int to_string(string &host, int &port);
 
   static void generate_test_instances(list<entity_addr_t*>& o);
 };
diff --git a/src/msg/simple/Pipe.cc b/src/msg/simple/Pipe.cc
index 40bf41b..c1e411d 100644
--- a/src/msg/simple/Pipe.cc
+++ b/src/msg/simple/Pipe.cc
@@ -114,6 +114,7 @@ Pipe::Pipe(SimpleMessenger *r, int st, PipeConnection *con)
 
   recv_max_prefetch = msgr->cct->_conf->ms_tcp_prefetch_max_size;
   recv_buf = new char[recv_max_prefetch];
+  BLKIN_PIPE_ENDPOINT();
 }
 
 Pipe::~Pipe()
@@ -124,6 +125,33 @@ Pipe::~Pipe()
   delete[] recv_buf;
 }
 
+#ifdef WITH_BLKIN
+void Pipe::set_endpoint()
+{
+  string type;
+  entity_inst_t inst = msgr->get_myinst();
+
+  if (inst.name.is_client()) {
+    type = "MON";
+  } else if (inst.name.is_mds()) {
+    type = "MDS";
+  } else if (inst.name.is_osd()) {
+    type = "OSD";
+  } else if (inst.name.is_client()) {
+    type = "CLIENT";
+  } else {
+    type = "UNKNOWN";
+  }
+
+  string host;
+  int port;
+
+  inst.addr.to_string(host, port);
+
+  pipe_endpoint = ZTracer::create_ZTraceEndpoint(host, port, "Messenger-" + type);
+}
+#endif // WITH_BLKIN
+
 void Pipe::handle_ack(uint64_t seq)
 {
   lsubdout(msgr->cct, ms, 15) << "reader got ack seq " << seq << dendl;
@@ -1587,6 +1615,7 @@ void Pipe::reader()
 	  fault(true);
 	continue;
       }
+      BLKIN_MSG_TRACE_EVENT(m, "message_read");
 
       if (state == STATE_CLOSED ||
 	  state == STATE_CONNECTING) {
@@ -1822,6 +1851,8 @@ void Pipe::writer()
 
         pipe_lock.Unlock();
 
+	BLKIN_MSG_TRACE_EVENT(m, "writer_sending");
+
         ldout(msgr->cct,20) << "writer sending " << m->get_seq() << " " << m << dendl;
 	int rc = write_message(header, footer, blist);
 
diff --git a/src/msg/simple/Pipe.h b/src/msg/simple/Pipe.h
index ddfa99f..0e31bb3 100644
--- a/src/msg/simple/Pipe.h
+++ b/src/msg/simple/Pipe.h
@@ -195,6 +195,7 @@ class DispatchQueue;
     ceph::shared_ptr<AuthSessionHandler> session_security;
 
   protected:
+    BLKIN_END_REF(pipe_endpoint)
     friend class SimpleMessenger;
     PipeConnectionRef connection_state;
 
@@ -219,6 +220,9 @@ class DispatchQueue;
     uint64_t in_seq, in_seq_acked;
     
     void set_socket_options();
+#ifdef WITH_BLKIN
+    void set_endpoint();
+#endif
 
     int accept();   // server handshake
     int connect();  // client handshake
diff --git a/src/msg/simple/SimpleMessenger.cc b/src/msg/simple/SimpleMessenger.cc
index 38b5d84..308492a 100644
--- a/src/msg/simple/SimpleMessenger.cc
+++ b/src/msg/simple/SimpleMessenger.cc
@@ -113,6 +113,7 @@ int SimpleMessenger::_send_message(Message *m, const entity_inst_t& dest)
 
   lock.Lock();
   Pipe *pipe = _lookup_pipe(dest.addr);
+  BLKIN_MSG_TRACE_EVENT(m, "submitting_message");
   submit_message(m, (pipe ? pipe->connection_state.get() : NULL),
                  dest.addr, dest.name.type(), true);
   lock.Unlock();
