From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: about cpu_profiler
Date: Fri, 4 Mar 2011 12:08:15 -0800
Message-ID: <AANLkTimYykJpXQF3qUPYA7OF2jUf55WruXje1q0xJTet@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46168 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760077Ab1CDUIQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Mar 2011 15:08:16 -0500
Received: by fxm17 with SMTP id 17so2510833fxm.19
        for <ceph-devel@vger.kernel.org>; Fri, 04 Mar 2011 12:08:15 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

tl;dr: cpu_profiler may randomly crash your program on x86_64.
The problem "should" be resolved in the "future".

Full text from google-perftools-1.7/README:

> 2) On x86-64 64-bit systems, while tcmalloc itself works fine, the
> cpu-profiler tool is unreliable: it will sometimes work, but sometimes
> cause a segfault.  I'll explain the problem first, and then some
> workarounds.
>
> Note that this only affects the cpu-profiler, which is a
> google-perftools feature you must turn on manually by setting the
> CPUPROFILE environment variable.  If you do not turn on cpu-profiling,
> you shouldn't see any crashes due to perftools.
>
> The gory details: The underlying problem is in the backtrace()
> function, which is a built-in function in libc.
> Backtracing is fairly straightforward in the normal case, but can run
> into problems when having to backtrace across a signal frame.
> Unfortunately, the cpu-profiler uses signals in order to register a
> profiling event, so every backtrace that the profiler does crosses a
> signal frame.
>
> In our experience, the only time there is trouble is when the signal
> fires in the middle of pthread_mutex_lock.  pthread_mutex_lock is
> called quite a bit from system libraries, particularly at program
> startup and when creating a new thread.
>
> The solution: The dwarf debugging format has support for 'cfi
> annotations', which make it easy to recognize a signal frame.  Some OS
> distributions, such as Fedora and gentoo 2007.0, already have added
> cfi annotations to their libc.  A future version of libunwind should
> recognize these annotations; these systems should not see any
> crashses.
>
> Workarounds: If you see problems with crashes when running the
> cpu-profiler, consider inserting ProfilerStart()/ProfilerStop() into
> your code, rather than setting CPUPROFILE.  This will profile only
> those sections of the codebase.  Though we haven't done much testing,
> in theory this should reduce the chance of crashes by limiting the
> signal generation to only a small part of the codebase.  Ideally, you
> would not use ProfilerStart()/ProfilerStop() around code that spawns
> new threads, or is otherwise likely to cause a call to
> pthread_mutex_lock!
>
> ---
> 11 January 2011

I'm hoping that this is out of date?

Colin
