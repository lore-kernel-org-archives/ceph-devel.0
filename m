From: Nathan O'Sullivan <nathan@mammoth.com.au>
Subject: Re: [Xen-devel] Xen blktap driver for Ceph RBD : Anybody wants to
 test ? :p
Date: Fri, 21 Jun 2013 17:21:20 +1000
Message-ID: <51C3FEF0.7030709@mammoth.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail1.bris.mammothmedia.com.au ([203.39.17.199]:43711 "EHLO
	mail1.bris.mammothmedia.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751829Ab3FUHaT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Fri, 21 Jun 2013 03:30:19 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail1.bris.mammothmedia.com.au (Postfix) with ESMTP id 7A2DBF43EC0
	for <ceph-devel@vger.kernel.org>; Fri, 21 Jun 2013 17:21:12 +1000 (EST)
Received: from mail1.bris.mammothmedia.com.au ([127.0.0.1])
	by localhost (mail1.bris.mammothmedia.com.au [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id Vg7R4CcShZXE for <ceph-devel@vger.kernel.org>;
	Fri, 21 Jun 2013 17:21:12 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail1.bris.mammothmedia.com.au (Postfix) with ESMTP id ED10AF43EE6
	for <ceph-devel@vger.kernel.org>; Fri, 21 Jun 2013 17:21:11 +1000 (EST)
Received: from mail1.bris.mammothmedia.com.au ([127.0.0.1])
	by localhost (mail1.bris.mammothmedia.com.au [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id q1hV6pAeyP_V for <ceph-devel@vger.kernel.org>;
	Fri, 21 Jun 2013 17:21:11 +1000 (EST)
Received: from [10.2.2.76] (unknown [10.2.2.76])
	by mail1.bris.mammothmedia.com.au (Postfix) with ESMTPSA id D1C48F43EC0
	for <ceph-devel@vger.kernel.org>; Fri, 21 Jun 2013 17:21:11 +1000 (EST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I've been testing this on Ubuntu 12.04.02 64-bit with kernel 3.2.0-48 
and ceph 0.61.4

With rbd cache disabled, it works well enough in initial testing.

However when rbd cache is enabled with:
[client]
rbd_cache = true

the tapdisk process crashes if I do this in the domU:
dd if=/dev/xvda bs=1M > /dev/null


I grabbed the tapdisk stacktrace with gdb:

Program received signal SIGSEGV, Segmentation fault.
[Switching to Thread 0x7f1677186700 (LWP 6507)]
0x00007f167d21857c in free () from /lib/x86_64-linux-gnu/libc.so.6
(gdb) bt
#0  0x00007f167d21857c in free () from /lib/x86_64-linux-gnu/libc.so.6
#1  0x00007f167daab84b in 
ceph::buffer::raw_posix_aligned::~raw_posix_aligned() () from 
/usr/lib/librados.so.2
#2  0x00007f167daa6f6e in ceph::buffer::ptr::release() () from 
/usr/lib/librados.so.2
#3  0x00007f167d5711c7 in std::_List_base<ceph::buffer::ptr, 
std::allocator<ceph::buffer::ptr> >::_M_clear() () from /usr/lib/librbd.so.1
#4  0x00007f167d5a8ffe in ObjectCacher::trim(long, long) () from 
/usr/lib/librbd.so.1
#5  0x00007f167d5b7e60 in ObjectCacher::_readx(ObjectCacher::OSDRead*, 
ObjectCacher::ObjectSet*, Context*, bool) () from /usr/lib/librbd.so.1
#6  0x00007f167d5bd620 in ObjectCacher::C_RetryRead::finish(int) () from 
/usr/lib/librbd.so.1
#7  0x00007f167d57281a in Context::complete(int) () from 
/usr/lib/librbd.so.1
#8  0x00007f167d5b8f65 in finish_contexts(CephContext*, 
std::list<Context*, std::allocator<Context*> >&, int) () from 
/usr/lib/librbd.so.1
#9  0x00007f167d5ae705 in ObjectCacher::bh_read_finish(long, sobject_t, 
long, unsigned long, ceph::buffer::list&, int, bool) ()
    from /usr/lib/librbd.so.1
#10 0x00007f167d5bc32f in ObjectCacher::C_ReadFinish::finish(int) () 
from /usr/lib/librbd.so.1
#11 0x00007f167d57281a in Context::complete(int) () from 
/usr/lib/librbd.so.1
#12 0x00007f167d5a31f5 in librbd::C_Request::finish(int) () from 
/usr/lib/librbd.so.1
#13 0x00007f167d5a1c14 in librbd::context_cb(void*, void*) () from 
/usr/lib/librbd.so.1
#14 0x00007f167d90f56d in librados::C_AioComplete::finish(int) () from 
/usr/lib/librados.so.2
#15 0x00007f167d97bb00 in Finisher::finisher_thread_entry() () from 
/usr/lib/librados.so.2
#16 0x00007f167c812e9a in start_thread () from 
/lib/x86_64-linux-gnu/libpthread.so.0
#17 0x00007f167d288ccd in clone () from /lib/x86_64-linux-gnu/libc.so.6
#18 0x0000000000000000 in ?? ()


Regards
Nathan
