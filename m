From: Sage Weil <sage@inktank.com>
Subject: Re: Small feature request for v0.55 release
Date: Wed, 14 Nov 2012 15:14:47 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1211141513040.26823@cobra.newdream.net>
References: <CAPud5_4pT3OPeVC=e2cFwpdiYXsx96TuAfYiCDJbWJek+hw_Xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36489 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423427Ab2KNXOs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Nov 2012 18:14:48 -0500
In-Reply-To: <CAPud5_4pT3OPeVC=e2cFwpdiYXsx96TuAfYiCDJbWJek+hw_Xg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nick Bartos <nick@pistoncloud.com>
Cc: ceph-devel@vger.kernel.org

On Wed, 14 Nov 2012, Nick Bartos wrote:
> I see that v0.55 will be the next stable release.  Would it be
> possible to use standard tarball naming conventions for this release?
> 
> If I download http://ceph.com/download/ceph-0.48.2.tar.bz2, the top
> level directory is actually ceph-0.48.2argonaut, not ceph-0.48.2 as
> expected.  Downloading
> http://ceph.com/download/ceph-0.48.2argonaut.tar.bz2 yields a slightly
> more expected result, but still isn't the typical *ix style of
> name-version.tar.  This is very annoying in some build systems, which
> have that assumption.  I've actually been extracting the tarballs,
> renaming the top level directory, then recompressing them.
> 
> It would be great if we didn't have to do that with the next release,
> e.g. extracting http://ceph.com/download/ceph-0.55.tar.bz2 would yield
> a top level directory of ceph-0.55.

Appending the codename to the version string is something we did with 
argonaut (0.48argonaut) just to make it obvious to users which stable 
version they are on.

How do people feel about that?  Is it worthwhile?  Useless?  Ugly?

We can certainly skip it for 0.55 bobtail...

sage
