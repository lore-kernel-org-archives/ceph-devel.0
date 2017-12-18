From: Eric Cano <Eric.Cano@cern.ch>
Subject: Segfault when connecting to cluster using Rados API (problem with
 pick_a_shard()?)
Date: Mon, 18 Dec 2017 14:28:12 +0000
Message-ID: <C23C0F22777EE8499587B3474C14DDF302605C469A@CERNXCHG52.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-eopbgr00048.outbound.protection.outlook.com ([40.107.0.48]:55532
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752688AbdLRO2m (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 18 Dec 2017 09:28:42 -0500
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi everyone,

We experience segfaults when connecting to the Rados cluster from our appli=
cation. The problem was first encountered when switching from 12.2.0 to 12.=
2.2. We downgraded to 12.2.1, which helped for some time, but we now also e=
ncounter the problem in 12.2.1. The current crash is for 12.2.1, which we s=
witched for as it seemed to work better.

We had a crash of a command line tool for our application, so the context o=
f the crash is rather simple. The segfault happens in a Rados thread, where=
 apparently pick_a_shard() delivered a wrong address :

#0=A0 operator+=3D (__i=3D1, this=3D0x8345dbd0a008) at /usr/include/c++/4.8=
.2/bits/atomic_base.h:420
#1=A0 mempool::pool_t::adjust_count (this=3D0x8345dbd0a000, items=3Ditems@e=
ntry=3D1, bytes=3Dbytes@entry=3D4008) at /usr/src/debug/ceph-12.2.1/src/com=
mon/mempool.cc:85
#2=A0 0x00007f544efa0755 in reassign_to_mempool (this=3D<optimized out>, th=
is=3D<optimized out>, pool=3D1026552624) at /usr/src/debug/ceph-12.2.1/src/=
common/buffer.cc:207
#3=A0 ceph::buffer::list::append (this=3Dthis@entry=3D0x7f543d2ff330, data=
=3D0xf64d89 "", len=3Dlen@entry=3D272) at /usr/src/debug/ceph-12.2.1/src/co=
mmon/buffer.cc:1915
#4=A0 0x00007f54443c7976 in AsyncConnection::_process_connection (this=3Dth=
is@entry=3D0xf61740) at /usr/src/debug/ceph-12.2.1/src/msg/async/AsyncConne=
ction.cc:962
#5=A0 0x00007f54443ca8a8 in AsyncConnection::process (this=3D0xf61740) at /=
usr/src/debug/ceph-12.2.1/src/msg/async/AsyncConnection.cc:838
#6=A0 0x00007f54443dceb9 in EventCenter::process_events (this=3Dthis@entry=
=3D0xf1dda0, timeout_microseconds=3D<optimized out>, timeout_microseconds@e=
ntry=3D30000000, working_dur=3Dworking_dur@entry=3D0x7f543d2ffaf0) at /usr/=
src/debug/ceph-12.2.1/src/msg/async/Event.cc:409
#7=A0 0x00007f54443e05ee in NetworkStack::__lambda4::operator() (__closure=
=3D0xf4af60) at /usr/src/debug/ceph-12.2.1/src/msg/async/Stack.cc:51
#8=A0 0x00007f544d5ed2b0 in std::(anonymous namespace)::execute_native_thre=
ad_routine (__p=3D<optimized out>) at ../../../../../libstdc++-v3/src/c++11=
/thread.cc:84
#9=A0 0x00007f544e16ee25 in start_thread (arg=3D0x7f543d301700) at pthread_=
create.c:308
#10 0x00007f544cd5534d in clone () at ../sysdeps/unix/sysv/linux/x86_64/clo=
ne.S:113

(gdb) frame 1
#1=A0 mempool::pool_t::adjust_count (this=3D0x8345dbd0a000, items=3Ditems@e=
ntry=3D1, bytes=3Dbytes@entry=3D4008) at /usr/src/debug/ceph-12.2.1/src/com=
mon/mempool.cc:85
85=A0=A0=A0=A0=A0=A0=A0 shard->items +=3D items;
(gdb) l
80=A0=A0=A0=A0=A0 }
81
82=A0=A0=A0=A0=A0 void mempool::pool_t::adjust_count(ssize_t items, ssize_t=
 bytes)
83=A0=A0=A0=A0=A0 {
84=A0=A0=A0=A0=A0=A0=A0 shard_t *shard =3D pick_a_shard();
85=A0=A0=A0=A0=A0=A0=A0 shard->items +=3D items;
86=A0=A0=A0=A0=A0=A0=A0 shard->bytes +=3D bytes;
87=A0=A0=A0=A0=A0 }
88
89=A0=A0=A0=A0=A0 void mempool::pool_t::get_stats(
(gdb) p shard
$1 =3D (mempool::shard_t *) 0x8345dbd0a000
(gdb) p *shard
Cannot access memory at address 0x8345dbd0a000

The user and main thread is as follows (listing is for frame 4):

(gdb) thread 7
[Switching to thread 7 (Thread 0x7f545004e9c0 (LWP 31308))]
#0=A0 pthread_cond_timedwait@@GLIBC_2.3.2 () at ../nptl/sysdeps/unix/sysv/l=
inux/x86_64/pthread_cond_timedwait.S:238
238=A0=A0=A0=A0 62:=A0=A0=A0=A0 movq=A0=A0=A0 %rax, %r14
(gdb) bt
#0=A0 pthread_cond_timedwait@@GLIBC_2.3.2 () at ../nptl/sysdeps/unix/sysv/l=
inux/x86_64/pthread_cond_timedwait.S:238
#1=A0 0x00007f54442a2e3c in WaitUntil (when=3D..., mutex=3D..., this=3D0xe7=
4190) at /usr/src/debug/ceph-12.2.1/src/common/Cond.h:64
#2=A0 MonClient::authenticate (this=3Dthis@entry=3D0xe73d58, timeout=3D300)=
 at /usr/src/debug/ceph-12.2.1/src/mon/MonClient.cc:464
#3=A0 0x00007f544ef9058c in librados::RadosClient::connect (this=3D0xe73d10=
) at /usr/src/debug/ceph-12.2.1/src/librados/RadosClient.cc:299
#4=A0 0x00007f544f73a1ee in cta::objectstore::BackendRados::BackendRados (t=
his=3D0xe08680, logger=3D..., userId=3D"eoscta", pool=3D"eoscta_metadata", =
radosNameSpace=3D"cta-ns") at /usr/src/debug/cta-0.0-85/objectstore/Backend=
Rados.cpp:100
#5=A0 0x00007f544f75eabc in cta::objectstore::BackendFactory::createBackend=
 (URL=3D"rados://eoscta@eoscta_metadata:cta-ns", logger=3D...) at /usr/src/=
debug/cta-0.0-85/objectstore/BackendFactory.cpp:42
#6=A0 0x000000000041024e in main (argc=3D2, argv=3D0x7ffdde466e78) at /usr/=
src/debug/cta-0.0-85/objectstore/cta-objectstore-dump-object.cpp:44

(gdb) l -
75=A0=A0=A0=A0=A0 #define TIMESTAMPEDPRINT(A)
76=A0=A0=A0=A0=A0 #define NOTIFYLOCKED()
77=A0=A0=A0=A0=A0 #define NOTIFYRELEASED()
78=A0=A0=A0=A0=A0 #endif
79
80=A0=A0=A0=A0=A0 namespace cta { namespace objectstore {
81
82=A0=A0=A0=A0=A0 cta::threading::Mutex BackendRados::RadosTimeoutLogger::g=
_mutex;
83
84=A0=A0=A0=A0=A0 BackendRados::BackendRados(log::Logger & logger, const st=
d::string & userId, const std::string & pool,
(gdb) l
85=A0=A0=A0=A0=A0=A0=A0 const std::string &radosNameSpace) :
86=A0=A0=A0=A0=A0 m_user(userId), m_pool(pool), m_namespace(radosNameSpace)=
, m_cluster(), m_radosCtxPool() {
87=A0=A0=A0=A0=A0=A0=A0 log::LogContext lc(logger);
88=A0=A0=A0=A0=A0=A0=A0 cta::exception::Errnum::throwOnReturnedErrno(-m_clu=
ster.init(userId.c_str()),
89=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "In ObjectStoreRados::ObjectStoreRados,=
 failed to m_cluster.init");
90=A0=A0=A0=A0=A0=A0=A0 try {
91=A0=A0=A0=A0=A0=A0=A0=A0=A0 RadosTimeoutLogger rtl;
92=A0=A0=A0=A0=A0=A0=A0=A0=A0 cta::exception::Errnum::throwOnReturnedErrno(=
-m_cluster.conf_read_file(NULL),
93=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "In ObjectStoreRados::ObjectStore=
Rados, failed to m_cluster.conf_read_file");
94=A0=A0=A0=A0=A0=A0=A0=A0=A0 rtl.logIfNeeded("In BackendRados::BackendRado=
s(): m_cluster.conf_read_file()", "no object");
(gdb) l
95=A0=A0=A0=A0=A0=A0=A0=A0=A0 rtl.reset();
96=A0=A0=A0=A0=A0=A0=A0=A0=A0 cta::exception::Errnum::throwOnReturnedErrno(=
-m_cluster.conf_parse_env(NULL),
97=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "In ObjectStoreRados::ObjectStore=
Rados, failed to m_cluster.conf_parse_env");
98=A0=A0=A0=A0=A0=A0=A0=A0=A0 rtl.logIfNeeded("In BackendRados::BackendRado=
s(): m_cluster.conf_parse_env()", "no object");
99=A0=A0=A0=A0=A0=A0=A0=A0=A0 rtl.reset();
100=A0=A0=A0=A0=A0=A0=A0=A0 cta::exception::Errnum::throwOnReturnedErrno(-m=
_cluster.connect(),
101=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "In ObjectStoreRados::ObjectStoreRa=
dos, failed to m_cluster.connect");
102=A0=A0=A0=A0=A0=A0=A0=A0 rtl.logIfNeeded("In BackendRados::BackendRados(=
): m_cluster.connect()", "no object");
103=A0=A0=A0=A0=A0=A0=A0=A0 // Create the connection pool. One per CPU hard=
ware thread.
104=A0=A0=A0=A0=A0=A0=A0=A0 for (size_t i=3D0; i<std::thread::hardware_conc=
urrency(); i++) {

Is there anything we do wrong or a bug somewhere in rados?

Thanks for any help,

Eric Cano

