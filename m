From: Sage Weil <sweil@redhat.com>
Subject: Re: ceph build changes
Date: Tue, 28 Jun 2016 14:00:25 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1606281357580.8816@piezo.us.to>
References: <alpine.DEB.2.11.1606272200310.7088@piezo.us.to> <CAC-Np1xXt5zAUv9vtqh4V43JeCd0NKKV1G8wB_mhUfWVB5t9uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43474 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752023AbcF1OCB (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 28 Jun 2016 10:02:01 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 65B26C05B1D1
	for <ceph-devel@vger.kernel.org>; Tue, 28 Jun 2016 14:00:30 +0000 (UTC)
In-Reply-To: <CAC-Np1xXt5zAUv9vtqh4V43JeCd0NKKV1G8wB_mhUfWVB5t9uw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <adeza@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, 28 Jun 2016, Alfredo Deza wrote:
> On Mon, Jun 27, 2016 at 6:05 PM, Sage Weil <sweil@redhat.com> wrote:
> > Hey Alfredo,
> >
> > Just a heads up that the changes to gitbuilder to enable cmake were pretty
> > minimal.  It basically comes down to using the make-dist script to
> > generate the tarball instead of running ./autogen.sh, ./configure, and
> > then 'make dist' just to get the tarball.  Here's what we changed:
> >
> >         https://github.com/ceph/autobuild-ceph/commit/eccdc8f61273e97710203eaae55a2c4258b64087
> >
> > It's slightly annoying because older branches won't have make-dist, but
> > newer branches will, and it has to do a build both ways.  Not too crazy,
> > though.
> 
> Thanks for the heads up.
> 
> The changes look straightforward but I am concerned on how to make
> them work for a release. I could just copy/pasta them
> into the build script but it is very easy (and has happened before) to
> get out of sync if the gitbuilder script gets modifications.
> 
> To get a tarball, you are right in what we call:
> 
> * install-deps.sh (if it exists)
> * autogen.sh
> * configure
> 
> 
> See: https://github.com/ceph/ceph-build/blob/master/ceph-setup/build/build#L30-L58
> 
> Is it not possible to get these changes within the source tree? Having
> a single place where to call them is a huge win.

Well, moving to make-dist is doing exactly that.  What I didn't 
consider is just backporting the latest make-dist to the branches we 
care about (just jewel and hammer, probably) so we don't need the 
conditional at all.  Now that you mention it though I rather like that 
approach!

> > The other change was that we have a new environment variable for passing
> > down cmake optons that parallels the old CEPH_EXTRA_CONFIGURE_ARGS:
> >
> >         https://github.com/ceph/autobuild-ceph/commit/71d02e8b2c9bd3533c44b3bf0408681ed7890248
> >
> > I'm guessing we don't need that for a proper release, but in case we do,
> > the script should just set both.
> 
> Passing options via environment variables sounds reasonable, it is
> nice that it got implemented.
> 
> >
> > Anyway, with those changes, the final step is to change debian/rules and
> > ceph.spec.in in ceph.git itself to build using cmake instead of autotools,
> > but as long as the source tarball is coming from make-dist the ceph-build
> > stuff doesn't need to know or care about that--it's all hidden by rpmbuild
> > and dpkg-buildpackage/pbuilder.
> 
> So, we do call `make dist` and `make dist-bzip2`, but then again,
> porting the changes in build-ceph-native.sh is what
> worries me.

One thing with make-dist is that it only generates a .bz2.  We can easily  
make it generate the whole gamut (.gz, .xz) too.  Whatever it needs to do 
to simplify callers...

> > As soon as the deb and rpm changes are working when built by the
> > gitbuilders (basically there with debs, rpms up next) I think we should do
> > a dev release through the new jenkins pipeline to demonstrate that the
> > whole thing works.  Maybe the week after next?
> 
> We can do that or even try "throwaway" builds before. Shouldn't be a
> problem to try it out.

Okay.  We need to fix the rpm builds (generate ceph.spec) first, but soon!

sage
