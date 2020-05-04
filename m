From: David Howells <dhowells@redhat.com>
Subject: [RFC PATCH 29/61] cachefiles: trace: Log coherency checks
Date: Mon, 04 May 2020 18:11:50 +0100
Message-ID: <158861231084.340223.11279014019426008566.stgit@warthog.procyon.org.uk>
References: <158861203563.340223.7585359869938129395.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <158861203563.340223.7585359869938129395.stgit@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Trond Myklebust <trondmy@hammerspace.com>, Anna Schumaker <anna.schumaker@netapp.com>, Steve French <sfrench@samba.org>, Jeff Layton <jlayton@redhat.com>
Cc: dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Add a cachefiles tracepoint that logs the result of coherency management
when the coherency data on a file in the cache is checked or committed.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/cachefiles/xattr.c             |   45 ++++++++++++++++++++++--------
 include/trace/events/cachefiles.h |   56 +++++++++++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+), 12 deletions(-)

diff --git a/fs/cachefiles/xattr.c b/fs/cachefiles/xattr.c
index 5b2f6da91cc8..17c16c2bd07e 100644
--- a/fs/cachefiles/xattr.c
+++ b/fs/cachefiles/xattr.c
@@ -125,12 +125,21 @@ int cachefiles_set_object_xattr(struct cachefiles_object *object,
 	ret = vfs_setxattr(dentry, cachefiles_xattr_cache,
 			   buf, sizeof(struct cachefiles_xattr) + len,
 			   xattr_flags);
-	kfree(buf);
-	if (ret < 0 && ret != -ENOMEM)
-		cachefiles_io_error_obj(
-			object,
-			"Failed to set xattr with error %d", ret);
+	if (ret < 0) {
+		trace_cachefiles_coherency(object, d_inode(dentry)->i_ino,
+					   0,
+					   cachefiles_coherency_set_fail);
+		if (ret != -ENOMEM)
+			cachefiles_io_error_obj(
+				object,
+				"Failed to set xattr with error %d", ret);
+	} else {
+		trace_cachefiles_coherency(object, d_inode(dentry)->i_ino,
+					   0,
+					   cachefiles_coherency_set_ok);
+	}
 
+	kfree(buf);
 	_leave(" = %d", ret);
 	return ret;
 }
@@ -144,7 +153,9 @@ int cachefiles_check_auxdata(struct cachefiles_object *object)
 	struct dentry *dentry = object->dentry;
 	unsigned int len = object->fscache.cookie->aux_len, tlen;
 	const void *p = fscache_get_aux(object->fscache.cookie);
-	ssize_t ret;
+	enum cachefiles_coherency_trace why;
+	ssize_t xlen;
+	int ret = -ESTALE;
 
 	ASSERT(dentry);
 	ASSERT(d_backing_inode(dentry));
@@ -154,14 +165,24 @@ int cachefiles_check_auxdata(struct cachefiles_object *object)
 	if (!buf)
 		return -ENOMEM;
 
-	ret = vfs_getxattr(dentry, cachefiles_xattr_cache, buf, tlen);
-	if (ret == tlen &&
-	    buf->type == object->fscache.cookie->type &&
-	    memcmp(buf->data, p, len) == 0)
+	xlen = vfs_getxattr(dentry, cachefiles_xattr_cache, buf, tlen);
+	if (xlen != tlen) {
+		if (xlen == -EIO)
+			cachefiles_io_error_obj(
+				object,
+				"Failed to read aux with error %zd", xlen);
+		why = cachefiles_coherency_check_xattr;
+	} else if (buf->type != object->fscache.cookie->type) {
+		why = cachefiles_coherency_check_type;
+	} else if (memcmp(buf->data, p, len) != 0) {
+		why = cachefiles_coherency_check_aux;
+	} else {
+		why = cachefiles_coherency_check_ok;
 		ret = 0;
-	else
-		ret = -ESTALE;
+	}
 
+	trace_cachefiles_coherency(object, d_inode(dentry)->i_ino,
+				   0, why);
 	kfree(buf);
 	return ret;
 }
diff --git a/include/trace/events/cachefiles.h b/include/trace/events/cachefiles.h
index 0aa3f3126f6e..bf588c3f4a07 100644
--- a/include/trace/events/cachefiles.h
+++ b/include/trace/events/cachefiles.h
@@ -24,6 +24,19 @@ enum cachefiles_obj_ref_trace {
 	cachefiles_obj_ref__nr_traces
 };
 
+enum cachefiles_coherency_trace {
+	cachefiles_coherency_check_aux,
+	cachefiles_coherency_check_content,
+	cachefiles_coherency_check_dirty,
+	cachefiles_coherency_check_len,
+	cachefiles_coherency_check_objsize,
+	cachefiles_coherency_check_ok,
+	cachefiles_coherency_check_type,
+	cachefiles_coherency_check_xattr,
+	cachefiles_coherency_set_fail,
+	cachefiles_coherency_set_ok,
+};
+
 #endif
 
 /*
@@ -56,6 +69,18 @@ enum cachefiles_obj_ref_trace {
 	EM(cachefiles_obj_put_wait_retry,	"PUT wait_retry")	\
 	E_(cachefiles_obj_put_wait_timeo,	"PUT wait_timeo")
 
+#define cachefiles_coherency_traces					\
+	EM(cachefiles_coherency_check_aux,	"BAD aux ")		\
+	EM(cachefiles_coherency_check_content,	"BAD cont")		\
+	EM(cachefiles_coherency_check_dirty,	"BAD dirt")		\
+	EM(cachefiles_coherency_check_len,	"BAD len ")		\
+	EM(cachefiles_coherency_check_objsize,	"BAD osiz")		\
+	EM(cachefiles_coherency_check_ok,	"OK      ")		\
+	EM(cachefiles_coherency_check_type,	"BAD type")		\
+	EM(cachefiles_coherency_check_xattr,	"BAD xatt")		\
+	EM(cachefiles_coherency_set_fail,	"SET fail")		\
+	E_(cachefiles_coherency_set_ok,		"SET ok  ")
+
 /*
  * Export enum symbols via userspace.
  */
@@ -66,6 +91,7 @@ enum cachefiles_obj_ref_trace {
 
 cachefiles_obj_kill_traces;
 cachefiles_obj_ref_traces;
+cachefiles_coherency_traces;
 
 /*
  * Now redefine the EM() and E_() macros to map the enums to the strings that
@@ -295,6 +321,36 @@ TRACE_EVENT(cachefiles_mark_buried,
 		      __print_symbolic(__entry->why, cachefiles_obj_kill_traces))
 	    );
 
+TRACE_EVENT(cachefiles_coherency,
+	    TP_PROTO(struct cachefiles_object *obj,
+		     ino_t ino,
+		     int content,
+		     enum cachefiles_coherency_trace why),
+
+	    TP_ARGS(obj, ino, content, why),
+
+	    /* Note that obj may be NULL */
+	    TP_STRUCT__entry(
+		    __field(unsigned int,			obj	)
+		    __field(enum cachefiles_coherency_trace,	why	)
+		    __field(int,				content	)
+		    __field(u64,				ino	)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->obj	= obj->fscache.debug_id;
+		    __entry->why	= why;
+		    __entry->content	= content;
+		    __entry->ino	= ino;
+			   ),
+
+	    TP_printk("o=%08x %s i=%llx c=%u",
+		      __entry->obj,
+		      __print_symbolic(__entry->why, cachefiles_coherency_traces),
+		      __entry->ino,
+		      __entry->content)
+	    );
+
 #endif /* _TRACE_CACHEFILES_H */
 
 /* This part must be outside protection */
