From: Daniel Gryniewicz <dang@redhat.com>
Subject: Re: RGW recursive lock on Jewel
Date: Wed, 26 Oct 2016 13:17:36 -0400
Message-ID: <fe5921e6-dfa7-bbb5-2734-494e865f5387@redhat.com>
References: <D9881DD9-3DEE-4E37-8ED3-B47017168CBA@walmartlabs.com>
Reply-To: dang@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f179.google.com ([209.85.220.179]:34348 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752427AbcJZRRi (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 26 Oct 2016 13:17:38 -0400
Received: by mail-qk0-f179.google.com with SMTP id x11so11523196qka.1
        for <ceph-devel@vger.kernel.org>; Wed, 26 Oct 2016 10:17:38 -0700 (PDT)
In-Reply-To: <D9881DD9-3DEE-4E37-8ED3-B47017168CBA@walmartlabs.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Pavan Rallabhandi <PRallabhandi@walmartlabs.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

It seems unlikely.  The codepath in that PR traversed 
RGWKeystoneTokenCache::find_admin() which caused the recursive lock, 
while the backtraces below traverse RGWSwift::validate_keystone_token() 
instead, which does not take the lock in question.

It's possible another thread may be hitting the recursive lock, however.

Daniel

On 10/26/2016 12:11 PM, Pavan Rallabhandi wrote:
> In one of our clusters, we are running a nightly version of Jewel (below), and one of the RGW nodes is unresponsive with ~4.5G of resident memory and almost one core of CPU consumed. Almost all of the client connections to the RGW are in CLOSE_WAIT, and we were trying with 1024 RGW thread pool size for some client operations. There are at least 3 other RGWs in the same cluster with similar configuration but they seem to be doing fine.
>
> I wonder if we have run into https://github.com/ceph/ceph/pull/10562 on Jewel. Please find the stack traces from couple of threads in the rogue RGW.
>
> Can someone please confirm if that’s indeed the case?
>
> <snip>
>
> $ceph -v
> ceph version 10.2.2-508-g9bfc0cf (9bfc0cf178dc21b0fe33e0ce3b90a18858abaf1b)
>
>
> (gdb) t 6836
> [Switching to thread 6836 (Thread 0x7f6a63069700 (LWP 27601))]
> #0  __lll_lock_wait () at ../nptl/sysdeps/unix/sysv/linux/x86_64/lowlevellock.S:135
> 135	../nptl/sysdeps/unix/sysv/linux/x86_64/lowlevellock.S: No such file or directory.
> (gdb) bt
> #0  __lll_lock_wait () at ../nptl/sysdeps/unix/sysv/linux/x86_64/lowlevellock.S:135
> #1  0x00007f7ecd0ca664 in _L_lock_952 () from /lib/x86_64-linux-gnu/libpthread.so.0
> #2  0x00007f7ecd0ca4c6 in __GI___pthread_mutex_lock (mutex=0x55a19f8b8fe0) at ../nptl/pthread_mutex_lock.c:114
> #3  0x00007f7ece002638 in Mutex::Lock(bool) () from /usr/lib/librgw.so.2
> #4  0x00007f7ecdc8097a in RGWKeystoneTokenCache::find(std::string const&, KeystoneToken&) () from /usr/lib/librgw.so.2
> #5  0x00007f7ecde17829 in RGWSwift::validate_keystone_token(RGWRados*, std::string const&, RGWUserInfo&) () from /usr/lib/librgw.so.2
> #6  0x00007f7ecde1a25d in RGWSwift::do_verify_swift_token(RGWRados*, req_state*) () from /usr/lib/librgw.so.2
> #7  0x00007f7ecde1a806 in RGWSwift::verify_swift_token(RGWRados*, req_state*) () from /usr/lib/librgw.so.2
> #8  0x00007f7ecde064da in RGWHandler_REST_SWIFT::authorize() () from /usr/lib/librgw.so.2
> #9  0x00007f7ecdd19d67 in process_request(RGWRados*, RGWREST*, RGWRequest*, RGWStreamIO*, OpsLogSocket*) () from /usr/lib/librgw.so.2
> #10 0x000055a19da88b9f in ?? ()
> #11 0x000055a19da9288f in ?? ()
> #12 0x000055a19da9485e in ?? ()
> #13 0x00007f7ecd0c8184 in start_thread (arg=0x7f6a63069700) at pthread_create.c:312
> #14 0x00007f7ecc8db37d in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:111
>  (gdb) t 5369
> [Switching to thread 5369 (Thread 0x7f67862b0700 (LWP 29074))]
> #0  __lll_lock_wait () at ../nptl/sysdeps/unix/sysv/linux/x86_64/lowlevellock.S:135
> 135	../nptl/sysdeps/unix/sysv/linux/x86_64/lowlevellock.S: No such file or directory.
> (gdb) bt
> #0  __lll_lock_wait () at ../nptl/sysdeps/unix/sysv/linux/x86_64/lowlevellock.S:135
> #1  0x00007f7ecd0ca664 in _L_lock_952 () from /lib/x86_64-linux-gnu/libpthread.so.0
> #2  0x00007f7ecd0ca4c6 in __GI___pthread_mutex_lock (mutex=0x55a19f8b8fe0) at ../nptl/pthread_mutex_lock.c:114
> #3  0x00007f7ece002638 in Mutex::Lock(bool) () from /usr/lib/librgw.so.2
> #4  0x00007f7ecdc8097a in RGWKeystoneTokenCache::find(std::string const&, KeystoneToken&) () from /usr/lib/librgw.so.2
> #5  0x00007f7ecde17829 in RGWSwift::validate_keystone_token(RGWRados*, std::string const&, RGWUserInfo&) () from /usr/lib/librgw.so.2
> #6  0x00007f7ecde1a25d in RGWSwift::do_verify_swift_token(RGWRados*, req_state*) () from /usr/lib/librgw.so.2
> #7  0x00007f7ecde1a806 in RGWSwift::verify_swift_token(RGWRados*, req_state*) () from /usr/lib/librgw.so.2
> #8  0x00007f7ecde064da in RGWHandler_REST_SWIFT::authorize() () from /usr/lib/librgw.so.2
> #9  0x00007f7ecdd19d67 in process_request(RGWRados*, RGWREST*, RGWRequest*, RGWStreamIO*, OpsLogSocket*) () from /usr/lib/librgw.so.2
> #10 0x000055a19da88b9f in ?? ()
> #11 0x000055a19da9288f in ?? ()
> #12 0x000055a19da9485e in ?? ()
> #13 0x00007f7ecd0c8184 in start_thread (arg=0x7f67862b0700) at pthread_create.c:312
> #14 0x00007f7ecc8db37d in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:111
> (gdb)
>
> <\snip>
>
> Thanks,
> -Pavan.
>
> N�����r��y���b�X��ǧv�^�)޺{.n�+���z�]z���{ay�ʇڙ�,j��f���h���z��w������j:+v���w�j�m��������zZ+�����ݢj"��!tml=
>

