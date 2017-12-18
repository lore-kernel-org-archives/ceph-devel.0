From: Eric Cano <Eric.Cano@cern.ch>
Subject: RE: Segfault when connecting to cluster using Rados API (problem
 with pick_a_shard()?)
Date: Mon, 18 Dec 2017 15:56:37 +0000
Message-ID: <C23C0F22777EE8499587B3474C14DDF302605C4F71@CERNXCHG52.cern.ch>
References: <C23C0F22777EE8499587B3474C14DDF302605C469A@CERNXCHG52.cern.ch>
 <alpine.DEB.2.11.1712181432440.15063@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-eopbgr00062.outbound.protection.outlook.com ([40.107.0.62]:44600
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934380AbdLRP4p (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 18 Dec 2017 10:56:45 -0500
In-Reply-To: <alpine.DEB.2.11.1712181432440.15063@piezo.novalocal>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Sage,

Thanks for the tip. That was the source of the confusion. Getting all (incl=
uding compilation) to 12.2.2 solved the issue.

Would it be possible to get a new major number for the lib each time the AB=
I changes (or even generating a new one on each compilation)? RPM relies on=
 that to generate the package dependencies, and let us go through due to th=
at:

# rpm -q cta-lib -R | grep rados
...
librados.so.2()(64bit)
...

#  ls -l /usr/lib64/librados*
lrwxrwxrwx. 1 root root      17 Dec 18 15:36 /usr/lib64/librados.so.2 -> li=
brados.so.2.0.0
-rwxr-xr-x. 1 root root 1522232 Nov 30 17:15 /usr/lib64/librados.so.2.0.0
lrwxrwxrwx. 1 root root      24 Dec 18 15:37 /usr/lib64/libradosstriper.so.=
1 -> libradosstriper.so.1.0.0
-rwxr-xr-x. 1 root root 1066440 Nov 30 17:15 /usr/lib64/libradosstriper.so.=
1.0.0
lrwxrwxrwx. 1 root root      20 Dec 18 15:36 /usr/lib64/librados_tp.so.2 ->=
 librados_tp.so.2.0.0
-rwxr-xr-x. 1 root root  878464 Nov 30 17:15 /usr/lib64/librados_tp.so.2.0.=
0

That would be really helpful for admins.

Thanks for the quick answer!
Eric

> -----Original Message-----
> From: Sage Weil [mailto:sage@newdream.net]
> Sent: Monday, December 18, 2017 15:45
> To: Eric Cano <Eric.Cano@cern.ch>
> Cc: ceph-devel@vger.kernel.org
> Subject: Re: Segfault when connecting to cluster using Rados API (problem=
 with pick_a_shard()?)
>=20
> On Mon, 18 Dec 2017, Eric Cano wrote:
> > Hi everyone,
> >
> > We experience segfaults when connecting to the Rados cluster from our
> > application. The problem was first encountered when switching from
> > 12.2.0 to 12.2.2. We downgraded to 12.2.1, which helped for some time,
> > but we now also encounter the problem in 12.2.1. The current crash is
> > for 12.2.1, which we switched for as it seemed to work better.
>=20
> It looks/sounds like the ABI for C++ linkage broke between the point
> releases.  This is really easy to trigger, unfortunately, due to the
> design of the C++ interface.  A recompile of the application
> against the updated headers should fix it.
>=20
> I see two problematic commits:
>  2ef222a58c3801eaac5a6d52dda2de1ffe37407b (mempool change)
>  0048e6a58c7cdf3b3d98df575bc47db8397cd5a9 (buffer::list change)
>=20
> I pushed a branch wip-abi-luminous to
> 	https://shaman.ceph.com/builds/ceph/
>=20
> You can either try that build and see if it fixes it, and/or rebuild your
> application.  Please let us know if either works!
>=20
> Thanks-
> sage
>=20
>=20
> Both are probably straightforward to fix... I'll push a test branch
> >
> > We had a crash of a command line tool for our application, so the conte=
xt of the crash is rather simple. The segfault happens in a
> Rados thread, where apparently pick_a_shard() delivered a wrong address :
> >
> > #0=A0 operator+=3D (__i=3D1, this=3D0x8345dbd0a008) at /usr/include/c++=
/4.8.2/bits/atomic_base.h:420
> > #1=A0 mempool::pool_t::adjust_count (this=3D0x8345dbd0a000, items=3Dite=
ms@entry=3D1, bytes=3Dbytes@entry=3D4008) at
> /usr/src/debug/ceph-12.2.1/src/common/mempool.cc:85
> > #2=A0 0x00007f544efa0755 in reassign_to_mempool (this=3D<optimized out>=
, this=3D<optimized out>, pool=3D1026552624) at
> /usr/src/debug/ceph-12.2.1/src/common/buffer.cc:207
> > #3=A0 ceph::buffer::list::append (this=3Dthis@entry=3D0x7f543d2ff330, d=
ata=3D0xf64d89 "", len=3Dlen@entry=3D272) at /usr/src/debug/ceph-
> 12.2.1/src/common/buffer.cc:1915
> > #4=A0 0x00007f54443c7976 in AsyncConnection::_process_connection (this=
=3Dthis@entry=3D0xf61740) at /usr/src/debug/ceph-
> 12.2.1/src/msg/async/AsyncConnection.cc:962
> > #5=A0 0x00007f54443ca8a8 in AsyncConnection::process (this=3D0xf61740) =
at /usr/src/debug/ceph-
> 12.2.1/src/msg/async/AsyncConnection.cc:838
> > #6=A0 0x00007f54443dceb9 in EventCenter::process_events (this=3Dthis@en=
try=3D0xf1dda0, timeout_microseconds=3D<optimized out>,
> timeout_microseconds@entry=3D30000000, working_dur=3Dworking_dur@entry=3D=
0x7f543d2ffaf0) at /usr/src/debug/ceph-
> 12.2.1/src/msg/async/Event.cc:409
> > #7=A0 0x00007f54443e05ee in NetworkStack::__lambda4::operator() (__clos=
ure=3D0xf4af60) at /usr/src/debug/ceph-
> 12.2.1/src/msg/async/Stack.cc:51
> > #8=A0 0x00007f544d5ed2b0 in std::(anonymous namespace)::execute_native_=
thread_routine (__p=3D<optimized out>) at
> ../../../../../libstdc++-v3/src/c++11/thread.cc:84
> > #9=A0 0x00007f544e16ee25 in start_thread (arg=3D0x7f543d301700) at pthr=
ead_create.c:308
> > #10 0x00007f544cd5534d in clone () at ../sysdeps/unix/sysv/linux/x86_64=
/clone.S:113
> >
> > (gdb) frame 1
> > #1=A0 mempool::pool_t::adjust_count (this=3D0x8345dbd0a000, items=3Dite=
ms@entry=3D1, bytes=3Dbytes@entry=3D4008) at
> /usr/src/debug/ceph-12.2.1/src/common/mempool.cc:85
> > 85=A0=A0=A0=A0=A0=A0=A0 shard->items +=3D items;
> > (gdb) l
> > 80=A0=A0=A0=A0=A0 }
> > 81
> > 82=A0=A0=A0=A0=A0 void mempool::pool_t::adjust_count(ssize_t items, ssi=
ze_t bytes)
> > 83=A0=A0=A0=A0=A0 {
> > 84=A0=A0=A0=A0=A0=A0=A0 shard_t *shard =3D pick_a_shard();
> > 85=A0=A0=A0=A0=A0=A0=A0 shard->items +=3D items;
> > 86=A0=A0=A0=A0=A0=A0=A0 shard->bytes +=3D bytes;
> > 87=A0=A0=A0=A0=A0 }
> > 88
> > 89=A0=A0=A0=A0=A0 void mempool::pool_t::get_stats(
> > (gdb) p shard
> > $1 =3D (mempool::shard_t *) 0x8345dbd0a000
> > (gdb) p *shard
> > Cannot access memory at address 0x8345dbd0a000
> >
> > The user and main thread is as follows (listing is for frame 4):
> >
> > (gdb) thread 7
> > [Switching to thread 7 (Thread 0x7f545004e9c0 (LWP 31308))]
> > #0=A0 pthread_cond_timedwait@@GLIBC_2.3.2 () at ../nptl/sysdeps/unix/sy=
sv/linux/x86_64/pthread_cond_timedwait.S:238
> > 238=A0=A0=A0=A0 62:=A0=A0=A0=A0 movq=A0=A0=A0 %rax, %r14
> > (gdb) bt
> > #0=A0 pthread_cond_timedwait@@GLIBC_2.3.2 () at ../nptl/sysdeps/unix/sy=
sv/linux/x86_64/pthread_cond_timedwait.S:238
> > #1=A0 0x00007f54442a2e3c in WaitUntil (when=3D..., mutex=3D..., this=3D=
0xe74190) at /usr/src/debug/ceph-12.2.1/src/common/Cond.h:64
> > #2=A0 MonClient::authenticate (this=3Dthis@entry=3D0xe73d58, timeout=3D=
300) at /usr/src/debug/ceph-12.2.1/src/mon/MonClient.cc:464
> > #3=A0 0x00007f544ef9058c in librados::RadosClient::connect (this=3D0xe7=
3d10) at /usr/src/debug/ceph-
> 12.2.1/src/librados/RadosClient.cc:299
> > #4=A0 0x00007f544f73a1ee in cta::objectstore::BackendRados::BackendRado=
s (this=3D0xe08680, logger=3D..., userId=3D"eoscta",
> pool=3D"eoscta_metadata", radosNameSpace=3D"cta-ns") at /usr/src/debug/ct=
a-0.0-85/objectstore/BackendRados.cpp:100
> > #5=A0 0x00007f544f75eabc in cta::objectstore::BackendFactory::createBac=
kend (URL=3D"rados://eoscta@eoscta_metadata:cta-ns",
> logger=3D...) at /usr/src/debug/cta-0.0-85/objectstore/BackendFactory.cpp=
:42
> > #6=A0 0x000000000041024e in main (argc=3D2, argv=3D0x7ffdde466e78) at /=
usr/src/debug/cta-0.0-85/objectstore/cta-objectstore-dump-
> object.cpp:44
> >
> > (gdb) l -
> > 75=A0=A0=A0=A0=A0 #define TIMESTAMPEDPRINT(A)
> > 76=A0=A0=A0=A0=A0 #define NOTIFYLOCKED()
> > 77=A0=A0=A0=A0=A0 #define NOTIFYRELEASED()
> > 78=A0=A0=A0=A0=A0 #endif
> > 79
> > 80=A0=A0=A0=A0=A0 namespace cta { namespace objectstore {
> > 81
> > 82=A0=A0=A0=A0=A0 cta::threading::Mutex BackendRados::RadosTimeoutLogge=
r::g_mutex;
> > 83
> > 84=A0=A0=A0=A0=A0 BackendRados::BackendRados(log::Logger & logger, cons=
t std::string & userId, const std::string & pool,
> > (gdb) l
> > 85=A0=A0=A0=A0=A0=A0=A0 const std::string &radosNameSpace) :
> > 86=A0=A0=A0=A0=A0 m_user(userId), m_pool(pool), m_namespace(radosNameSp=
ace), m_cluster(), m_radosCtxPool() {
> > 87=A0=A0=A0=A0=A0=A0=A0 log::LogContext lc(logger);
> > 88=A0=A0=A0=A0=A0=A0=A0 cta::exception::Errnum::throwOnReturnedErrno(-m=
_cluster.init(userId.c_str()),
> > 89=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "In ObjectStoreRados::ObjectStoreRa=
dos, failed to m_cluster.init");
> > 90=A0=A0=A0=A0=A0=A0=A0 try {
> > 91=A0=A0=A0=A0=A0=A0=A0=A0=A0 RadosTimeoutLogger rtl;
> > 92=A0=A0=A0=A0=A0=A0=A0=A0=A0 cta::exception::Errnum::throwOnReturnedEr=
rno(-m_cluster.conf_read_file(NULL),
> > 93=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "In ObjectStoreRados::ObjectS=
toreRados, failed to m_cluster.conf_read_file");
> > 94=A0=A0=A0=A0=A0=A0=A0=A0=A0 rtl.logIfNeeded("In BackendRados::Backend=
Rados(): m_cluster.conf_read_file()", "no object");
> > (gdb) l
> > 95=A0=A0=A0=A0=A0=A0=A0=A0=A0 rtl.reset();
> > 96=A0=A0=A0=A0=A0=A0=A0=A0=A0 cta::exception::Errnum::throwOnReturnedEr=
rno(-m_cluster.conf_parse_env(NULL),
> > 97=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "In ObjectStoreRados::ObjectS=
toreRados, failed to m_cluster.conf_parse_env");
> > 98=A0=A0=A0=A0=A0=A0=A0=A0=A0 rtl.logIfNeeded("In BackendRados::Backend=
Rados(): m_cluster.conf_parse_env()", "no object");
> > 99=A0=A0=A0=A0=A0=A0=A0=A0=A0 rtl.reset();
> > 100=A0=A0=A0=A0=A0=A0=A0=A0 cta::exception::Errnum::throwOnReturnedErrn=
o(-m_cluster.connect(),
> > 101=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "In ObjectStoreRados::ObjectSto=
reRados, failed to m_cluster.connect");
> > 102=A0=A0=A0=A0=A0=A0=A0=A0 rtl.logIfNeeded("In BackendRados::BackendRa=
dos(): m_cluster.connect()", "no object");
> > 103=A0=A0=A0=A0=A0=A0=A0=A0 // Create the connection pool. One per CPU =
hardware thread.
> > 104=A0=A0=A0=A0=A0=A0=A0=A0 for (size_t i=3D0; i<std::thread::hardware_=
concurrency(); i++) {
> >
> > Is there anything we do wrong or a bug somewhere in rados?
> >
> > Thanks for any help,
> >
> > Eric Cano
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> >
