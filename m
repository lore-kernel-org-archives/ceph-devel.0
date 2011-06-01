From: Colin Patrick McCabe <colin.mccabe@dreamhost.com>
Subject: Some thoughts about exceptions and Ceph
Date: Tue, 31 May 2011 21:45:45 -0700
Message-ID: <BANLkTinPqDm-pbAfi2eEa2_ZtM38-7kSkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:52899 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750923Ab1FAEpr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Jun 2011 00:45:47 -0400
Received: by fxm17 with SMTP id 17so3521135fxm.19
        for <ceph-devel@vger.kernel.org>; Tue, 31 May 2011 21:45:45 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Ok. The exceptions issue. Flamewar in 3... 2... 1...

Although most of Ceph is C++, a lot of the code in Ceph is written in a C-like
style. Partly this is because we want to use the low-level features of C++ is
gain some additional efficiency. Partly this is because we supply C APIs and
interact with a lot of C APIs. The kernel client, obviously, is written in pure
C. All of the daemons interact a lot with the POSIX libc APIs rather than using
something like QT, .NET, or ACE, etc.

Unfortunately, one aspect of this C-like style is that almost none of the code
is exception-safe. Although it interacts with code that can throw exceptions,
it can't handle the situations which would arise if an exception were actually
thrown. Any place where you have something like this is an deadlock waiting to
happen:

> pthread_mutex_lock(&lock);
> exception_fest();
> pthread_mutex_unlock(&lock);

Another problem is that we offer a lot of library APIs which use "extern C".
Functions with C linkage cannot handle exceptions. If an exception tries to
propagate through a function with C linkage, the entire program aborts with a
message like this:

> "terminate called after throwing an instance of 'std::runtime_error'"

You can see this behavior in this C++ program:

> int foo() {
>   throw std::runtime_error("hi");
>   return 0;
> }
>
> extern "C" int main(void) {
>   return foo();
> }

It's very hard to avoid situations like these while exceptions are enabled.
Especially for novices who don't know the unwritten rules, this can be very
difficult.

In theory, we could rewrite the code to be exception-safe. However, the amount
of work required to do this would be immense. Almost every naked pointer would
have to be wrapped in a smart pointer. All mutex locks would have to replaced
with Mutex::Locker or similar. Control flow would have to be analyzed
everywhere. Even once that effort had been put it, there is a big ongoing cost
to stay exception-safe in C++.

It seems that many well-known and successful C++ projects use -fno-exceptions.
Mozilla Firefox uses -fno-exceptions. Nicholas Nethercote says that he has been
told that this is because "the performance of code that uses exceptions is
unacceptable." WebKit compiles with -fno-exceptions and -fno-rtti.  The Android
native development kit (NDK) until recently did not support exceptions for C++.
(You still must supply your own version of libstdc++ if you want to use
exceptions on Android, and there are a lot of gotchas.)
Google Chrome does not use exceptions. See
http://code.google.com/p/chromium/issues/detail?id=19094
This link is about Chromium, but it's the same basic codebase.

On the other hand, -fno-exceptions seems to have some pitfalls. Apparently, if
you want the default operator new to give you a NULL pointer, instead of
throwing an exception, you have to recompile libstdc++ yourself with special
options.  Mozilla's approach to avoiding this problem seems to be just not using
operator new, at least in SpiderMonkey. Instead, they use their own allocation
functions.  See https://bugzilla.mozilla.org/show_bug.cgi?id=624878 I think
several companies do recompile libstdc++ for their internal use, but asking
Ceph users to do that seems a little bit excessive.

I think -fno-exceptions means that you have to also use -fno-rtti. This is
because a dynamic cast to a reference type cannot fail by returning a NULL
reference (since there is no such thing.) The documentation is strangely
lacking on this subject, but it seems that you can't have RTTI without
exceptions.

Is all of this annoyance worth it?  Well, the Chromium bug report says that
with -fno-exceptions, the size of their binaries went down by 20%. That is a
pretty huge savings, especially when you consider its effect on things like the
instruction cache. On the other hand, this is probably a distraction from the
other important things that we have been working on.

Here are a few concrete recommendations:
1. Any place that is checking for a NULL pointer from new() is wrong. new()
will never return one of those.

Replace this:
> Foo *f = new Foo*();
> if (!f)
>   return -ENOMEM;

with this:
> try {
>   f = new Foo*();
> }
> catch (std::bad_alloc &a) {
>   return -ENOMEM;
> }

2. *Unless* we decide to embark on a major refactoring adventure, we should use
error codes rather than exceptions, in order to be consistent with the existing
Ceph code.

3. Whenever calling user-supplied functions, we need to surround the call with
a catch(...) block, in case the user throws an exception.

4. We should investigate std::set_unexpected and std::set_terminate.
I think the "unexpected" callback is invoked when an exception attempts to
cross an extern "C" ABI barrier. Perhaps we can print out a stack trace or a
better diagnostic message when this happens.

cheers,
Colin
