From: David Howells <dhowells@redhat.com>
Subject: [RFC PATCH 49/61] afs: Don't truncate iter during data fetch
Date: Mon, 04 May 2020 18:14:52 +0100
Message-ID: <158861249201.340223.13035445866976590375.stgit@warthog.procyon.org.uk>
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

Don't truncate the iterator to correspond to the actual data size when
fetching the data from the server - rather, pass the length we want to read
to rxrpc.

This will allow the clear-after-read code in future to simply clear the
remaining iterator capacity rather than having to reinitialise the
iterator.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/fsclient.c      |    6 ++++--
 fs/afs/internal.h      |    6 ++++++
 fs/afs/rxrpc.c         |   13 +++++++++----
 fs/afs/yfsclient.c     |    6 ++++--
 include/net/af_rxrpc.h |    2 +-
 net/rxrpc/recvmsg.c    |    9 +++++----
 6 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index 68fc46634346..492fbd964576 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -327,8 +327,9 @@ static int afs_deliver_fs_fetch_data(struct afs_call *call)
 	unsigned int size;
 	int ret;
 
-	_enter("{%u,%zu/%llu}",
-	       call->unmarshall, iov_iter_count(call->iter), req->actual_len);
+	_enter("{%u,%zu,%zu/%llu}",
+	       call->unmarshall, call->iov_len, iov_iter_count(call->iter),
+	       req->actual_len);
 
 	switch (call->unmarshall) {
 	case 0:
@@ -365,6 +366,7 @@ static int afs_deliver_fs_fetch_data(struct afs_call *call)
 			size = PAGE_SIZE - req->offset;
 		else
 			size = req->remain;
+		call->iov_len = size;
 		call->bvec[0].bv_len = size;
 		call->bvec[0].bv_offset = req->offset;
 		call->bvec[0].bv_page = req->pages[req->index];
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 68d3eb0dc367..521a03023112 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -115,6 +115,7 @@ struct afs_call {
 	struct afs_vnode	*lvnode;	/* vnode being locked */
 	void			*request;	/* request data (first part) */
 	struct address_space	*mapping;	/* Pages being written from */
+	size_t			iov_len;	/* Size of *iter to be used */
 	struct iov_iter		def_iter;	/* Default buffer/data iterator */
 	struct iov_iter		*iter;		/* Iterator currently in use */
 	union {	/* Convenience for ->def_iter */
@@ -1131,6 +1132,7 @@ static inline void afs_set_fc_call(struct afs_call *call, struct afs_fs_cursor *
 
 static inline void afs_extract_begin(struct afs_call *call, void *buf, size_t size)
 {
+	call->iov_len = size;
 	call->kvec[0].iov_base = buf;
 	call->kvec[0].iov_len = size;
 	iov_iter_kvec(&call->def_iter, READ, call->kvec, 1, size);
@@ -1138,21 +1140,25 @@ static inline void afs_extract_begin(struct afs_call *call, void *buf, size_t si
 
 static inline void afs_extract_to_tmp(struct afs_call *call)
 {
+	call->iov_len = sizeof(call->tmp);
 	afs_extract_begin(call, &call->tmp, sizeof(call->tmp));
 }
 
 static inline void afs_extract_to_tmp64(struct afs_call *call)
 {
+	call->iov_len = sizeof(call->tmp64);
 	afs_extract_begin(call, &call->tmp64, sizeof(call->tmp64));
 }
 
 static inline void afs_extract_discard(struct afs_call *call, size_t size)
 {
+	call->iov_len = size;
 	iov_iter_discard(&call->def_iter, READ, size);
 }
 
 static inline void afs_extract_to_buf(struct afs_call *call, size_t size)
 {
+	call->iov_len = size;
 	afs_extract_begin(call, call->buffer, size);
 }
 
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index 1ecc67da6c1a..b2296feaaff3 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -364,6 +364,7 @@ void afs_make_call(struct afs_addr_cursor *ac, struct afs_call *call, gfp_t gfp)
 	struct rxrpc_call *rxcall;
 	struct msghdr msg;
 	struct kvec iov[1];
+	size_t len;
 	s64 tx_total_len;
 	int ret;
 
@@ -465,9 +466,10 @@ void afs_make_call(struct afs_addr_cursor *ac, struct afs_call *call, gfp_t gfp)
 		rxrpc_kernel_abort_call(call->net->socket, rxcall,
 					RX_USER_ABORT, ret, "KSD");
 	} else {
+		len = 0;
 		iov_iter_kvec(&msg.msg_iter, READ, NULL, 0, 0);
 		rxrpc_kernel_recv_data(call->net->socket, rxcall,
-				       &msg.msg_iter, false,
+				       &msg.msg_iter, &len, false,
 				       &call->abort_code, &call->service_id);
 		ac->abort_code = call->abort_code;
 		ac->responded = true;
@@ -503,6 +505,7 @@ void afs_make_call(struct afs_addr_cursor *ac, struct afs_call *call, gfp_t gfp)
 static void afs_deliver_to_call(struct afs_call *call)
 {
 	enum afs_call_state state;
+	size_t len;
 	u32 abort_code, remote_abort = 0;
 	int ret;
 
@@ -515,10 +518,11 @@ static void afs_deliver_to_call(struct afs_call *call)
 	       state == AFS_CALL_SV_AWAIT_ACK
 	       ) {
 		if (state == AFS_CALL_SV_AWAIT_ACK) {
+			len = 0;
 			iov_iter_kvec(&call->def_iter, READ, NULL, 0, 0);
 			ret = rxrpc_kernel_recv_data(call->net->socket,
 						     call->rxcall, &call->def_iter,
-						     false, &remote_abort,
+						     &len, false, &remote_abort,
 						     &call->service_id);
 			trace_afs_receive_data(call, &call->def_iter, false, ret);
 
@@ -926,10 +930,11 @@ int afs_extract_data(struct afs_call *call, bool want_more)
 	u32 remote_abort = 0;
 	int ret;
 
-	_enter("{%s,%zu},%d", call->type->name, iov_iter_count(iter), want_more);
+	_enter("{%s,%zu,%zu},%d",
+	       call->type->name, call->iov_len, iov_iter_count(iter), want_more);
 
 	ret = rxrpc_kernel_recv_data(net->socket, call->rxcall, iter,
-				     want_more, &remote_abort,
+				     &call->iov_len, want_more, &remote_abort,
 				     &call->service_id);
 	if (ret == 0 || ret == -EAGAIN)
 		return ret;
diff --git a/fs/afs/yfsclient.c b/fs/afs/yfsclient.c
index 7f419f8bb943..1164f48e308d 100644
--- a/fs/afs/yfsclient.c
+++ b/fs/afs/yfsclient.c
@@ -442,8 +442,9 @@ static int yfs_deliver_fs_fetch_data64(struct afs_call *call)
 	unsigned int size;
 	int ret;
 
-	_enter("{%u,%zu/%llu}",
-	       call->unmarshall, iov_iter_count(call->iter), req->actual_len);
+	_enter("{%u,%zu, %zu/%llu}",
+	       call->unmarshall, call->iov_len, iov_iter_count(call->iter),
+	       req->actual_len);
 
 	switch (call->unmarshall) {
 	case 0:
@@ -475,6 +476,7 @@ static int yfs_deliver_fs_fetch_data64(struct afs_call *call)
 			size = PAGE_SIZE - req->offset;
 		else
 			size = req->remain;
+		call->iov_len = size;
 		call->bvec[0].bv_len = size;
 		call->bvec[0].bv_offset = req->offset;
 		call->bvec[0].bv_page = req->pages[req->index];
diff --git a/include/net/af_rxrpc.h b/include/net/af_rxrpc.h
index 04e97bab6f28..0f7d13547b77 100644
--- a/include/net/af_rxrpc.h
+++ b/include/net/af_rxrpc.h
@@ -53,7 +53,7 @@ int rxrpc_kernel_send_data(struct socket *, struct rxrpc_call *,
 			   struct msghdr *, size_t,
 			   rxrpc_notify_end_tx_t);
 int rxrpc_kernel_recv_data(struct socket *, struct rxrpc_call *,
-			   struct iov_iter *, bool, u32 *, u16 *);
+			   struct iov_iter *, size_t *, bool, u32 *, u16 *);
 bool rxrpc_kernel_abort_call(struct socket *, struct rxrpc_call *,
 			     u32, int, const char *);
 void rxrpc_kernel_end_call(struct socket *, struct rxrpc_call *);
diff --git a/net/rxrpc/recvmsg.c b/net/rxrpc/recvmsg.c
index 8578c39ec839..802b712f3d79 100644
--- a/net/rxrpc/recvmsg.c
+++ b/net/rxrpc/recvmsg.c
@@ -624,6 +624,7 @@ int rxrpc_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
  * @sock: The socket that the call exists on
  * @call: The call to send data through
  * @iter: The buffer to receive into
+ * @_len: The amount of data we want to receive (decreased on return)
  * @want_more: True if more data is expected to be read
  * @_abort: Where the abort code is stored if -ECONNABORTED is returned
  * @_service: Where to store the actual service ID (may be upgraded)
@@ -639,7 +640,7 @@ int rxrpc_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
  * *_abort should also be initialised to 0.
  */
 int rxrpc_kernel_recv_data(struct socket *sock, struct rxrpc_call *call,
-			   struct iov_iter *iter,
+			   struct iov_iter *iter, size_t *_len,
 			   bool want_more, u32 *_abort, u16 *_service)
 {
 	size_t offset = 0;
@@ -647,7 +648,7 @@ int rxrpc_kernel_recv_data(struct socket *sock, struct rxrpc_call *call,
 
 	_enter("{%d,%s},%zu,%d",
 	       call->debug_id, rxrpc_call_states[call->state],
-	       iov_iter_count(iter), want_more);
+	       *_len, want_more);
 
 	ASSERTCMP(call->state, !=, RXRPC_CALL_SERVER_ACCEPTING);
 
@@ -658,8 +659,8 @@ int rxrpc_kernel_recv_data(struct socket *sock, struct rxrpc_call *call,
 	case RXRPC_CALL_SERVER_RECV_REQUEST:
 	case RXRPC_CALL_SERVER_ACK_REQUEST:
 		ret = rxrpc_recvmsg_data(sock, call, NULL, iter,
-					 iov_iter_count(iter), 0,
-					 &offset);
+					 *_len, 0, &offset);
+		*_len -= offset;
 		if (ret < 0)
 			goto out;
 
