From: John Spray <jspray@redhat.com>
Subject: Re: cmake
Date: Wed, 16 Dec 2015 18:28:09 +0000
Message-ID: <CALe9h7e4iS9=mgM4oR0iQcNBPUoA1G==bn4BK1TLka122NO=eQ@mail.gmail.com>
References: <alpine.DEB.2.00.1512160839350.10312@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:34548 "EHLO
	mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933086AbbLPS2a (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Dec 2015 13:28:30 -0500
Received: by mail-lf0-f49.google.com with SMTP id y184so35547841lfc.1
        for <ceph-devel@vger.kernel.org>; Wed, 16 Dec 2015 10:28:29 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1512160839350.10312@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Dec 16, 2015 at 5:33 PM, Sage Weil <sweil@redhat.com> wrote:
> The work to transition to cmake has stalled somewhat.  I've tried to use
> it a few times but keep running into issues that make it unusable for me.
> Not having make check is a big one, but I think the hackery required to
> get that going points to the underlying problem(s).
>
> I seems like the main problem is that automake puts all build targets in
> src/ and cmake spreads them all over build/*.  This makes that you can't
> just add ./ to anything that would normally be in your path (or,
> PATH=.:$PATH, and then run, say, ../qa/workunits/cephtool/test.sh).
> There's a bunch of kludges in vstart.sh to make it work that I think
> mostly point to this issue (and the .libs things).  Is there simply an
> option we can give cmake to make it put built binaries directly in build/?
>
> Stepping back a bit, it seems like the goals should be
>
> 1. Be able to completely replace autotools.  I don't fancy maintaining
> both in parallel.

Yes!

> 2. Be able to run vstart etc from the build dir.

I'm currently doing this (i.e. being in the build dir and running
../src/vstart.sh), along with the vstart_runner.py for cephfs tests.
I did indeed have to make sure that vstart_runner was aware of the
differing binary paths though.

Though I'm obviously using just MDS+OSD, so I might be overstating the
extent to which it currently works.

> 3. Be able to run ./ceph[-anything] from the build dir, or put the build
> dir in the path.  (I suppose we could rely in a make install step, but
> that seems like more hassle... hopefully it's not neceesary?)

Shall we just put all our libs and binaries in one place?  This works for me:
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

(to get a bin/ and a lib/ with absolutely everything in)

That way folks can either get used to typing bin/foo instead of ./foo,
or add bin/ to their path.

> 4. make check has to work
>
> 5. Use make-dist.sh to generate a release tarball (not make dist)
>
> 6. gitbuilders use make-dist.sh and cmake to build packages
>
> 7. release process uses make-dist.sh and cmake to build a relelase
>
> I'm probably missing something?
>
> Should we set a target of doing the 10.0.2 or .3 with cmake?
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
