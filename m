From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: Re: cmake
Date: Wed, 16 Dec 2015 10:45:54 -0800
Message-ID: <CADRKj5Ru75B=uNtb3OyaBBxYJVLrNXPhec77pnQddj88Jb05ng@mail.gmail.com>
References: <alpine.DEB.2.00.1512160839350.10312@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f43.google.com ([209.85.218.43]:35150 "EHLO
	mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754785AbbLPSpy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Dec 2015 13:45:54 -0500
Received: by mail-oi0-f43.google.com with SMTP id l9so838446oia.2
        for <ceph-devel@vger.kernel.org>; Wed, 16 Dec 2015 10:45:54 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1512160839350.10312@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Dec 16, 2015 at 9:33 AM, Sage Weil <sweil@redhat.com> wrote:
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
>

Is cmake a viable option in all environments we expect ceph (or any
part of) to be compiled on? (e.g. aix, solaris, freebsd, different
linux arm distros, etc.)

> 2. Be able to run vstart etc from the build dir.

There's an awful hack currently in vstart.sh and stop.sh that checks
for CMakeCache.txt in the current work directory to verify whether we
built using cmake or autotools. Can we make this go away?
We can do something like having the build system create a
'ceph-setenv.sh' script that would set the env (or open a shelll) with
the appropriate paths.

>
> 3. Be able to run ./ceph[-anything] from the build dir, or put the build
> dir in the path.  (I suppose we could rely in a make install step, but
> that seems like more hassle... hopefully it's not neceesary?)
>
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
