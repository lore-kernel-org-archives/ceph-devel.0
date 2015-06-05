From: Robert LeBlanc <robert@leblancnet.us>
Subject: Looking to improve small I/O performance
Date: Fri, 5 Jun 2015 17:17:25 -0600
Message-ID: <CAANLjFrL_KcmiCkbKjqMNoCY3hByEap2JYBFRJFeH3MG41qWrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:36646 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836AbbFEXR1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Jun 2015 19:17:27 -0400
Received: by wgbgq6 with SMTP id gq6so66790332wgb.3
        for <ceph-devel@vger.kernel.org>; Fri, 05 Jun 2015 16:17:25 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

I'm digging into perf and the code to see here/how I might be able to
improve performance for small I/O around 16K.

I ran fio with rados and used perf to record. Looking through the
report, there is a very substantial amount of time creating threads
(or so it looks, but I'm really new to perf). It seems to point to
messenger, so I looked in the code. From perf if looks like thread
pooling isn't happening, but from what I can gather from the code, it
should.

I then ran perf on the QEMU process and most time was in
_raw_spin_lock_irqsave so I thought that it might be fio threading not
interacting well with librados and it may be causing the extra thread
creation.

I ran perf on one of the OSD processes and again saw a lot of time in
what seems like thread creation.

It looks like there is code in simple messenger to log when threads
are created, but I couldn't figure out how to expose it (debug_msgr
doesn't exist) in the logs.

Any pointers on how to narrow this down? If I'm totally chasing after
a red herring, please let me know (I seem to be good at that).

Here is an example from the OSD perf:

Samples: 40K of event 'cycles', Event count (approx.): 656365744585
  Children      Self  Command   Shared Object         Symbol
- -   89.00%     0.00%  ceph-osd  libpthread-2.17.so    [.] start_thread
   - start_thread
        __clone
- -   88.42%     0.00%  ceph-osd  libc-2.17.so          [.] __clone
     __clone
- -   30.22%     0.16%  ceph-osd  ceph-osd              [.] Pipe::reader
   - Pipe::reader
      - Pipe::Reader::entry
        start_thread
        __clone
- -   30.22%     0.00%  ceph-osd  ceph-osd              [.] Pipe::Reader::entry
     Pipe::Reader::entry
     start_thread
     __clone
- -   29.17%     0.49%  ceph-osd  ceph-osd              [.] Pipe::writer
   - Pipe::writer
      - Pipe::Writer::entry
        start_thread
        __clone
- -   29.11%     0.00%  ceph-osd  ceph-osd              [.] Pipe::Writer::entry
     Pipe::Writer::entry
     start_thread
     __clone
- -   22.12%     0.00%  ceph-osd  [kernel.kallsyms]     [k] system_call_fastpath
   - system_call_fastpath
      + 30.23% 0x7fca77f637bd
      + 16.06% pthread_cond_wait@@GLIBC_2.3.2
      + 14.46% 0x7fca76a34b7d
      + 8.75% __libc_recv
        7.68% pthread_cond_broadcast@@GLIBC_2.3.2
      + 4.27% __lll_unlock_wake
      + 2.42% __lll_lock_wait
      + 2.35% base::internal::SpinLockDelay
      + 2.16% base::internal::SpinLockWake
        1.70% pthread_cond_signal@@GLIBC_2.3.2
      + 1.51% __madvise
      + 1.09% posix_fadvise64
      + 1.09% base::internal::SpinLockDelay
      + 1.02% __xstat64
      + 0.81% 0x7fca76a36b2d
      + 0.71% fsetxattr
      + 0.63% __libc_writev
      + 0.62% syncfs
      + 0.53% io_submit
+   19.01%     1.71%  ceph-osd  libtcmalloc.so.4.2.6  [.] operator delete
+   18.06%     0.11%  ceph-osd  ceph-osd              [.] encode_encrypt
+   16.98%     7.58%  ceph-osd  libtcmalloc.so.4.2.6  [.]
tcmalloc::ThreadCache::ReleaseToCentralCache
+   15.83%     0.00%  ceph-osd  ceph-osd              [.]
OSD::ShardedOpWQ::_process
+   15.76%     0.11%  ceph-osd  libtcmalloc.so.4.2.6  [.]
tcmalloc::ThreadCache::Scavenge
+   15.31%     0.16%  ceph-osd  ceph-osd              [.] CryptoKey::encrypt
+   15.30%     0.00%  ceph-osd  ceph-osd              [.] OSD::dequeue_op
+   15.30%     0.00%  ceph-osd  ceph-osd              [.]
ShardedThreadPool::shardedthreadpool_worker
+   15.07%     0.00%  ceph-osd  ceph-osd              [.]
ReplicatedPG::do_request
+   14.93%     0.43%  ceph-osd  ceph-osd              [.] Pipe::read_message
+   13.38%     0.00%  ceph-osd  ceph-osd              [.]
ShardedThreadPool::WorkThreadSharded::entry
+   12.77%     2.23%  ceph-osd  libtcmalloc.so.4.2.6  [.] operator new
+   11.49%     0.37%  ceph-osd  ceph-osd              [.]
std::_List_base >::_M_clear
+   11.00%     0.06%  ceph-osd  libtcmalloc.so.4.2.6  [.]
tcmalloc::ThreadCache::FetchFromCentralCache
+   10.96%     0.13%  ceph-osd  libtcmalloc.so.4.2.6  [.]
tcmalloc::CentralFreeList::RemoveRange
+   10.58%     0.02%  ceph-osd  ceph-osd              [.]
FileStore::_do_transaction
+   10.56%     9.99%  ceph-osd  libtcmalloc.so.4.2.6  [.]
tcmalloc::CentralFreeList::FetchFromOneSpans
+   10.31%     0.07%  ceph-osd  ceph-osd              [.]
CephxSessionHandler::sign_message
+    9.88%     0.00%  ceph-osd  ceph-osd              [.] ThreadPool::worker
+    9.85%     0.00%  ceph-osd  ceph-osd              [.]
ThreadPool::WorkThread::entry
+    9.80%     0.01%  ceph-osd  ceph-osd              [.] FileStore::_do_op
+    9.79%     0.00%  ceph-osd  ceph-osd              [.]
FileStore::_do_transactions
+    8.95%     0.00%  ceph-osd  ceph-osd              [.]
ReplicatedBackend::handle_message
+    8.94%     0.04%  ceph-osd  ceph-osd              [.]
CephxSessionHandler::check_message_signature
+    8.89%     0.00%  ceph-osd  ceph-osd              [.]
ReplicatedBackend::sub_op_modify
+    8.89%     0.00%  ceph-osd  ceph-osd              [.]
ReplicatedBackend::sub_op_modify_impl
+    8.66%     0.21%  ceph-osd  libtcmalloc.so.4.2.6  [.]
tcmalloc::CentralFreeList::InsertRange
+    8.55%     0.22%  ceph-osd  [kernel.kallsyms]     [k] sys_futex
+    8.33%     0.15%  ceph-osd  [kernel.kallsyms]     [k] do_futex
+    8.19%     0.01%  ceph-osd  ceph-osd              [.]
FileStore::_omap_setkeys
+    7.39%     0.93%  ceph-osd  libtcmalloc.so.4.2.6  [.]
tcmalloc::CentralFreeList::ReleaseListToSpans
+    7.26%     0.15%  ceph-osd  ceph-osd              [.] Pipe::do_sendmsg
+    7.00%     0.00%  ceph-osd  libpthread-2.17.so    [.] 0x000000000000e7bd
+    6.69%     0.06%  ceph-osd  [kernel.kallsyms]     [k] sys_sendmsg
+    6.61%     5.93%  ceph-osd  libtcmalloc.so.4.2.6  [.]
tcmalloc::CentralFreeList::ReleaseToSpans
+    6.57%     0.08%  ceph-osd  [kernel.kallsyms]     [k] __sys_sendmsg
+    6.32%     0.01%  ceph-osd  ceph-osd              [.] ReplicatedPG::do_op
+    6.14%     0.00%  ceph-osd  ceph-osd              [.]
ReplicatedPG::execute_ctx
+    6.09%     0.15%  ceph-osd  [kernel.kallsyms]     [k] ___sys_sendmsg
+    5.68%     0.00%  ceph-osd  [kernel.kallsyms]     [k] do_sock_sendmsg

Thanks for humoring me,

- ----------------
Robert LeBlanc
GPG Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
-----BEGIN PGP SIGNATURE-----
Version: Mailvelope v0.13.1
Comment: https://www.mailvelope.com

wsFcBAEBCAAQBQJVci31CRDmVDuy+mK58QAAWFYQAKI2KIh3UmwtWF588M/2
H8yNujq/30I/VSbnkP328Kx6h/W88bL47SmF7wB9oSZgXRHiK45Rw5kH8H90
RwFWWtqwtPT1JBhA6k7eeIABqKQopTdYo+yMa0DWwNks0zPnDD37S3M8Xe0D
Wt+RvIRb6qDfj5VsUTDSFMUSNBW4/vSE0Gx7RssIUgf5QUPIqV254Frid39T
e10IPFtprWSzFvFSQwn3uGhhlkjyNO2/tO0veMj+Tm4TYGBu40+DjGFWf9SU
rAjfSVrD2XCAbSUOWlFjC9kDMMSR6pvbawrYAYfRbRILiL1c9/SDSLeH4AyL
zmHxCud6AVBUKi6kQZOINGlbN68mcNJPPHhfmFBT+OvY+A8RQ1FDrBSaaznR
CM043wc0+49YwyDpeDyCxjuCMcK7LhQTjAcYQcuCgzLi/R78k3emkmxcJlxC
2dAfa5bzh7xltQxhvMKVq97BvxMnd5dLfXfCAtxVE+ruNc+FaoYVMnwLMAhJ
eYTiM0vwBcWfv2qvbal6ZlaWfERfDRjjKkCkUp29uGmy4thRu/VwL0vhadsJ
29dpFPG5uzRshCxV2V4fxxlgKoCU10pnd1sqAcyTwDdVWQ/yYLGNffplIW7a
Awuspjb9l6qZNJ+hB6m9j6dq+rnzcUpYULJ7wbgLtEW9/FKZSJw6eLCEG4o0
qFIV
=5+P+
-----END PGP SIGNATURE-----
