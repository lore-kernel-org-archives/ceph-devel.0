From: Sage Weil <sweil@redhat.com>
Subject: Re: Configure dependencies can be the same as make dependencies
Date: Tue, 9 Jun 2015 10:22:32 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1506091017430.1985@cobra.newdream.net>
References: <5548807A.6060103@dachary.org> <CAC6JEv_s1i9vw8zt16iW1WBe9JRfpG_cg2npnvuvmzpoUYxuYg@mail.gmail.com> <5548D57E.3050406@dachary.org> <55491307.8010203@redhat.com> <554914EC.6000102@dachary.org> <alpine.DEB.2.00.1505051231040.13336@cobra.newdream.net>
 <55771E30.8070308@suse.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-447029015-1433870554=:1985"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41904 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752131AbbFIRWf (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 9 Jun 2015 13:22:35 -0400
In-Reply-To: <55771E30.8070308@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Owen Synge <osynge@suse.com>
Cc: Loic Dachary <loic@dachary.org>, Ken Dreyer <kdreyer@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-447029015-1433870554=:1985
Content-Type: TEXT/PLAIN; charset=windows-1252
Content-Transfer-Encoding: 8BIT

On Tue, 9 Jun 2015, Owen Synge wrote:
> Sorry to catch this thread late.

There were two goals here:

 1- make the generated tarball deterministic and independent of 
configure options.  Currently we have horrible hackery to include rocksdb 
source in the tarball when configure doesn't get the rocksdb arguments, 
and were hitting similar roadblocks/pain with libxio.  This is avoided 
with the make_dist.sh script (although we're not using it yet because of 
the specfile generation piece).

 2- avoid multiple passes through ./configure for 'make dist' and the 
subsequent build.  We currently do it for the 'make dist' step (which also 
generates ceph.spec) and then for the eventual build.  Using autotools for 
generating the spec means we still do it twice.

I'm less concerned about build speed and it may be worth consolidating all 
of the distro logic in configure.ac.  Honestly I don't really know if 
that is better or not (vs conditionals in the specfile)... I have no real 
love for autotools.

But hopefully the tarball step can remain a fast, deterministic step that 
doesn't require a configure pass?

sage




> 
> I come here via patch
> 
> https://github.com/ceph/ceph/pull/4911#issuecomment-110422312
> 
> I think you guys are missing that configure is doing some thing here.
> 
> (1) Configure is generating the spec file.
> (2) It could also generate the deb files.
> 
> What no one has done is to:
> 
> (A) Use configure to eliminate the differences between OS's.
> 
> If any one had done (A) you would not be considering this I hope.
> 
> This impact is particularly felt in the ceph.spec.in file where because
> of the lack of (A) in the process we are plagued with OS specific
> conditionals.
> 
> If the path of say:
> 
> 	src/ceph-osd-prestart.sh
> 
> is ether:
> 
> 	/usr/libexec/ceph
> 
> or:
> 
> 	/usr/lib/ceph
> 
> 
> Is purely distribution specific.
> 
> Having conditionals in
> 
> 	ceph.sepc.in
> 
> defeats the point of generating it via autotools.
> 
> we can be remove many hard coded values replaced with variable and that
> probably will only grow in number for example
> 
> 	%if 0%{?rhel} || 0%{?fedora}
> 		--with-systemd-libexec-dir=/usr/libexec/ceph \
> 	%endif
> 	%if 0%{?opensuse} || 0%{?suse_version}
> 		--with-systemd-libexec-dir=/usr/lib/ceph/ \
> 	%endif
> 
> some wont need distribution specific locations like:
> 
> 	--with-systemd-unit-dir=%_unitdir
> 
> In the long term replaced all these path variables could be replaced by
> single parameter.
> 
> 	./configure --with-distro-defaults=redhat
> 	make rpm
> 	./configure --with-distro-defaults=suse
> 	make rpm
> 	./configure --with-distro-defaults=debian
> 	make deb
> 	./configure --with-distro-defaults=ubuntu
> 	make deb
> 
> Very easily.
> 
> In summary, please reconsider this decision as if you follow this policy
> we are left with conditionals all over the ceph.spec.in file.
> 
> 
> Best regards
> 
> Owen
> 
> 
> 
> 
> 
> 
> On 05/05/2015 09:31 PM, Sage Weil wrote:
> > On Tue, 5 May 2015, Loic Dachary wrote:
> >>> I think the long-term solution to Kefu's issue is that we need to
> >>> remove the requirement to run through a full "./configure" invocation
> >>> just to get a tarball. All the RPM and Debian packages internally run
> >>> ./configure, so running it a second time slows things down. I think it
> >>> makes sense to implement the tarball-generation functionality using a
> >>> simpler script at the root of the ceph.git tree. The operation should
> >>> be about as fast as "git archive".
> >>
> >> I agree. It's going to be significant work but it's worth it.
> > 
> > Yep!
> > 
> >>> The "ceph.spec.in" -> "ceph.spec" suffers from a similar issue. It
> >>> takes a full "./configure" run to get to a point where Make can write
> >>> the proper version numbers into that file. Ideally we could skip all
> >>> of that and simply do the variable interpolation with sed or something.
> > 
> > Yep!
> > 
> > sage
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
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
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
--557981400-447029015-1433870554=:1985--
