From: Sage Weil <sage@newdream.net>
Subject: Re: Segfault when connecting to cluster using Rados API (problem
 with pick_a_shard()?)
Date: Mon, 18 Dec 2017 14:44:46 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1712181432440.15063@piezo.novalocal>
References: <C23C0F22777EE8499587B3474C14DDF302605C469A@CERNXCHG52.cern.ch>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1412586949-1513608288=:15063"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tragedy.dreamhost.com ([66.33.205.236]:55703 "EHLO
        tragedy.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752742AbdLROot (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Dec 2017 09:44:49 -0500
In-Reply-To: <C23C0F22777EE8499587B3474C14DDF302605C469A@CERNXCHG52.cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Eric Cano <Eric.Cano@cern.ch>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1412586949-1513608288=:15063
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Mon, 18 Dec 2017, Eric Cano wrote:
> Hi everyone,
> 
> We experience segfaults when connecting to the Rados cluster from our 
> application. The problem was first encountered when switching from 
> 12.2.0 to 12.2.2. We downgraded to 12.2.1, which helped for some time, 
> but we now also encounter the problem in 12.2.1. The current crash is 
> for 12.2.1, which we switched for as it seemed to work better.

It looks/sounds like the ABI for C++ linkage broke between the point 
releases.  This is really easy to trigger, unfortunately, due to the 
design of the C++ interface.  A recompile of the application 
against the updated headers should fix it.

I see two problematic commits:
 2ef222a58c3801eaac5a6d52dda2de1ffe37407b (mempool change)
 0048e6a58c7cdf3b3d98df575bc47db8397cd5a9 (buffer::list change)

I pushed a branch wip-abi-luminous to 
	https://shaman.ceph.com/builds/ceph/

You can either try that build and see if it fixes it, and/or rebuild your 
application.  Please let us know if either works!

Thanks-
sage


Both are probably straightforward to fix... I'll push a test branch
> 
> We had a crash of a command line tool for our application, so the context of the crash is rather simple. The segfault happens in a Rados thread, where apparently pick_a_shard() delivered a wrong address :
> 
> #0  operator+= (__i=1, this=0x8345dbd0a008) at /usr/include/c++/4.8.2/bits/atomic_base.h:420
> #1  mempool::pool_t::adjust_count (this=0x8345dbd0a000, items=items@entry=1, bytes=bytes@entry=4008) at /usr/src/debug/ceph-12.2.1/src/common/mempool.cc:85
> #2  0x00007f544efa0755 in reassign_to_mempool (this=<optimized out>, this=<optimized out>, pool=1026552624) at /usr/src/debug/ceph-12.2.1/src/common/buffer.cc:207
> #3  ceph::buffer::list::append (this=this@entry=0x7f543d2ff330, data=0xf64d89 "", len=len@entry=272) at /usr/src/debug/ceph-12.2.1/src/common/buffer.cc:1915
> #4  0x00007f54443c7976 in AsyncConnection::_process_connection (this=this@entry=0xf61740) at /usr/src/debug/ceph-12.2.1/src/msg/async/AsyncConnection.cc:962
> #5  0x00007f54443ca8a8 in AsyncConnection::process (this=0xf61740) at /usr/src/debug/ceph-12.2.1/src/msg/async/AsyncConnection.cc:838
> #6  0x00007f54443dceb9 in EventCenter::process_events (this=this@entry=0xf1dda0, timeout_microseconds=<optimized out>, timeout_microseconds@entry=30000000, working_dur=working_dur@entry=0x7f543d2ffaf0) at /usr/src/debug/ceph-12.2.1/src/msg/async/Event.cc:409
> #7  0x00007f54443e05ee in NetworkStack::__lambda4::operator() (__closure=0xf4af60) at /usr/src/debug/ceph-12.2.1/src/msg/async/Stack.cc:51
> #8  0x00007f544d5ed2b0 in std::(anonymous namespace)::execute_native_thread_routine (__p=<optimized out>) at ../../../../../libstdc++-v3/src/c++11/thread.cc:84
> #9  0x00007f544e16ee25 in start_thread (arg=0x7f543d301700) at pthread_create.c:308
> #10 0x00007f544cd5534d in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:113
> 
> (gdb) frame 1
> #1  mempool::pool_t::adjust_count (this=0x8345dbd0a000, items=items@entry=1, bytes=bytes@entry=4008) at /usr/src/debug/ceph-12.2.1/src/common/mempool.cc:85
> 85        shard->items += items;
> (gdb) l
> 80      }
> 81
> 82      void mempool::pool_t::adjust_count(ssize_t items, ssize_t bytes)
> 83      {
> 84        shard_t *shard = pick_a_shard();
> 85        shard->items += items;
> 86        shard->bytes += bytes;
> 87      }
> 88
> 89      void mempool::pool_t::get_stats(
> (gdb) p shard
> $1 = (mempool::shard_t *) 0x8345dbd0a000
> (gdb) p *shard
> Cannot access memory at address 0x8345dbd0a000
> 
> The user and main thread is as follows (listing is for frame 4):
> 
> (gdb) thread 7
> [Switching to thread 7 (Thread 0x7f545004e9c0 (LWP 31308))]
> #0  pthread_cond_timedwait@@GLIBC_2.3.2 () at ../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_timedwait.S:238
> 238     62:     movq    %rax, %r14
> (gdb) bt
> #0  pthread_cond_timedwait@@GLIBC_2.3.2 () at ../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_timedwait.S:238
> #1  0x00007f54442a2e3c in WaitUntil (when=..., mutex=..., this=0xe74190) at /usr/src/debug/ceph-12.2.1/src/common/Cond.h:64
> #2  MonClient::authenticate (this=this@entry=0xe73d58, timeout=300) at /usr/src/debug/ceph-12.2.1/src/mon/MonClient.cc:464
> #3  0x00007f544ef9058c in librados::RadosClient::connect (this=0xe73d10) at /usr/src/debug/ceph-12.2.1/src/librados/RadosClient.cc:299
> #4  0x00007f544f73a1ee in cta::objectstore::BackendRados::BackendRados (this=0xe08680, logger=..., userId="eoscta", pool="eoscta_metadata", radosNameSpace="cta-ns") at /usr/src/debug/cta-0.0-85/objectstore/BackendRados.cpp:100
> #5  0x00007f544f75eabc in cta::objectstore::BackendFactory::createBackend (URL="rados://eoscta@eoscta_metadata:cta-ns", logger=...) at /usr/src/debug/cta-0.0-85/objectstore/BackendFactory.cpp:42
> #6  0x000000000041024e in main (argc=2, argv=0x7ffdde466e78) at /usr/src/debug/cta-0.0-85/objectstore/cta-objectstore-dump-object.cpp:44
> 
> (gdb) l -
> 75      #define TIMESTAMPEDPRINT(A)
> 76      #define NOTIFYLOCKED()
> 77      #define NOTIFYRELEASED()
> 78      #endif
> 79
> 80      namespace cta { namespace objectstore {
> 81
> 82      cta::threading::Mutex BackendRados::RadosTimeoutLogger::g_mutex;
> 83
> 84      BackendRados::BackendRados(log::Logger & logger, const std::string & userId, const std::string & pool,
> (gdb) l
> 85        const std::string &radosNameSpace) :
> 86      m_user(userId), m_pool(pool), m_namespace(radosNameSpace), m_cluster(), m_radosCtxPool() {
> 87        log::LogContext lc(logger);
> 88        cta::exception::Errnum::throwOnReturnedErrno(-m_cluster.init(userId.c_str()),
> 89            "In ObjectStoreRados::ObjectStoreRados, failed to m_cluster.init");
> 90        try {
> 91          RadosTimeoutLogger rtl;
> 92          cta::exception::Errnum::throwOnReturnedErrno(-m_cluster.conf_read_file(NULL),
> 93              "In ObjectStoreRados::ObjectStoreRados, failed to m_cluster.conf_read_file");
> 94          rtl.logIfNeeded("In BackendRados::BackendRados(): m_cluster.conf_read_file()", "no object");
> (gdb) l
> 95          rtl.reset();
> 96          cta::exception::Errnum::throwOnReturnedErrno(-m_cluster.conf_parse_env(NULL),
> 97              "In ObjectStoreRados::ObjectStoreRados, failed to m_cluster.conf_parse_env");
> 98          rtl.logIfNeeded("In BackendRados::BackendRados(): m_cluster.conf_parse_env()", "no object");
> 99          rtl.reset();
> 100         cta::exception::Errnum::throwOnReturnedErrno(-m_cluster.connect(),
> 101             "In ObjectStoreRados::ObjectStoreRados, failed to m_cluster.connect");
> 102         rtl.logIfNeeded("In BackendRados::BackendRados(): m_cluster.connect()", "no object");
> 103         // Create the connection pool. One per CPU hardware thread.
> 104         for (size_t i=0; i<std::thread::hardware_concurrency(); i++) {
> 
> Is there anything we do wrong or a bug somewhere in rados?
> 
> Thanks for any help,
> 
> Eric Cano
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
--8323329-1412586949-1513608288=:15063--
