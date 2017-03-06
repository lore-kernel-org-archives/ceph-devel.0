From: Brad Hubbard <bhubbard@redhat.com>
Subject: Proposing strategies for debuginfo size reduction
Date: Mon, 6 Mar 2017 17:00:28 +1000
Message-ID: <CAF-wwdHTkEAGchaPD=qV0tuVNtrevhG0=ny1SdDz7-vbTXE3BQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f175.google.com ([209.85.223.175]:32889 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753037AbdCFHAb (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Mar 2017 02:00:31 -0500
Received: by mail-io0-f175.google.com with SMTP id f84so106064807ioj.0
        for <ceph-devel@vger.kernel.org>; Sun, 05 Mar 2017 23:00:30 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Recently there was some discussion about the size of the ceph
debuginfo package so I thought I would do a little investigation into
the size and what, if anything, we can do about it.

A recent master build shows the following.

ceph-debuginfo-12.0.0-812.gc73d8b4.el7.x86_64.rpm  06-Mar-2017 03:46
        911856132

So about 900M (note that an equivalent kernel debuginfo package is
under 350M). This will increase as we have just disabled dwz
compression in master.

Once extracted that is...

$ du ./usr/ --max-depth=0
3472348 ./usr/

So about 3.4G on disk. That's a lot of debuginfo.

First I went looking for an easy win and I believe there may be one to
be had in the fact that we include debuginfo for the ceph_test_*
binaries. Do we need to produce debuginfo for them? They currently
represent about 800+M on disk so could represent a quick and easy way
to reduce the size of the debuginfo we ship.

Another option that has been discussed may be to split the debuginfo
package into various sub-packages that align somewhat with the
sub-packages we currently generate. I believe this already happens to
some degree in the deb packaging. Unfortunately, this is not
straight-forward to achieve with rpm based distros although I note
that OpenSUSE have gone down this path.A the problem with these two
approaches IMHO is that they don't directly address the issue of why
the debuginfo package is so large.

I then looked at compiler options that may help.

With the addition of the following line to CMakeLists.txt we see a
significant reduction in the size of the debuginfo.

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -femit-struct-debug-reduced")

ceph-debuginfo-12.0.0-812.g60fccb2.el7.x86_64.rpm  06-Mar-2017 01:08
        661507672

Changing that CMakeLists.txt line to the following reduces it further.

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -femit-struct-debug-baseonly")

ceph-debuginfo-12.0.0-812.gac37464.el7.x86_64.rpm  06-Mar-2017 02:37
        513097340

These flags seem to be the only ones that make a significant difference [1].

The scary part here is that these flags result in some loss of
debuginfo, how much and how that would affect debugging I'm still
trying to determine. There are strategies to include debuginfo that
may be omitted [2]. I'd suggest thought that this option would need a
lot more research and some testing.

The final suggestion is based on speculation and therefore requires
further investigation, discussion, planning and testing before moving
forward. I *suspect* that the reason our debuginfo package is so large
is due to all the static linking we do and I would suggest that
reducing the amount of static linking would go a long way to reduce
the size of the debuginfo. Currently we statically link rocksdb,
boost, civetweb, zstd, and isa-l at least as well as libceph-common
and possibly others on a per-binary basis but these are the main ones.
One possible solution to this may be to build our own shared objects
and dynamically link to them (libcephboost_system.so,
libcephboost_program_options.so, libcephrocksdb.so, etc.) We would
then, of course, have to package these but I suspect it would actually
lead to a smaller on-disk footprint. If my suspicion is right this
will significantly reduce the size of the debuginfo we package but, of
course, this would need to be validated and I welcome the thoughts and
opinions of others about the merit of this approach as well as the
others mentioned.

Looking forward to people's thoughts on this.


[1] https://gcc.gnu.org/onlinedocs/gcc/Debugging-Options.html
[2] http://opengrok.baylibre.com/source/history/linux/lib/debug_info.c


--
Cheers,
Brad
