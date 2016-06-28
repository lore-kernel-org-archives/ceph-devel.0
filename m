From: Alfredo Deza <adeza@redhat.com>
Subject: Re: ceph build changes
Date: Tue, 28 Jun 2016 08:13:06 -0400
Message-ID: <CAC-Np1xXt5zAUv9vtqh4V43JeCd0NKKV1G8wB_mhUfWVB5t9uw@mail.gmail.com>
References: <alpine.DEB.2.11.1606272200310.7088@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35745 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753AbcF1MNJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Jun 2016 08:13:09 -0400
Received: by mail-wm0-f53.google.com with SMTP id v199so137050589wmv.0
        for <ceph-devel@vger.kernel.org>; Tue, 28 Jun 2016 05:13:08 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1606272200310.7088@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Jun 27, 2016 at 6:05 PM, Sage Weil <sweil@redhat.com> wrote:
> Hey Alfredo,
>
> Just a heads up that the changes to gitbuilder to enable cmake were pretty
> minimal.  It basically comes down to using the make-dist script to
> generate the tarball instead of running ./autogen.sh, ./configure, and
> then 'make dist' just to get the tarball.  Here's what we changed:
>
>         https://github.com/ceph/autobuild-ceph/commit/eccdc8f61273e97710203eaae55a2c4258b64087
>
> It's slightly annoying because older branches won't have make-dist, but
> newer branches will, and it has to do a build both ways.  Not too crazy,
> though.

Thanks for the heads up.

The changes look straightforward but I am concerned on how to make
them work for a release. I could just copy/pasta them
into the build script but it is very easy (and has happened before) to
get out of sync if the gitbuilder script gets modifications.

To get a tarball, you are right in what we call:

* install-deps.sh (if it exists)
* autogen.sh
* configure


See: https://github.com/ceph/ceph-build/blob/master/ceph-setup/build/build#L30-L58

Is it not possible to get these changes within the source tree? Having
a single place where to call them is a huge win.

>
> The other change was that we have a new environment variable for passing
> down cmake optons that parallels the old CEPH_EXTRA_CONFIGURE_ARGS:
>
>         https://github.com/ceph/autobuild-ceph/commit/71d02e8b2c9bd3533c44b3bf0408681ed7890248
>
> I'm guessing we don't need that for a proper release, but in case we do,
> the script should just set both.

Passing options via environment variables sounds reasonable, it is
nice that it got implemented.

>
> Anyway, with those changes, the final step is to change debian/rules and
> ceph.spec.in in ceph.git itself to build using cmake instead of autotools,
> but as long as the source tarball is coming from make-dist the ceph-build
> stuff doesn't need to know or care about that--it's all hidden by rpmbuild
> and dpkg-buildpackage/pbuilder.

So, we do call `make dist` and `make dist-bzip2`, but then again,
porting the changes in build-ceph-native.sh is what
worries me.

>
> As soon as the deb and rpm changes are working when built by the
> gitbuilders (basically there with debs, rpms up next) I think we should do
> a dev release through the new jenkins pipeline to demonstrate that the
> whole thing works.  Maybe the week after next?

We can do that or even try "throwaway" builds before. Shouldn't be a
problem to try it out.

>
> Thanks!
> sage
