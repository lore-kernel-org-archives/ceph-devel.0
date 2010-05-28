From: Sage Weil <sage@newdream.net>
Subject: Re: ceph.spec for Centos 5
Date: Fri, 28 May 2010 13:56:32 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1005281354190.3234@cobra.newdream.net>
References: <htlluv$70g$2@dough.gmane.org> <Pine.LNX.4.64.1005271424210.27661@cobra.newdream.net>
 <htnv41$l6k$3@dough.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36280 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758483Ab0E1U42 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 28 May 2010 16:56:28 -0400
In-Reply-To: <htnv41$l6k$3@dough.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Thomas Mueller <thomas@chaschperli.ch>
Cc: ceph-devel@vger.kernel.org

On Fri, 28 May 2010, Thomas Mueller wrote:
> Am Thu, 27 May 2010 14:26:38 -0700 schrieb Sage Weil:
> > Thanks.
> > 
> > It looks like your changes are all RHEL <= 5, Fedora <= 9 specific, with
> > the exception of the build-requires changes, which I've updated in git.
> > If I'm missing something, let me know--I don't use the rpms myself. 
> 
> ... and it needs a "%configure" instead of "./autogen.sh" (IMHO ./
> autogen.sh seems does not to call "./configure" as make tells me that the 
> Makefile is not found - so maybe "%configure" is needed after autogen.sh 
> for git versions)

Yeah, the version in git does both.  ./autogen.sh is needed to generate 
the configure script from configure.ac before ./configure is run.

 %build
 ./autogen.sh
 %{configure} --without-hadoop --without-debug
 make CFLAGS="$RPM_OPT_FLAGS"

sage
