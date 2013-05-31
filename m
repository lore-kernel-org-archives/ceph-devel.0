From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 1/2] Add RADOS lock mechanism to the librados C/C++ API.
Date: Fri, 31 May 2013 12:45:05 -0700
Message-ID: <51A8FDC1.2040007@inktank.com>
References: <1369918922-867-1-git-send-email-philipgian@grnet.gr> <1369918922-867-2-git-send-email-philipgian@grnet.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:37592 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754847Ab3EaTpL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 31 May 2013 15:45:11 -0400
Received: by mail-pa0-f51.google.com with SMTP id lf11so227886pab.24
        for <ceph-devel@vger.kernel.org>; Fri, 31 May 2013 12:45:10 -0700 (PDT)
In-Reply-To: <1369918922-867-2-git-send-email-philipgian@grnet.gr>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Filippos Giannakos <philipgian@grnet.gr>, ceph-devel@vger.kernel.org
Cc: synnefo-devel@googlegroups.com

Filippos Giannakos <philipgian@grnet.gr> wrote:
>Add functions to the librados C/C++ API, to take advantage and utilize
>the
>advisory locking system offered by RADOS.
>
>Signed-off-by: Filippos Giannakos <philipgian@grnet.gr>
>---
> src/Makefile.am                |    5 +-
> src/include/rados/librados.h   |   95 +++++++++++++++++++-
> src/include/rados/librados.hpp |   27 ++++++
>src/librados/librados.cc       |  187
>++++++++++++++++++++++++++++++++++++++++
> 4 files changed, 312 insertions(+), 2 deletions(-)
>
>diff --git a/src/Makefile.am b/src/Makefile.am
>index 5e17687..3b95662 100644
>--- a/src/Makefile.am
>+++ b/src/Makefile.am
>@@ -357,7 +357,10 @@ librados_SOURCES = \
> 	librados/RadosClient.cc \
> 	librados/IoCtxImpl.cc \
> 	osdc/Objecter.cc \
>-	osdc/Striper.cc
>+	osdc/Striper.cc \
>+	cls/lock/cls_lock_client.cc \
>+	cls/lock/cls_lock_types.cc \
>+	cls/lock/cls_lock_ops.cc
> librados_la_SOURCES = ${librados_SOURCES}
> librados_la_CFLAGS = ${CRYPTO_CFLAGS} ${AM_CFLAGS}
> librados_la_CXXFLAGS = ${AM_CXXFLAGS}
>diff --git a/src/include/rados/librados.h
>b/src/include/rados/librados.h
>index a575042..ae8db4a 100644
>--- a/src/include/rados/librados.h
>+++ b/src/include/rados/librados.h
>@@ -24,7 +24,7 @@ extern "C" {
> #endif
>
> #define LIBRADOS_VER_MAJOR 0
>-#define LIBRADOS_VER_MINOR 52
>+#define LIBRADOS_VER_MINOR 53
> #define LIBRADOS_VER_EXTRA 0
>
>#define LIBRADOS_VERSION(maj, min, extra) ((maj << 16) + (min << 8) +
>extra)
>@@ -1571,6 +1571,99 @@ int rados_notify(rados_ioctx_t io, const char
>*o, uint64_t ver, const char *buf,
>
> /** @} Watch/Notify */
>
>+/**
>+ * Take an exclusive lock on an object.
>+ *
>+ * @param io the context to operate in
>+ * @param oid the name of the object
>+ * @param name the name of the lock
>+ * @param cookie user-defined identifier for this instance of the lock
>+ * @param tag The tag of the lock

tag is only relevant for shared locks, it can always be set to "" for
exclusive locks

>+ * @param desc user-defined lock description
>+ * #param flags lock flags

s/#/@/

An enum for possible flags should be included in librados.h

Maybe we should add the duration parameter to lock_exclusive and
lock_shared too, so all the underlying functionality is exposed.

>+ * @returns 0 on success, negative error code on failure
>+ * @returns -EBUSY if the lock is already held by another (client,
>cookie) pair
>+ * @returns -EEXIST if the lock is already held by the same (client,
>cookie) pair
>+ */
>+int rados_lock_exclusive(rados_ioctx_t io, const char * o, const char
>* name,
>+	       const char * cookie, const char * tag, const char * desc,
>+	       uint8_t flags);
>+
>+/**
>+ * Take a shared lock on an object.
>+ *
>+ * @param io the context to operate in
>+ * @param o the name of the object
>+ * @param name the name of the lock
>+ * @param cookie user-defined identifier for this instance of the lock
>+ * @param tag The tag of the lock
>+ * @param desc user-defined lock description
>+ * #param flags lock flags

s/#/@/

>+ * @returns 0 on success, negative error code on failure
>+ * @returns -EBUSY if the lock is already held by another (client,
>cookie) pair
>+ * @returns -EEXIST if the lock is already held by the same (client,
>cookie) pair
>+ */
>+int rados_lock_shared(rados_ioctx_t io, const char * o, const char *
>name,
>+	       const char * cookie, const char * tag, const char * desc,
>+	       uint8_t flags);
>+
>+/**
>+ * Release a shared or exclusive lock on an object.
>+ *
>+ * @param io the context to operate in
>+ * @param o the name of the object
>+ * @param name the name of the lock
>+ * @param cookie user-defined identifier for the instance of the lock
>+ * @returns 0 on success, negative error code on failure
>+ * @returns -ENOENT if the lock is not held by the specified (client,
>cookie) pair
>+ */
>+int rados_unlock(rados_ioctx_t io, const char *o, const char *name,
>+		 const char *cookie);
>+
>+/**
>+ * List clients that have locked the named object lokc and information

s/lokc/lock/

>about
>+ * the lock.
>+ *
>+ * The number of bytes required in each buffer is put in the
>+ * corresponding size out parameter. If any of the provided buffers
>+ * are too short, -ERANGE is returned after these sizes are filled in.
>+ *
>+ * @param io the context to operate in
>+ * @param o the name of the object
>+ * @param name the name of the lock
>+ * @param exclusive where to store whether the lock is exclusive (1)
>or shared (0)
>+ * @param tag where to store the tag associated with the object lock
>+ * @param tag_len number of bytes in tag buffer
>+ * @param clients buffer in which locker clients are stored, separated
>by '\0'
>+ * @param clients_len number of bytes in the clients buffer
>+ * @param cookies buffer in which locker cookies are stored, separated
>by '\0'
>+ * @param cookies_len number of bytes in the cookies buffer
>+ * @param addrs buffer in which locker addresses are stored, separated
>by '\0'
>+ * @param addrs_len number of bytes in the clients buffer
>+ * @returns number of lockers on success, negative error code on
>failure
>+ * @returns -ERANGE if any of the buffers are too short
>+ */
>+ssize_t rados_list_lockers(rados_ioctx_t io, const char *o,
>+			   const char *name, int *exclusive,
>+			   char *tag, size_t *tag_len,
>+			   char *clients, size_t *clients_len,
>+			   char *cookies, size_t *cookies_len,
>+			   char *addrs, size_t *addrs_len);
>+
>+/**
>+ * Releases a shared or exclusive lock on an object, which was taken
>by the
>+ * specified client.
>+ *
>+ * @param io the context to operate in
>+ * @param o the name of the object
>+ * @param name the name of the lock
>+ * @param client the client currently holding the lock
>+ * @param cookie user-defined identifier for the instance of the lock
>+ * @returns 0 on success, negative error code on failure
>+ * @returns -ENOENT if the lock is not held by the specified (client,
>cookie) pair

Mention the error code for a client that can't be parsed

>+ */
>+int rados_break_lock(rados_ioctx_t io, const char *o, const char
>*name,
>+		     const char *client, const char *cookie);
> #ifdef __cplusplus
> }
> #endif
>diff --git a/src/include/rados/librados.hpp
>b/src/include/rados/librados.hpp
>index af14a18..e7e28da 100644
>--- a/src/include/rados/librados.hpp
>+++ b/src/include/rados/librados.hpp
>@@ -47,6 +47,12 @@ namespace librados
>     uint64_t num_rd, num_rd_kb, num_wr, num_wr_kb;
>   };
>
>+  typedef struct {
>+    std::string client;
>+    std::string cookie;
>+    std::string address;
>+  } locker_t;
>+
>   typedef std::map<std::string, pool_stat_t> stats_map;
>
>   typedef void *completion_t;
>@@ -488,6 +494,27 @@ namespace librados
>
>int selfmanaged_snap_rollback(const std::string& oid, uint64_t snapid);
>
>+    // Advisory locking on rados objects.
>+    int lock_exclusive(const std::string &oid, const std::string
>&name,
>+		       const std::string &cookie, const std::string &tag,
>+		       const std::string &description, uint8_t flags);
>+
>+    int lock_shared(const std::string &oid, const std::string &name,
>+		    const std::string &cookie, const std::string &tag,
>+		    const std::string &description, uint8_t flags);
>+
>+    int unlock(const std::string &oid, const std::string &name,
>+	       const std::string &cookie);
>+
>+    int break_lock(const std::string &oid, const std::string &name,
>+		   const std::string &client, const std::string &cookie);
>+
>+    int list_lockers(const std::string &oid, const std::string &name,
>+		     int *exclusive,
>+		     std::string *tag,
>+		     std::list<librados::locker_t> *lockers);
>+
>+
>     ObjectIterator objects_begin();
>     const ObjectIterator& objects_end() const;
>
>diff --git a/src/librados/librados.cc b/src/librados/librados.cc
>index 5e8b38f..2d6a235 100644
>--- a/src/librados/librados.cc
>+++ b/src/librados/librados.cc
>@@ -19,11 +19,13 @@
> #include "include/rados/librados.h"
> #include "include/rados/librados.hpp"
> #include "include/types.h"
>+#include <include/stringify.h>
>
> #include "librados/AioCompletionImpl.h"
> #include "librados/IoCtxImpl.h"
> #include "librados/PoolAsyncCompletionImpl.h"
> #include "librados/RadosClient.h"
>+#include <cls/lock/cls_lock_client.h>
>
> #include <string>
> #include <map>
>@@ -981,6 +983,73 @@ int
>librados::IoCtx::selfmanaged_snap_rollback(const std::string& oid,
>uint64_t
> 						       snapid);
> }
>
>+int librados::IoCtx::lock_exclusive(const std::string &oid, const
>std::string &name,
>+				    const std::string &cookie, const std::string &tag,
>+				    const std::string &description, uint8_t flags)
>+{
>+  return rados::cls::lock::lock(this, oid, name, LOCK_EXCLUSIVE,
>cookie, tag,
>+		  		description, utime_t(), flags);
>+}
>+
>+int librados::IoCtx::lock_shared(const std::string &oid, const
>std::string &name,
>+				 const std::string &cookie, const std::string &tag,
>+				 const std::string &description, uint8_t flags)
>+{
>+  return rados::cls::lock::lock(this, oid, name, LOCK_SHARED, cookie,
>tag,
>+		  		description, utime_t(),	flags);
>+}
>+
>+int librados::IoCtx::unlock(const std::string &oid, const std::string
>&name,
>+			    const std::string &cookie)
>+{
>+  return rados::cls::lock::unlock(this, oid, name, cookie);
>+}
>+
>+int librados::IoCtx::break_lock(const std::string &oid, const
>std::string &name,
>+				const std::string &client, const std::string &cookie)
>+{
>+  entity_name_t locker;
>+  if (!locker.parse(client))
>+    return -1;

should be an errno symbol, maybe -EINVAL

>+  return rados::cls::lock::break_lock(this, oid, name, cookie,
>locker);
>+}
>+
>+int librados::IoCtx::list_lockers(const std::string &oid, const
>std::string &name,
>+				  int *exclusive,
>+				  std::string *tag,
>+				  std::list<librados::locker_t> *lockers)
>+{
>+  std::list<librados::locker_t> tmp_lockers;
>+  map<rados::cls::lock::locker_id_t, rados::cls::lock::locker_info_t>
>rados_lockers;
>+  std::string tmp_tag;
>+  ClsLockType tmp_type;
>+  int r = rados::cls::lock::get_lock_info(this, oid, name,
>&rados_lockers, &tmp_type, &tmp_tag);
>+  if (r < 0)
>+	  return r;
>+
>+  map<rados::cls::lock::locker_id_t,
>rados::cls::lock::locker_info_t>::iterator map_it;
>+  for (map_it = rados_lockers.begin(); map_it != rados_lockers.end();
>++map_it){

space before brace

>+    librados::locker_t locker;
>+    locker.client = stringify(map_it->first.locker);
>+    locker.cookie = map_it->first.cookie;
>+    locker.address = stringify(map_it->second.addr);
>+    tmp_lockers.push_back(locker);
>+  }
>+
>+  if (lockers)
>+    *lockers = tmp_lockers;
>+  if (tag)
>+    *tag = tmp_tag;
>+  if (exclusive){

space before brace

>+    if (tmp_type == LOCK_EXCLUSIVE)
>+      *exclusive = 1;
>+    else
>+      *exclusive = 0;
>+  }
>+
>+  return tmp_lockers.size();
>+}
>+
> librados::ObjectIterator librados::IoCtx::objects_begin()
> {
>   rados_list_ctx_t listh;
>@@ -2366,3 +2435,121 @@ int rados_notify(rados_ioctx_t io, const char
>*o, uint64_t ver, const char *buf,
>   }
>   return ctx->notify(oid, ver, bl);
> }
>+
>+extern "C" int rados_lock_exclusive(rados_ioctx_t io, const char * o,
>+			  const char * name, const char * cookie,
>+			  const char * tag, const char * desc,
>+			  uint8_t flags)
>+{
>+  librados::IoCtx ctx;
>+  librados::IoCtx::from_rados_ioctx_t(io, ctx);
>+  std::string s = name;
>+  std::string oid = o;
>+  std::string c = cookie;
>+  std::string t = tag;
>+  std::string description = desc;

no need to convert the arguments to strings

>+
>+  return ctx.lock_exclusive(oid, name, cookie, tag, description,
>+		  flags);
>+}
>+
>+extern "C" int rados_lock_shared(rados_ioctx_t io, const char * o,
>+			  const char * name, const char * cookie,
>+			  const char * tag, const char * desc,
>+			  uint8_t flags)
>+{
>+  librados::IoCtx ctx;
>+  librados::IoCtx::from_rados_ioctx_t(io, ctx);
>+  std::string s = name;
>+  std::string oid = o;
>+  std::string c = cookie;
>+  std::string t = tag;
>+  std::string description = desc;

no need to convert the arguments to strings

>+
>+  return ctx.lock_shared(oid, name, cookie, tag, description,
>+		  flags);
>+}
>+extern "C" int rados_unlock(rados_ioctx_t io, const char *o, const
>char *name,
>+			    const char *cookie)
>+{
>+  librados::IoCtx ctx;
>+  librados::IoCtx::from_rados_ioctx_t(io, ctx);
>+  std::string s = name;
>+  std::string oid = o;
>+  std::string c = cookie;

no need to convert the arguments to strings

>+
>+  return ctx.unlock(oid, name, cookie);
>+
>+}
>+
>+extern "C" ssize_t rados_list_lockers(rados_ioctx_t io, const char *o,
>+				      const char *name, int *exclusive,
>+				      char *tag, size_t *tag_len,
>+				      char *clients, size_t *clients_len,
>+				      char *cookies, size_t *cookies_len,
>+				      char *addrs, size_t *addrs_len)
>+{
>+  librados::IoCtx ctx;
>+  librados::IoCtx::from_rados_ioctx_t(io, ctx);
>+  std::string name_str = name;
>+  std::string oid = o;

no need to convert the arguments to strings

>+  std::string tag_str;
>+  int tmp_exclusive;
>+  std::list<librados::locker_t> lockers;
>+  int r = ctx.list_lockers(oid, name_str, &tmp_exclusive, &tag_str,
>&lockers);
>+  if (r < 0)
>+	  return r;
>+
>+  size_t clients_total = 0;
>+  size_t cookies_total = 0;
>+  size_t addrs_total = 0;
>+  list<librados::locker_t>::const_iterator it;
>+  for (it = lockers.begin(); it != lockers.end(); ++it) {
>+    clients_total += it->client.length() + 1;
>+    cookies_total += it->cookie.length() + 1;
>+    addrs_total += it->address.length() + 1;
>+  }
>+
>+  bool too_short = ((clients_total > *clients_len) ||
>+                    (cookies_total > *cookies_len) ||
>+                    (addrs_total > *addrs_len) ||
>+                    (tag_str.length() + 1 > *tag_len));
>+  *clients_len = clients_total;
>+  *cookies_len = cookies_total;
>+  *addrs_len = addrs_total;
>+  *tag_len = tag_str.length() + 1;
>+  if (too_short)
>+    return -ERANGE;
>+
>+  strcpy(tag, tag_str.c_str());
>+  char *clients_p = clients;
>+  char *cookies_p = cookies;
>+  char *addrs_p = addrs;
>+  for (it = lockers.begin(); it != lockers.end(); ++it) {
>+    strcpy(clients_p, it->client.c_str());
>+    clients_p += it->client.length() + 1;
>+    strcpy(cookies_p, it->cookie.c_str());
>+    cookies_p += it->cookie.length() + 1;
>+    strcpy(addrs_p, it->address.c_str());
>+    addrs_p += it->address.length() + 1;
>+  }
>+  if (tmp_exclusive)
>+    *exclusive = 1;
>+  else
>+    *exclusive = 0;
>+
>+  return lockers.size();
>+}
>+
>+extern "C" int rados_break_lock(rados_ioctx_t io, const char *o,
>+				const char *name, const char *client,
>+				const char *cookie)
>+{
>+  librados::IoCtx ctx;
>+  librados::IoCtx::from_rados_ioctx_t(io, ctx);
>+  std::string s = name;
>+  std::string oid = o;
>+  std::string c = cookie;

s and c aren't used, and the conversion to strings isn't needed

>+  return ctx.break_lock(oid, name, client, cookie);
>+}
>+

