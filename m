From: Sage Weil <sweil@redhat.com>
Subject: Re: Configure dependencies can be the same as make dependencies
Date: Tue, 9 Jun 2015 11:44:51 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1506091140380.1985@cobra.newdream.net>
References: <5548807A.6060103@dachary.org> <CAC6JEv_s1i9vw8zt16iW1WBe9JRfpG_cg2npnvuvmzpoUYxuYg@mail.gmail.com> <5548D57E.3050406@dachary.org> <55491307.8010203@redhat.com> <554914EC.6000102@dachary.org> <alpine.DEB.2.00.1505051231040.13336@cobra.newdream.net>
 <55771E30.8070308@suse.com> <alpine.DEB.2.00.1506091017430.1985@cobra.newdream.net> <55772F08.6040508@suse.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-756420552-1433875493=:1985"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37419 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752335AbbFISoz (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 9 Jun 2015 14:44:55 -0400
In-Reply-To: <55772F08.6040508@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Owen Synge <osynge@suse.com>
Cc: Loic Dachary <loic@dachary.org>, Ken Dreyer <kdreyer@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-756420552-1433875493=:1985
Content-Type: TEXT/PLAIN; charset=windows-1252
Content-Transfer-Encoding: 8BIT

On Tue, 9 Jun 2015, Owen Synge wrote:
> On 06/09/2015 07:22 PM, Sage Weil wrote:
> > On Tue, 9 Jun 2015, Owen Synge wrote:
> >> Sorry to catch this thread late.
> > 
> > There were two goals here:
> > 
> >  1- make the generated tarball deterministic and independent of 
> > configure options.  Currently we have horrible hackery to include rocksdb 
> > source in the tarball when configure doesn't get the rocksdb arguments, 
> > and were hitting similar roadblocks/pain with libxio.  This is avoided 
> > with the make_dist.sh script (although we're not using it yet because of 
> > the specfile generation piece).
> 
> I think deterministic is a reasonable goal.
> 
> I think independent of configure options, is not really a goal, its a
> solution to a goal that misses a couple of observations. The goal is
> deterministic operation.
> 
> The important observations are:
> 
> (a) The same source will need to be released multiple times.
> (b) It is nice to release with some differences to each environment.

This doesn't make sense to me.  There should be *one* upstream .tar.gz (or 
whatever) that is the canonical source associated with a release.  That is 
entirely independent of which distro you eventually build that source on, 
and should (more or less) correspond to a snapshot of the git tree for the 
release tag.

Currently the only reason ceph.spec is generated from autotools is to fill 
in the version string.  I can see why filling in all the other stuff makes 
sense, but that points toward a process like

 tar zxvf ceph-9.2.1.tar.gz    # that's the canonical release tarball
 cd ceph-9.2.1
 ./autogen.sh
 ./configure --with-systemd-libexec-dir=/usr/libexec/ceph \
               --with-rpm-dir=/export/redhat/
 make srpm

right?

Making different release tarball flavors for each distro seems crazy to 
me...

sage



> 
> If you combine (a) and (b) you quickly see why the "--configure" step
> exists before:
> 
> 	make dist-bzip2
> 
> as say on release you iterate between distributions to produce each
> setup deterministically.
> 
> To illustrate I have put a little of my proposals for a replacement
> model of "make_dist.sh" to illustrate this in my opinion improved process.
> 
> But if this step exists imagining a couple of patches later:
> 
>  	$cat make_dist.sh
> 	#!/bin/sh -e
> 	# Common code
> 	autogen.sh
> 	# Redhat
> 	./configure --with-systemd-libexec-dir=/usr/libexec/ceph \
> 		--with-rpm-dir=/export/redhat/
>  	make srpm
> 	# Suse
>  	./configure --with-systemd-libexec-dir=/usr/lib/ceph/ \
> 		--with-rpm-dir=/export/suse/
>  	make srpm
> 	# Debian
>  	./configure --with-systemd-libexec-dir=/usr/lib/ceph/ \
> 		--with-sdeb-dir=/export/debian/
>  	make sdeb
> 	# Ubuntu
>  	./configure --with-systemd-libexec-dir=/usr/libexec/ceph \
> 		--with-sdeb-dir=/export/ubuntu
>  	make sdeb
> 
> This will also solve the problems (1) and (2) with ceph.spec.in to
> ceph.spec transformation. And not just solve it once but make it clearer
> for each distribution.
> 
> Problems.
> 
> These are problems with your planned approach I don't have good answers
> for, and this approach solves now.
> 
> (1) having autotools and another thing template ceph.spec.in could be
> complex.
> 
> (2) This code need to be documented as its not standard autotools.
> 
> (3) How much faster must the template tool be to be acceptably faster
> than ./configure
> 
> >  2- avoid multiple passes through ./configure for 'make dist' and the 
> > subsequent build.  We currently do it for the 'make dist' step (which also 
> > generates ceph.spec) and then for the eventual build.  Using autotools for 
> > generating the spec means we still do it twice.
> > 
> > I'm less concerned about build speed and it may be worth consolidating all 
> > of the distro logic in configure.ac.  Honestly I don't really know if 
> > that is better or not (vs conditionals in the specfile)... I have no real 
> > love for autotools.
> 
> autotools is not some thing I love, but I find it very useful, within
> the scope of building C/C++, I have found it has a solution with _every_
> use case already catered for. You just need some time to find it, and it
> may look different from what you thought you wanted and how you would
> make it, but I find the pre made autotools solution is a better solution
> than making your own from experience.
> 
> I must say though, autotools is much nicer than rpm for macros and
> variables and template expansion.
> 
> > But hopefully the tarball step can remain a fast, deterministic step that 
> > doesn't require a configure pass?
> 
> I really support you desire for deterministic.
> 
> I commend your desire that each step remain fast.
> 
> I believe you are missing a step if you follow the path of skipping the
> configure pass, and you loose some important functionality.
> 
> I point out now what functionality in the hope that we can use it to
> make other work easier, and autoools can be used to template any files
> it needs to, including at least, spec files and deb files by putting
> paths into autotools.
> 
> 
> Owen
> 
> 
> 
> > sage
> > 
> > 
> > 
> > 
> >>
> >> I come here via patch
> >>
> >> https://github.com/ceph/ceph/pull/4911#issuecomment-110422312
> >>
> >> I think you guys are missing that configure is doing some thing here.
> >>
> >> (1) Configure is generating the spec file.
> >> (2) It could also generate the deb files.
> >>
> >> What no one has done is to:
> >>
> >> (A) Use configure to eliminate the differences between OS's.
> >>
> >> If any one had done (A) you would not be considering this I hope.
> >>
> >> This impact is particularly felt in the ceph.spec.in file where because
> >> of the lack of (A) in the process we are plagued with OS specific
> >> conditionals.
> >>
> >> If the path of say:
> >>
> >> 	src/ceph-osd-prestart.sh
> >>
> >> is ether:
> >>
> >> 	/usr/libexec/ceph
> >>
> >> or:
> >>
> >> 	/usr/lib/ceph
> >>
> >>
> >> Is purely distribution specific.
> >>
> >> Having conditionals in
> >>
> >> 	ceph.sepc.in
> >>
> >> defeats the point of generating it via autotools.
> >>
> >> we can be remove many hard coded values replaced with variable and that
> >> probably will only grow in number for example
> >>
> >> 	%if 0%{?rhel} || 0%{?fedora}
> >> 		--with-systemd-libexec-dir=/usr/libexec/ceph \
> >> 	%endif
> >> 	%if 0%{?opensuse} || 0%{?suse_version}
> >> 		--with-systemd-libexec-dir=/usr/lib/ceph/ \
> >> 	%endif
> >>
> >> some wont need distribution specific locations like:
> >>
> >> 	--with-systemd-unit-dir=%_unitdir
> >>
> >> In the long term replaced all these path variables could be replaced by
> >> single parameter.
> >>
> >> 	./configure --with-distro-defaults=redhat
> >> 	make rpm
> >> 	./configure --with-distro-defaults=suse
> >> 	make rpm
> >> 	./configure --with-distro-defaults=debian
> >> 	make deb
> >> 	./configure --with-distro-defaults=ubuntu
> >> 	make deb
> >>
> >> Very easily.
> >>
> >> In summary, please reconsider this decision as if you follow this policy
> >> we are left with conditionals all over the ceph.spec.in file.
> >>
> >>
> >> Best regards
> >>
> >> Owen
> >>
> >>
> >>
> >>
> >>
> >>
> >> On 05/05/2015 09:31 PM, Sage Weil wrote:
> >>> On Tue, 5 May 2015, Loic Dachary wrote:
> >>>>> I think the long-term solution to Kefu's issue is that we need to
> >>>>> remove the requirement to run through a full "./configure" invocation
> >>>>> just to get a tarball. All the RPM and Debian packages internally run
> >>>>> ./configure, so running it a second time slows things down. I think it
> >>>>> makes sense to implement the tarball-generation functionality using a
> >>>>> simpler script at the root of the ceph.git tree. The operation should
> >>>>> be about as fast as "git archive".
> >>>>
> >>>> I agree. It's going to be significant work but it's worth it.
> >>>
> >>> Yep!
> >>>
> >>>>> The "ceph.spec.in" -> "ceph.spec" suffers from a similar issue. It
> >>>>> takes a full "./configure" run to get to a point where Make can write
> >>>>> the proper version numbers into that file. Ideally we could skip all
> >>>>> of that and simply do the variable interpolation with sed or something.
> >>>
> >>> Yep!
> >>>
> >>> sage
> >>> --
> >>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >>> the body of a message to majordomo@vger.kernel.org
> >>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>>
> >>
> >> -- 
> >> SUSE LINUX GmbH, GF: Jeff Hawn, Jennifer Guild, Felix Imendörffer, HRB
> >> 21284 (AG
> >> Nürnberg)
> >>
> >> Maxfeldstraße 5
> >>
> >> 90409 Nürnberg
> >>
> >> Germany
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>
> 
> -- 
> SUSE LINUX GmbH, GF: Jeff Hawn, Jennifer Guild, Felix Imendörffer, HRB
> 21284 (AG
> Nürnberg)
> 
> Maxfeldstraße 5
> 
> 90409 Nürnberg
> 
> Germany
> 
> 
--557981400-756420552-1433875493=:1985--
