From: James Harper <james.harper@bendigoit.com.au>
Subject: RE: libuuid vs boost uuid
Date: Wed, 13 Nov 2013 22:33:22 +0000
Message-ID: <6035A0D088A63A46850C3988ED045A4B665EA52D@BITCOM1.int.sbss.com.au>
References: <6035A0D088A63A46850C3988ED045A4B665E1FB8@BITCOM1.int.sbss.com.au>
 <alpine.DEB.2.00.1311082238350.4750@cobra.newdream.net>
 <6035A0D088A63A46850C3988ED045A4B665E29B6@BITCOM1.int.sbss.com.au>
 <alpine.DEB.2.00.1311092120290.30944@cobra.newdream.net>
 <B4DA9072-EED6-48EE-94FE-4F24CCDFA1F8@inktank.com>
 <6035A0D088A63A46850C3988ED045A4B665EA2F6@BITCOM1.int.sbss.com.au>
 <3C1A0909-F08C-44EE-AF1A-61E91460C764@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.bendigoit.com.au ([203.16.207.99]:42533 "EHLO
	smtp2.bendigoit.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751003Ab3KMWd1 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Nov 2013 17:33:27 -0500
In-Reply-To: <3C1A0909-F08C-44EE-AF1A-61E91460C764@inktank.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <noah.watkins@inktank.com>
Cc: Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Patch follows. When I wrote it I was just thinking it would be used for win32 build, hence the #ifdef. As I said before, it compiles but I haven't tested it. I can clean it up a bit and resend it with a signed-off-by if anyone wants to pick it up and follow it through sooner than I can. I don't know how boost behaves if the uuid parse fails (exception maybe?) so that would need resolving too.

In addition, a bunch of ceph files include the libuuid header directly, even though all the ones I've found don't appear to need it, so they need to be fixed for a clean compile under win32, and to remove dependency on libuuid. There may also be other cases that need work, in particular anything that memcpy's into the 16 byte uuid directly. See patch for MStatfsReply.h where a minor tweak was necessary.

(if anyone is interested, I have librados and librbd compiling under mingw32, but I can't get boost to build its thread library so I don't get a clean link, and there are probably other link errors too. I've run out of time for doing much more on this for the moment)

James

diff --git a/src/include/uuid.h b/src/include/uuid.h
index 942b807..201ac76 100644
--- a/src/include/uuid.h
+++ b/src/include/uuid.h
@@ -8,6 +8,70 @@
 #include "encoding.h"
 #include <ostream>

+#if defined(_WIN32)
+
+#include <boost/lexical_cast.hpp>
+#include <boost/uuid/uuid.hpp>
+#include <boost/uuid/uuid_generators.hpp>
+#include <boost/uuid/uuid_io.hpp>
+#include <string>
+
+struct uuid_d {
+  boost::uuids::uuid uuid;
+
+  uuid_d() {
+    uuid = boost::uuids::nil_uuid();
+  }
+
+  bool is_zero() const {
+    return uuid.is_nil();
+    //return boost::uuids::uuid::is_nil(uuid);
+  }
+
+  void generate_random() {
+    boost::uuids::random_generator gen;
+    uuid = gen();
+  }
+
+  bool parse(const char *s) {
+    boost::uuids::string_generator gen;
+    uuid = gen(s);
+    return true;
+    // what happens if parse fails?
+  }
+  void print(char *s) {
+    std::string str = boost::lexical_cast<std::string>(uuid);
+    memcpy(s, str.c_str(), 37);
+  }
+
+  void encode(bufferlist& bl) const {
+    ::encode_raw(uuid, bl);
+  }
+  void decode(bufferlist::iterator& p) const {
+    ::decode_raw(uuid, p);
+  }
+
+  uuid_d& operator=(const uuid_d& r) {
+    uuid = r.uuid;
+    return *this;
+  }
+};
+WRITE_CLASS_ENCODER(uuid_d)
+
+inline std::ostream& operator<<(std::ostream& out, const uuid_d& u) {
+  //char b[37];
diff --git a/src/include/uuid.h b/src/include/uuid.h
index 942b807..201ac76 100644
--- a/src/include/uuid.h
+++ b/src/include/uuid.h
@@ -8,6 +8,70 @@
 #include "encoding.h"
 #include <ostream>

+#if defined(_WIN32)
+
+#include <boost/lexical_cast.hpp>
+#include <boost/uuid/uuid.hpp>
+#include <boost/uuid/uuid_generators.hpp>
+#include <boost/uuid/uuid_io.hpp>
+#include <string>
+
+struct uuid_d {
+  boost::uuids::uuid uuid;
+
+  uuid_d() {
+    uuid = boost::uuids::nil_uuid();
+  }
+
+  bool is_zero() const {
+    return uuid.is_nil();
+    //return boost::uuids::uuid::is_nil(uuid);
+  }
+
+  void generate_random() {
+    boost::uuids::random_generator gen;
+    uuid = gen();
+  }
+
+  bool parse(const char *s) {
+    boost::uuids::string_generator gen;
+    uuid = gen(s);
+    return true;
+    // what happens if parse fails?
+  }
+  void print(char *s) {
+    std::string str = boost::lexical_cast<std::string>(uuid);
+    memcpy(s, str.c_str(), 37);
+  }
+
+  void encode(bufferlist& bl) const {
+    ::encode_raw(uuid, bl);
+  }
+  void decode(bufferlist::iterator& p) const {
+    ::decode_raw(uuid, p);
+  }
+
+  uuid_d& operator=(const uuid_d& r) {
+    uuid = r.uuid;
+    return *this;
+  }
+};
+WRITE_CLASS_ENCODER(uuid_d)
+
+inline std::ostream& operator<<(std::ostream& out, const uuid_d& u) {
+  //char b[37];
+  //uuid_unparse(u.uuid, b);
+  return out << u.uuid;
+}
+
+inline bool operator==(const uuid_d& l, const uuid_d& r) {
+  return l.uuid == r.uuid;
+}
+
+inline bool operator!=(const uuid_d& l, const uuid_d& r) {
+  return l.uuid != r.uuid;
+}
+#else
 extern "C" {
 #include <uuid/uuid.h>
 #include <unistd.h>
@@ -56,6 +120,6 @@ inline bool operator==(const uuid_d& l, const uuid_d& r) {
 inline bool operator!=(const uuid_d& l, const uuid_d& r) {
   return uuid_compare(l.uuid, r.uuid) != 0;
 }
-
+#endif

 #endif
diff --git a/src/messages/MStatfsReply.h b/src/messages/MStatfsReply.h
index 8ceec9c..40a5bdd 100644
--- a/src/messages/MStatfsReply.h
+++ b/src/messages/MStatfsReply.h
@@ -22,7 +22,7 @@ public:

   MStatfsReply() : Message(CEPH_MSG_STATFS_REPLY) {}
   MStatfsReply(uuid_d &f, tid_t t, epoch_t epoch) : Message(CEPH_MSG_STATFS_REPLY) {
-    memcpy(&h.fsid, f.uuid, sizeof(h.fsid));
+    memcpy(&h.fsid, &f.uuid, sizeof(h.fsid));
     header.tid = t;
     h.version = epoch;
   }

