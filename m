From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: read/write on RADOS using external buffer
Date: Tue, 19 Oct 2010 21:10:48 -0700
Message-ID: <AANLkTim7ZEAUuZhc+u99cMSi1sD6OQ=AhKN8ONVg61yb@mail.gmail.com>
References: <AANLkTikRnvWbsD5OD7a88hpHsm5N3hJteaisYkfjdY2H@mail.gmail.com>
	<Pine.LNX.4.64.1009141142250.8559@cobra.newdream.net>
	<20101019222727.GA1737@enoki.dokukino.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:62426 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750781Ab0JTEKt convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Oct 2010 00:10:49 -0400
Received: by pxi16 with SMTP id 16so794047pxi.19
        for <ceph-devel@vger.kernel.org>; Tue, 19 Oct 2010 21:10:48 -0700 (PDT)
In-Reply-To: <20101019222727.GA1737@enoki.dokukino.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Takuya ASADA <syuu@dokukino.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

Takuya:
At first glance this looks okay, but we're going to want to review it
carefully given the changes to SimpleMessenger, and check its impact
on performance, etc to decide if this is something we actually want to
merge, or if we'd like to implement this as a derivative messenger or
something. :)
Could you let us know how you've been testing this? :)
-Greg

On Tue, Oct 19, 2010 at 3:27 PM, Takuya ASADA <syuu@dokukino.com> wrote=
:
> Hi,
>
> I just implemented the patch to support external buffer on Rados::rea=
d() and Rados::write().
>
> diff --git a/src/include/librados.hpp b/src/include/librados.hpp
> index 06fa3b2..bfb0f5b 100644
> --- a/src/include/librados.hpp
> +++ b/src/include/librados.hpp
> @@ -63,8 +63,10 @@ public:
> =A0 int create(pool_t pool, const std::string& oid, bool exclusive);
>
> =A0 int write(pool_t pool, const std::string& oid, off_t off, bufferl=
ist& bl, size_t len);
> + =A0int write(pool_t pool, const std::string& oid, off_t off, void *=
buf, size_t len);
> =A0 int write_full(pool_t pool, const std::string& oid, bufferlist& b=
l);
> =A0 int read(pool_t pool, const std::string& oid, off_t off, bufferli=
st& bl, size_t len);
> + =A0int read(pool_t pool, const std::string& oid, off_t off, void *b=
uf, size_t len);
> =A0 int remove(pool_t pool, const std::string& oid);
> =A0 int trunc(pool_t pool, const std::string& oid, size_t size);
>
> @@ -135,4 +137,3 @@ public:
> =A0}
>
> =A0#endif
> -
> diff --git a/src/librados.cc b/src/librados.cc
> index 4c8a464..91e6a27 100644
> --- a/src/librados.cc
> +++ b/src/librados.cc
> @@ -72,11 +72,12 @@ class RadosClient : public Dispatcher
>
> =A0 Mutex lock;
> =A0 Cond cond;
> + =A0static hash_map<tid_t, bufferptr*> buffer_map;
> + =A0static bufferptr* fetch_buffer_func(tid_t tid);
>
> -
> =A0public:
> =A0 RadosClient() : messenger(NULL), lock("radosclient") {
> - =A0 =A0messenger =3D new SimpleMessenger();
> + =A0 =A0messenger =3D new SimpleMessenger(&RadosClient::fetch_buffer=
_func);
> =A0 }
>
> =A0 ~RadosClient();
> @@ -132,8 +133,10 @@ public:
> =A0 // io
> =A0 int create(PoolCtx& pool, const object_t& oid, bool exclusive);
> =A0 int write(PoolCtx& pool, const object_t& oid, off_t off, bufferli=
st& bl, size_t len);
> + =A0int write(PoolCtx& pool, const object_t& oid, off_t off, void *b=
uf, size_t len);
> =A0 int write_full(PoolCtx& pool, const object_t& oid, bufferlist& bl=
);
> =A0 int read(PoolCtx& pool, const object_t& oid, off_t off, bufferlis=
t& bl, size_t len);
> + =A0int read(PoolCtx& pool, const object_t& oid, off_t off, void *bu=
f, size_t len);
> =A0 int remove(PoolCtx& pool, const object_t& oid);
> =A0 int stat(PoolCtx& pool, const object_t& oid, uint64_t *psize, tim=
e_t *pmtime);
> =A0 int trunc(PoolCtx& pool, const object_t& oid, size_t size);
> @@ -870,6 +873,15 @@ int RadosClient::write(PoolCtx& pool, const obje=
ct_t& oid, off_t off, bufferlist
> =A0 return len;
> =A0}
>
> +int RadosClient::write(PoolCtx& pool, const object_t& oid, off_t off=
, void *buf, size_t len)
> +{
> + =A0bufferptr bp =3D buffer::create_static(len, static_cast<char *>(=
buf));
> + =A0bufferlist bl;
> +
> + =A0bl.push_back(bp);
> + =A0return write(pool, oid, off, bl, len);
> +}
> +
> =A0int RadosClient::write_full(PoolCtx& pool, const object_t& oid, bu=
fferlist& bl)
> =A0{
> =A0 utime_t ut =3D g_clock.now();
> @@ -1116,6 +1128,46 @@ int RadosClient::read(PoolCtx& pool, const obj=
ect_t& oid, off_t off, bufferlist&
> =A0 return bl.length();
> =A0}
>
> +int RadosClient::read(PoolCtx& pool, const object_t& oid, off_t off,=
 void *buf, size_t len)
> +{
> + =A0SnapContext snapc;
> +
> + =A0Mutex mylock("RadosClient::read::mylock");
> + =A0Cond cond;
> + =A0bool done;
> + =A0int r;
> + =A0Context *onack =3D new C_SafeCond(&mylock, &cond, &done, &r);
> + =A0bufferptr bp =3D buffer::create_static(len, static_cast<char *>(=
buf));
> + =A0bufferlist bl;
> +
> + =A0bl.push_back(bp);
> + =A0lock.Lock();
> + =A0ceph_object_layout layout =3D objecter->osdmap->make_object_layo=
ut(oid, pool.poolid);
> + =A0tid_t tid =3D objecter->get_tid();
> + =A0buffer_map[tid] =3D &bp;
> + =A0objecter->read_with_tid(oid, layout,
> + =A0 =A0 =A0 =A0 =A0 =A0 off, len, pool.snap_seq, &bl, 0,
> + =A0 =A0 =A0 =A0 =A0 =A0 onack, tid);
> + =A0lock.Unlock();
> +
> + =A0mylock.Lock();
> + =A0while (!done)
> + =A0 =A0cond.Wait(mylock);
> + =A0mylock.Unlock();
> + =A0buffer_map.erase(tid);
> + =A0dout(10) << "Objecter returned from read r=3D" << r << dendl;
> +
> + =A0if (r < 0)
> + =A0 =A0return r;
> +
> + =A0if (bl.length() < len) {
> + =A0 =A0dout(10) << "Returned length " << bl.length()
> + =A0 =A0 =A0 =A0 =A0 =A0<< " less than original length "<< len << de=
ndl;
> + =A0}
> +
> + =A0return bl.length();
> +}
> +
> =A0int RadosClient::stat(PoolCtx& pool, const object_t& oid, uint64_t=
 *psize, time_t *pmtime)
> =A0{
> =A0 SnapContext snapc;
> @@ -1251,6 +1303,13 @@ int RadosClient::getxattrs(PoolCtx& pool, cons=
t object_t& oid, map<std::string,
> =A0 return r;
> =A0}
>
> +hash_map<tid_t, bufferptr*> RadosClient::buffer_map;
> +
> +bufferptr* RadosClient::fetch_buffer_func(tid_t tid)
> +{
> + =A0return buffer_map[tid];
> +}
> +
> =A0// ---------------------------------------------
>
> =A0namespace librados {
> @@ -1401,6 +1460,14 @@ int Rados::write(rados_pool_t pool, const stri=
ng& o, off_t off, bufferlist& bl,
> =A0 return ((RadosClient *)client)->write(*(RadosClient::PoolCtx *)po=
ol, oid, off, bl, len);
> =A0}
>
> +int Rados::write(rados_pool_t pool, const string& o, off_t off, void=
 *buf, size_t len)
> +{
> + =A0if (!client)
> + =A0 =A0return -EINVAL;
> + =A0object_t oid(o);
> + =A0return ((RadosClient *)client)->write(*(RadosClient::PoolCtx *)p=
ool, oid, off, buf, len);
> +}
> +
> =A0int Rados::write_full(rados_pool_t pool, const string& o, bufferli=
st& bl)
> =A0{
> =A0 if (!client)
> @@ -1433,6 +1500,14 @@ int Rados::read(rados_pool_t pool, const strin=
g& o, off_t off, bufferlist& bl, s
> =A0 return ((RadosClient *)client)->read(*(RadosClient::PoolCtx *)poo=
l, oid, off, bl, len);
> =A0}
>
> +int Rados::read(rados_pool_t pool, const string& o, off_t off, void =
*buf, size_t len)
> +{
> + =A0if (!client)
> + =A0 =A0return -EINVAL;
> + =A0object_t oid(o);
> + =A0return ((RadosClient *)client)->read(*(RadosClient::PoolCtx *)po=
ol, oid, off, buf, len);
> +}
> +
> =A0int Rados::getxattr(rados_pool_t pool, const string& o, const char=
 *name, bufferlist& bl)
> =A0{
> =A0 if (!client)
> diff --git a/src/msg/SimpleMessenger.cc b/src/msg/SimpleMessenger.cc
> index 4632267..75b4576 100644
> --- a/src/msg/SimpleMessenger.cc
> +++ b/src/msg/SimpleMessenger.cc
> @@ -51,7 +51,7 @@ static ostream& _prefix(SimpleMessenger *messenger)=
 {
> =A0#define closed_socket() //dout(20) << "closed_socket " << --sockop=
en << dendl;
> =A0#define opened_socket() //dout(20) << "opened_socket " << ++sockop=
en << dendl;
>
> -
> +SimpleMessenger::fetch_buffer_callback_t SimpleMessenger::fetch_buff=
er_callback =3D 0;
>
> =A0/********************************************
> =A0* Accepter
> @@ -1786,36 +1786,47 @@ int SimpleMessenger::Pipe::read_message(Messa=
ge **pm)
> =A0 data_len =3D le32_to_cpu(header.data_len);
> =A0 data_off =3D le32_to_cpu(header.data_off);
> =A0 if (data_len) {
> - =A0 =A0int left =3D data_len;
> - =A0 =A0if (data_off & ~PAGE_MASK) {
> - =A0 =A0 =A0// head
> - =A0 =A0 =A0int head =3D MIN(PAGE_SIZE - (data_off & ~PAGE_MASK),
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(unsigned)left);
> - =A0 =A0 =A0bufferptr bp =3D buffer::create(head);
> - =A0 =A0 =A0if (tcp_read( sd, bp.c_str(), head, messenger->timeout )=
 < 0)
> + =A0 =A0if (fetch_buffer_callback) {
> + =A0 =A0 =A0bufferptr *bpp =3D fetch_buffer_callback(header.tid);
> + =A0 =A0 =A0if (!bpp)
> + =A0 =A0 =A0 goto allocate_buffer;
> + =A0 =A0 =A0if (tcp_read( sd, bpp->c_str(), data_len, messenger->tim=
eout ) < 0)
> =A0 =A0 =A0 =A0goto out_dethrottle;
> - =A0 =A0 =A0data.push_back(bp);
> - =A0 =A0 =A0left -=3D head;
> - =A0 =A0 =A0dout(20) << "reader got data head " << head << dendl;
> - =A0 =A0}
> + =A0 =A0 =A0data.push_back(*bpp);
> + =A0 =A0 =A0dout(20) << "reader got data " << data_len << dendl;
> + =A0 =A0}else{
> + =A0 =A0allocate_buffer:
> + =A0 =A0 =A0int left =3D data_len;
> + =A0 =A0 =A0if (data_off & ~PAGE_MASK) {
> + =A0 =A0 =A0 // head
> + =A0 =A0 =A0 int head =3D MIN(PAGE_SIZE - (data_off & ~PAGE_MASK),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(unsigned)left);
> + =A0 =A0 =A0 bufferptr bp =3D buffer::create(head);
> + =A0 =A0 =A0 if (tcp_read( sd, bp.c_str(), head, messenger->timeout =
) < 0)
> + =A0 =A0 =A0 =A0 goto out_dethrottle;
> + =A0 =A0 =A0 data.push_back(bp);
> + =A0 =A0 =A0 left -=3D head;
> + =A0 =A0 =A0 dout(20) << "reader got data head " << head << dendl;
> + =A0 =A0 =A0}
>
> - =A0 =A0// middle
> - =A0 =A0int middle =3D left & PAGE_MASK;
> - =A0 =A0if (middle > 0) {
> - =A0 =A0 =A0bufferptr bp =3D buffer::create_page_aligned(middle);
> - =A0 =A0 =A0if (tcp_read( sd, bp.c_str(), middle, messenger->timeout=
 ) < 0)
> - =A0 =A0 =A0 goto out_dethrottle;
> - =A0 =A0 =A0data.push_back(bp);
> - =A0 =A0 =A0left -=3D middle;
> - =A0 =A0 =A0dout(20) << "reader got data page-aligned middle " << mi=
ddle << dendl;
> - =A0 =A0}
> + =A0 =A0 =A0// middle
> + =A0 =A0 =A0int middle =3D left & PAGE_MASK;
> + =A0 =A0 =A0if (middle > 0) {
> + =A0 =A0 =A0 bufferptr bp =3D buffer::create_page_aligned(middle);
> + =A0 =A0 =A0 if (tcp_read( sd, bp.c_str(), middle, messenger->timeou=
t ) < 0)
> + =A0 =A0 =A0 =A0 goto out_dethrottle;
> + =A0 =A0 =A0 data.push_back(bp);
> + =A0 =A0 =A0 left -=3D middle;
> + =A0 =A0 =A0 dout(20) << "reader got data page-aligned middle " << m=
iddle << dendl;
> + =A0 =A0 =A0}
>
> - =A0 =A0if (left) {
> - =A0 =A0 =A0bufferptr bp =3D buffer::create(left);
> - =A0 =A0 =A0if (tcp_read( sd, bp.c_str(), left, messenger->timeout )=
 < 0)
> - =A0 =A0 =A0 goto out_dethrottle;
> - =A0 =A0 =A0data.push_back(bp);
> - =A0 =A0 =A0dout(20) << "reader got data tail " << left << dendl;
> + =A0 =A0 =A0if (left) {
> + =A0 =A0 =A0 bufferptr bp =3D buffer::create(left);
> + =A0 =A0 =A0 if (tcp_read( sd, bp.c_str(), left, messenger->timeout =
) < 0)
> + =A0 =A0 =A0 =A0 goto out_dethrottle;
> + =A0 =A0 =A0 data.push_back(bp);
> + =A0 =A0 =A0 dout(20) << "reader got data tail " << left << dendl;
> + =A0 =A0 =A0}
> =A0 =A0 }
> =A0 }
>
> diff --git a/src/msg/SimpleMessenger.h b/src/msg/SimpleMessenger.h
> index b4a0ef3..72a5a1b 100644
> --- a/src/msg/SimpleMessenger.h
> +++ b/src/msg/SimpleMessenger.h
> @@ -567,6 +567,9 @@ private:
> =A0 SimpleMessenger *messenger; //hack to make dout macro work, will =
fix
> =A0 int timeout;
>
> + =A0typedef bufferptr* (*fetch_buffer_callback_t) (tid_t);
> + =A0static fetch_buffer_callback_t fetch_buffer_callback;
> +
> =A0public:
> =A0 SimpleMessenger() :
> =A0 =A0 Messenger(entity_name_t()),
> @@ -580,6 +583,20 @@ public:
> =A0 =A0 // for local dmsg delivery
> =A0 =A0 dispatch_queue.local_pipe =3D new Pipe(this, Pipe::STATE_OPEN=
);
> =A0 }
> +
> + =A0SimpleMessenger(fetch_buffer_callback_t callback) :
> + =A0 =A0Messenger(entity_name_t()),
> + =A0 =A0accepter(this),
> + =A0 =A0lock("SimpleMessenger::lock"), started(false), did_bind(fals=
e),
> + =A0 =A0dispatch_throttler(g_conf.ms_dispatch_throttle_bytes), need_=
addr(true),
> + =A0 =A0destination_stopped(true), my_type(-1),
> + =A0 =A0global_seq_lock("SimpleMessenger::global_seq_lock"), global_=
seq(0),
> + =A0 =A0reaper_thread(this), reaper_started(false), reaper_stop(fals=
e),
> + =A0 =A0dispatch_thread(this), messenger(this) {
> + =A0 =A0fetch_buffer_callback =3D callback;
> + =A0 =A0// for local dmsg delivery
> + =A0 =A0dispatch_queue.local_pipe =3D new Pipe(this, Pipe::STATE_OPE=
N);
> + =A0}
> =A0 ~SimpleMessenger() {
> =A0 =A0 delete dispatch_queue.local_pipe;
> =A0 }
> diff --git a/src/osdc/Objecter.h b/src/osdc/Objecter.h
> index a34c0a9..fd43795 100644
> --- a/src/osdc/Objecter.h
> +++ b/src/osdc/Objecter.h
> @@ -530,6 +530,21 @@ private:
> =A0 =A0 o->outbl =3D pbl;
> =A0 =A0 return op_submit(o);
> =A0 }
> + =A0tid_t read_with_tid(const object_t& oid, ceph_object_layout ol,
> + =A0 =A0 =A0 =A0 =A0 =A0uint64_t off, uint64_t len, snapid_t snap, b=
ufferlist *pbl, int flags,
> + =A0 =A0 =A0 =A0 =A0 =A0Context *onfinish, tid_t tid) {
> + =A0 =A0vector<OSDOp> ops(1);
> + =A0 =A0ops[0].op.op =3D CEPH_OSD_OP_READ;
> + =A0 =A0ops[0].op.extent.offset =3D off;
> + =A0 =A0ops[0].op.extent.length =3D len;
> + =A0 =A0ops[0].op.extent.truncate_size =3D 0;
> + =A0 =A0ops[0].op.extent.truncate_seq =3D 0;
> + =A0 =A0Op *o =3D new Op(oid, ol, ops, flags, onfinish, 0);
> + =A0 =A0o->snapid =3D snap;
> + =A0 =A0o->outbl =3D pbl;
> + =A0 =A0o->tid =3D tid;
> + =A0 =A0return op_submit(o);
> + =A0}
> =A0 tid_t read_trunc(const object_t& oid, ceph_object_layout ol,
> =A0 =A0 =A0 =A0 =A0 =A0 uint64_t off, uint64_t len, snapid_t snap, bu=
fferlist *pbl, int flags,
> =A0 =A0 =A0 =A0 =A0 =A0 uint64_t trunc_size, __u32 trunc_seq,
> @@ -725,6 +740,8 @@ private:
>
> =A0 void list_objects(ListContext *p, Context *onfinish);
>
> + =A0tid_t get_tid(void) { return ++last_tid; }
> +
> =A0 // -------------------------
> =A0 // pool ops
> =A0private:
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
