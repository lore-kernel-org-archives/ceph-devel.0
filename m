From: Yehuda Sadeh-Weinraub <ysadehwe@redhat.com>
Subject: Re: RGW recursive lock on Jewel
Date: Wed, 26 Oct 2016 12:06:14 -0700
Message-ID: <CADRKj5RP1mrfFQh5HCv3Hb6WTy3hzdQnS1HJt8RvFgBbw5jnbQ@mail.gmail.com>
References: <D9881DD9-3DEE-4E37-8ED3-B47017168CBA@walmartlabs.com>
 <CADRKj5SunNTh9a1A79TopHwzp9477o966p68cSJ3=8E1-7whZg@mail.gmail.com> <B093F233-8CAA-45A1-8BB9-8909652E4E90@walmartlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f178.google.com ([209.85.217.178]:34506 "EHLO
        mail-ua0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753120AbcJZTGQ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 26 Oct 2016 15:06:16 -0400
Received: by mail-ua0-f178.google.com with SMTP id 6so2744022uau.1
        for <ceph-devel@vger.kernel.org>; Wed, 26 Oct 2016 12:06:16 -0700 (PDT)
In-Reply-To: <B093F233-8CAA-45A1-8BB9-8909652E4E90@walmartlabs.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Pavan Rallabhandi <PRallabhandi@walmartlabs.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Can you run in gdb:

$ thread apply all bt


and provide the output somehow?

Thanks,
Yehuda

On Wed, Oct 26, 2016 at 12:00 PM, Pavan Rallabhandi
<PRallabhandi@walmartlabs.com> wrote:
> Thanks for the responses, as Dan mentioned I ruled out the find_admin() stack traces.
>
> There are ~15K threads in the process (below are how most of them are looking like), and I see the logs are not rotated as well. Sorry for the verbosity of the below snippet.
>
> I have never seen a ‘t’ across virtual memory size but here is how the top for rgw looks like:
>
>   18784 ceph      20   0  0.102t 4.432g   6084 S  98.0  2.3   2318:15 radosgw
>
> <snip>
>
> For one such interesting thread:
>
> Thread 6903 (Thread 0x7f6a848ac700 (LWP 27534)):
> #0  __lll_lock_wait_private () at ../nptl/sysdeps/unix/sysv/linux/x86_64/lowlevellock.S:95
> #1  0x00007f7ecc865cba in _L_lock_12808 () at malloc.c:5206
> #2  0x00007f7ecc8636b5 in __GI___libc_malloc (bytes=56) at malloc.c:2887
> #3  0x00007f7ed756fe7c in _dl_map_object_deps (map=map@entry=0x7f7ed77794f8, preloads=preloads@entry=0x0, npreloads=npreloads@entry=0, trace_mode=trace_mode@entry=0,
>     open_mode=open_mode@entry=-2147483648) at dl-deps.c:511
> #4  0x00007f7ed7576a6b in dl_open_worker (a=a@entry=0x7f6a848a2f48) at dl-open.c:272
> #5  0x00007f7ed7571fc4 in _dl_catch_error (objname=objname@entry=0x7f6a848a2f38, errstring=errstring@entry=0x7f6a848a2f40, mallocedp=mallocedp@entry=0x7f6a848a2f30,
>     operate=operate@entry=0x7f7ed7576960 <dl_open_worker>, args=args@entry=0x7f6a848a2f48) at dl-error.c:187
> #6  0x00007f7ed757637b in _dl_open (file=0x7f7ecc95d1a6 "libgcc_s.so.1", mode=-2147483647, caller_dlopen=<optimized out>, nsid=-2, argc=9, argv=0x7ffe720f2bd8, env=0x7ffe720f2c28) at dl-open.c:661
> #7  0x00007f7ecc916cf2 in do_dlopen (ptr=ptr@entry=0x7f6a848a3160) at dl-libc.c:87
> #8  0x00007f7ed7571fc4 in _dl_catch_error (objname=0x7f6a848a3140, errstring=0x7f6a848a3150, mallocedp=0x7f6a848a3130, operate=0x7f7ecc916cb0 <do_dlopen>, args=0x7f6a848a3160) at dl-error.c:187
> #9  0x00007f7ecc916db2 in dlerror_run (args=0x7f6a848a3160, operate=0x7f7ecc916cb0 <do_dlopen>) at dl-libc.c:46
> #10 __GI___libc_dlopen_mode (name=name@entry=0x7f7ecc95d1a6 "libgcc_s.so.1", mode=mode@entry=-2147483647) at dl-libc.c:163
> #11 0x00007f7ecc8ebc75 in init () at ../sysdeps/x86_64/backtrace.c:52
> #12 0x00007f7ecd0cda80 in pthread_once () at ../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_once.S:103
> #13 0x00007f7ecc8ebd8c in __GI___backtrace (array=<optimized out>, size=100) at ../sysdeps/x86_64/backtrace.c:103
> #14 0x00007f7ecde93f42 in ?? () from /usr/lib/librgw.so.2
> #15 <signal handler called>
> #16 malloc_consolidate (av=av@entry=0x7f7d08000020) at malloc.c:4151
> #17 0x00007f7ecc860ce8 in _int_malloc (av=0x7f7d08000020, bytes=1408) at malloc.c:3423
> #18 0x00007f7ecc8636c0 in __GI___libc_malloc (bytes=1408) at malloc.c:2891
> #19 0x00007f7ecce1adad in operator new(unsigned long) () from /usr/lib/x86_64-linux-gnu/libstdc++.so.6
> #20 0x00007f7ecdd8ef11 in std::_Rb_tree_iterator<std::pair<rgw_obj const, RGWObjState> > std::_Rb_tree<rgw_obj, std::pair<rgw_obj const, RGWObjState>, std::_Select1st<std::pair<rgw_obj const, RGWObjState> >, std::less<rgw_obj>, std::allocator<std::pair<rgw_obj const, RGWObjState> > >::_M_emplace_hint_unique<std::piecewise_construct_t const&, std::tuple<rgw_obj const&>, std::tuple<> >(std::_Rb_tree_const_iterator<std::pair<rgw_obj const, RGWObjState> >, std::piecewise_construct_t const&, std::tuple<rgw_obj const&>&&, std::tuple<>&&) () from /usr/lib/librgw.so.2
> #21 0x00007f7ecdd8f725 in std::map<rgw_obj, RGWObjState, std::less<rgw_obj>, std::allocator<std::pair<rgw_obj const, RGWObjState> > >::operator[](rgw_obj const&) () from /usr/lib/librgw.so.2
> #22 0x00007f7ecdd3c585 in RGWObjectCtx::get_state(rgw_obj&) () from /usr/lib/librgw.so.2
> #23 0x00007f7ecdd3e6ed in RGWRados::get_system_obj_state_impl(RGWObjectCtx*, rgw_obj&, RGWObjState**, RGWObjVersionTracker*) () from /usr/lib/librgw.so.2
> #24 0x00007f7ecdd3ecb4 in RGWRados::get_system_obj_state(RGWObjectCtx*, rgw_obj&, RGWObjState**, RGWObjVersionTracker*) () from /usr/lib/librgw.so.2
> #25 0x00007f7ecdd3ed2a in RGWRados::stat_system_obj(RGWObjectCtx&, RGWRados::SystemObject::Read::GetObjState&, rgw_obj&, std::map<std::string, ceph::buffer::list, std::less<std::string>, std::allocator<std::pair<std::string const, ceph::buffer::list> > >*, std::chrono::time_point<ceph::time_detail::real_clock, std::chrono::duration<unsigned long, std::ratio<1l, 1000000000l> > >*, unsigned long*, RGWObjVersionTracker*) () from /usr/lib/librgw.so.2
> #26 0x00007f7ecdd27bbb in RGWRados::SystemObject::Read::stat(RGWObjVersionTracker*) () from /usr/lib/librgw.so.2
> #27 0x00007f7ecdc2d4a8 in rgw_get_system_obj(RGWRados*, RGWObjectCtx&, rgw_bucket&, std::string const&, ceph::buffer::list&, RGWObjVersionTracker*, std::chrono::time_point<ceph::time_detail::real_clock, s---Type <return> to continue, or q <return> to quit---
> td::chrono::duration<unsigned long, std::ratio<1l, 1000000000l> > >*, std::map<std::string, ceph::buffer::list, std::less<std::string>, std::allocator<std::pair<std::string const, ceph::buffer::list> > >*, rgw_cache_entry_info*) () from /usr/lib/librgw.so.2
> #28 0x00007f7ecde2320b in rgw_get_user_info_by_uid(RGWRados*, rgw_user const&, RGWUserInfo&, RGWObjVersionTracker*, std::chrono::time_point<ceph::time_detail::real_clock, std::chrono::duration<unsigned long, std::ratio<1l, 1000000000l> > >*, rgw_cache_entry_info*, std::map<std::string, ceph::buffer::list, std::less<std::string>, std::allocator<std::pair<std::string const, ceph::buffer::list> > >*) ()
>    from /usr/lib/librgw.so.2
> #29 0x00007f7ecde15965 in RGWSwift::update_user_info(RGWRados*, rgw_swift_auth_info*, RGWUserInfo&) () from /usr/lib/librgw.so.2
> #30 0x00007f7ecde17945 in RGWSwift::validate_keystone_token(RGWRados*, std::string const&, RGWUserInfo&) () from /usr/lib/librgw.so.2
> #31 0x00007f7ecde1a25d in RGWSwift::do_verify_swift_token(RGWRados*, req_state*) () from /usr/lib/librgw.so.2
> #32 0x00007f7ecde1a806 in RGWSwift::verify_swift_token(RGWRados*, req_state*) () from /usr/lib/librgw.so.2
> #33 0x00007f7ecde064da in RGWHandler_REST_SWIFT::authorize() () from /usr/lib/librgw.so.2
> #34 0x00007f7ecdd19d67 in process_request(RGWRados*, RGWREST*, RGWRequest*, RGWStreamIO*, OpsLogSocket*) () from /usr/lib/librgw.so.2
> #35 0x000055a19da88b9f in ?? ()
> #36 0x000055a19da9288f in ?? ()
> #37 0x000055a19da9485e in ?? ()
> #38 0x00007f7ecd0c8184 in start_thread (arg=0x7f6a848ac700) at pthread_create.c:312
> #39 0x00007f7ecc8db37d in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:111
>
>
> Thread 7485 (Thread 0x7f6ba6af0700 (LWP 26948)):
> #0  pthread_cond_wait@@GLIBC_2.3.2 () at ../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
> #1  0x00007f7ec30e2ef1 in librados::AioCompletion::wait_for_complete_and_cb() () from /usr/lib/librados.so.2
> #2  0x00007f7ecdd559e0 in RGWRados::Object::Read::iterate(long, long, RGWGetDataCB*) () from /usr/lib/librgw.so.2
> #3  0x00007f7ecdd065cb in RGWGetObj::execute() () from /usr/lib/librgw.so.2
> #4  0x00007f7ecdd19f4b in process_request(RGWRados*, RGWREST*, RGWRequest*, RGWStreamIO*, OpsLogSocket*) () from /usr/lib/librgw.so.2
> #5  0x000055a19da88b9f in ?? ()
> #6  0x000055a19da9288f in ?? ()
> #7  0x000055a19da9485e in ?? ()
> #8  0x00007f7ecd0c8184 in start_thread (arg=0x7f6ba6af0700) at pthread_create.c:312
> #9  0x00007f7ecc8db37d in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:111
>
>
> Thread 4805 (Thread 0x7f666d07e700 (LWP 29641)):
> #0  pthread_cond_wait@@GLIBC_2.3.2 () at ../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
> #1  0x00007f7ecdf76e43 in ceph::log::Log::submit_entry(ceph::log::Entry*) () from /usr/lib/librgw.so.2
> #2  0x00007f7ecdd1931f in process_request(RGWRados*, RGWREST*, RGWRequest*, RGWStreamIO*, OpsLogSocket*) () from /usr/lib/librgw.so.2
> #3  0x000055a19da88b9f in ?? ()
> #4  0x000055a19da9288f in ?? ()
> #5  0x000055a19da9485e in ?? ()
> #6  0x00007f7ecd0c8184 in start_thread (arg=0x7f666d07e700) at pthread_create.c:312
> #7  0x00007f7ecc8db37d in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:111
>
> Thread 6853 (Thread 0x7f6a6b87a700 (LWP 27584)):
> #0  pthread_cond_wait@@GLIBC_2.3.2 () at ../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
> #1  0x00007f7ece059a44 in Throttle::_wait(long) () from /usr/lib/librgw.so.2
> #2  0x00007f7ece05a6a7 in Throttle::get(long, long) () from /usr/lib/librgw.so.2
> #3  0x00007f7ecdd51ca7 in RGWRados::get_obj_iterate_cb(RGWObjectCtx*, RGWObjState*, rgw_obj&, long, long, long, bool, void*) () from /usr/lib/librgw.so.2
> #4  0x00007f7ecdd5289e in ?? () from /usr/lib/librgw.so.2
> #5  0x00007f7ecdd555b4 in RGWRados::iterate_obj(RGWObjectCtx&, rgw_obj&, long, long, unsigned long, int (*)(rgw_obj&, long, long, long, bool, RGWObjState*, void*), void*) () from /usr/lib/librgw.so.2
> #6  0x00007f7ecdd559aa in RGWRados::Object::Read::iterate(long, long, RGWGetDataCB*) () from /usr/lib/librgw.so.2
> #7  0x00007f7ecdd065cb in RGWGetObj::execute() () from /usr/lib/librgw.so.2
> #8  0x00007f7ecdd19f4b in process_request(RGWRados*, RGWREST*, RGWRequest*, RGWStreamIO*, OpsLogSocket*) () from /usr/lib/librgw.so.2
> #9  0x000055a19da88b9f in ?? ()
> #10 0x000055a19da9288f in ?? ()
> #11 0x000055a19da9485e in ?? ()
> #12 0x00007f7ecd0c8184 in start_thread (arg=0x7f6a6b87a700) at pthread_create.c:312
> #13 0x00007f7ecc8db37d in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:111
>
>
> <\snip>
>
> Thanks,
> -Pavan.
>
> On 10/26/16, 11:23 PM, "ceph-devel-owner@vger.kernel.org on behalf of Yehuda Sadeh-Weinraub" <ceph-devel-owner@vger.kernel.org on behalf of ysadehwe@redhat.com> wrote:
>
>     Not sure that these threads are the culprit, can you provide a list of
>     all the rgw threads?
>
>     On Wed, Oct 26, 2016 at 9:11 AM, Pavan Rallabhandi
>     <PRallabhandi@walmartlabs.com> wrote:
>     > In one of our clusters, we are running a nightly version of Jewel (below), and one of the RGW nodes is unresponsive with ~4.5G of resident memory and almost one core of CPU consumed. Almost all of the client connections to the RGW are in CLOSE_WAIT, and we were trying with 1024 RGW thread pool size for some client operations. There are at least 3 other RGWs in the same cluster with similar configuration but they seem to be doing fine.
>     >
>     > I wonder if we have run into https://github.com/ceph/ceph/pull/10562 on Jewel. Please find the stack traces from couple of threads in the rogue RGW.
>     >
>     > Can someone please confirm if that’s indeed the case?
>     >
>     > <snip>
>     >
>     > $ceph -v
>     > ceph version 10.2.2-508-g9bfc0cf (9bfc0cf178dc21b0fe33e0ce3b90a18858abaf1b)
>     >
>     >
>     > (gdb) t 6836
>     > [Switching to thread 6836 (Thread 0x7f6a63069700 (LWP 27601))]
>     > #0  __lll_lock_wait () at ../nptl/sysdeps/unix/sysv/linux/x86_64/lowlevellock.S:135
>     > 135     ../nptl/sysdeps/unix/sysv/linux/x86_64/lowlevellock.S: No such file or directory.
>     > (gdb) bt
>     > #0  __lll_lock_wait () at ../nptl/sysdeps/unix/sysv/linux/x86_64/lowlevellock.S:135
>     > #1  0x00007f7ecd0ca664 in _L_lock_952 () from /lib/x86_64-linux-gnu/libpthread.so.0
>     > #2  0x00007f7ecd0ca4c6 in __GI___pthread_mutex_lock (mutex=0x55a19f8b8fe0) at ../nptl/pthread_mutex_lock.c:114
>     > #3  0x00007f7ece002638 in Mutex::Lock(bool) () from /usr/lib/librgw.so.2
>     > #4  0x00007f7ecdc8097a in RGWKeystoneTokenCache::find(std::string const&, KeystoneToken&) () from /usr/lib/librgw.so.2
>     > #5  0x00007f7ecde17829 in RGWSwift::validate_keystone_token(RGWRados*, std::string const&, RGWUserInfo&) () from /usr/lib/librgw.so.2
>     > #6  0x00007f7ecde1a25d in RGWSwift::do_verify_swift_token(RGWRados*, req_state*) () from /usr/lib/librgw.so.2
>     > #7  0x00007f7ecde1a806 in RGWSwift::verify_swift_token(RGWRados*, req_state*) () from /usr/lib/librgw.so.2
>     > #8  0x00007f7ecde064da in RGWHandler_REST_SWIFT::authorize() () from /usr/lib/librgw.so.2
>     > #9  0x00007f7ecdd19d67 in process_request(RGWRados*, RGWREST*, RGWRequest*, RGWStreamIO*, OpsLogSocket*) () from /usr/lib/librgw.so.2
>     > #10 0x000055a19da88b9f in ?? ()
>     > #11 0x000055a19da9288f in ?? ()
>     > #12 0x000055a19da9485e in ?? ()
>     > #13 0x00007f7ecd0c8184 in start_thread (arg=0x7f6a63069700) at pthread_create.c:312
>     > #14 0x00007f7ecc8db37d in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:111
>     >  (gdb) t 5369
>     > [Switching to thread 5369 (Thread 0x7f67862b0700 (LWP 29074))]
>     > #0  __lll_lock_wait () at ../nptl/sysdeps/unix/sysv/linux/x86_64/lowlevellock.S:135
>     > 135     ../nptl/sysdeps/unix/sysv/linux/x86_64/lowlevellock.S: No such file or directory.
>     > (gdb) bt
>     > #0  __lll_lock_wait () at ../nptl/sysdeps/unix/sysv/linux/x86_64/lowlevellock.S:135
>     > #1  0x00007f7ecd0ca664 in _L_lock_952 () from /lib/x86_64-linux-gnu/libpthread.so.0
>     > #2  0x00007f7ecd0ca4c6 in __GI___pthread_mutex_lock (mutex=0x55a19f8b8fe0) at ../nptl/pthread_mutex_lock.c:114
>     > #3  0x00007f7ece002638 in Mutex::Lock(bool) () from /usr/lib/librgw.so.2
>     > #4  0x00007f7ecdc8097a in RGWKeystoneTokenCache::find(std::string const&, KeystoneToken&) () from /usr/lib/librgw.so.2
>     > #5  0x00007f7ecde17829 in RGWSwift::validate_keystone_token(RGWRados*, std::string const&, RGWUserInfo&) () from /usr/lib/librgw.so.2
>     > #6  0x00007f7ecde1a25d in RGWSwift::do_verify_swift_token(RGWRados*, req_state*) () from /usr/lib/librgw.so.2
>     > #7  0x00007f7ecde1a806 in RGWSwift::verify_swift_token(RGWRados*, req_state*) () from /usr/lib/librgw.so.2
>     > #8  0x00007f7ecde064da in RGWHandler_REST_SWIFT::authorize() () from /usr/lib/librgw.so.2
>     > #9  0x00007f7ecdd19d67 in process_request(RGWRados*, RGWREST*, RGWRequest*, RGWStreamIO*, OpsLogSocket*) () from /usr/lib/librgw.so.2
>     > #10 0x000055a19da88b9f in ?? ()
>     > #11 0x000055a19da9288f in ?? ()
>     > #12 0x000055a19da9485e in ?? ()
>     > #13 0x00007f7ecd0c8184 in start_thread (arg=0x7f67862b0700) at pthread_create.c:312
>     > #14 0x00007f7ecc8db37d in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:111
>     > (gdb)
>     >
>     > <\snip>
>     >
>     > Thanks,
>     > -Pavan.
>     >
>     --
>     To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>     the body of a message to majordomo@vger.kernel.org
>     More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
