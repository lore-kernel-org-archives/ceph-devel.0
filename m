From: Matt Benjamin <mbenjamin@redhat.com>
Subject: Re: cmake
Date: Wed, 16 Dec 2015 14:06:06 -0500 (EST)
Message-ID: <1306047444.39980907.1450292766855.JavaMail.zimbra@redhat.com>
References: <alpine.DEB.2.00.1512160839350.10312@cobra.newdream.net> <CADRKj5Ru75B=uNtb3OyaBBxYJVLrNXPhec77pnQddj88Jb05ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:50384 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965728AbbLPTGH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Dec 2015 14:06:07 -0500
In-Reply-To: <CADRKj5Ru75B=uNtb3OyaBBxYJVLrNXPhec77pnQddj88Jb05ng@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Cc: Sage Weil <sweil@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi,

responding to all these at once.

----- Original Message -----
> From: "Yehuda Sadeh-Weinraub" <yehuda@redhat.com>
> To: "Sage Weil" <sweil@redhat.com>
> Cc: "ceph-devel" <ceph-devel@vger.kernel.org>
> Sent: Wednesday, December 16, 2015 1:45:54 PM
> Subject: Re: cmake
> 
> On Wed, Dec 16, 2015 at 9:33 AM, Sage Weil <sweil@redhat.com> wrote:
> > The work to transition to cmake has stalled somewhat.  I've tried to use
> > it a few times but keep running into issues that make it unusable for me.
> > Not having make check is a big one, but I think the hackery required to
> > get that going points to the underlying problem(s).

I'm going to push for cmake work already in progress to be moved to the next milestone ASAP.

With respect to "make check" blockers, which contains the issue of where cmake puts built objects.  Ali, Casey, and I discussed this today at some length.  We think the current "hackery" to make cmake make check work "the same way" auto* did is long-term undesirable due to it mutating files in the src dir.  I have not assumed that it would be an improvement to put all objects built in a tree of submakes into a single dir, as automake does.  I do think it is essential that at least eventually, it makes it simple to operate on any object that is built, and simple to extend processes like make check.

Ali and Casey agree, but contend that the current make check work is "almost finished"--specifically, that it could be finished and a PR sent -this week-.  Rewriting it will take additional time.  They propose starting with finishing and documenting the current setup, then doing a larger cleanup.

What do others think?

Matt

> >
> > I seems like the main problem is that automake puts all build targets in
> > src/ and cmake spreads them all over build/*.  This makes that you can't
> > just add ./ to anything that would normally be in your path (or,
> > PATH=.:$PATH, and then run, say, ../qa/workunits/cephtool/test.sh).
> > There's a bunch of kludges in vstart.sh to make it work that I think
> > mostly point to this issue (and the .libs things).  Is there simply an
> > option we can give cmake to make it put built binaries directly in build/?
> >
> > Stepping back a bit, it seems like the goals should be
> >
> > 1. Be able to completely replace autotools.  I don't fancy maintaining
> > both in parallel.
> >
> 
> Is cmake a viable option in all environments we expect ceph (or any
> part of) to be compiled on? (e.g. aix, solaris, freebsd, different
> linux arm distros, etc.)

One cannot expect cmake to be pre-installed on those platforms, but it will work on every one you mentioned, some others, not to mention Windows.

> 
> > 2. Be able to run vstart etc from the build dir.
> 
> There's an awful hack currently in vstart.sh and stop.sh that checks
> for CMakeCache.txt in the current work directory to verify whether we
> built using cmake or autotools. Can we make this go away?
> We can do something like having the build system create a
> 'ceph-setenv.sh' script that would set the env (or open a shelll) with
> the appropriate paths.



> 
> >
> > 3. Be able to run ./ceph[-anything] from the build dir, or put the build
> > dir in the path.  (I suppose we could rely in a make install step, but
> > that seems like more hassle... hopefully it's not neceesary?)
> >
> > 4. make check has to work
> >
> > 5. Use make-dist.sh to generate a release tarball (not make dist)
> >
> > 6. gitbuilders use make-dist.sh and cmake to build packages
> >
> > 7. release process uses make-dist.sh and cmake to build a relelase
> >
> > I'm probably missing something?
> >
> > Should we set a target of doing the 10.0.2 or .3 with cmake?
> >
> > sage
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
-- 
Matt Benjamin
Red Hat, Inc.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://www.redhat.com/en/technologies/storage

tel.  734-707-0660
fax.  734-769-8938
cel.  734-216-5309
