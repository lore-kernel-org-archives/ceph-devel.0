From: kefu chai <tchaikov@gmail.com>
Subject: Re: Proposing strategies for debuginfo size reduction
Date: Mon, 6 Mar 2017 17:31:29 +0800
Message-ID: <CAJE9aOPBkXETOTW6QgZTJVuW65wLv=UrENHADvd_r6VNwvHqHA@mail.gmail.com>
References: <CAF-wwdHTkEAGchaPD=qV0tuVNtrevhG0=ny1SdDz7-vbTXE3BQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f177.google.com ([209.85.217.177]:33538 "EHLO
        mail-ua0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754035AbdCFJbb (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Mar 2017 04:31:31 -0500
Received: by mail-ua0-f177.google.com with SMTP id u30so28513362uau.0
        for <ceph-devel@vger.kernel.org>; Mon, 06 Mar 2017 01:31:30 -0800 (PST)
In-Reply-To: <CAF-wwdHTkEAGchaPD=qV0tuVNtrevhG0=ny1SdDz7-vbTXE3BQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brad Hubbard <bhubbard@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Mar 6, 2017 at 3:00 PM, Brad Hubbard <bhubbard@redhat.com> wrote:
> Recently there was some discussion about the size of the ceph
> debuginfo package so I thought I would do a little investigation into
> the size and what, if anything, we can do about it.
>
> A recent master build shows the following.
>
> ceph-debuginfo-12.0.0-812.gc73d8b4.el7.x86_64.rpm  06-Mar-2017 03:46
>         911856132
>
> So about 900M (note that an equivalent kernel debuginfo package is
> under 350M). This will increase as we have just disabled dwz
> compression in master.
>
> Once extracted that is...
>
> $ du ./usr/ --max-depth=0
> 3472348 ./usr/
>
> So about 3.4G on disk. That's a lot of debuginfo.
>
> First I went looking for an easy win and I believe there may be one to
> be had in the fact that we include debuginfo for the ceph_test_*
> binaries. Do we need to produce debuginfo for them? They currently
> represent about 800+M on disk so could represent a quick and easy way
> to reduce the size of the debuginfo we ship.

we do, so we can perform post-mortem debugging with the coredump if any
of them crashes in the qa run. but maybe their debuginfo is not necessary
for the builds intended be used by our users. but we still need to patch
rpm[1]. and looks like the upstream does not like this idea[2]. as discussed
over IRC, maybe we need to understand the "underlying problem", i.e.
who/what is the biggest contributor of the 800+M debuginfo before going
any further.

>
> Another option that has been discussed may be to split the debuginfo
> package into various sub-packages that align somewhat with the
> sub-packages we currently generate. I believe this already happens to
> some degree in the deb packaging. Unfortunately, this is not
> straight-forward to achieve with rpm based distros although I note
> that OpenSUSE have gone down this path.A the problem with these two
> approaches IMHO is that they don't directly address the issue of why

please see http://tracker.ceph.com/issues/19099#note-16.


> the debuginfo package is so large.
>
> I then looked at compiler options that may help.
>
> With the addition of the following line to CMakeLists.txt we see a
> significant reduction in the size of the debuginfo.
>
> set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -femit-struct-debug-reduced")
>
> ceph-debuginfo-12.0.0-812.g60fccb2.el7.x86_64.rpm  06-Mar-2017 01:08
>         661507672
>
> Changing that CMakeLists.txt line to the following reduces it further.
>
> set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -femit-struct-debug-baseonly")
>
> ceph-debuginfo-12.0.0-812.gac37464.el7.x86_64.rpm  06-Mar-2017 02:37
>         513097340
>
> These flags seem to be the only ones that make a significant difference [1].
>
> The scary part here is that these flags result in some loss of
> debuginfo, how much and how that would affect debugging I'm still
> trying to determine. There are strategies to include debuginfo that
> may be omitted [2]. I'd suggest thought that this option would need a
> lot more research and some testing.
>
> The final suggestion is based on speculation and therefore requires
> further investigation, discussion, planning and testing before moving
> forward. I *suspect* that the reason our debuginfo package is so large
> is due to all the static linking we do and I would suggest that
> reducing the amount of static linking would go a long way to reduce
> the size of the debuginfo. Currently we statically link rocksdb,
> boost, civetweb, zstd, and isa-l at least as well as libceph-common
> and possibly others on a per-binary basis but these are the main ones.

this is not accurate. currently, libceph-common statically links against
these libraries. and our tests and client side tools are linked against
libceph-common, so they are not duplicated among them.

but because this library is included by librados2 which is not depended
by the daemons, like, ceph-osd, ceph-mon. and these daemons have
their own copy of these libraries. so if we want to dedup the shared
code/debuginfo further, we should create a dedicated package so
both client/tests and daemons can depend on it. because i don't think
that the ceph-osd and its friends should depend on librados, which
is a client side library/package.

> One possible solution to this may be to build our own shared objects
> and dynamically link to them (libcephboost_system.so,
> libcephboost_program_options.so, libcephrocksdb.so, etc.) We would
> then, of course, have to package these but I suspect it would actually
> lead to a smaller on-disk footprint. If my suspicion is right this
> will significantly reduce the size of the debuginfo we package but, of
> course, this would need to be validated and I welcome the thoughts and
> opinions of others about the merit of this approach as well as the
> others mentioned.

i don't think the downstreams would be in favor of this solution. as the only
point of splitting them is to have smaller debuginfo. these so will be only
used by libceph-common. even if we go this way, we still have problem
for packaging the debuginfo of them: we cannot do this without patching
the rpm, see

---
[1] SuSE's patch of rpm for splitting debuginfo into subpackage,
    https://build.opensuse.org/package/view_file?file=debugsubpkg.diff&package=rpm&project=openSUSE%3AFactory.
[2] https://bugzilla.redhat.com/show_bug.cgi?id=185590

>
> Looking forward to people's thoughts on this.
>
>
> [1] https://gcc.gnu.org/onlinedocs/gcc/Debugging-Options.html
> [2] http://opengrok.baylibre.com/source/history/linux/lib/debug_info.c
>
>
> --
> Cheers,
> Brad
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Regards
Kefu Chai
