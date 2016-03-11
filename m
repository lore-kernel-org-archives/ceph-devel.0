From: Jason Dillaman <dillaman@redhat.com>
Subject: Re: librbd mutex segfault/assert with fio
Date: Thu, 10 Mar 2016 19:05:33 -0500 (EST)
Message-ID: <1346190656.37035533.1457654733756.JavaMail.zimbra@redhat.com>
References: <CAANLjFoL0R2o21kBxmQPoK9ahbLjpQJ5FUzuZWJRW0y0quUxpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:46919 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932830AbcCKAFf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Mar 2016 19:05:35 -0500
In-Reply-To: <CAANLjFoL0R2o21kBxmQPoK9ahbLjpQJ5FUzuZWJRW0y0quUxpg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Robert LeBlanc <robert@leblancnet.us>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

What version of fio are you running?  Pre 2.2.11, there was a race condition issue with rbd aio operations [1].

[1] https://github.com/axboe/fio/pull/121

-- 

Jason Dillaman 


----- Original Message -----
> From: "Robert LeBlanc" <robert@leblancnet.us>
> To: "ceph-devel" <ceph-devel@vger.kernel.org>
> Sent: Thursday, March 10, 2016 5:45:15 PM
> Subject: librbd mutex segfault/assert with fio
> 
> We are doing some tests with 0.94.6 and fio and we have had a few
> segfaults/asserts so I loaded it up in gdb. It would be nice to get
> down to the root of this.
> 
> #0  0x00007ffff5903a00 in Mutex::Lock (this=0x7fffc8020310,
> no_lockdep=<optimized out>) at common/Mutex.cc:94
>        start = {tv = {tv_sec = 0, tv_nsec = 0}}
>        r = <optimized out>
>        __PRETTY_FUNCTION__ = "void Mutex::Lock(bool)"
> #1  0x00007ffff582bd50 in librbd::AioCompletion::get_return_value
> (this=0x7fffc8020310) at librbd/AioCompletion.cc:147
>        r = <optimized out>
> #2  0x0000000000452174 in _fio_rbd_finish_aiocb ()
> No symbol table info available.
> #3  0x00007ffff582bb29 in librbd::AioCompletion::complete
> (this=this@entry=0x7fffc80389b0, cct=cct@entry=0x7fffc800d150) at
> librbd/AioCompletion.cc:94
>        __PRETTY_FUNCTION__ = "void
> librbd::AioCompletion::complete(CephContext*)"
> #4  0x00007ffff582ca15 in librbd::AioCompletion::complete_request
> (this=0x7fffc80389b0, cct=0x7fffc800d150, r=0) at
> librbd/AioCompletion.cc:129
>        __PRETTY_FUNCTION__ = "void
> librbd::AioCompletion::complete_request(CephContext*, ssize_t)"
>        count = <optimized out>
> #5  0x00007ffff582af19 in Context::complete (this=0x7fff5929c730,
> r=<optimized out>) at include/Context.h:65
> No locals.
> #6  0x00007ffff5baeb17 in delete_me (this=0x7fff59e8c550) at
> include/Context.h:272
> No locals.
> #7  C_GatherBase<Context, Context>::sub_finish (this=0x7fff59e8c550,
> sub=0x7fff5b419520, r=0) at include/Context.h:267
> No locals.
> #8  0x00007ffff5baec22 in C_GatherBase<Context,
> Context>::C_GatherSub::finish (this=0x7fff5b419520, r=<optimized out>)
> at include/Context.h:290
> No locals.
> #9  0x00007ffff5ba9579 in complete (r=<optimized out>,
> this=0x7fff5b419520) at include/Context.h:65
> No locals.
> #10 C_GatherBase<Context, Context>::C_GatherSub::complete
> (this=0x7fff5b419520, r=<optimized out>) at include/Context.h:287
> No locals.
> Python Exception <type 'exceptions.IndexError'> list index out of range:
> #11 0x00007ffff5bab46c in finish_contexts<Context>
> (cct=0x7fffc800d150, finished=empty std::list, result=result@entry=0)
> at include/Context.h:121
>        c = 0x7fff5b419520
>        ls = std::list = {[0] = 0x7fff5b419520}
>        it =
> #12 0x00007ffff5ba314f in ObjectCacher::bh_write_commit
> (this=0x7fffc8025700, poolid=<optimized out>, oid=...,
> start=start@entry=1110016,
>    length=length@entry=4096, tid=tid@entry=674304, r=r@entry=0) at
> osdc/ObjectCacher.cc:960
>        was_dirty_or_tx = 131072
>        hit = std::list = {[0] = 0x7ffd09688a30}
>        ob = 0x7fff5b785b70
>        ls = empty std::list
>        oset = 0x7fffc8021e50
>        __PRETTY_FUNCTION__ = "void
> ObjectCacher::bh_write_commit(int64_t, sobject_t, loff_t, uint64_t,
> ceph_tid_t, int)"
> #13 0x00007ffff5bade77 in ObjectCacher::C_WriteCommit::finish
> (this=0x7fff59d0bcf0, r=0) at osdc/ObjectCacher.h:535
> No locals.
> #14 0x00007ffff582af19 in Context::complete (this=0x7fff59d0bcf0,
> r=<optimized out>) at include/Context.h:65
> No locals.
> ---Type <return> to continue, or q <return> to quit---
> #15 0x00007ffff5882bce in librbd::LibrbdWriteback::complete_writes
> (this=0x7fffc801ded0, oid=...) at librbd/LibrbdWriteback.cc:209
>        result = 0x7fff59ea6f80
>        it =
>        __PRETTY_FUNCTION__ = "void
> librbd::LibrbdWriteback::complete_writes(const string&)"
>        results = <optimized out>
>        finished = std::list = {[0] = 0x7fff59ea6f80}
> #16 0x00007ffff58844f4 in librbd::C_OrderedWrite::finish
> (this=0x7ffd084f7d40, r=0) at librbd/LibrbdWriteback.cc:84
>        l = {mutex = @0x7fffc8021528}
>        __PRETTY_FUNCTION__ = "virtual void
>        librbd::C_OrderedWrite::finish(int)"
> #17 0x00007ffff582af19 in Context::complete (this=0x7ffd084f7d40,
> r=<optimized out>) at include/Context.h:65
> No locals.
> #18 0x00007ffff582d897 in librbd::AioRequest::complete
> (this=0x7fff5ab0d310, r=0) at librbd/AioRequest.cc:51
> No locals.
> #19 0x00007ffff32ec19d in librados::C_AioSafe::finish
> (this=0x7ffe380f6fe0, r=<optimized out>) at
> librados/AioCompletionImpl.h:199
>        cb = <optimized out>
>        cb_arg = <optimized out>
> #20 0x00007ffff32c70d9 in Context::complete (this=0x7ffe380f6fe0,
> r=<optimized out>) at include/Context.h:65
> No locals.
> #21 0x00007ffff3390cb8 in Finisher::finisher_thread_entry
> (this=0x7fffc80137b8) at common/Finisher.cc:59
>        p =
>        ls = std::vector of length 1, capacity -17591229840886 =
>        {0x7ffe380f6fe0}
>        ls_rval = empty std::list
>        __PRETTY_FUNCTION__ = "void* Finisher::finisher_thread_entry()"
> #22 0x00007ffff251fdc5 in start_thread () from /lib64/libpthread.so.0
> No symbol table info available.
> #23 0x00007ffff204928d in clone () from /lib64/libc.so.6
> No symbol table info available.
> 
> A full backtrace of all threads can be found at
> http://robert.leblancnet.us/files/gdb.txt.bz2
> 
> Thanks,
> ----------------
> Robert LeBlanc
> PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
