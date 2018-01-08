From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: [ceph-users] C++17 and C++ ABI on master
Date: Mon, 8 Jan 2018 13:52:26 -0800
Message-ID: <CAJ4mKGYG32tFD37BVVin-kjRxtpcmO0xAp36ozfB4ugDPnrHFg@mail.gmail.com>
References: <20180108214425.GA10545@ultraspiritum.eng.arb.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f41.google.com ([209.85.214.41]:33264 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755667AbeAHVw2 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Jan 2018 16:52:28 -0500
Received: by mail-it0-f41.google.com with SMTP id c102so5360383itd.0
        for <ceph-devel@vger.kernel.org>; Mon, 08 Jan 2018 13:52:28 -0800 (PST)
In-Reply-To: <20180108214425.GA10545@ultraspiritum.eng.arb.redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: The Esoteric Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>
Cc: Eric.Cano@cern.ch, Dan Van Der Ster <daniel.vanderster@cern.ch>

CC: the only people I'm aware of who noticed the last C++ ABI breakage.

We discussed splitting out a "libradospp" for C++ that lets us change
SO_VERSION on ABI changes in the future, and hope to do it for Mimic
release. Unfortunately we can't do that in librados at the moment
since most users are C-only, and bumping the version on QEMU or other
upstreams would result in them being stuck with the previous library
versions.
-Greg

On Mon, Jan 8, 2018 at 1:44 PM, Adam C. Emerson <aemerson@redhat.com> wrote:
> Good day,
>
> I've just merged some changs into master that set us up to compile
> with C++17. This will require a reasonably new compiler to build
> master.
>
> Due to a change in how 'noexcept' is handled (it is now part of the type
> signature of a function), mangled symbol names of noexcept functions are
> different, so if you have custom clients using the C++ libraries, you may
> need to recompile.
>
> Do not worry, there should be no change to the C ABI. Any C clients
> should be unaffected.
>
> Thank you.
>
> --
> Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
> IRC: Aemerson@OFTC, Actinic@Freenode
> 0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
