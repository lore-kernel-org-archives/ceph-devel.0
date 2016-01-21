From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: c++ build flags, clang++, -Wnomismatched-tags?
Date: Thu, 21 Jan 2016 12:18:05 +0100
Message-ID: <CAOi1vP-gCvix34C=AhbGS7+4_sHqg-jo2+0HfaQAmr7dnqJOwg@mail.gmail.com>
References: <1295550971.21353553.1453329599755.JavaMail.zimbra@redhat.com>
	<alpine.DEB.2.11.1601201756390.18145@cpach.fuggernut.com>
	<1103317763.21365872.1453331251349.JavaMail.zimbra@redhat.com>
	<CAJ4mKGbjZ0vbupUwN1yH813Hw2cBQqXq=wpAf4zqKHRz2_Y5zQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:38831 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758886AbcAULSH convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Jan 2016 06:18:07 -0500
Received: by mail-wm0-f51.google.com with SMTP id b14so75064642wmb.1
        for <ceph-devel@vger.kernel.org>; Thu, 21 Jan 2016 03:18:06 -0800 (PST)
In-Reply-To: <CAJ4mKGbjZ0vbupUwN1yH813Hw2cBQqXq=wpAf4zqKHRz2_Y5zQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Matt Benjamin <mbenjamin@redhat.com>, Sage Weil <sage@newdream.net>, Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Jan 21, 2016 at 12:49 AM, Gregory Farnum <gfarnum@redhat.com> wrote:
> On Wed, Jan 20, 2016 at 3:07 PM, Matt Benjamin <mbenjamin@redhat.com> wrote:
>> My annoyance with this warning is that I don't really want to see "friend struct foo" decls, which seems vaguely bogus?  The warnings could be eliminated by using class everywhere and adding public specifier where expected--but we shouldn't have to do that...
>
> Do we know what other class of issues this flag warns us on? I
> actually think it might be good to be consistent about the
> struct/class distinction but don't have a strong opinion on it as long
> as we aren't masking something else by zapping the warning.

I think the reason this warning exists has to do with Microsoft
compilers, which used to (?) mangle structs and classes differently,
leading to link errors.

From the errata to Herb Sutter's "Exceptional C++" [1]:

"It's perfectly legal and standards-conforming to forward-declare
a class as a struct and vice versa. In most of the book I've tended to
avoid doing that, though. Why? Only because some compilers are buggy
and still don't get this right -- e.g., by name-mangling a class and
a struct differently, which will cause the linker to fail to match them
up. Such compiler bugs really are bugs and are wrong, but they're
common enough that we might as well avoid the issue by not relying on
this standard feature. Sigh."

It looks like MSVC 6 at least was among those compilers.  I assume it
was fixed, but this warning is still there in the latest Visual Studio [2].

[1] http://www.gotw.ca/publications/xc++-errata.htm
[2] https://msdn.microsoft.com/en-us/library/695x5bes.aspx

I doubt there is anything else we would mask by zapping it.

Thanks,

                Ilya
