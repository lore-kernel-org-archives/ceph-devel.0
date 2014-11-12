From: Andrew Shewmaker <agshew@gmail.com>
Subject: [PATCH 1/6] Initial support for blkin (LTTng + Zipkin) tracing
Date: Wed, 12 Nov 2014 16:19:55 -0700
Message-ID: <20141112231955.GB6892@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:59364 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752901AbaKLXT6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Nov 2014 18:19:58 -0500
Received: by mail-pa0-f45.google.com with SMTP id lf10so14018276pab.32
        for <ceph-devel@vger.kernel.org>; Wed, 12 Nov 2014 15:19:57 -0800 (PST)
Received: from localhost (host-69-145-59-76.bln-mt.client.bresnan.net. [69.145.59.76])
        by mx.google.com with ESMTPSA id ip1sm23153538pbc.0.2014.11.12.15.19.56
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 12 Nov 2014 15:19:57 -0800 (PST)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Adds blkin linking to build system.
Adds blkin header include.
Adds message infrastructure for blkin tracing.
Adds blkin trace events and keyvals to OpTracker.
Adds osd, pg, journal, and filestore blkin traces to OpTracker.

These changes are Marios', with the following exceptions:
 - split out initial support for Marios' additional tracing changes
 - blkin added as ceph submodule, include path is "blkin/ztracer.hpp"
 - only Message.h includes blkin, as others include Message.h
 - commented code has been removed
 - unused lname var/code in SimpleMessenger has been removed
 - braces added to conditionals to match recommended coding style
   - note: did not change member variable names to use m_ prefix
           since member vars in same class did not
 - Ref suffix added to TrackedOp shared_ptr vars to be consistent
   - note: did not add -Ref suffix to ZTrace*Ref vars in Message

Signed-off-by: Andrew Shewmaker <agshew@gmail.com>
---
 .gitmodules                |   3 ++
 src/Makefile-env.am        |   2 +-
 src/blkin                  |   1 +
 src/common/TrackedOp.cc    | 123 +++++++++++++++++++++++++++++++++++++++++++++
 src/common/TrackedOp.h     |  21 ++++++++
 src/msg/Message.cc         |  85 +++++++++++++++++++++++++++++++
 src/msg/Message.h          |  21 ++++++++
 src/msg/Pipe.cc            |  37 +++++++++++++-
 src/msg/Pipe.h             |   2 +
 src/msg/SimpleMessenger.cc |   1 +
 src/msg/msg_types.cc       |  23 +++++++--
 src/msg/msg_types.h        |   1 +
 12 files changed, 314 insertions(+), 6 deletions(-)
 create mode 160000 src/blkin

diff --git a/.gitmodules b/.gitmodules
index 0d5258c..83c429f 100644
--- a/.gitmodules
+++ b/.gitmodules
@@ -15,3 +15,6 @@
 	path = src/erasure-code/jerasure/gf-complete
 	url = https://github.com/ceph/gf-complete.git
 	branch = v1-ceph
+[submodule "src/blkin"]
+	path = src/blkin
+	url = https://github.com/agshew/blkin.git
diff --git a/src/Makefile-env.am b/src/Makefile-env.am
index e1ba4a8..50e01cf 100644
--- a/src/Makefile-env.am
+++ b/src/Makefile-env.am
@@ -116,7 +116,7 @@ AM_CCASFLAGS = -f elf64
 #####################
 ## library definitions and dependencies
 
-EXTRALIBS = -luuid -lm
+EXTRALIBS = -luuid -lm -lzipkin-cpp
 if FREEBSD
 EXTRALIBS += -lexecinfo
 endif # FREEBSD
diff --git a/src/blkin b/src/blkin
new file mode 160000
index 0000000..b31b81c
--- /dev/null
+++ b/src/blkin
@@ -0,0 +1 @@
+Subproject commit b31b81ccad4327015bfb934671a5026bd84ef24c
diff --git a/src/common/TrackedOp.cc b/src/common/TrackedOp.cc
index ddb2f91..c6df95b 100644
--- a/src/common/TrackedOp.cc
+++ b/src/common/TrackedOp.cc
@@ -240,6 +240,17 @@ void OpTracker::_mark_event(TrackedOp *op, const string &evt,
 	  << ", request: " << *op->request << dendl;
 }
 
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
+
 void OpTracker::RemoveOnDelete::operator()(TrackedOp *op) {
   if (!tracker->tracking_enabled) {
     op->request->clear_data();
@@ -247,6 +258,7 @@ void OpTracker::RemoveOnDelete::operator()(TrackedOp *op) {
     return;
   }
   op->mark_event("done");
+  op->trace_osd("Span ended");
   tracker->unregister_inflight_op(op);
   // Do not delete op, unregister_inflight_op took control
 }
@@ -277,3 +289,114 @@ void TrackedOp::dump(utime_t now, Formatter *f) const
     f->close_section();
   }
 }
+
+bool TrackedOp::create_osd_trace(TrackedOpEndpointRef ep)
+{
+  string name = "OSD Handling op";
+  if (!request) {
+    return false;
+  }
+
+  TrackedOpTraceRef mt = request->get_master_trace();
+  if (!mt) {
+    return false;
+  }
+
+  osd_trace = ZTracer::create_ZTrace(name, mt, ep);
+  return true;
+}
+
+void TrackedOp::trace_osd(string event)
+{
+  if (!osd_trace) {
+    return;
+  }
+
+  tracker->trace_event(this, osd_trace, event, osd_trace->get_endpoint());
+}
+
+void TrackedOp::trace_osd(string key, string val)
+{
+  if (!osd_trace) {
+    return;
+  }
+
+  tracker->trace_keyval(this, osd_trace, key, val, osd_trace->get_endpoint());
+}
+
+
+bool TrackedOp::create_pg_trace(TrackedOpEndpointRef ep)
+{
+  string name = "PG";
+  if (!request) {
+    return false;
+  }
+
+  TrackedOpTraceRef mt = request->get_master_trace();
+  if (!mt) {
+    return false;
+  }
+
+  pg_trace = ZTracer::create_ZTrace(name, mt, ep);
+  return true;
+}
+
+void TrackedOp::trace_pg(string event)
+{
+  if (!pg_trace) {
+    return;
+  }
+
+  tracker->trace_event(this, osd_trace, event, pg_trace->get_endpoint());
+}
+
+void TrackedOp::get_pg_trace_info(struct blkin_trace_info *info)
+{
+  if (!pg_trace) {
+    return;
+  }
+
+  osd_trace->get_trace_info(info);
+}
+
+bool TrackedOp::create_journal_trace(TrackedOpEndpointRef ep)
+{
+  string name = "Journal access";
+
+  if (!osd_trace) {
+    return false;
+  }
+
+  journal_trace = ZTracer::create_ZTrace(name, osd_trace, ep);
+  return true;
+}
+
+void TrackedOp::trace_journal(string event)
+{
+  if (!journal_trace) {
+    return;
+  }
+
+  tracker->trace_event(this, journal_trace, event, journal_trace->get_endpoint());
+}
+
+bool TrackedOp::create_filestore_trace(TrackedOpEndpointRef ep)
+{
+  string name = "Filestore access";
+
+  if (!osd_trace) {
+    return false;
+  }
+
+  filestore_trace = ZTracer::create_ZTrace(name, osd_trace, ep);
+  return true;
+}
+
+void TrackedOp::trace_filestore(string event)
+{
+  if (!filestore_trace) {
+    return;
+  }
+
+  tracker->trace_event(this, filestore_trace, event, filestore_trace->get_endpoint());
+}
diff --git a/src/common/TrackedOp.h b/src/common/TrackedOp.h
index 4673c1b..5c25d5a 100644
--- a/src/common/TrackedOp.h
+++ b/src/common/TrackedOp.h
@@ -24,6 +24,8 @@
 
 class TrackedOp;
 typedef ceph::shared_ptr<TrackedOp> TrackedOpRef;
+typedef ZTracer::ZTraceEndpointRef TrackedOpEndpointRef;
+typedef ZTracer::ZTraceRef TrackedOpTraceRef;
 
 class OpTracker;
 class OpHistory {
@@ -98,6 +100,9 @@ public:
   void mark_event(TrackedOp *op, const string &evt);
   void _mark_event(TrackedOp *op, const string &evt, utime_t now);
 
+  void trace_event(TrackedOp *op, TrackedOpTraceRef t, const string &evt, TrackedOpEndpointRef ep);
+  void trace_keyval(TrackedOp *op, TrackedOpTraceRef t, const string &key,
+		    const string &val, TrackedOpEndpointRef ep);
   void on_shutdown() {
     Mutex::Locker l(ops_in_flight_lock);
     history.on_shutdown();
@@ -128,6 +133,10 @@ private:
   friend class OpHistory;
   friend class OpTracker;
   xlist<TrackedOp*>::item xitem;
+  TrackedOpTraceRef osd_trace;
+  TrackedOpTraceRef pg_trace;
+  TrackedOpTraceRef journal_trace;
+  TrackedOpTraceRef filestore_trace;
 protected:
   Message *request; /// the logical request we are tracking
   OpTracker *tracker; /// the tracker we are associated with
@@ -175,6 +184,18 @@ public:
     return events.rbegin()->second.c_str();
   }
   void dump(utime_t now, Formatter *f) const;
+
+  bool create_osd_trace(TrackedOpEndpointRef ep);
+  void trace_osd(string event);
+  void trace_osd(string key, string val);
+  bool create_pg_trace(TrackedOpEndpointRef ep);
+  void trace_pg(string event);
+  void get_pg_trace_info(struct blkin_trace_info *info);
+  bool create_journal_trace(TrackedOpEndpointRef ep);
+  void trace_journal(string event);
+  bool create_filestore_trace(TrackedOpEndpointRef ep);
+  void trace_filestore(string event);
+  TrackedOpTraceRef get_osd_trace() { return osd_trace; };
 };
 
 #endif
diff --git a/src/msg/Message.cc b/src/msg/Message.cc
index 6ecce71..a2c0127 100644
--- a/src/msg/Message.cc
+++ b/src/msg/Message.cc
@@ -785,3 +785,88 @@ Message *decode_message(CephContext *cct, bufferlist::iterator& p)
   return decode_message(cct, h, f, fr, mi, da);
 }
 
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
+  ostringstream oss;
+  oss << "INIT TRACE TINFO: "
+      << "trace_id: " << tinfo->trace_id
+      << "span_id: " << tinfo->span_id
+      << "parent_span_id: " << tinfo->parent_span_id;
+
+  if (!(tinfo->trace_id == 0 && tinfo->span_id == 0 && tinfo->parent_span_id == 0)) {
+    oss << " OK" << std::endl;
+    write(3, oss.str().c_str(), oss.str().length());
+    create_message_endpoint();
+    master_trace = ZTracer::create_ZTrace("Main", message_endpoint, tinfo);
+    return trace_basic_info();
+  }
+
+  oss << " ZEROS" << std::endl;
+  write(3, oss.str().c_str(), oss.str().length());
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
diff --git a/src/msg/Message.h b/src/msg/Message.h
index a69944f..0f28a31 100644
--- a/src/msg/Message.h
+++ b/src/msg/Message.h
@@ -18,6 +18,8 @@
 #include <stdlib.h>
 #include <ostream>
 
+#include "blkin/ztracer.hpp"
+
 #include <boost/intrusive_ptr.hpp>
 // Because intusive_ptr clobbers our assert...
 #include "include/assert.h"
@@ -340,6 +342,9 @@ protected:
   // currently throttled.
   uint64_t dispatch_throttle_size;
 
+  ZTracer::ZTraceEndpointRef message_endpoint;
+  ZTracer::ZTraceRef master_trace;
+  ZTracer::ZTraceRef messenger_trace;
   friend class Messenger;
 
 public:
@@ -350,6 +355,7 @@ public:
       dispatch_throttle_size(0) {
     memset(&header, 0, sizeof(header));
     memset(&footer, 0, sizeof(footer));
+    trace_end_after_span = false;
   };
   Message(int t, int version=1, int compat_version=0)
     : connection(NULL),
@@ -363,8 +369,10 @@ public:
     header.priority = 0;  // undef
     header.data_off = 0;
     memset(&footer, 0, sizeof(footer));
+    trace_end_after_span = false;
   }
 
+  bool trace_end_after_span;
   Message *get() {
     return static_cast<Message *>(RefCountedObject::get());
   }
@@ -394,6 +402,9 @@ public:
   void set_header(const ceph_msg_header &e) { header = e; }
   void set_footer(const ceph_msg_footer &e) { footer = e; }
   ceph_msg_footer &get_footer() { return footer; }
+  ZTracer::ZTraceRef get_master_trace() { return master_trace; }
+  ZTracer::ZTraceRef get_messenger_trace() { return messenger_trace; }
+  void set_messenger_trace(ZTracer::ZTraceRef t) { messenger_trace = t; }
 
   /*
    * If you use get_[data, middle, payload] you shouldn't
@@ -525,6 +536,15 @@ public:
   virtual void dump(Formatter *f) const;
 
   void encode(uint64_t features, bool datacrc);
+
+  int init_trace_info();
+  int init_trace_info(struct blkin_trace_info *tinfo);
+  int init_trace_info(ZTracer::ZTraceRef t);
+  void trace(string event);
+  void trace(string key, string val);
+  int trace_basic_info();
+  virtual void trace_msg_info() { };
+  virtual bool create_message_endpoint();
 };
 typedef boost::intrusive_ptr<Message> MessageRef;
 
@@ -541,4 +561,5 @@ inline ostream& operator<<(ostream& out, Message& m) {
 extern void encode_message(Message *m, uint64_t features, bufferlist& bl);
 extern Message *decode_message(CephContext *cct, bufferlist::iterator& bl);
 
+
 #endif
diff --git a/src/msg/Pipe.cc b/src/msg/Pipe.cc
index 0693c09..4ab5977 100644
--- a/src/msg/Pipe.cc
+++ b/src/msg/Pipe.cc
@@ -106,6 +106,7 @@ Pipe::Pipe(SimpleMessenger *r, int st, Connection *con)
   msgr->timeout = msgr->cct->_conf->ms_tcp_read_timeout * 1000; //convert to ms
   if (msgr->timeout == 0)
     msgr->timeout = -1;
+  set_endpoint();
 }
 
 Pipe::~Pipe()
@@ -115,6 +116,31 @@ Pipe::~Pipe()
   delete delay_thread;
 }
 
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
+
 void Pipe::handle_ack(uint64_t seq)
 {
   lsubdout(msgr->cct, ms, 15) << "reader got ack seq " << seq << dendl;
@@ -1479,6 +1505,7 @@ void Pipe::reader()
 	  fault(true);
 	continue;
       }
+      m->trace("Message read");
 
       if (state == STATE_CLOSED ||
 	  state == STATE_CONNECTING) {
@@ -1526,8 +1553,9 @@ void Pipe::reader()
       } else {
 	in_q->enqueue(m, m->get_priority(), conn_id);
       }
-    } 
-    
+      m->trace("Messenger end");
+    }
+
     else if (tag == CEPH_MSGR_TAG_CLOSE) {
       ldout(msgr->cct,20) << "reader got CLOSE" << dendl;
       pipe_lock.Lock();
@@ -1695,6 +1723,11 @@ void Pipe::writer()
 
 	pipe_lock.Unlock();
 
+	m->trace("Writer sending");
+        if (m->trace_end_after_span) {
+	  m->trace("Span ended");
+        }
+
         ldout(msgr->cct,20) << "writer sending " << m->get_seq() << " " << m << dendl;
 	int rc = write_message(header, footer, blist);
 
diff --git a/src/msg/Pipe.h b/src/msg/Pipe.h
index 468a6a5..14d3dbc 100644
--- a/src/msg/Pipe.h
+++ b/src/msg/Pipe.h
@@ -151,6 +151,7 @@ class DispatchQueue;
     ceph::shared_ptr<AuthSessionHandler> session_security;
 
   protected:
+    ZTracer::ZTraceEndpointRef pipe_endpoint;
     friend class SimpleMessenger;
     ConnectionRef connection_state;
 
@@ -174,6 +175,7 @@ class DispatchQueue;
     uint64_t in_seq, in_seq_acked;
     
     void set_socket_options();
+    void set_endpoint();
 
     int accept();   // server handshake
     int connect();  // client handshake
diff --git a/src/msg/SimpleMessenger.cc b/src/msg/SimpleMessenger.cc
index 2070fe5..b3bdf36 100644
--- a/src/msg/SimpleMessenger.cc
+++ b/src/msg/SimpleMessenger.cc
@@ -112,6 +112,7 @@ int SimpleMessenger::_send_message(Message *m, const entity_inst_t& dest,
 
   lock.Lock();
   Pipe *pipe = _lookup_pipe(dest.addr);
+  m->trace("submitting message");
   submit_message(m, (pipe ? pipe->connection_state.get() : NULL),
                  dest.addr, dest.name.type(), lazy);
   lock.Unlock();
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
index 5d86b3a..443f8c5 100644
--- a/src/msg/msg_types.h
+++ b/src/msg/msg_types.h
@@ -343,6 +343,7 @@ struct entity_addr_t {
   }
 
   void dump(Formatter *f) const;
+  int to_string(string &host, int &port);
 
   static void generate_test_instances(list<entity_addr_t*>& o);
 };
-- 
2.1.0

