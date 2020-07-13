From: David Howells <dhowells@redhat.com>
Subject: [PATCH 12/14] fscache: Remove old I/O tracepoints
Date: Mon, 13 Jul 2020 17:30:04 +0100
Message-ID: <159465780453.1376105.17832417270889389182.stgit@warthog.procyon.org.uk>
References: <159465766378.1376105.11619976251039287525.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-cachefs-bounces@redhat.com>
In-Reply-To: <159465766378.1376105.11619976251039287525.stgit@warthog.procyon.org.uk>
List-Unsubscribe: <https://www.redhat.com/mailman/options/linux-cachefs>,
	<mailto:linux-cachefs-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/archives/linux-cachefs>
List-Post: <mailto:linux-cachefs@redhat.com>
List-Help: <mailto:linux-cachefs-request@redhat.com?subject=help>
List-Subscribe: <https://www.redhat.com/mailman/listinfo/linux-cachefs>,
	<mailto:linux-cachefs-request@redhat.com?subject=subscribe>
Sender: linux-cachefs-bounces@redhat.com
Errors-To: linux-cachefs-bounces@redhat.com
To: Trond Myklebust <trondmy@hammerspace.com>, Anna Schumaker <anna.schumaker@netapp.com>, Steve French <sfrench@samba.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Matthew Wilcox <willy@infradead.org>
Cc: linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org, v9fs-developer@lists.sourceforge.net, ceph-devel@vger.kernel.org, linux-afs@lists.infradead.org
List-Id: ceph-devel.vger.kernel.org

Remove now-unused fscache tracepoints that have been obsoleted by the
removal of the old I/O code.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/fscache/object.c            |    1 
 include/trace/events/fscache.h |  195 ----------------------------------------
 2 files changed, 196 deletions(-)

diff --git a/fs/fscache/object.c b/fs/fscache/object.c
index e2e04ac2c0a1..e31164f0446b 100644
--- a/fs/fscache/object.c
+++ b/fs/fscache/object.c
@@ -942,7 +942,6 @@ static const struct fscache_state *_fscache_invalidate_object(struct fscache_obj
 	op->flags = FSCACHE_OP_ASYNC |
 		(1 << FSCACHE_OP_EXCLUSIVE) |
 		(1 << FSCACHE_OP_UNUSE_COOKIE);
-	trace_fscache_page_op(cookie, NULL, op, fscache_page_op_invalidate);
 
 	spin_lock(&cookie->lock);
 	if (fscache_submit_exclusive_op(object, op) < 0)
diff --git a/include/trace/events/fscache.h b/include/trace/events/fscache.h
index 953e15fad063..2ebfd688a7c2 100644
--- a/include/trace/events/fscache.h
+++ b/include/trace/events/fscache.h
@@ -33,24 +33,6 @@ enum fscache_cookie_trace {
 	fscache_cookie_put_parent,
 };
 
-enum fscache_page_trace {
-	fscache_page_cached,
-	fscache_page_inval,
-	fscache_page_maybe_release,
-	fscache_page_radix_clear_store,
-	fscache_page_radix_delete,
-	fscache_page_radix_insert,
-	fscache_page_radix_pend2store,
-	fscache_page_radix_set_pend,
-	fscache_page_uncache,
-	fscache_page_write,
-	fscache_page_write_end,
-	fscache_page_write_end_pend,
-	fscache_page_write_end_noc,
-	fscache_page_write_wait,
-	fscache_page_trace__nr
-};
-
 enum fscache_op_trace {
 	fscache_op_cancel,
 	fscache_op_cancel_all,
@@ -69,17 +51,6 @@ enum fscache_op_trace {
 	fscache_op_trace__nr
 };
 
-enum fscache_page_op_trace {
-	fscache_page_op_alloc_one,
-	fscache_page_op_attr_changed,
-	fscache_page_op_check_consistency,
-	fscache_page_op_invalidate,
-	fscache_page_op_retr_multi,
-	fscache_page_op_retr_one,
-	fscache_page_op_write_one,
-	fscache_page_op_trace__nr
-};
-
 #endif
 
 /*
@@ -98,22 +69,6 @@ enum fscache_page_op_trace {
 	EM(fscache_cookie_put_object,		"PUT obj")		\
 	E_(fscache_cookie_put_parent,		"PUT prn")
 
-#define fscache_page_traces						\
-	EM(fscache_page_cached,			"Cached ")		\
-	EM(fscache_page_inval,			"InvalPg")		\
-	EM(fscache_page_maybe_release,		"MayRels")		\
-	EM(fscache_page_uncache,		"Uncache")		\
-	EM(fscache_page_radix_clear_store,	"RxCStr ")		\
-	EM(fscache_page_radix_delete,		"RxDel  ")		\
-	EM(fscache_page_radix_insert,		"RxIns  ")		\
-	EM(fscache_page_radix_pend2store,	"RxP2S  ")		\
-	EM(fscache_page_radix_set_pend,		"RxSPend ")		\
-	EM(fscache_page_write,			"WritePg")		\
-	EM(fscache_page_write_end,		"EndPgWr")		\
-	EM(fscache_page_write_end_pend,		"EndPgWP")		\
-	EM(fscache_page_write_end_noc,		"EndPgNC")		\
-	E_(fscache_page_write_wait,		"WtOnWrt")
-
 #define fscache_op_traces						\
 	EM(fscache_op_cancel,			"Cancel1")		\
 	EM(fscache_op_cancel_all,		"CancelA")		\
@@ -130,15 +85,6 @@ enum fscache_page_op_trace {
 	EM(fscache_op_submit_ex,		"SubmitX")		\
 	E_(fscache_op_work,			"Work   ")
 
-#define fscache_page_op_traces						\
-	EM(fscache_page_op_alloc_one,		"Alloc1 ")		\
-	EM(fscache_page_op_attr_changed,	"AttrChg")		\
-	EM(fscache_page_op_check_consistency,	"CheckCn")		\
-	EM(fscache_page_op_invalidate,		"Inval  ")		\
-	EM(fscache_page_op_retr_multi,		"RetrMul")		\
-	EM(fscache_page_op_retr_one,		"Retr1  ")		\
-	E_(fscache_page_op_write_one,		"Write1 ")
-
 /*
  * Export enum symbols via userspace.
  */
@@ -363,70 +309,6 @@ TRACE_EVENT(fscache_osm,
 		      __entry->event_num)
 	    );
 
-TRACE_EVENT(fscache_page,
-	    TP_PROTO(struct fscache_cookie *cookie, struct page *page,
-		     enum fscache_page_trace why),
-
-	    TP_ARGS(cookie, page, why),
-
-	    TP_STRUCT__entry(
-		    __field(unsigned int,		cookie		)
-		    __field(pgoff_t,			page		)
-		    __field(enum fscache_page_trace,	why		)
-			     ),
-
-	    TP_fast_assign(
-		    __entry->cookie		= cookie->debug_id;
-		    __entry->page		= page->index;
-		    __entry->why		= why;
-			   ),
-
-	    TP_printk("c=%08x %s pg=%lx",
-		      __entry->cookie,
-		      __print_symbolic(__entry->why, fscache_page_traces),
-		      __entry->page)
-	    );
-
-TRACE_EVENT(fscache_check_page,
-	    TP_PROTO(struct fscache_cookie *cookie, struct page *page,
-		     void *val, int n),
-
-	    TP_ARGS(cookie, page, val, n),
-
-	    TP_STRUCT__entry(
-		    __field(unsigned int,		cookie		)
-		    __field(void *,			page		)
-		    __field(void *,			val		)
-		    __field(int,			n		)
-			     ),
-
-	    TP_fast_assign(
-		    __entry->cookie		= cookie->debug_id;
-		    __entry->page		= page;
-		    __entry->val		= val;
-		    __entry->n			= n;
-			   ),
-
-	    TP_printk("c=%08x pg=%p val=%p n=%d",
-		      __entry->cookie, __entry->page, __entry->val, __entry->n)
-	    );
-
-TRACE_EVENT(fscache_wake_cookie,
-	    TP_PROTO(struct fscache_cookie *cookie),
-
-	    TP_ARGS(cookie),
-
-	    TP_STRUCT__entry(
-		    __field(unsigned int,		cookie		)
-			     ),
-
-	    TP_fast_assign(
-		    __entry->cookie		= cookie->debug_id;
-			   ),
-
-	    TP_printk("c=%08x", __entry->cookie)
-	    );
-
 TRACE_EVENT(fscache_op,
 	    TP_PROTO(struct fscache_cookie *cookie, struct fscache_operation *op,
 		     enum fscache_op_trace why),
@@ -450,83 +332,6 @@ TRACE_EVENT(fscache_op,
 		      __print_symbolic(__entry->why, fscache_op_traces))
 	    );
 
-TRACE_EVENT(fscache_page_op,
-	    TP_PROTO(struct fscache_cookie *cookie, struct page *page,
-		     struct fscache_operation *op, enum fscache_page_op_trace what),
-
-	    TP_ARGS(cookie, page, op, what),
-
-	    TP_STRUCT__entry(
-		    __field(unsigned int,		cookie		)
-		    __field(unsigned int,		op		)
-		    __field(pgoff_t,			page		)
-		    __field(enum fscache_page_op_trace,	what		)
-			     ),
-
-	    TP_fast_assign(
-		    __entry->cookie		= cookie->debug_id;
-		    __entry->page		= page ? page->index : 0;
-		    __entry->op			= op->debug_id;
-		    __entry->what		= what;
-			   ),
-
-	    TP_printk("c=%08x %s pg=%lx op=%08x",
-		      __entry->cookie,
-		      __print_symbolic(__entry->what, fscache_page_op_traces),
-		      __entry->page, __entry->op)
-	    );
-
-TRACE_EVENT(fscache_wrote_page,
-	    TP_PROTO(struct fscache_cookie *cookie, struct page *page,
-		     struct fscache_operation *op, int ret),
-
-	    TP_ARGS(cookie, page, op, ret),
-
-	    TP_STRUCT__entry(
-		    __field(unsigned int,		cookie		)
-		    __field(unsigned int,		op		)
-		    __field(pgoff_t,			page		)
-		    __field(int,			ret		)
-			     ),
-
-	    TP_fast_assign(
-		    __entry->cookie		= cookie->debug_id;
-		    __entry->page		= page->index;
-		    __entry->op			= op->debug_id;
-		    __entry->ret		= ret;
-			   ),
-
-	    TP_printk("c=%08x pg=%lx op=%08x ret=%d",
-		      __entry->cookie, __entry->page, __entry->op, __entry->ret)
-	    );
-
-TRACE_EVENT(fscache_gang_lookup,
-	    TP_PROTO(struct fscache_cookie *cookie, struct fscache_operation *op,
-		     void **results, int n, pgoff_t store_limit),
-
-	    TP_ARGS(cookie, op, results, n, store_limit),
-
-	    TP_STRUCT__entry(
-		    __field(unsigned int,		cookie		)
-		    __field(unsigned int,		op		)
-		    __field(pgoff_t,			results0	)
-		    __field(int,			n		)
-		    __field(pgoff_t,			store_limit	)
-			     ),
-
-	    TP_fast_assign(
-		    __entry->cookie		= cookie->debug_id;
-		    __entry->op			= op->debug_id;
-		    __entry->results0		= results[0] ? ((struct page *)results[0])->index : (pgoff_t)-1;
-		    __entry->n			= n;
-		    __entry->store_limit	= store_limit;
-			   ),
-
-	    TP_printk("c=%08x op=%08x r0=%lx n=%d sl=%lx",
-		      __entry->cookie, __entry->op, __entry->results0, __entry->n,
-		      __entry->store_limit)
-	    );
-
 #endif /* _TRACE_FSCACHE_H */
 
 /* This part must be outside protection */
